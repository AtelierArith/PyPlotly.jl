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
using PyCall
```

```julia
using PyPlotly
```

```julia
go.Figure(
    data=Dict(
        :x=>[1,2,3],
        :y=>[1,5,3],
    )
)
```

```julia
fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
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

```julia
using PyCall
```

```julia
np = pyimport("numpy") # sorry i'm so lazy...

sklearn = pyimport("sklearn")
datasets = pyimport("sklearn.datasets")
make_moons = datasets.make_moons
model_selection = pyimport("sklearn.model_selection")
neighbors = pyimport("sklearn.neighbors")

train_test_split = model_selection.train_test_split
KNeighborsClassifier =  neighbors.KNeighborsClassifier
```

```julia
# Load and split data
X, y = make_moons(noise=0.3, random_state=0)
X_train, X_test, y_train, y_test = train_test_split(
    X, string.(y), test_size=0.25, random_state=0
)

trace_specs = [
    [X_train, y_train, "0", "Train", "square"],
    [X_train, y_train, "1", "Train", "circle"],
    [X_test, y_test, "0", "Test", "square-dot"],
    [X_test, y_test, "1", "Test", "circle-dot"],
];
```

```julia
fig = go.Figure(
    data=[
        go.Scatter(
            x=X[y .== label, begin],
            y=X[y .== label, begin+1],
            name="$(split) Split, Label $(label)",
            mode="markers",
            marker_symbol=marker,
        )
        for (X, y, label, split, marker) in trace_specs
    ]
)

fig.update_traces(marker_size=12, marker_line_width=1.5, marker_color="lightyellow")
```

```julia
cat(rand(10), rand(10),dims=2)
```

```julia
mesh_size = 0.02
margin = 0.25

# Load and split data
X, y = make_moons(noise=0.3, random_state=0)
X_train, X_test, y_train, y_test = train_test_split(
    X, string.(y), test_size=0.25, random_state=0
)

# Create a mesh grid on which we will run our model
x_min, x_max = minimum(X[:, begin]) - margin, maximum(X[:, begin]) + margin
y_min, y_max = minimum(X[:, begin+1]) - margin, maximum(X[:, begin+1]) + margin
xrange = np.arange(x_min, x_max, mesh_size)
yrange = np.arange(y_min, y_max, mesh_size)
xx, yy = np.meshgrid(xrange, yrange)

# Create classifier, run predictions on grid
clf = KNeighborsClassifier(15, weights="uniform")
clf.fit(X, y)
Z = clf.predict_proba(cat(xx |> vec, yy |> vec, dims=2))[:, begin+1]
Z = reshape(Z, xx |> size)

trace_specs = [
    [X_train, y_train, "0", "Train", "square"],
    [X_train, y_train, "1", "Train", "circle"],
    [X_test, y_test, "0", "Test", "square-dot"],
    [X_test, y_test, "1", "Test", "circle-dot"],
]

fig = go.Figure(
    data=[
        go.Scatter(
            x=X[y .== label, begin],
            y=X[y .== label, begin+1],
            name="$(split) Split, Label $(label)",
            mode="markers",
            marker_symbol=marker,
        )
        for (X, y, label, split, marker) in trace_specs
    ]
)
fig.update_traces(marker_size=12, marker_line_width=1.5, marker_color="lightyellow")

fig.add_trace(
    go.Contour(
        x=xrange,
        y=yrange,
        z=Z,
        showscale=false,
        colorscale="RdBu",
        opacity=0.4,
        name="Score",
        hoverinfo="skip",
    )
)

fig
```

```julia
using PyPlotly
using Random
Random.seed!(0)

N = 100
random_x = range(0, 1, length=N)
random_y0 = randn(N) .+ 5
random_y1 = randn(N)
random_y2 = randn(N) .- 5

fig = go.Figure()

# Add traces
fig.add_trace(go.Scatter(x=random_x, y=random_y0,
                    mode="markers",
                    name="markers"))
fig.add_trace(go.Scatter(x=random_x, y=random_y1,
                    mode="lines+markers",
                    name="lines+markers"))
fig.add_trace(go.Scatter(x=random_x, y=random_y2,
                    mode="lines",
                    name="lines"))

fig
```
