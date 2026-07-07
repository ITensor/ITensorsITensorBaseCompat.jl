# Compatibility layer providing the legacy `ITensors.jl` API, implemented over the
# next-gen `ITensorBase.jl` backend. A user replaces `using ITensors` with
# `using ITensorsITensorBaseCompat.ITensors` (and, where needed, the `NDTensors` names
# via `using ITensorsITensorBaseCompat.NDTensors`) and legacy code keeps working with
# minimal changes.
#
# The API is split into two submodules mirroring ITensors.jl's own namespacing:
#   - `NDTensors` holds the names that live in `NDTensors` in the real ecosystem.
#   - `ITensors` holds everything else and re-exports `NDTensors` (as legacy
#     `ITensors` does), so an `ITensors`-scoped import sees the `NDTensors` names too.
module ITensorsITensorBaseCompat

include("NDTensors.jl")
include("ITensors.jl")

end
