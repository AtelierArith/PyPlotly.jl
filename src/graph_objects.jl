module GraphObjects

using PyCall

export go

const plotly = PyNULL()
const go = PyNULL()

graph_objects_classes = Symbol[
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

for class in graph_objects_classes
    @eval begin
        struct $class
            pyobj::PyObject
            $(class)(args..., ; kwargs...) = new(go.$(class)(args...; kwargs...))
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

        export $(class)
    end
end


function __init__()
    copy!(plotly, pyimport_conda("plotly", "plotly", "plotly"))
    copy!(go, pyimport_conda("plotly.graph_objects", "plotly", "plotly"))
end

end
