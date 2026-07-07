using Documenter: Documenter, DocMeta, deploydocs, makedocs
using ITensorFormatter: ITensorFormatter
using ITensorsITensorBaseCompat: ITensorsITensorBaseCompat

DocMeta.setdocmeta!(
    ITensorsITensorBaseCompat, :DocTestSetup, :(using ITensorsITensorBaseCompat);
    recursive = true
)

ITensorFormatter.make_index!(pkgdir(ITensorsITensorBaseCompat))

makedocs(;
    modules = [ITensorsITensorBaseCompat],
    authors = "ITensor developers <support@itensor.org> and contributors",
    sitename = "ITensorsITensorBaseCompat.jl",
    format = Documenter.HTML(;
        canonical = "https://itensor.github.io/ITensorsITensorBaseCompat.jl",
        edit_link = "main",
        assets = ["assets/favicon.ico", "assets/extras.css"]
    ),
    pages = ["Home" => "index.md", "Reference" => "reference.md"]
)

deploydocs(;
    repo = "github.com/ITensor/ITensorsITensorBaseCompat.jl", devbranch = "main",
    push_preview = true
)
