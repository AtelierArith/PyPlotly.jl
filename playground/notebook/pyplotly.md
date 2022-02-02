---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.6
  kernelspec:
    display_name: julia 1.7.1
    language: julia
    name: julia-1.7
---

```julia
using PyPlotly
using PyPlotly.GraphObjects
using PyPlotly.Express
```

```julia
go.Figure(
    data=Dict(
        :x=>[1,2,3],
        :y=>[1,2,3],
    )
)
```

```julia
go
```

```julia
df = px.data.election()
fig = px.scatter_ternary(df, a="Joly", b="Coderre", c="Bergeron")
fig.show()
```
