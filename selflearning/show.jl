using Serialization
using Statistics
using DataFrames
using NeuroPlanner
using JSON
using CSV
using DataFrames
using HypothesisTests
using Statistics
using PrettyTables
using Printf

function lexargmax(a, b)
	@assert length(a) == length(b)
	function _lt(i,j)
		a[i] == a[j] && return(b[i] < b[j])
		a[i] < a[j]
	end
	first(sort(1:length(a), lt = _lt, rev = true))
end

function highlight_max(data, i, j)
	j == 1 && return(false)
	maximum(data[i,2:end]) == data[i,j]
end

function highlight_min(data, i, j)
	j == 1 && return(false)
	minimum(data[i,2:end]) == data[i,j]
end

nohighlight(args...) = false

joindomains(a,b) = outerjoin(a, b, on = :domain_name)

function compute_stats(df; max_time = 30)
	gdf = DataFrames.groupby(df, [:domain_name, :arch_name, :loss_name, :planner, :max_steps,  :max_time, :graph_layers, :residual, :dense_layers, :dense_dim, :seed])
	combined_stats = combine(gdf) do sub_df
		ii = sortperm(sub_df.problem_file)
		i1 = filter(i -> !sub_df.used_in_train[i], ii[1:2:end])
		i2 = filter(i -> !sub_df.used_in_train[i], ii[2:2:end])
		solved = sub_df.solution_time .≤ max_time
		(;	trn_solved = mean(solved[sub_df.used_in_train]),
	     	tst_solved = mean(solved[.!sub_df.used_in_train]),
	     	tst_solved_fold1 = mean(solved[i1]),
	     	tst_solved_fold2 = mean(solved[i2]),
	     	expanded_fold1 = mean(sub_df.expanded[i1]),
	     	expanded_fold2 = mean(sub_df.expanded[i2]),
	     	solution_time_fold1 = mean(sub_df.solution_time[i1]),
	     	solution_time_fold2 = mean(sub_df.solution_time[i2]),
	     	sol_length_fold1 = mean(skipmissing(sub_df.sol_length[i1])),
	     	sol_length_fold2 = mean(skipmissing(sub_df.sol_length[i2])),
	     	solx_length_fold1 = Dict([sub_df.problem_file[i] => sub_df.sol_length[i] for i in i1 if solved[i]]),
	     	solx_length_fold2 = Dict([sub_df.problem_file[i] => sub_df.sol_length[i] for i in i2 if solved[i]]),
	     	time_in_heuristic = mean(sub_df.time_in_heuristic[.!sub_df.used_in_train]),
	     	solved_problems = size(sub_df, 1),
		)
	end
end

function show_loss(combined_stats, key; agg = mean)
	key ∉ (:tst_solved, :expanded, :solution_time, :sol_length) && error("works only for tst_solved and :expanded are supported")
	k1 = Symbol("$(key)_fold1")
	k2 = Symbol("$(key)_fold2")
	dfs = mapreduce(joindomains, unique(combined_stats.loss_name)) do ln 
		df1 = filter(r -> r.loss_name == ln, combined_stats)
		gdf = DataFrames.groupby(df1, :domain_name)
		dfs = combine(gdf) do sub_df
			# (;average = mean(sub_df.tst_solved), maximum = maximum(sub_df.tst_solved))
			v = map(unique(sub_df.seed)) do s
				subsub_df = filter(r -> r.seed == s, sub_df)
				i = subsub_df[lexargmax(subsub_df.tst_solved_fold1, -subsub_df.sol_length_fold1),k2]
				j = subsub_df[lexargmax(subsub_df.tst_solved_fold2, -subsub_df.sol_length_fold2),k1]
				(i+j) / 2
			end |> agg
			DataFrame("$ln" => [v])
		end
		dfs
	end;
end

