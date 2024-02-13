module NeuroPlanner

using PDDL
using Julog
using Graphs
using Flux
using OneHotArrays
using Statistics
using SymbolicPlanners
using StatsBase
using Mill
using MLUtils
using DataStructures
using HierarchicalUtils
using ChainRulesCore
using Accessors
using Reexport

include("mill_extension/MillExt.jl")
@reexport using .MillExtension

"""
initproblem(ex, problem; add_goal = true)

Specialize extractor for the given problem instance and return init state 
"""
function initproblem(ex, problem; add_goal=true)
    ex = specialize(ex, problem)
    pddle = add_goal ? add_goalstate(ex, problem) : ex
    pddle, initstate(ex.domain, problem)
end
export initproblem


include("relational/knowledge_base.jl")
include("relational/knowledge_model.jl")
export KBEntry, KnowledgeBase, append

include("lifted_relational/MixedLRNN/extractor.jl")
include("lifted_relational/LRNN/extractor.jl")
include("lifted_relational/deduplication.jl")
include("lifted_relational/dedu_matrix.jl")
export MixedLRNN, LRNN, deduplicate

include("lifted_relational/mha.jl")
export MultiheadAttention

include("asnets/extractor.jl")
export ASNet

include("levin_asnet/extractor.jl")
include("levin_asnet/loss.jl")
include("levin_asnet/bfs_planner.jl")
export LevinASNet, BFSPlanner

include("hgnn/extractor.jl")
export HGNNLite, HGNN

include("potential/extractor.jl")
export LinearExtractor

include("rsearch_tree.jl")
include("losses.jl")
export L₂MiniBatch, LₛMiniBatch, LRTMiniBatch, LgbfsMiniBatch

include("artificial_goals.jl")
include("sample_trace.jl")
export sample_trace, sample_forward_trace, sample_backward_trace, sample_backward_tree, search_tree_from_trajectory
export BackwardSampler

include("heuristic.jl")
export NeuroHeuristic

export add_goalstate, add_initstate, specialize

MLUtils.batch(xs::AbstractVector{<:AbstractMillNode}) = reduce(catobs, xs)
end
