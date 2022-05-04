using PyPlotly
using PyCall

using Test

py"""
import inspect
def create_symbols(mod, target):
    symbols = []
    for attr in mod.__all__:
        if attr.startswith("_"):
            continue
        satisfy = eval(f"inspect.{target}(mod.{attr})")
        if satisfy:
            symbols.append(attr)
    return symbols
"""

create_symbols(mod::PyObject, target) = Symbol.(py"create_symbols"(mod, target))

@testset "constants" begin
    @test PyPlotly.GraphObjects.go_classes ==
          create_symbols(plotly.graph_objects, "isclass")
    @test PyPlotly.Express.px_functions == create_symbols(plotly.express, "isfunction")
    @test PyPlotly.Express.px_classes == create_symbols(plotly.express, "isclass")
end

@testset "PyPlotly.jl" begin
    # Write your tests here.
end