function extract_length(df, planner, seed; max_time = 30)
	k1 = :solx_length_fold1
	k2 = :solx_length_fold2
	ddf = filter(r -> r.planner == planner && r.seed == seed, df);
	combined_stats = compute_stats(ddf;max_time)
	dfs = mapreduce(joindomains, unique(combined_stats.loss_name)) do ln 
		df1 = filter(r -> r.loss_name == ln && r.seed == seed, combined_stats)
		gdf = DataFrames.groupby(df1, :domain_name)
		dfs = combine(gdf) do sub_df
			i = sub_df[lexargmax(sub_df.tst_solved_fold1, -sub_df.sol_length_fold1),k2]
			j = sub_df[lexargmax(sub_df.tst_solved_fold2, -sub_df.sol_length_fold2),k1]
			DataFrame("$(planner) $ln" => [merge(i,j)])
		end
	end;
	dfs
end

function extract_length(df, seed; max_time = 30)
	dfs = mapreduce(p -> extract_length(df, p, seed; max_time), joindomains, ["AStarPlanner", "GreedyPlanner", "BFSPlanner"])

	# for each domain_name, do the intersection
	odf = map(eachrow(dfs)) do row 
		always_solved =  reduce(intersect, [keys(x) for x in row if x isa Dict])
		map(row) do x 
			x isa Dict || return(x)
			round(mean(x[k] for k in always_solved), digits = 1)
		end
	end |> DataFrame
	sort(odf, :domain_name)
end

function show_length(df; backend = Val(:text), max_time = 30)
	t = extract_length(df, 1; max_time)
	d = Matrix(t[:,2:end])
	for i in 2:3
		d += Matrix(extract_length(df, i; max_time)[:,2:end])

	end
	data = hcat(t.domain_name, round.(d ./ 3, digits = 1))

	dm = Dict(reverse.(enumerate(names(t))))
	header =  vcat("domain_name",
		["AStarPlanner $(l)" for l in ["lstar", "lgbfs", "lrt","l2","bellman"]], 
		["GreedyPlanner $(l)" for l in ["lstar", "lgbfs", "lrt","l2","bellman"]],
		"BFSPlanner levinloss")
	data[:,[get(dm, h,"") for h in header]]
	pretty_table(data ; backend, header = [split(s," ")[end] for s in header])
end

function submit_missing(;dry_run = true, domain_name, arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed)
	filename = joinpath("super", domain_name, join([arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed], "_"))
	filename = filename*"_stats.jls"
	isfile(filename) && return(false)
	@show filename
	dry_run || run(`sbatch -D /home/pevnytom/julia/Pkg/NeuroPlanner.jl/selflearning slurm.sh $domain_name $dense_dim $graph_layers $residual $loss_name $arch_name $seed`)
	return(true)
end

function read_data(;domain_name, arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed)
	# filename = joinpath("super", domain_name, join([arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed], "_"))
	filename = joinpath("super", domain_name, join([arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed], "_"))
	filename = filename*"_stats.jls"
	!isfile(filename) && return(DataFrame())
	df = DataFrame(vec(deserialize(filename)))
	select!(df, Not(:trajectory))
	df[:,:domain_name] .= domain_name
	df[:,:arch_name] .= arch_name
	df[:,:loss_name] .= loss_name
	df[:,:graph_layers] .= graph_layers
	df[:,:dense_dim] .= dense_dim
	df[:,:dense_layers] .= dense_layers
	df[:,:residual] .= residual
	df[:,:seed] .= seed
	df[:,:max_steps] .= max_steps
	df[:,:max_time] .= max_time
	df
end

