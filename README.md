# PyPlotly 

[![Build Status](https://github.com/AtelierArith/PyPlotly.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/AtelierArith/PyPlotly.jl/actions/workflows/CI.yml?query=branch%3Amain) 

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://AtelierArith.github.io/PyPlotly.jl/stable) 

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://AtelierArith.github.io/PyPlotly.jl/dev)

# Introduction

I know there are Plotly.jl and PlotlyJS.jl. But, it would be nice to provide a Pythonista-friendly Julia interface for plotly since there are lots of examples on the internet regarding plotly written in Python.

# Just give it a try

```console
$ pip3 install numpy pandas plotly
$ git clone https://github.com/AtelierArith/PyPlotly.jl.git
$ cd PyPlotly
$ julia --project=@. -e 'using Pkg; Pkg.isinstance()'
```

# How to use

Let's assume you've written a Python script something like:

```python
import plotly.graph_objects as go

# Create random data with numpy
import numpy as np
np.random.seed(1)

N = 100
random_x = np.linspace(0, 1, N)
random_y0 = np.random.randn(N) + 5
random_y1 = np.random.randn(N)
random_y2 = np.random.randn(N) - 5

fig = go.Figure()

# Add traces
fig.add_trace(go.Scatter(x=random_x, y=random_y0,
                    mode='markers',
                    name='markers'))
fig.add_trace(go.Scatter(x=random_x, y=random_y1,
                    mode='lines+markers',
                    name='lines+markers'))
fig.add_trace(go.Scatter(x=random_x, y=random_y2,
                    mode='lines',
                    name='lines'))

fig.show()
```

The example above is taken from [Line and Scatter Plots](https://plotly.com/python/line-and-scatter/#line-and-scatter-plots). You can translate the python code into Julia code as below:

```julia
using PyPlotly # this exports `go` and `px`

using Random
Random.seed!(1)

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

