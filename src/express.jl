module Express

using ..GraphObjects: Figure

using PyCall

abstract type PxModule end
abstract type PxClass end
export px

struct Px end
px = Px()

const plotly = PyNULL()
const express = PyNULL()

const px_functions = [
    :scatter,
    :scatter_3d,
    :scatter_polar,
    :scatter_ternary,
    :scatter_mapbox,
    :scatter_geo,
    :scatter_matrix,
    :density_contour,
    :density_heatmap,
    :density_mapbox,
    :line,
    :line_3d,
    :line_polar,
    :line_ternary,
    :line_mapbox,
    :line_geo,
    :parallel_coordinates,
    :parallel_categories,
    :area,
    :bar,
    :timeline,
    :bar_polar,
    :violin,
    :box,
    :strip,
    :histogram,
    :ecdf,
    :choropleth,
    :choropleth_mapbox,
    :pie,
    :sunburst,
    :treemap,
    :icicle,
    :funnel,
    :funnel_area,
    :imshow,
    :set_mapbox_access_token,
    :get_trendline_results,
]

sym2obj = Dict{Symbol,Union{Function,DataType}}()

for func in px_functions
    @eval begin
        function $(func)(args...; kwargs...)
            ret = express.$(func)(args...; kwargs...)
            if pybuiltin("isinstance")(ret, plotly.graph_objs._figure.Figure)
                Figure(ret)
            end
        end
        sym2obj[nameof($func)] = $func
    end
end

const px_modules = [:data, :colors, :trendline_functions]

for m in px_modules
    @eval begin
        struct $(m) <: PxModule
            pyobj::PyObject
            $(m)() = new(getproperty(express, nameof($m)))
        end

        PyObject(t::$(m)) = t.pyobj

        function Base.propertynames(t::$(m))
            propertynames(getfield(t, :pyobj))
        end

        function Base.getproperty(t::$(m), s::Symbol)
            if s in fieldnames($(m))
                return getfield(t, s)
            else
                return getproperty(getfield(t, :pyobj), s)
            end
        end
        sym2obj[nameof($m)] = $(m)
    end
end

const px_classes = [:IdentityMap, :Constant, :Range]
for class in px_classes
    @eval begin
        struct $(class) <: PxClass
            pyobj::PyObject
            function $(class)(args..., ; kwargs...)
                new(express.$(class)(args...; kwargs...))
            end
        end

        PyObject(t::$(class)) = t.pyobj

        function Base.propertynames(t::$(class))
            propertynames(getfield(t, :pyobj))
        end

        function Base.getproperty(t::$(class), s::Symbol)
            if s in fieldnames($(class))
                return getfield(t, s)
            else
                return getproperty(getfield(t, :pyobj), s)
            end
        end
        sym2obj[nameof($class)] = $(class)
    end
end

function Base.getproperty(px::Px, s::Symbol)
    if s in fieldnames(Px)
        return getfield(px, s)
    else
        if s in px_modules
            return sym2obj[s]().pyobj
        else
            return sym2obj[s]
        end
    end
end
Base.propertynames(px::Px) = vcat(px_functions, px_modules, px_classes)

function __init__()
    pyimport_conda("pandas", "pandas")
    copy!(plotly, pyimport_conda("plotly", "plotly", "plotly"))
    copy!(express, pyimport_conda("plotly.express", "plotly", "plotly"))
end
# Write your package code here.

end