function make_table(df, k, high; max_time = 30, backend = Val(:text), agg = mean)
	function _make_table(planner) 
		ddf = filter(r -> r.planner == planner, df)
		show_loss(compute_stats(ddf;max_time), k; agg)
	end
	da = _make_table("AStarPlanner")
	da = da[:,[:domain_name, :lstar, :lgbfs, :lrt, :l2, :bellman]]
	db = joindomains(_make_table("GreedyPlanner"), _make_table("BFSPlanner"))
	db = db[:,[:domain_name, :lstar, :lgbfs, :lrt, :l2, :bellman, :levinloss]]


	header = [names(da)..., " ", names(db)[2:end]...]
	data = hcat(Matrix(da), fill(" ", size(da,1)), Matrix(db)[:,2:end])
	ha = [high(Matrix(da), i, j) for i in 1:size(da,1), j in 1:size(da,2)]
	hb = [high(Matrix(db), i, j) for i in 1:size(db,1), j in 1:size(db,2)]
	h = hcat(ha, falses(size(da,1)), hb[:,2:end])

	highlighters = backend == Val(:latex) ? LatexHighlighter((data, i, j) -> h[i, j], "textbf") :  Highlighter((data, i, j) -> h[i, j], crayon"yellow")
	pretty_table(data ; header, backend , highlighters)
end

function compute_compute_time(username)
	# sacct -u username --starttime 2023-01-01 --format=User,partition,JobID,elapsed  > duration.txt
	v = mapreduce(+, readlines("duration.txt")) do l 
		!startswith(l, " $(username)") && return(0)
		s = split(l, " ")[end-1]
		if contains(s, "-")
			days = parse(Int, s[1:findfirst('-',s)-1])
			s = s[findfirst('-',s)+1:end]
			return(days * 24 *3600 + (parse(Dates.Time, s).instant.value ÷ 1e9))
		else
			return(parse(Dates.Time, s).instant.value ÷ 1e9)
		end
	end
	hours = ceil(v/ 3600)
end


function collect_stats()
	max_steps = 10_000
	max_time = 30
	dense_layers = 2
	seed = 1
	dry_run = true
	problems = ["blocks","ferry","npuzzle","spanner","elevators_00"]
	stats = map(Iterators.product(("hgnn",), ("bellman", "lstar", "l2", "lrt", "lgbfs",), problems, (4, 8, 16), (1, 2, 3), (:none, :linear), (1, 2, 3))) do (arch_name, loss_name, domain_name, dense_dim, graph_layers, residual, seed)
		# submit_missing(;dry_run, domain_name, arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed)
		read_data(;domain_name, arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed)
	end |> vec

	lstats = map(Iterators.product(("levinasnet",), ("levinloss",), problems, (4, 8, 16), (1, 2, 3), (:none, :linear, :dense), (1, 2, 3))) do (arch_name, loss_name, domain_name, dense_dim, graph_layers, residual, seed)
		# submit_missing(;dry_run, domain_name, arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed)
		read_data(;domain_name, arch_name, loss_name, max_steps,  max_time, graph_layers, residual, dense_layers, dense_dim, seed)
	end |> vec;

	df = reduce(vcat, filter(!isempty, vec(vcat(stats, lstats))))
	df = CSV.read("super/results.csv", DataFrame)
	df
end

df = CSV.read("super/results.csv", DataFrame)
df = filter(r -> r.arch_name ∈ ("hgnn", "levinasnet"), df);

# Table 1 in the main paper
# backend = Val(:text)
backend = Val(:latex)
make_table(df, :tst_solved, highlight_max; max_time =  5, backend,  agg = x -> round(Int, mean(100*x)))

# Table 1 in supplementary (mean and standard deviation)
meanstd_text(x) = "$(round(Int, mean(100*x))) ± $(round(Int, std(100*x)))"
meanstd_latex(x) = "\$ $(round(Int, mean(100*x))) \\pm $(round(Int, std(100*x))) \$"
make_table(df, :tst_solved, nohighlight; backend, max_time =  5, agg = backend == Val(:latex) ? meanstd_latex : meanstd_text)

# Table 2 in supplementary (average number of expanded states)
make_table(df, :expanded, highlight_min; max_time =  30, backend,  agg = x -> round(Int, mean(x)))

# Table 3 in supplementary (average length of the solutions)
show_length(df; backend, max_time = 5)
