using Julog

function save_plan(ofile, plan)
    open(ofile, "w") do fio
        for a in plan
            s = "(" * join([a.name, a.args...], " ") * ")"
            println(fio, s)
        end
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

function setup_training(problem_name)
    sdir(s...) = joinpath("..", "ipc23_problems", problem_name, s...)
    domain_pddl = sdir("domain.pddl")
    problem_files = [sdir(f) for f in readdir(sdir()) if endswith(f, ".pddl") && f !== "domain.pddl"]
    return (domain_pddl, problem_files)
end

function get_training_problems(problem)
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

"""
(domain_pddl, problem_files) =  getproblem(problem)
(domain_pddl, problem_files) =  getproblem(problem, sort_by_complexity)

if sort_by_complexity is true, problem_files are sorted by the number of objects, 
which is treated as a proxy for complexity.
"""
function get_training_problems(problem, sort_by_complexity)
    !sort_by_complexity && return (get_training_problems(problem))
    (domain_pddl, problem_files) = get_training_problems(problem)
    no = map(f -> length(load_problem(f).objects), problem_files)
    problem_files = problem_files[sortperm(no)]
    return (domain_pddl, problem_files)
end
