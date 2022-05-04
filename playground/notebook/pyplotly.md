```julia
using PyPlotly
```

```julia
fig = go.Figure(
    data=Dict(
        :x=>[1,2,3],
        :y=>[1,2,3],
    )
)

fig
```

```julia
df = px.data.iris()
fig = px.scatter(
    df,
    x="sepal_width",
    y="sepal_length",
    color="species",
    size="petal_length",
    hover_data=["petal_width"],
)
fig
```
