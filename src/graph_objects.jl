module GraphObjects

using PyCall

export go

const graph_objects = PyNULL()

struct Go end
const go = Go()


const go_classes = Symbol[
    :Waterfall,
    :Volume,
    :Violin,
    :Treemap,
    :Table,
    :Surface,
    :Sunburst,
    :Streamtube,
    :Splom,
    :Scatterternary,
    :Scattersmith,
    :Scatterpolargl,
    :Scatterpolar,
    :Scattermapbox,
    :Scattergl,
    :Scattergeo,
    :Scattercarpet,
    :Scatter3d,
    :Scatter,
    :Sankey,
    :Pointcloud,
    :Pie,
    :Parcoords,
    :Parcats,
    :Ohlc,
    :Mesh3d,
    :Isosurface,
    :Indicator,
    :Image,
    :Icicle,
    :Histogram2dContour,
    :Histogram2d,
    :Histogram,
    :Heatmapgl,
    :Heatmap,
    :Funnelarea,
    :Funnel,
    :Densitymapbox,
    :Contourcarpet,
    :Contour,
    :Cone,
    :Choroplethmapbox,
    :Choropleth,
    :Carpet,
    :Candlestick,
    :Box,
    :Barpolar,
    :Bar,
    :Layout,
    :Frame,
    :Figure,
    :Data,
    :Annotations,
    :Frames,
    :AngularAxis,
    :Annotation,
    :ColorBar,
    :Contours,
    :ErrorX,
    :ErrorY,
    :ErrorZ,
    :Font,
    :Legend,
    :Line,
    :Margin,
    :Marker,
    :RadialAxis,
    :Scene,
    :Stream,
    :XAxis,
    :YAxis,
    :ZAxis,
    :XBins,
    :YBins,
    :Trace,
    :Histogram2dcontour,
    :FigureWidget,
]

sym2obj = Dict{Symbol, Union{Function, DataType}}()

for class in go_classes
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

const go_methods = [
:waterfall,
 :volume,
 :violin,
 :treemap,
 :table,
 :surface,
 :sunburst,
 :streamtube,
 :splom,
 :scatterternary,
 :scattersmith,
 :scatterpolargl,
 :scatterpolar,
 :scattermapbox,
 :scattergl,
 :scattergeo,
 :scattercarpet,
 :scatter3d,
 :scatter,
 :sankey,
 :pointcloud,
 :pie,
 :parcoords,
 :parcats,
 :ohlc,
 :mesh3d,
 :isosurface,
 :indicator,
 :image,
 :icicle,
 :histogram2dcontour,
 :histogram2d,
 :histogram,
 :heatmapgl,
 :heatmap,
 :funnelarea,
 :funnel,
 :densitymapbox,
 :contourcarpet,
 :contour,
 :cone,
 :choroplethmapbox,
 :choropleth,
 :carpet,
 :candlestick,
 :box,
 :barpolar,
 :bar,
 :layout
 ]

for func in go_methods
    @eval begin
        function $(func)(args...; kwargs...)
            graph_objects.$(func)(args...; kwargs...)
        end
        sym2obj[nameof($func)] = $func
    end
end

function Base.getproperty(go::Go, s::Symbol)
    if s in fieldnames(Go)
        getfield(go, s)
    else
        sym2obj[s]
    end
end

Base.propertynames(go::Go) = vcat(go_methods, go_classes)

function __init__()
    copy!(graph_objects, pyimport_conda("plotly.graph_objects", "plotly", "plotly"))
end

end
