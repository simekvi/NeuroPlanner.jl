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

include("problems.jl")
include("training.jl")
include("utils.jl")

domain = load_domain(joinpath("..", "domains_test", "domain.pddl"))
problem = load_problem(joinpath("..", "domains_test", "blocks3_task01.pddl"))
plan = load_plan(joinpath("..", "domains_test", "blocks3_task01.plan"))

ex = LRNN(domain)
ex, state = initproblem(ex, problem)
h0 = ex(state)


fminibatch = NeuroPlanner.minibatchconstructor("lstar")

ds = fminibatch(ex, domain, problem, plan)

dedu = deduplicate(ds.x)

dense_dim = 32
dense_layers = 2

model = reflectinmodel(h0, d -> ffnn(d, dense_dim, dense_dim, dense_layers); fsm=Dict("" => d -> ffnn(d, dense_dim, 1, dense_layers)))

model(ds.x) ≈ model(dedu)
