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

# ╔═╡ 34ac2ba2-7401-11eb-1fdb-631fb373edd5
using Distributions

# ╔═╡ 6cb09300-7402-11eb-2ab3-cd3a9e6692f0
begin
	using Plots
	pyplot()
end

# ╔═╡ 6fc99f32-73c8-11eb-1441-0d386e4dd6b3
@bind n_r html"<input type=range min=0 max=4>"

# ╔═╡ 7bc20b60-73c8-11eb-0f5d-4b989a34db24
n_r

# ╔═╡ 7e4ef7d2-73c8-11eb-3bf2-e33ced33793f
(binomial(4,n_r)*binomial(48,5-n_r))/binomial(52,5)

# ╔═╡ 5afe7662-7400-11eb-18ad-bb922a1bdc98
D_h=Hypergeometric(4,48,5)

# ╔═╡ 41f5a180-7404-11eb-2703-0959ca3f4e7b
plot(0:4, [pdf(D_h, x) for x in 0:4], line=:stem, marker=:circle, label="hypergeometric",xlabel="Success",ylabel="Probability")

# ╔═╡ 754a8dc0-7409-11eb-2931-136fe8497576
@bind n html"<input type=range min=0 max=5>"

# ╔═╡ 7a6c55e0-7409-11eb-15d5-e5a55f519401
n

# ╔═╡ bd5b41e0-73c8-11eb-09ef-9313812eec18
binomial(5,n)*((4/52)^n)*((48/52))^(5-n)

# ╔═╡ 5c2c4800-7400-11eb-25de-579b2d6056c4
D_b=Binomial(5,4/52)

# ╔═╡ 428a7960-7402-11eb-0a78-59860fd956b8
plot(0:5, [pdf(D_b, x) for x in 0:5], line=:stem, marker=:circle, label="Binomial",xlabel="Success",ylabel="Probability")

# ╔═╡ Cell order:
# ╠═34ac2ba2-7401-11eb-1fdb-631fb373edd5
# ╠═6cb09300-7402-11eb-2ab3-cd3a9e6692f0
# ╠═6fc99f32-73c8-11eb-1441-0d386e4dd6b3
# ╠═7bc20b60-73c8-11eb-0f5d-4b989a34db24
# ╠═7e4ef7d2-73c8-11eb-3bf2-e33ced33793f
# ╠═5afe7662-7400-11eb-18ad-bb922a1bdc98
# ╠═41f5a180-7404-11eb-2703-0959ca3f4e7b
# ╠═754a8dc0-7409-11eb-2931-136fe8497576
# ╠═7a6c55e0-7409-11eb-15d5-e5a55f519401
# ╠═bd5b41e0-73c8-11eb-09ef-9313812eec18
# ╠═5c2c4800-7400-11eb-25de-579b2d6056c4
# ╠═428a7960-7402-11eb-0a78-59860fd956b8
