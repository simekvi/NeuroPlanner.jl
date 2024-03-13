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

struct ObjPairBin{DO,D,N,MP,S,G}
    domain::DO
    multiarg_predicates::NTuple{N,Symbol}
    unary_predicates::Dict{Symbol,Int64}
    nullary_predicates::Dict{Symbol,Int64}
    objtype2id::Dict{Symbol,Int64}
    constmap::Dict{Symbol,Int64}
    model_params::MP
    obj2id::D
    obj2pid::Dict{Symbol,Tuple{Int64,Int64}}
    pairs::Vector{Tuple{Symbol,Symbol}}
    init_state::S
    goal_state::G
    function ObjPairBin(domain::DO, multiarg_predicates::NTuple{N,Symbol}, unary_predicates::Dict{Symbol,Int64}, nullary_predicates::Dict{Symbol,Int64},
        objtype2id::Dict{Symbol,Int64}, constmap::Dict{Symbol,Int64}, model_params::MP, obj2id::D, obj2pid::Dict{Symbol,Tuple{Int64,Int64}},
        pairs::Vector{Tuple{Symbol,Symbol}}, init::S, goal::G) where {DO,D,N,MP<:NamedTuple,S,G}

        @assert issubset((:message_passes, :residual), keys(model_params)) "Parameters of the model are not fully specified"
        @assert (init === nothing || goal === nothing) "Fixing init and goal state is bizzaare, as the extractor would always create a constant"
        new{DO,D,N,MP,S,G}(domain, multiarg_predicates, unary_predicates, nullary_predicates, objtype2id, constmap, model_params, obj2id, obj2pid, pairs, init, goal)
    end
end


ObjPairBinNoGoal{DO,D,N,MP} = ObjPairBin{DO,D,N,MP,Nothing,Nothing} where {DO,D,N,MP}
ObjPairBinStart{DO,D,N,MP,S} = ObjPairBin{DO,D,N,MP,S,Nothing} where {DO,D,N,MP,S<:KnowledgeBase}
ObjPairBinGoal{DO,D,N,MP,S} = ObjPairBin{DO,D,N,MP,Nothing,S} where {DO,D,N,MP,S<:KnowledgeBase}

function ObjPairBin(domain; message_passes=2, residual=:linear, kwargs...)
    model_params = (; message_passes, residual)
    dictmap(x) = Dict(reverse.(enumerate(sort(x))))
    predicates = collect(domain.predicates)
    multiarg_predicates = tuple([kv[1] for kv in predicates if length(kv[2].args) > 1]...)
    unary_predicates = dictmap([kv[1] for kv in predicates if length(kv[2].args) == 1])
    nullary_predicates = dictmap([kv[1] for kv in predicates if length(kv[2].args) < 1])
    objtype2id = Dict(s => i + length(nunanary_predicates) for (i, s) in enumerate(collect(keys(domain.typetree))))
    constmap = Dict{Symbol,Int}(dictmap([x.name for x in domain.constants]))
    ObjPairBin(domain, multiarg_predicates, unary_predicates, nullary_predicates, objtype2id, constmap, model_params, nothing, nothing, nothing, nothing, nothing)
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
            " (", length(ex.nunanary_predicates), ", ", length(ex.multiarg_predicates), ")")
    else
        g = hasgoal(ex) ? "with" : "without"
        print(io, "Specialized extractor ", g, " goal for ", ex.domain.name,
            " (", length(ex.nunanary_predicates), ", ", length(ex.multiarg_predicates), ", ", length(ex.obj2id), ")")
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

    obj2pid = Dict(i => [] for i in 1:length(obj2idv))
    offset = -length(obj2idv)

    pairs = map(obj2idv) do (name, id)
        global offset
        offset += length(obj2idv) + 1 - id
        p = []
        for i in id:length(obj2idv)
            push!(obj2pid[id], (offset + i, 1))
            push!(obj2pid[i], (offset + i, 2))
            push!(p, (name, obj2idv[i][1]))
        end
        p
        # [(name, obj2idv[i][1]) for i in id:length(obj2idv)]
    end |> (arrays -> vcat(arrays...))

    ObjPairBin(ex.domain, ex.multiarg_predicates, ex.unary_predicates, ex.nullary_predicates, ex.objtype2id,
        ex.constmap, ex.model_params, obj2id, obj2pid, pairs, nothing, nothing)
end

function (ex::ObjPairBin)(state::GenericState)
    prefix = (ex.goal_state !== nothing) ? :start : ((ex.init_state !== nothing) ? :goal : nothing)
    kb = encode_state(ex, state, prefix)
    addgoal(ex, kb)
end

function encode_state(ex::ObjPairBin, state::GenericState, prefix=nothing)
    message_passes, residual = ex.model_params
    # rename to feature vectors
    x = nunary_predicates(ex, state)
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
add_residual_layer(kb::KnowledgeBase, inputs::Tuple{Symbol}, n::Int)

