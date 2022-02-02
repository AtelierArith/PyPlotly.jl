module Express

using PyCall

export px
const px = PyNULL()

px_functions = [
    :absolute_import,
    :optional_imports,
    :pd,
    :trendline_functions,
    :imshow_utils,
    :imshow,
    :scatter,
    :scatter_3d,
    :scatter_polar,
    :scatter_ternary,
    :scatter_mapbox,
    :scatter_geo,
    :line,
    :line_3d,
    :line_polar,
    :line_ternary,
    :line_mapbox,
    :line_geo,
    :area,
    :bar,
    :timeline,
    :bar_polar,
    :violin,
    :box,
    :strip,
    :histogram,
    :ecdf,
    :scatter_matrix,
    :parallel_coordinates,
    :parallel_categories,
    :choropleth,
    :density_contour,
    :density_heatmap,
    :pie,
    :sunburst,
    :treemap,
    :icicle,
    :funnel,
    :funnel_area,
    :choropleth_mapbox,
    :density_mapbox,
    :set_mapbox_access_token,
    :defaults,
    :get_trendline_results,
    :data,
    :colors
]

for func in px_functions
    @eval begin
        function $(func)(args...; kwargs...)
            px.$(func)(args...; kwargs...)
        end
    end
end

function __init__()
    copy!(px, pyimport_conda("plotly.express", "plotly", "plotly"))
end
# Write your package code here.

end
