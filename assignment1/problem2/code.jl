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

# ╔═╡ a9408350-73be-11eb-018e-074927ce157c
begin
	deck=[]
	for i in 1:48
		push!(deck,"❌")
	end
	for i in 1:4
		push!(deck,"⭕")
	end
	deck
end

# ╔═╡ 619318ee-73bf-11eb-00a2-796168710350
begin
	count(i->(i=="❌"),deck)
end

# ╔═╡ d984d860-73bc-11eb-0517-235ac7d5814c
@bind n_r html"<input type=range min=0 max=4>"

# ╔═╡ a3eef8a0-73be-11eb-17dd-930305db7b27
n_r

# ╔═╡ ffa0d410-73bf-11eb-2878-69bd5d63e418
begin
	n_exp = 500000
	success = 0
	for k in 1:n_exp
		cards_drawn=[]
		d=copy(deck)
		for _ in 1:5
			card=rand(d)
			push!(cards_drawn,card)
			deleteat!(d, findfirst(x-> x == card, d))
		end
		if count(i->(i=="⭕"),cards_drawn) == n_r
			success += 1
		end
	end	
	convert(BigFloat, n_exp)
	success/n_exp
end

# ╔═╡ 27dc2a80-7409-11eb-09fe-f356652fecb2
@bind n html"<input type=range min=0 max=5>"

# ╔═╡ 2df0de20-7409-11eb-3002-77b6f23e82a1
n

# ╔═╡ a41a4a30-73c5-11eb-0f93-936c23afb805
begin
	success_r = 0
	for k in 1:n_exp
		cards_drawn_=[]
		for _ in 1:5
			card=rand(deck)
			push!(cards_drawn_,card)
		end
		if count(i->(i=="⭕"),cards_drawn_) == n
			success_r += 1
		end
	end	
	success_r/n_exp
end

# ╔═╡ Cell order:
# ╠═a9408350-73be-11eb-018e-074927ce157c
# ╠═619318ee-73bf-11eb-00a2-796168710350
# ╠═d984d860-73bc-11eb-0517-235ac7d5814c
# ╠═a3eef8a0-73be-11eb-17dd-930305db7b27
# ╠═ffa0d410-73bf-11eb-2878-69bd5d63e418
# ╠═27dc2a80-7409-11eb-09fe-f356652fecb2
# ╠═2df0de20-7409-11eb-3002-77b6f23e82a1
# ╠═a41a4a30-73c5-11eb-0f93-936c23afb805
