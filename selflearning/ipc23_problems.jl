using Julog

function save_plan(ofile, plan)
    open(ofile, "w") do fio
        for a in plan
            s = "(" * join([a.name, a.args...], " ") * ")"
            println(fio, s)
        end
        println(fio, "; cost = $(length(plan)) (unit cost)")
    end
end

plan_file(s) = endswith(s, ".pddl") ? s[1:end-5] * ".plan" : s

function load_plan(pfile)
    pfile = plan_file(pfile)
    map(readlines(pfile)) do s
        p = Symbol.(split(s[2:end-1], " "))
        Compound(p[1], Const.(p[2:end]))
    end[1:end-1]
end

"""
(domain_pddl, problem_files, plan_files) = get_training_problems(problem, sort_by_complexity)

if sort_by_complexity is true, problem_files are sorted by their specified difficulty.
"""
function get_training_problems(problem, sort_by_complexity)
    !sort_by_complexity && return (setup_training_problems(problem))
    (domain_pddl, problem_files, plan_files) = setup_training_problems(problem)
    return (domain_pddl, reverse(problem_files), reverse(plan_files))
end

function setup_training_problems(problem)
    problem == "blocks" && return (setup_training("blocksworld"))
    problem == "blocksworld" && return (setup_training("blocksworld"))
    problem == "childsnack" && return (setup_training("childsnack"))
    problem == "ferry" && return (setup_training("ferry"))
    problem == "floortile" && return (setup_training("floortile"))
    problem == "miconic" && return (setup_training("miconic"))
    problem == "rovers" && return (setup_training("rovers"))
    problem == "satellite" && return (setup_training("satellite"))
    problem == "sokoban" && return (setup_training("sokoban"))
    problem == "spanner" && return (setup_training("spanner"))
    problem == "transport" && return (setup_training("transport"))
    error("unknown problem $(problem)")
end

function setup_training(problem_name)
    sdir(s...) = joinpath("ipc23-problems", problem_name, s...)
    domain_pddl = sdir("domain.pddl")
    problem_files = [sdir(joinpath("training", "easy", f)) for f in readdir(sdir(joinpath("training", "easy")))]
    plan_files = [sdir(joinpath("training_plans", f)) for f in readdir(sdir(joinpath("training_plans")))]
    return (domain_pddl, problem_files, plan_files)
end


"""
(problem_files, plan_files) = get_testing_problems(problem; difficulty=:none)

if difficulty is not specified, problem_files of difficulty `:easy`, `:medium` and `:hard` are returned, 
    with their specified plans.
"""
function get_testing_problems(problem; difficulty=:none)
    if difficulty == :none
        (vcat(map((:easy, :medium, :hard)) do diff
                diff = _get_testing_problems(problem, diff)
            end...),
            get_solutions(problem)
        )
    else
        return (_get_testing_problems(problem, difficulty), _get_solutions(problem, difficulty))
    end
end

function _get_testing_problems(problem_name, difficulty)
    sdir(s...) = joinpath("ipc23-problems", problem_name, "testing", string(difficulty), s...)
    [sdir(f) for f in readdir(sdir())]
end


"""
plan_files = get_solutions(problem; difficulty=:none)

if difficulty is not specified, plan_files of difficulty `:easy`, `:medium` and `:hard` are returned.
"""
function get_solutions(problem; difficulty=:none)
    if difficulty == :none
        vcat(map((:easy, :medium, :hard)) do diff
            _get_solutions(problem, diff)
        end...)
    else
        _get_solutions(problem, difficulty)
    end
end

function _get_solutions(problem_name, difficulty; type=:testing)
    sdir(s...) = joinpath("ipc23-problems", "solutions", problem_name, string(type), string(difficulty), s...)
    [sdir(f) for f in readdir(sdir())]
end
