using NeuroPlanner
using PDDL
using Flux
using JSON
using SymbolicPlanners
using PDDL: GenericProblem
using SymbolicPlanners: PathSearchSolution
using Statistics
using IterTools
using Random
using StatsBase
using Serialization
using DataFrames
using Mill
using Functors
using Accessors
using Logging
using TensorBoardLogger

include("solution_tracking.jl")
include("ipc23_problems.jl")
include("training.jl")
include("utils.jl")

function experiment(domain_name, hnet, domain_pddl, train_files, test_files, filename, fminibatch;
    max_steps=10000, max_time=30, graph_layers=2, residual=true, dense_layers=2, dense_dim=32, settings=nothing)
    !isdir(dirname(filename)) && mkpath(dirname(filename))
    domain = load_domain(domain_pddl)
    pddld = hnet(domain; message_passes=graph_layers, residual)

    #create model from some problem instance

    # we can check that the model can learn the training data if the dedup_model can differentiate all input states, which is interesting by no means

    train_problems, train_plans = train_files
    test_problems, test_plans = test_files

    model = if isfile(filename * "_model.jls")
        deserialize(filename * "_model.jls")
    else
        model = let
            problem = load_problem(first(train_problems))
            pddle, state = initproblem(pddld, problem)
            h₀ = pddle(state)
            # model = reflectinmodel(h₀, d -> ffnn(d, dense_dim, dense_dim, dense_layers);fsm = Dict("" =>  d -> ffnn(d, dense_dim, 1, dense_layers)))
            reflectinmodel(h₀, d -> Dense(d, dense_dim, relu); fsm=Dict("" => d -> ffnn(d, dense_dim, 1, dense_layers)))
        end

        # logger = tblogger(filename * "_events.pb")
        t = @elapsed minibatches = map(zip(train_files...)) do (problem_file, plan_file)
            @show problem_file, plan_file
            println("creating sample from problem: ", problem_file)
            plan = load_plan(plan_file)
            problem = load_problem(problem_file)
            ds = fminibatch(pddld, domain, problem, plan)
            dedu = @set ds.x = deduplicate(ds.x)
            size_o, size_d = Base.summarysize(ds), Base.summarysize(dedu)
            # println("original: ", size_o, " dedupped: ", size_d, " (", round(100 * size_d / size(d), digits=2), "%)")
            println("original: ", size_o, " dedupped: ", size_d, " (", round(100 * size_d / 100, digits=2), "%)")
            dedu
        end
        # log_value(logger, "time_minibatch", t; step=0)
        opt = AdaBelief()
        ps = Flux.params(model)
        t = @elapsed train!(NeuroPlanner.loss, model, ps, opt, () -> rand(minibatches), max_steps; trn_data=minibatches)
        # log_value(logger, "time_train", t; step=0)
        serialize(filename * "_model.jls", model)
        model
    end
    planners = model isa NeuroPlanner.LevinModel ? [BFSPlanner] : [AStarPlanner, GreedyPlanner, W15AStarPlanner, W20AStarPlanner]

    stats = map(Iterators.product(planners, test_problems)) do (planner, problem_file)
        used_in_train = problem_file ∈ train_problems
        @show problem_file
        sol = solve_problem(pddld, problem_file, model, planner; return_unsolved=true)
        trajectory = sol.sol.status == :max_time ? nothing : sol.sol.trajectory
        merge(sol.stats, (; used_in_train, planner="$(planner)", trajectory, problem_file))
    end
    df = DataFrame(vec(stats))
    mean(df.solved[.!df.used_in_train])
    serialize(filename * "_stats.jls", stats)
    settings !== nothing && serialize(filename * "_settings.jls", settings)
end

"""
ArgParse example implemented in Comonicon.

# Arguments

- `problem_name`: a name of the problem to solve ("ferry", "gripper", "blocks", "npuzzle", "elevator_00")
- `arch_name`: an architecture of the neural network implementing heuristic("asnet", "pddl")
- `loss_name`: 

# Options

- `--max_steps <Int>`: maximum number of steps of SGD algorithm (default 10_000)
- `--max_time <Int>`:  maximum steps of the planner used for evaluation (default 30)
- `--graph_layers <Int>`:  maximum number of layers of (H)GNN (default 1)
- `--dense_dim <Int>`:  dimension of all hidden layers, even those realizing graph convolutions (default  32)
- `--dense_layers <Int>`:  number of layers of dense network after pooling vertices (default 32)
- `--residual <String>`:  residual connections between graph convolutions (none / dense / linear)

max_steps = 10_000; max_time = 30; graph_layers = 2; dense_dim = 16; dense_layers = 2; residual = "none"; seed = 1
domain_name = "ferry"
loss_name = "lstar"
arch_name = "lrnn"
"""

@main function main(domain_name, arch_name, loss_name; max_steps::Int=10_000, max_time::Int=30, graph_layers::Int=1,
    dense_dim::Int=32, dense_layers::Int=2, residual::String="none", seed::Int=1)
    Random.seed!(seed)
    settings = (; domain_name, arch_name, loss_name, max_steps, max_time, graph_layers, dense_dim, dense_layers, residual, seed)
    @show settings
    archs = Dict("asnet" => ASNet, "pddl" => MixedLRNN, "lrnn" => LRNN, "hgnnlite" => HGNNLite, "hgnn" => HGNN, "levinasnet" => LevinASNet)
    residual = Symbol(residual)
    domain_pddl, problem_files, plan_files = get_training_problems(domain_name, false)


    train_files = (problem_files, plan_files)
    test_files = get_testing_problems(domain_name; difficulty=:easy)

    fminibatch = NeuroPlanner.minibatchconstructor(loss_name)
    hnet = archs[arch_name]

    filename = joinpath("super", domain_name,
        join([arch_name, loss_name, max_steps, max_time, graph_layers, residual, dense_layers, dense_dim, seed], "_"))

    experiment(domain_name, hnet, domain_pddl, train_files, test_files, filename, fminibatch;
        max_steps, max_time, graph_layers, residual, dense_layers, dense_dim, settings)
end

