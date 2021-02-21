### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ d6285c60-73bb-11eb-2a49-fb51c3579ae3
begin
	using Plots
	pyplot()
end

# ╔═╡ 9da30fc0-73bb-11eb-11e2-4f10e0c7b8f7
begin
	num=[]
	sum=[]
	mean=[]
	n_exp = 10^4
end

# ╔═╡ a8f46680-73bb-11eb-3f8b-377ef13a9ea4
begin
	for _ in 1:n_exp
	 push!(num, rand(-500:500))
	end
	num
end

# ╔═╡ b6d827f0-73bb-11eb-28dc-71cc3c66c421
begin
	push!(sum,num[1])
	for i in 2:n_exp
	 push!(sum,(last(sum) + num[i]))
	end
	sum
end

# ╔═╡ 028e8e40-73f9-11eb-2cfa-c1974d0851b3
begin
	for i in 1:n_exp
	 push!(mean, sum[i]/i)
	end
	mean
end

# ╔═╡ 4c3cf000-73bc-11eb-3c88-4b4839ebfb22
plot(1:n_exp,mean,xlabel="Experiment Number",ylabel="Mean")

# ╔═╡ Cell order:
# ╠═9da30fc0-73bb-11eb-11e2-4f10e0c7b8f7
# ╠═a8f46680-73bb-11eb-3f8b-377ef13a9ea4
# ╠═b6d827f0-73bb-11eb-28dc-71cc3c66c421
# ╠═028e8e40-73f9-11eb-2cfa-c1974d0851b3
# ╠═d6285c60-73bb-11eb-2a49-fb51c3579ae3
# ╠═4c3cf000-73bc-11eb-3c88-4b4839ebfb22
