# The names in this submodule are the ones that live in `NDTensors` in the real
# ecosystem (`ITensors` re-exports `NDTensors`). They are collected here so that both
# `ITensorsITensorBaseCompat.NDTensors.<name>` and, via the re-export in the sibling
# `ITensors` submodule, `ITensorsITensorBaseCompat.ITensors.<name>` resolve.
module NDTensors

using BackendSelection: @Algorithm_str, Algorithm
using ITensorBase: ITensorBase, AbstractITensor, unnamed

#
# Storage / element type accessors. `scalartype` is the scalar (element) type;
# `datatype` is the underlying storage array type (used by `adapt`); `data` exposes
# the plain unnamed array.
scalartype(x) = ITensorBase.scalartype(x)
datatype(T::AbstractITensor) = typeof(unnamed(T))
data(T::AbstractITensor) = unnamed(T)

# Dense no-ops. Legacy QN-storage helpers; on the dense next-gen backend the tensor
# is already dense, so these are identities. (Graded/QN path is a stack gap.)
denseblocks(T::AbstractITensor) = T
dense(T::AbstractITensor) = T

#
# Diagonal manipulation. Legacy `map_diag(f, T)` / `map_diag!` apply `f` to a tensor's
# diagonal (used on factorization spectra). These names belong to `NDTensors` in the real
# ecosystem, so the generic functions live here; the `AbstractITensor` methods are defined
# in the sibling `ITensors` submodule, the layer that owns the tensor type.
function map_diag end
function map_diag! end

# The algorithm dispatch tag (legacy `Algorithm` / `@Algorithm_str`) comes from
# BackendSelection.jl, which NDTensors re-exports in the real ecosystem; imported above
# and re-exported below.

export
    # Storage / element-type accessors
    scalartype, datatype, data,
    # Dense / quantum-number no-ops
    denseblocks, dense,
    # Diagonal manipulation
    map_diag, map_diag!,
    # Algorithm dispatch tag
    Algorithm, @Algorithm_str

end
