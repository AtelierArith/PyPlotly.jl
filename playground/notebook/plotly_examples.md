---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.6
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

```python
import plotly
```

```python
go = plotly.graph_objects
go.Figure(
    data={
        "x": [1, 2, 3],
        "y": [1, 2, 3],
    }
)
```

```python
df = px.data.iris()
fig = px.scatter(
    df,
    x="sepal_width",
    y="sepal_length",
    color="species",
    size="petal_length",
    hover_data=["petal_width"],
)
fig.show()
```

```python
import numpy as np
import plotly.graph_objects as go
from sklearn.datasets import make_moons
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

# Load and split data
X, y = make_moons(noise=0.3, random_state=0)
X_train, X_test, y_train, y_test = train_test_split(
    X, y.astype(str), test_size=0.25, random_state=0
)

trace_specs = [
    [X_train, y_train, "0", "Train", "square"],
    [X_train, y_train, "1", "Train", "circle"],
    [X_test, y_test, "0", "Test", "square-dot"],
    [X_test, y_test, "1", "Test", "circle-dot"],
]

fig = go.Figure(
    data=[
        go.Scatter(
            x=X[y == label, 0],
            y=X[y == label, 1],
            name=f"{split} Split, Label {label}",
            mode="markers",
            marker_symbol=marker,
        )
        for X, y, label, split, marker in trace_specs
    ]
)
fig.update_traces(marker_size=12, marker_line_width=1.5, marker_color="lightyellow")
```

```python
mesh_size = 0.02
margin = 0.25

# Load and split data
X, y = make_moons(noise=0.3, random_state=0)
X_train, X_test, y_train, y_test = train_test_split(
    X, y.astype(str), test_size=0.25, random_state=0
)

# Create a mesh grid on which we will run our model
x_min, x_max = X[:, 0].min() - margin, X[:, 0].max() + margin
y_min, y_max = X[:, 1].min() - margin, X[:, 1].max() + margin
xrange = np.arange(x_min, x_max, mesh_size)
yrange = np.arange(y_min, y_max, mesh_size)
xx, yy = np.meshgrid(xrange, yrange)

# Create classifier, run predictions on grid
clf = KNeighborsClassifier(15, weights="uniform")
clf.fit(X, y)
Z = clf.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:, 1]
Z = Z.reshape(xx.shape)

trace_specs = [
    [X_train, y_train, "0", "Train", "square"],
    [X_train, y_train, "1", "Train", "circle"],
    [X_test, y_test, "0", "Test", "square-dot"],
    [X_test, y_test, "1", "Test", "circle-dot"],
]

fig = go.Figure(
    data=[
        go.Scatter(
            x=X[y == label, 0],
            y=X[y == label, 1],
            name=f"{split} Split, Label {label}",
            mode="markers",
            marker_symbol=marker,
        )
        for X, y, label, split, marker in trace_specs
    ]
)
fig.update_traces(marker_size=12, marker_line_width=1.5, marker_color="lightyellow")

fig.add_trace(
    go.Contour(
        x=xrange,
        y=yrange,
        z=Z,
        showscale=False,
        colorscale="RdBu",
        opacity=0.4,
        name="Score",
        hoverinfo="skip",
    )
)
```

```python
np.c_[xx.ravel(), yy.ravel()].shape
```
