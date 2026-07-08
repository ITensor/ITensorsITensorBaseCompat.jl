# The legacy `ITensors.jl` API implemented over the next-gen `ITensorBase.jl` backend.
#
# Names that would shadow a `Base`, `LinearAlgebra`, or `ITensorBase` function (`exp`, the
# `svd`/`qr`/`eigen`/`factorize` factorizations, and `inds`/`prime`/`noprime`/`apply`/`state`)
# are defined below but deliberately not exported, so they don't collide when one of those
# packages is also in scope. Reach them qualified, e.g. `ITensors.svd`, as with `tr`. (They
# would ideally be `public` instead, but that needs Julia >= 1.11 and this package still
# supports 1.10.) Everything else is exported for `using ITensorsITensorBaseCompat.ITensors`.
module ITensors

# Re-export the names that live in the `NDTensors` submodule — legacy `ITensors`
# re-exports `NDTensors`, so `using ITensorsITensorBaseCompat.ITensors: scalartype` must
# also work — and bring in the ones this submodule's own methods build on
# (`scalartype` / `datatype`).
import ..NDTensors: map_diag, map_diag!
import Base: truncate
using ..NDTensors: @Algorithm_str, Algorithm, data, datatype, dense, denseblocks, scalartype

include("itensor.jl")

# The operator / named-state system lives in the `SiteTypes` submodule, matching real
# ITensors.jl (`ITensors.SiteTypes`); `ITensors` re-exports its names below, so both
# `ITensors.op` and `ITensors.SiteTypes.op` resolve to the same binding.
include("SiteTypes.jl")
using .SiteTypes: @OpName_str, @SiteType_str, OpName, SiteType, op, state

export
    # Index access and set algebra
    commoninds, commonind, uniqueinds, noncommonind, noncommoninds, unioninds,
    hascommoninds,
    # Index operations
    sim, dag, replaceind, replaceinds, dim, swapind,
    # ITensor construction
    itensor, random_itensor, scalar, delta, onehot, combiner, combinedind,
    # Factorizations
    factorize_svd,
    # Diagonal manipulation
    map_diag, map_diag!,
    # Storage / element-type accessors
    scalartype, datatype, array, data,
    # Dense / quantum-number no-ops
    denseblocks, dense, hasqns,
    # Contraction and inner product
    contract, inner,
    # Direct sum and misc legacy helpers
    directsum, disable_warn_order,
    # Algorithm dispatch tag
    Algorithm, @Algorithm_str,
    # Tags
    hastags,
    # Operator / named-state system
    op, OpName, SiteType, @OpName_str, @SiteType_str,
    # Bond truncation (bound to `Base.truncate`)
    truncate

end
