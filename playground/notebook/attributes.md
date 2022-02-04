---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.5
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

```python
express.data
```

```python
import importlib
import inspect

import plotly
from plotly import express
```

```python
inspect.ismodule(plotly.graph_objects)
```

```python
def create_symbols(mod, target):
    symbols = []
    for attr in mod.__all__:
        if attr.startswith("_"):
            continue
        satisfy = eval(f"inspect.{target}(mod.{attr})")
        if satisfy:
            symbols.append(":"+attr)
    return symbols


create_symbols(plotly, "ismodule")
```

```python
create_symbols(plotly.graph_objects, "ismodule")
```

```python
create_symbols(plotly.express, "isclass")
```

```python
plotly.graph_objects.__all__
```

```python
plotly.express.__all__
```

```python
create_symbols(express, target="class")
```

```python
create_symbols(plotly.graph_objects, target="method")
```

```python
create_symbols(plotly.graph_objects, target="class")
```

```python
[
    ":Waterfall",
    ":Volume",
    ":Violin",
    ":Treemap",
    ":Table",
    ":Surface",
    ":Sunburst",
    ":Streamtube",
    ":Splom",
    ":Scatterternary",
    ":Scattersmith",
    ":Scatterpolargl",
    ":Scatterpolar",
    ":Scattermapbox",
    ":Scattergl",
    ":Scattergeo",
    ":Scattercarpet",
    ":Scatter3d",
    ":Scatter",
    ":Sankey",
    ":Pointcloud",
    ":Pie",
    ":Parcoords",
    ":Parcats",
    ":Ohlc",
    ":Mesh3d",
    ":Isosurface",
    ":Indicator",
    ":Image",
    ":Icicle",
    ":Histogram2dContour",
    ":Histogram2d",
    ":Histogram",
    ":Heatmapgl",
    ":Heatmap",
    ":Funnelarea",
    ":Funnel",
    ":Densitymapbox",
    ":Contourcarpet",
    ":Contour",
    ":Cone",
    ":Choroplethmapbox",
    ":Choropleth",
    ":Carpet",
    ":Candlestick",
    ":Box",
    ":Barpolar",
    ":Bar",
    ":Layout",
    ":Frame",
    ":Figure",
    ":Data",
    ":Annotations",
    ":Frames",
    ":AngularAxis",
    ":Annotation",
    ":ColorBar",
    ":Contours",
    ":ErrorX",
    ":ErrorY",
    ":ErrorZ",
    ":Font",
    ":Legend",
    ":Line",
    ":Margin",
    ":Marker",
    ":RadialAxis",
    ":Scene",
    ":Stream",
    ":XAxis",
    ":YAxis",
    ":ZAxis",
    ":XBins",
    ":YBins",
    ":Trace",
    ":Histogram2dcontour",
    ":FigureWidget",
]
```
