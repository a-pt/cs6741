### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 7f58d9ce-73e0-11eb-1a64-d15f0b01d921
using Distributions

# ╔═╡ d98303d0-73e1-11eb-14da-39bdc16c243a
begin
	using Plots
	pyplot()
end

# ╔═╡ 6bca9570-7426-11eb-011e-51472f2de0dd
p_bankrupt=[]

# ╔═╡ 70e865f0-7426-11eb-3273-b177b233fb22
begin
	for p in 0.0:0.1:1.0
		n_exp = 100000
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
		push!(p_bankrupt,success/n_exp)
	end
end

# ╔═╡ 77e70460-7426-11eb-16b0-6dc29a44668a
p_bankrupt

# ╔═╡ 81bae2e0-7426-11eb-1b7c-61151306e0b3
p_int=[]

# ╔═╡ 84180cc0-7426-11eb-15cc-3d0aa6811cbc
begin
	for p in 0.0:0.1:1.0
		n_exp_ = 100000
		success_ = 0
		bankrupt = 0
		for _ in 1:n_exp_
			amount = 10
			D_b = Bernoulli(p)
			outcome = rand(D_b,20)
			flag = false
			for i in 1:20
				if outcome[i] == true
					amount -= 1
				else
					amount += 1
				end
				if amount == 0
					bankrupt += 1
					flag = true
					break
				end
			end
			if flag == false && amount >= 10
				success_ += 1
			end
		end
		push!(p_int,success_/(n_exp_-bankrupt))
	end
end

# ╔═╡ 8a6ab3c0-7426-11eb-0743-819137e86e0d
p_int

# ╔═╡ 92fc7550-7426-11eb-32eb-9f150cedc122
p_cond=[]

# ╔═╡ 98a7b8c0-7426-11eb-0e41-452eca964bc7
begin
	for i in 1:10
		push!(p_cond,p_int[i]/(1-p_bankrupt[i]))
	end
end

# ╔═╡ 992489e0-7426-11eb-3603-79812eecbf52
p_cond

# ╔═╡ a5ac3dc0-7426-11eb-02dd-039e9dca1c67
plot(0.0:0.1:0.9,p_cond,xlabel="p",ylabel="Conditional Probability")

# ╔═╡ Cell order:
# ╠═7f58d9ce-73e0-11eb-1a64-d15f0b01d921
# ╠═d98303d0-73e1-11eb-14da-39bdc16c243a
# ╠═6bca9570-7426-11eb-011e-51472f2de0dd
# ╠═70e865f0-7426-11eb-3273-b177b233fb22
# ╠═77e70460-7426-11eb-16b0-6dc29a44668a
# ╠═81bae2e0-7426-11eb-1b7c-61151306e0b3
# ╠═84180cc0-7426-11eb-15cc-3d0aa6811cbc
# ╠═8a6ab3c0-7426-11eb-0743-819137e86e0d
# ╠═92fc7550-7426-11eb-32eb-9f150cedc122
# ╠═98a7b8c0-7426-11eb-0e41-452eca964bc7
# ╠═992489e0-7426-11eb-3603-79812eecbf52
# ╠═a5ac3dc0-7426-11eb-02dd-039e9dca1c67
