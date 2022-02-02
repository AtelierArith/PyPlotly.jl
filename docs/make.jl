using PyPlotly
using Documenter

DocMeta.setdocmeta!(PyPlotly, :DocTestSetup, :(using PyPlotly); recursive=true)

makedocs(;
    modules=[PyPlotly],
    authors="SatoshiTerasaki <terasakisatoshi.math@gmail.com> and contributors",
    repo="https://github.com/AtelierArith/PyPlotly.jl/blob/{commit}{path}#{line}",
    sitename="PyPlotly.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://AtelierArith.github.io/PyPlotly.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/AtelierArith/PyPlotly.jl",
    devbranch="main",
)
