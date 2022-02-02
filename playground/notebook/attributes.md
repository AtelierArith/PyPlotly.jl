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
from plotly import express
```

```python
def create_symbols(mod, target=None):
    symbols = []
    for attr in mod.__dir__():
        if attr.startswith("_"):
            continue

        if target == "class":
            if attr[0].isupper() and (not attr.isupper()):
                symbols.append(":" + attr)
        elif target == "method":
            if attr[0].islower():
                symbols.append(":" + attr)
        else:
            symbols.append(":" + attr)
    return symbols


create_symbols(plotly)
```

```python
create_symbols(express, target="method")
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
