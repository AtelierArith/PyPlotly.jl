module Plotly

using PyCall

export plotly
const plotly = PyNULL()

function __init__()
    copy!(plotly, pyimport_conda("plotly", "plotly", "plotly"))
end
# Write your package code here.

end
