module Express

using ..GraphObjects: Figure

using PyCall

export px

struct Px end
px = Px()

const plotly = PyNULL()
const express = PyNULL()

const px_functions = [
    :absolute_import,
    :optional_imports,
    :pd,
    :trendline_functions,
    :imshow_utils,
    :imshow,
    :scatter,
    :scatter_3d,
    :scatter_polar,
    :scatter_ternary,
    :scatter_mapbox,
    :scatter_geo,
    :line,
    :line_3d,
    :line_polar,
    :line_ternary,
    :line_mapbox,
    :line_geo,
    :area,
    :bar,
    :timeline,
    :bar_polar,
    :violin,
    :box,
    :strip,
    :histogram,
    :ecdf,
    :scatter_matrix,
    :parallel_coordinates,
    :parallel_categories,
    :choropleth,
    :density_contour,
    :density_heatmap,
    :pie,
    :sunburst,
    :treemap,
    :icicle,
    :funnel,
    :funnel_area,
    :choropleth_mapbox,
    :density_mapbox,
    :set_mapbox_access_token,
    :defaults,
    :get_trendline_results,
    :data,
    :colors
]

sym2obj = Dict{Symbol, Union{Function, DataType}}()

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

const px_classes = [:IdentityMap, :Constant, :Range]
for class in px_classes
    @eval begin
        struct $(class)
            pyobj::PyObject
            function $(class)(args..., ; kwargs...)
                new(graph_objects.$(class)(args...; kwargs...))
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

Base.getproperty(px::Px, s::Symbol)= sym2obj[s]
Base.propertynames(px::Px)= px_functions

function __init__()
    pyimport_conda("pandas", "pandas")
    copy!(plotly, pyimport_conda("plotly", "plotly", "plotly"))
    copy!(express, pyimport_conda("plotly.express", "plotly", "plotly"))
end
# Write your package code here.

end
