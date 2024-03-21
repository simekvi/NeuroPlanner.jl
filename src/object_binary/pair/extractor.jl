using PDDL: get_facts, get_args
"""
struct ObjPairBin{DO,D,N,MP,S,G}
	domain::DO
	multiarg_predicates::NTuple{N,Symbol}
	nunanary_predicates::Dict{Symbol,Int64}
	objtype2id::Dict{Symbol,Int64}
	constmap::Dict{Symbol, Int64}
	model_params::NamedTuple{(:message_passes, :residual), Tuple{Int64, Symbol}}
	obj2id::D
	goal::G
end

Represents a PDDL state as a hypergraph, whre 
- Each node is either an object or a contant
- unary predicate is a property of an object
- nullary predicate is a property of all objects
- n-ary predicate is a hyper-edge

The computational model is message-passing over hyper-graph, which is essentially 
a message passing over a bipartite graph, where left vertices corresponds to vertices
in hypergraph and right vertices corresponds to hyper-edges. There is an edge between
vertex corresponding to the hyper-edge and its vertices.

--- `multiarg_predicates` is a list of all n-ary predicates
--- `nunary_predicates` maps unary predicates to an index in one-hot encoded vertex' properties 
--- `objtype2id` maps unary predicates to an index in one-hot encoded vertex' properties 
--- `constmap` maps constants to an index in one-hot encoded vertex' properties 
--- `model_params` some parameters of an algorithm constructing the message passing passes 
"""

struct ObjPairBin{DO,D,MP,DV,DT,V,S,G}
    domain::DO
    multiarg_predicates::Dict{Symbol,Int64}
    unary_predicates::Dict{Symbol,Int64}
    nullary_predicates::Dict{Symbol,Int64}
    objtype2id::Dict{Symbol,Int64}
    constmap::Dict{Symbol,Int64}
    model_params::MP
    obj2id::D
    obj2pid::DV
    pair2id::DT
    pairs::V
    init_state::S
    goal_state::G
    function ObjPairBin(domain::DO, multiarg_predicates::Dict{Symbol,Int64}, unary_predicates::Dict{Symbol,Int64}, nullary_predicates::Dict{Symbol,Int64},
        objtype2id::Dict{Symbol,Int64}, constmap::Dict{Symbol,Int64}, model_params::MP, obj2id::D, obj2pid::DV, pair2id::DT,
        pairs::V, init::S, goal::G) where {DO,D,MP<:NamedTuple,DV,DT,V,S,G}

        @assert issubset((:message_passes, :residual), keys(model_params)) "Parameters of the model are not fully specified"
        @assert (init === nothing || goal === nothing) "Fixing init and goal state is bizzaare, as the extractor would always create a constant"
        new{DO,D,MP,DV,DT,V,S,G}(domain, multiarg_predicates, unary_predicates, nullary_predicates, objtype2id, constmap, model_params,
            obj2id, obj2pid, pair2id, pairs, init, goal)
    end
end


ObjPairBinNoGoal{DO,D,MP} = ObjPairBin{DO,D,MP,Nothing,Nothing} where {DO,D,MP}
ObjPairBinStart{DO,D,MP,S} = ObjPairBin{DO,D,MP,S,Nothing} where {DO,D,MP,S<:KnowledgeBase}
ObjPairBinGoal{DO,D,MP,S} = ObjPairBin{DO,D,MP,Nothing,S} where {DO,D,MP,S<:KnowledgeBase}

function ObjPairBin(domain; message_passes=2, residual=:linear, kwargs...)
    model_params = (; message_passes, residual)
    dictmap(x) = Dict(reverse.(enumerate(sort(x))))
    predicates = collect(domain.predicates)
    multiarg_predicates = dictmap([kv[1] for kv in predicates if length(kv[2].args) > 1])
    unary_predicates = dictmap([kv[1] for kv in predicates if length(kv[2].args) == 1])
    nullary_predicates = dictmap([kv[1] for kv in predicates if length(kv[2].args) < 1])
    objtype2id = Dict(s => i + length(unary_predicates) for (i, s) in enumerate(collect(keys(domain.typetree))))
    constmap = Dict{Symbol,Int}(dictmap([x.name for x in domain.constants]))
    ObjPairBin(domain, multiarg_predicates, unary_predicates, nullary_predicates, objtype2id, constmap, model_params,
        nothing, nothing, nothing, nothing, nothing, nothing)
end

isspecialized(ex::ObjPairBin) = ex.obj2id !== nothing
hasgoal(ex::ObjPairBin) = ex.init_state !== nothing || ex.goal_state !== nothing

