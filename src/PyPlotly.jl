module PyPlotly

using REPL
using Reexport: @reexport
using JSON

include("plotly.jl")
@reexport using .Plotly

include("graph_objects.jl")
@reexport using .GraphObjects

include("express.jl")
@reexport using .Express

Base.show(io, mime::MIME"text/html", fig::GraphObjects.Figure) = show(io, mime, fig.pyobj)

# Call fig.show() when one is trying to display `fig` object from Julia REPL
Base.display(d::REPL.REPLDisplay, fig::GraphObjects.Figure) = fig.show()
end

end