adds a residual layer mixing `inputs` in `kb` KnowledgeBase over `n` items
"""
function add_residual_layer(kb::KnowledgeBase, inputs::NTuple{N,Symbol}, n::Int, prefix="res") where {N}
    childs = map(s -> ArrayNode(KBEntry(s, 1:n)), inputs)
    ds = ProductNode(childs)
    append(kb, layer_name(kb, prefix), ds)
end

"""
layer_name(kb::KnowledgeBase, prefix)

create a unique name of the layer for KnowledgeBase `kb`
"""
layer_name(kb::KnowledgeBase{KS,<:Any}, prefix) where {KS} = Symbol(prefix * "_$(length(KS)+1)")




"""
feature_vectors(ex::ObjPairBin, state) 

Creates a matrix with one column per pairs of objects and encode by one-hot-encoding
"""
function feature_vectors(ex::ObjPairBin, state)

    idim = 2 * (length(ex.unary_predicates) + length(ex.objtype2id) + length(ex.constmap)) + length(ex.multiarg_predicates) + length(ex.nullary_predicates) + length(ex.multiarg_predicates)
    x = zeros(Float32, idim, length(ex.pairs))



    # 2 * (

    # unary_predicates  


    # encode constants



    # encode types of objects

    # )



    # nullary_predicates



    # multiarg_predicates


end


"""
nunary_predicates(ex::ObjPairBin, state)

Create matrix with one column per object and encode by one-hot-encoding unary predicates 
and types of objects. Nunary predicates are encoded as properties of all objects.
"""
function nunary_predicates(ex::ObjPairBin, state)
    # first, we completely specify the matrix with properties
    idim = length(ex.nunanary_predicates) + length(ex.objtype2id) + length(ex.constmap)
    x = zeros(Float32, idim, length(ex.obj2id))

    # encode constants
    offset = length(ex.nunanary_predicates) + length(ex.objtype2id)
    for (k, i) in ex.constmap
        j = ex.obj2id[k]
        x[offset+i, j] = 1
    end

    # encode types of objects
    for s in state.types
        i = ex.objtype2id[s.name]
        j = ex.obj2id[only(s.args).name]
        x[i, j] = 1
    end

    for f in filter(f -> length(get_args(f)) < 2, get_facts(state))
        v = 1
        if (f isa PDDL.Compound) && (f.name == :not)
            f = only(f.args)
            v = 0
        end
        a = get_args(f)
        pid = ex.nunanary_predicates[f.name]
        if length(a) == 1
            vid = ex.obj2id[only(get_args(f)).name]
            x[pid, vid] = v
        else
            length(a) == 0
            x[pid, :] .= v
        end
    end
    x
end


function multi_predicates(ex::ObjPairBin, kid::Symbol, state, prefix=nothing)
    # Then, we specify the predicates the dirty way
    ks = ex.multiarg_predicates
    xs = map(ks) do k
        preds = filter(f -> f.name == k, get_facts(state))
        encode_predicates(ex, k, preds, kid)
    end
    ns = isnothing(prefix) ? ks : tuple([Symbol(prefix, "_", k) for k in ks]...)
    ProductNode(NamedTuple{ns}(xs))
end

function encode_predicates(ex::ObjPairBin, pname::Symbol, preds, kid::Symbol)


    p = ex.domain.predicates[pname]
    obj2id = ex.obj2id
    constmap = ex.constmap

    xs = map(collect(preds)) do f
        [[obj2id[f.args[i].name], obj2id[f.args[j].name]] for i in 1:length(f.args)-1 for j in i+1:length(f.args)]
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
    ObjPairBin(ex.domain, ex.multiarg_predicates, ex.unary_predicates, ex.nullary_predicates, ex.objtype2id, ex.constmap, ex.model_params, ex.obj2id, ex.obj2pid, ex.pairs, nothing, exg)
end

function add_initstate(ex::ObjPairBin, problem, start=initstate(ex.domain, problem))
    ex = isspecialized(ex) ? ex : specialize(ex, problem)
    exg = encode_state(ex, start, :start)
    ObjPairBin(ex.domain, ex.multiarg_predicates, ex.unary_predicates, ex.nullary_predicates, ex.objtype2id, ex.constmap, ex.model_params, ex.obj2id, ex.obj2pid, ex.pairs, exg, nothing)
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

function stack_hypergraphs(kb1::KnowledgeBase{KX,V1}, kb2::KnowledgeBase{KX,V2}) where {KX,V1,V2}
    x = vcat(kb1[:x1], kb2[:x1])
    gp = map(KX[2:end-1]) do k
        if _isstackable(kb1[k], kb2[k])
            ProductNode(merge(kb1[k].data, kb2[k].data))
        else
            kb1[k]
        end
    end
    KnowledgeBase(NamedTuple{KX}(tuple(x, gp..., kb1.kb[end])))
end


"""
Checks if two ProductNodes should be stacked on top of each other. 
"""
function _isstackable(ds1::ProductNode{<:NamedTuple}, ds2::ProductNode{<:NamedTuple})
    return (true)
end
_isstackable(ds1, ds2) = false