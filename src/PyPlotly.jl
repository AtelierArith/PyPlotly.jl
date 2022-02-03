module PyPlotly

using Reexport: @reexport
using JSON
using PlotlyJS: PlotlyJS


include("plotly.jl")
@reexport using .Plotly

include("graph_objects.jl")
@reexport using .GraphObjects

include("express.jl")
@reexport using .Express

function create_plotlyjs(fig::GraphObjects.Figure)
    jsonobj = JSON.parse(fig.to_json())
    traces = PlotlyJS.GenericTrace.(jsonobj["data"])
    layout = PlotlyJS.Layout(jsonobj["layout"])
    return PlotlyJS.plot(traces, layout)
end

Base.show(io::IO, mime::MIME, fig::GraphObjects.Figure) = show(io, mime, create_plotlyjs(fig))
Base.display(::PlotlyJS.PlotlyJSDisplay, fig::GraphObjects.Figure) = PlotlyJS.display_blink(create_plotlyjs(fig))

end
