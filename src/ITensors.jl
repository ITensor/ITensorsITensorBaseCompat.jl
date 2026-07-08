# The legacy `ITensors.jl` API implemented over the next-gen `ITensorBase.jl` backend.
# The export list below is the spec for what this compat layer covers.
#
# Export vs `public`: used as `using ITensorBase; using ITensorsITensorBaseCompat`, the
# names ITensorBase also exports (`apply`, `prime`, `noprime`, `state`) would ideally be
# declared `public` rather than `export`ed, so they don't shadow ITensorBase's versions
# — a consumer wanting the legacy semantics imports them explicitly. Here every name is
# exported instead: consumers reach for this API through `using
# ITensorsITensorBaseCompat.ITensors`, where there is no collision to avoid, and
# `public` would force Julia >= 1.11 while this package still supports 1.10.
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
    inds, commoninds, commonind, uniqueinds, noncommonind, noncommoninds, unioninds,
    hascommoninds,
    # Index operations
    sim, dag, prime, noprime, replaceind, replaceinds, dim, swapind,
    # ITensor construction
    itensor, random_itensor, scalar, delta, onehot, combiner, combinedind,
    # Factorizations
    qr, svd, eigen, factorize, factorize_svd,
    # Diagonal manipulation
    map_diag, map_diag!,
    # Operator exponential
    exp,
    # Storage / element-type accessors
    scalartype, datatype, array, data,
    # Dense / quantum-number no-ops
    denseblocks, dense, hasqns,
    # Contraction, inner product, gate application
    contract, inner, apply,
    # Direct sum and misc legacy helpers
    directsum, disable_warn_order,
    # Algorithm dispatch tag
    Algorithm, @Algorithm_str,
    # Tags
    hastags,
    # Operator / named-state system
    state, op, OpName, SiteType, @OpName_str, @SiteType_str,
    # Bond truncation (bound to `Base.truncate`)
    truncate

end
