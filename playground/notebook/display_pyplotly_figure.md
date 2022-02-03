---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.5
  kernelspec:
    display_name: Julia-sys 1.7.1
    language: julia
    name: julia-sys-1.7
---

```julia
using JSON
using PlotlyJS: PlotlyJS

using PyPlotly.GraphObjects
using PyPlotly.Express
```

```julia
function Base.show(io::IO, mime::MIME, fig::GraphObjects.Figure)
    jsonobj = JSON.parse(fig.to_json())
    traces = PlotlyJS.GenericTrace.(jsonobj["data"])
    layout = PlotlyJS.Layout(jsonobj["layout"])
    show(io, mime, PlotlyJS.plot(traces, layout))
end
```

```julia
fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
fig
```

```julia
fig = go.Figure(
    go.Scatter(
        x=[1,2,3],
        y=[1,4,2],
    )
)

jsonobj = JSON.parse(fig.to_json())
traces = PlotlyJS.GenericTrace.(jsonobj["data"])
layout = PlotlyJS.Layout(jsonobj["layout"])
PlotlyJS.plot(traces, layout)
```
