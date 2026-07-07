using Aqua: Aqua
using ITensorsITensorBaseCompat: ITensorsITensorBaseCompat
using Test: @testset

@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(ITensorsITensorBaseCompat)
end
