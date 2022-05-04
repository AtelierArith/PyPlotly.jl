### A Pluto.jl notebook ###
# v0.19.0

using Markdown
using InteractiveUtils

# ╔═╡ 9513dfd4-cb93-11ec-03d9-2b4109ca3b97
begin
	using Pkg
	Pkg.activate("../../")
	using PyPlotly
end

# ╔═╡ 170bc566-3b0a-4436-a249-2cb26d891e90
begin
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
end

# ╔═╡ Cell order:
# ╠═9513dfd4-cb93-11ec-03d9-2b4109ca3b97
# ╠═170bc566-3b0a-4436-a249-2cb26d891e90
