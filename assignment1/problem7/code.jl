### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ f1860c00-73de-11eb-051e-fd29fc37a3d3
using Distributions

# ╔═╡ fada8150-73de-11eb-1e1a-2dc2bd95c6b0
begin
	using Plots
	pyplot()
end

# ╔═╡ dbd64e90-7421-11eb-390d-27f237301990
p_exp = []

# ╔═╡ e385c670-7421-11eb-35eb-815fdc5ca05e
begin
	for p in 0.0:0.1:1.0
		n_exp = 10000
		success = 0
		for _ in 1:n_exp
			amount = 10
			D_b = Bernoulli(p)
			outcome = rand(D_b,20)
			for i in 1:20
				if outcome[i] == true
					amount -= 1
				else
					amount += 1
				end
				if amount == 0
					success += 1
					break
				end
			end
		end
		push!(p_exp,success/n_exp)
	end
end

# ╔═╡ e7d23d2e-7421-11eb-3edf-2b1051373060
p_exp

# ╔═╡ e9090f80-7421-11eb-3a39-5fc6ed2e5197
plot(0.0:0.1:1.0,p_exp,xlabel="p",ylabel="Probability of going bankrupt atleast once")

# ╔═╡ Cell order:
# ╠═f1860c00-73de-11eb-051e-fd29fc37a3d3
# ╠═fada8150-73de-11eb-1e1a-2dc2bd95c6b0
# ╠═dbd64e90-7421-11eb-390d-27f237301990
# ╠═e385c670-7421-11eb-35eb-815fdc5ca05e
# ╠═e7d23d2e-7421-11eb-3edf-2b1051373060
# ╠═e9090f80-7421-11eb-3a39-5fc6ed2e5197