function ObjPairBin(domain, problem; embed_goal=true, kwargs...)
    ex = ObjPairBin(domain; kwargs...)
    ex = specialize(ex, problem)
    embed_goal ? add_goalstate(ex, problem) : ex
end

function Base.show(io::IO, ex::ObjPairBin)
    if !isspecialized(ex)
        print(io, "Unspecialized extractor for ", ex.domain.name,
            " (", length(ex.unary_predicates), ", ", length(ex.multiarg_predicates), ")")
    else
        g = hasgoal(ex) ? "with" : "without"
        print(io, "Specialized extractor ", g, " goal for ", ex.domain.name,
            " (", length(ex.unary_predicates), ", ", length(ex.multiarg_predicates), ", ", length(ex.obj2id), ")")
    end
end


"""
specialize(ex::ObjPairBin{<:Nothing,<:Nothing}, problem)

initializes extractor for a given `problem` by initializing mapping 
from objects to id of vertices. Goals are not changed added to the 
extractor.
"""
function specialize(ex::ObjPairBin, problem)
    obj2id = Dict(v.name => i for (i, v) in enumerate(problem.objects))
    obj2idv = [(v.name, i) for (i, v) in enumerate(problem.objects)]

    for k in keys(ex.constmap)
        obj2id[k] = length(obj2id) + 1
        push!(obj2idv, (k, length(obj2idv) + 1))
    end

    obj2pid = Dict(v[1] => Tuple{Int64,Int64}[] for v in obj2idv)
    pair2id = Dict{Tuple{Symbol,Symbol},Int32}()

    offset = -length(obj2idv)

    pairs = map(obj2idv) do (name, id)
        # global offset
        offset += length(obj2idv) + 1 - id
        p = Tuple{Symbol,Symbol}[]
        for i in id:length(obj2idv)
            push!(obj2pid[name], (offset + i, 1))
            push!(obj2pid[obj2idv[i][1]], (offset + i, 2))
            push!(p, (name, obj2idv[i][1]))
            pair2id[(name, obj2idv[i][1])] = offset + i
        end
        p
        # [(name, obj2idv[i][1]) for i in id:length(obj2idv)]
    end |> (arrays -> vcat(arrays...))

    ObjPairBin(ex.domain, ex.multiarg_predicates, ex.unary_predicates, ex.nullary_predicates, ex.objtype2id,
        ex.constmap, ex.model_params, obj2id, obj2pid, pair2id, pairs, nothing, nothing)
end

function (ex::ObjPairBin)(state::GenericState)
    prefix = (ex.goal_state !== nothing) ? :start : ((ex.init_state !== nothing) ? :goal : nothing)
    kb = encode_state(ex, state, prefix)
    addgoal(ex, kb)
end

function encode_state(ex::ObjPairBin, state::GenericState, prefix=nothing)
    message_passes, residual = ex.model_params
    # rename to feature vectors
    x = feature_vectors(ex, state)
    kb = KnowledgeBase((; x1=x))
    n = size(x, 2)
    sₓ = :x1
    if !isempty(ex.multiarg_predicates)
        for i in 1:message_passes
            input_to_gnn = last(keys(kb))
            ds = multi_predicates(ex, input_to_gnn, state, prefix)
            kb = append(kb, layer_name(kb, "gnn"), ds)
            if residual !== :none #if there is a residual connection, add it 
                kb = add_residual_layer(kb, keys(kb)[end-1:end], n)
            end
        end
    end
    s = last(keys(kb))
    kb = append(kb, :o, BagNode(ArrayNode(KBEntry(s, 1:n)), [1:n]))
end

