### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 658d36b0-73cf-11eb-322f-2d470a3a1c01
allowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~!@#{%^&*()_+=-`"

# ╔═╡ 7c9e40f2-73d0-11eb-1d10-293127297d59
begin
	Password = "Abef#23o"
	String(Password)
end

# ╔═╡ 8c81fba0-73d1-11eb-1e9a-17a19e01612d
begin
	n_exp=100000
	stored=0
	for _ in 1:n_exp
		pass_try=String(rand(allowed,8))
		match=0
		for i in 1:8
			if pass_try[i] == Password[i]
				match += 1
			end
		end
		if match > 1
			stored += 1
		end
	end
	stored/n_exp
end

# ╔═╡ 6e163e50-73d2-11eb-05dd-3d8beff0246c
1-(((length(allowed)-1)^8/(length(allowed))^8)+((8*(length(allowed)-1)^7)/(length(allowed)^8)))

# ╔═╡ Cell order:
# ╠═658d36b0-73cf-11eb-322f-2d470a3a1c01
# ╠═7c9e40f2-73d0-11eb-1d10-293127297d59
# ╠═8c81fba0-73d1-11eb-1e9a-17a19e01612d
# ╠═6e163e50-73d2-11eb-05dd-3d8beff0246c
