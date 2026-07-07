# The names in this submodule are the ones that live in `NDTensors` in the real
# ecosystem (`ITensors` re-exports `NDTensors`). They are collected here so that both
# `ITensorsITensorBaseCompat.NDTensors.<name>` and, via the re-export in the sibling
# `ITensors` submodule, `ITensorsITensorBaseCompat.ITensors.<name>` resolve.
module NDTensors

using BackendSelection: @Algorithm_str, Algorithm
using ITensorBase: ITensorBase, AbstractITensor, inds, unnamed

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
# Diagonal manipulation. Legacy `map_diag(f, T)` applies `f` to the diagonal of a
# (diagonal-like) tensor; used on factorization spectra (singular values /
# eigenvalues). Reproduced via the same diagonal machinery as `delta`.
_diagcartesian(arr, k) = CartesianIndex(ntuple(Returns(k), ndims(arr)))
function map_diag(f, T::AbstractITensor)
    arr = copy(unnamed(T))
    for k in 1:minimum(size(arr))
        idx = _diagcartesian(arr, k)
        arr[idx] = f(arr[idx])
    end
    return arr[inds(T)...]
end
function map_diag!(f, T::AbstractITensor)
    arr = unnamed(T)
    for k in 1:minimum(size(arr))
        idx = _diagcartesian(arr, k)
        arr[idx] = f(arr[idx])
    end
    return T
end
# Out-of-place-into-`dest` form `map_diag!(f, dest, src)`: write `f` of `src`'s diagonal
# onto `dest`'s diagonal (TNQS calls it with `dest === src` for an in-place diagonal map).
function map_diag!(f, dest::AbstractITensor, src::AbstractITensor)
    d, s = unnamed(dest), unnamed(src)
    for k in 1:minimum(size(s))
        d[_diagcartesian(d, k)] = f(s[_diagcartesian(s, k)])
    end
    return dest
end

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
