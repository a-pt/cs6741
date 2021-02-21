### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 9693ed30-73d4-11eb-33bf-a333fcffaaf8
@bind n html"<input type=range min=1 max=8>"

# ╔═╡ bde514de-73d4-11eb-0e23-63d63bc58f2d
n

# ╔═╡ c323b3d0-73d4-11eb-0751-23b87b0e6f9f
allowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~!@#{%^&*()_+=-`"

# ╔═╡ cc36b34e-73d4-11eb-3835-a9f35fb21334
begin
	Password = "Abef#23o"
	String(Password)
end

# ╔═╡ d0d58fd0-73d4-11eb-258e-d9bb9138baa2
begin
	n_exp=1000000
	stored=0
	for _ in 1:n_exp
		pass_try=String(rand(allowed,8))
		match=0
		for i in 1:8
			if pass_try[i] == Password[i]
				match += 1
			end
		end
		if match > n
			stored += 1
		end
	end
	stored/n_exp
end

# ╔═╡ d7d91ad0-73d5-11eb-1822-65f5f730610d
md"Since for n=2, probability is less than 10^-3, the rule should be atleast 3 charactes matches, then store onto database."

# ╔═╡ 72218600-73d5-11eb-318d-a71cabec57eb
1-(((length(allowed)-1)^8/(length(allowed))^8)+((8*(length(allowed)-1)^7)/(length(allowed)^8))+((binomial(8,2)*(length(allowed)-1)^6)/(length(allowed)^8)))

# ╔═╡ Cell order:
# ╠═9693ed30-73d4-11eb-33bf-a333fcffaaf8
# ╠═bde514de-73d4-11eb-0e23-63d63bc58f2d
# ╠═c323b3d0-73d4-11eb-0751-23b87b0e6f9f
# ╠═cc36b34e-73d4-11eb-3835-a9f35fb21334
# ╠═d0d58fd0-73d4-11eb-258e-d9bb9138baa2
# ╟─d7d91ad0-73d5-11eb-1822-65f5f730610d
# ╠═72218600-73d5-11eb-318d-a71cabec57eb