"""
feature_vectors(ex::ObjPairBin, state) 

Creates a matrix with one column per pairs of objects and encode by one-hot-encoding
"""
function feature_vectors(ex::ObjPairBin, state)
    idim = length(ex.nullary_predicates) + 2 * (length(ex.unary_predicates) + length(ex.objtype2id) + length(ex.constmap)) + length(ex.multiarg_predicates)
    x = zeros(Float32, idim, length(ex.pairs))

    # length of feature vector of one object in a pair
    obj_length = length(ex.unary_predicates) + length(ex.objtype2id) + length(ex.constmap)



    # nullary_predicates
    for (_, i) in ex.nullary_predicates
        x[i, :] .= 1
    end


    # encode unary predicates
    offset = length(ex.nullary_predicates)
    for f in get_facts(state)
        length(get_args(f)) != 1 && continue
        (f isa PDDL.Compound) && (f.name == :not) && continue

        pred_id = ex.unary_predicates[f.name]
        vids = ex.obj2pid[only(get_args(f)).name]
        for (vid, pos) in vids
            x[offset+(pos-1)*obj_length+pred_id, vid] = 1
        end
    end

    # encode types of objects
    for s in state.types
        i = ex.objtype2id[s.name]
        js = ex.obj2pid[only(s.args).name]
        for (j, pos) in js
            x[(pos-1)*obj_length+i, j] = 1
        end
    end

    # encode constants
    offset = length(ex.nullary_predicates) + length(ex.unary_predicates) + length(ex.objtype2id)
    for (k, i) in ex.constmap
        js = ex.obj2pid[k]
        for (j, pos) in js
            x[offset+(pos-1)*obj_length+i, j] = 1
        end
    end


    # encode predicate relatedness
    offset = length(ex.nullary_predicates) + 2 * obj_length
    for f in get_facts(state)
        length(get_args(f)) < 2 && continue
        (f isa PDDL.Compound) && (f.name == :not) && continue

        pred_id = ex.multiarg_predicates[f.name]
        is = [ex.obj2id[o.name] for o in get_args(f)]

        for (i, id) in enumerate(is)
            for j in i+1:length(is)
                # ordering ids of objects for formula to work
                id1, id2 = id < is[j] ? (id, is[j]) : (is[j], id)
                # formula for getting pair id
                pid = Int(((length(ex.obj2id) + (length(ex.obj2id) - (id1 - 1) + 1)) * (id1 - 1) / 2)) + 1 + (id2 - id1)
                x[offset+pred_id, pid] = 1
            end
        end
    end

    x
end

function multi_predicates(ex::ObjPairBin, kid::Symbol, state, prefix=nothing)
    # Then, we specify the predicates the dirty way
    ks = tuple(collect(keys(ex.multiarg_predicates))...)
    xs = map(ks) do k
        preds = filter(f -> f.name == k, get_facts(state))
        encode_predicates(ex, k, preds, kid)
    end
    ns = isnothing(prefix) ? ks : tuple([Symbol(prefix, "_", k) for k in ks]...)
    ProductNode(NamedTuple{ns}(xs))
end

function encode_edges(ex::ObjPairBin, kid::Symbol)
    bags = [Int64[] for _ in 1:length(ex.pairs)]

    x = map(collect(keys(ex.obj2id))) do obj
        pairs = ex.obj2pid[obj]
        edges = Tuple{Int64,Int64}[]
        for i in 1:length(pairs)
            pid = pairs[i][1]
            es = [(pid, pairs[j][1]) for j in i+1:length(pairs) if pid != pairs[j][1]]
            push!(edges, es...)
        end
        edges
    end
end

function encode_predicates(ex::ObjPairBin, pname::Symbol, preds, kid::Symbol)
    p = ex.domain.predicates[pname]
    obj2id = ex.obj2id

    xs = map(collect(preds)) do f
        [(obj2id[f.args[i].name], obj2id[f.args[j].name]) for i in 1:length(f.args)-1 for j in i+1:length(f.args)]
    end |> (arrays -> vcat(arrays...))

    x = map(1:2) do i
        ArrayNode(KBEntry(kid, map(p -> p[i], xs)))
    end |> (an -> ProductNode(tuple(an...)))

    bags = [Int[] for _ in 1:length(obj2id)]

    for (i, f) in enumerate(xs)
        for j in 1:2
            push!(bags[f[j]], i)
        end
    end

    BagNode(x, ScatteredBags(bags))
end




function add_goalstate(ex::ObjPairBin, problem, goal=goalstate(ex.domain, problem))
    ex = isspecialized(ex) ? ex : specialize(ex, problem)
    exg = encode_state(ex, goal, :goal)
    ObjPairBin(ex.domain, ex.multiarg_predicates, ex.unary_predicates, ex.nullary_predicates, ex.objtype2id, ex.constmap,
        ex.model_params, ex.obj2id, ex.obj2pid, ex.pair2id, ex.pairs, nothing, exg)
end

function add_initstate(ex::ObjPairBin, problem, start=initstate(ex.domain, problem))
    ex = isspecialized(ex) ? ex : specialize(ex, problem)
    exg = encode_state(ex, start, :start)
    ObjPairBin(ex.domain, ex.multiarg_predicates, ex.unary_predicates, ex.nullary_predicates, ex.objtype2id, ex.constmap,
        ex.model_params, ex.obj2id, ex.obj2pid, ex.pair2id, ex.pairs, exg, nothing)
end

function addgoal(ex::ObjPairBinStart, kb::KnowledgeBase)
    return (stack_hypergraphs(ex.init_state, kb))
end

function addgoal(ex::ObjPairBinGoal, kb::KnowledgeBase)
    return (stack_hypergraphs(kb, ex.goal_state))
end

function addgoal(ex::ObjPairBinNoGoal, kb::KnowledgeBase)
    return (kb)
end
