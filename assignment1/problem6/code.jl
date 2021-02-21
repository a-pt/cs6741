### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ a28f2642-73d9-11eb-3056-3db1e68eec68
using Distributions

# ╔═╡ 211ee630-73da-11eb-3d71-318edec1808a
begin
	using Plots
	pyplot()
end

# ╔═╡ c81cebb0-73dc-11eb-3e9b-8da36a388be1
md"Probability by Experiment"

# ╔═╡ 95395c10-741d-11eb-2bbb-1d16c415519a
p_exp=[]

# ╔═╡ 0580eee0-73db-11eb-02ec-63da3104d4ae
begin
	for l in 0.0:0.1:1.0
		n_exp = 100000
		success = 0
		for _ in 1:n_exp
			amount = 10
			D_b = Bernoulli(l)
			outcome = rand(D_b,20)
			for i in 1:20
				if outcome[i] == true
					amount -= 1
				else
					amount += 1
				end
			end
			if amount >= 10
				success += 1
			end
		end
		push!(p_exp,success/n_exp)
	end
end

# ╔═╡ a410f362-741d-11eb-386a-0d62ed0f330b
p_exp

# ╔═╡ e60234f0-741d-11eb-1cd6-b5e6a93fdd01
plot(0.0:0.1:1.0,p_exp,xlabel="p",ylabel="experimental probability")

# ╔═╡ b9f36eb0-73dc-11eb-0240-6b76e8b9ebc1
md"Probability by Computation"

# ╔═╡ 53361920-741d-11eb-0c2b-cb4ef9868e42
p_comp=[]

# ╔═╡ 56b23110-73dc-11eb-13c8-614ef6b32faf
begin
	for k in 0.0:0.1:1.0
		tot_prob = 0
		for i in 0:10
			tot_prob += binomial(20,i)*(k^i)*((1-k)^(20-i))
		end
		push!(p_comp,tot_prob)
	end
end

# ╔═╡ 3cfbca62-741d-11eb-0bcc-0169533d0b40
p_comp

# ╔═╡ 0735331e-741e-11eb-2a05-0dc5aab11975
plot(0.0:0.1:1.0,p_comp,xlabel="p",ylabel="computational probability")

# ╔═╡ Cell order:
# ╠═a28f2642-73d9-11eb-3056-3db1e68eec68
# ╠═211ee630-73da-11eb-3d71-318edec1808a
# ╟─c81cebb0-73dc-11eb-3e9b-8da36a388be1
# ╠═95395c10-741d-11eb-2bbb-1d16c415519a
# ╠═0580eee0-73db-11eb-02ec-63da3104d4ae
# ╠═a410f362-741d-11eb-386a-0d62ed0f330b
# ╠═e60234f0-741d-11eb-1cd6-b5e6a93fdd01
# ╟─b9f36eb0-73dc-11eb-0240-6b76e8b9ebc1
# ╠═53361920-741d-11eb-0c2b-cb4ef9868e42
# ╠═56b23110-73dc-11eb-13c8-614ef6b32faf
# ╠═3cfbca62-741d-11eb-0bcc-0169533d0b40
# ╠═0735331e-741e-11eb-2a05-0dc5aab11975
