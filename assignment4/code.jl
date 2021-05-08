### A Pluto.jl notebook ###
# v0.14.0

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

# ╔═╡ 63311445-4648-4dc6-a7c5-c81e12c0a073
using Distributions,PlutoUI,Combinatorics,StatsBase,StatsPlots,QuadGK,Random

# ╔═╡ 1088eca0-4faf-41fc-aa58-a910fcd9864a
begin
	using Plots
	pyplot()
end

# ╔═╡ bfc01f94-eb5c-42f0-abc8-df7c367be010
md"# Question 1"

# ╔═╡ 26812bfb-8242-4b38-b8b3-c11ac861a02b
md"**(a) Monte Carlo Simulation**"

# ╔═╡ 812e388e-3a01-466e-addd-c1a2dbf49a07
begin
	nsamples = 1000000
	samples = [[rand(0:1) for _ in 1:50] for _ in 1:nsamples]
	success = 0
	for sample in samples
		if (count(i->(i> 0),sample)>=30)
		success += 1
		end
	end
	success/nsamples
end

# ╔═╡ d8edb3c1-7039-4887-bad7-6f6e6f40727f
md"**(b) Using Binomial Distribution**"

# ╔═╡ c9271886-a9fe-42b7-b116-8e52f4e37b7c
begin 
	n=50
	p=0.5
	prob=0
		for i in 30:50
		prob += (binomial(n,i)/ (2^n))
	end
	prob
end

# ╔═╡ 0c6d761e-a6e6-47a2-9a3a-8949e0bde059
md"**(c) Using CLT approximation**"

# ╔═╡ e39976cd-0100-4b69-a40c-e669215959dd
begin
	D_n=Normal(25,sqrt(50)/2)
	D_b=Binomial(50,0.5)
	data=rand(D_b,10000)
end

# ╔═╡ ad7201b7-d13f-4311-bad2-c3999b07326c
begin
	plot(0:0.1:50, [pdf(D_n, x) for x in 0:0.1:50], label="Normal", line=2)
	plot!(0:50, [pdf(D_b, x) for x in 0:50], line=:stem, marker=:circle, label="Binomial")
end

# ╔═╡ eff6b6d4-27c9-4a01-bbe0-2d300851e6de
1-quadgk(u->pdf(D_n,u),(-Inf,29.5)...)[1]

# ╔═╡ 7cd5d3ee-0efa-497f-ad2c-85e74badf281
md"# Question 2"

# ╔═╡ 33143f13-5672-4c56-b1a8-113ae95e6556
md"**(a) Using CLT**"

# ╔═╡ a831df80-2274-45f1-aed3-30b5dc54835f
qslider = @bind q html"<input type=range min=0.5 max=1 step=0.01>"

# ╔═╡ a5def87c-011c-4b3f-b917-80068af55d11
md"Set q=0.59"

# ╔═╡ 74ee48a5-e3c0-485d-86c2-c7e19210df55
q

# ╔═╡ fd6279df-8aa4-48ce-91f8-517f414eb755
begin
	D_clt=Normal(n*q,sqrt(n)*sqrt(q*(1-q)))
	1-quadgk(u->pdf(D_clt,u),(-Inf,29.5)...)[1]
end

# ╔═╡ 6f506655-2f18-4b3a-94a8-e2dbd278afd8
md"**(b) Monte Carlo Experiment**"

# ╔═╡ d31e72ce-097c-4def-a08f-a2e67c54ed10
begin
	q_=0.59
	ns = 1000000
	smps =[]
	for _ in 1:ns
		current = []
		for _ in 1:50
			if (rand()<=q_)
				push!(current,1)
			else
				push!(current,0)
			end
		end
		push!(smps,current)
	end
	pass = 0
	for sample in smps
		if (count(i->(i> 0),sample)>=30)
		pass += 1
		end
	end
	pass/ns
end

# ╔═╡ b71799b8-904b-4447-83ef-c2e6dedeb259
md"**(c) Binomial Formula**"

# ╔═╡ f569516c-3e12-4f7d-a0df-a7c52ca285f9
begin
	pb=0
	for i in 30:50
		pb += (binomial(n,i)*(q_^i)*((1-q_)^(n-i)))
	end
	pb
end

# ╔═╡ 9deb5bbf-19bf-4a0f-8f4e-929baee7f2c4
md"# Question 3"

# ╔═╡ b0e0c117-5c35-425e-a38d-bf17621fefef
begin
	μ = 100
	σ = 30
end

# ╔═╡ 5ee1c396-bbba-4142-af63-e5f483987601
Nslider = @bind N html"<input type=range min=20 max=40 step=1>"

# ╔═╡ 95234a4e-86fa-4364-af3b-e5e99958a909
md"Set N = 33"

# ╔═╡ 57e077b7-2d96-43ab-90ee-1cc4015e8a3c
N

# ╔═╡ cf4b3121-4dfd-437d-9f98-f6490857efdb
D_CLT=Normal(N*μ,sqrt(N)*σ)

# ╔═╡ b6aafda6-3536-4878-bd1e-43b61ad08ce8
1-quadgk(u->pdf(D_CLT,u),(-Inf,3000)...)[1]

# ╔═╡ cc2829a1-00c0-4bbe-a97c-5c6e03a365c8
md"# Question 4"

# ╔═╡ 6b142b5b-c722-4d57-96e7-a8c22d5bacc9
begin
	Random.seed!(74)
	D=Normal(0,1)
	M_D,V_D,S_D,K_D = (mean(D),var(D),skewness(D),kurtosis(D))
	function compare_moments(Da)
		k = 50000
		for n in 1:2000
			samples = [rand(Da,n) for _ in 1:k]
			z_samples = [(sample.-mean(Da))./std(Da) for sample in samples]
			sum_d = [sum(sample)/sqrt(n) for sample in z_samples]
		(M_Da,V_Da,S_Da,K_Da)=mean(sum_d),var(sum_d),skewness(sum_d),kurtosis(sum_d)
			if(abs(S_Da-S_D)<= 0.1 && abs(K_Da-K_D) <= 0.1)
				return n,sum_d
			end
		end
	end
	U=Uniform()
	ru,a_ru = compare_moments(U)
	B1=Binomial(100,0.01)
	rb1,a_rb1 = compare_moments(B1)
	B2 = Binomial(100,0.5)
	rb2,a_rb2 = compare_moments(B2)
	C=Chisq(3)
	rc,a_chs=compare_moments(C)
	(ru,rb1,rb2,rc)
end

# ╔═╡ 75f3b467-32e6-4ca6-a94a-1b56d76213a5
begin
	density(a_ru,label="Empirical convolution n=$ru",title="Uniform Distribution")
	plot!(-4:0.1:4, [pdf(Normal(0,1), x) for x in -4:0.1:4],label="Std Normal")
end

# ╔═╡ 42f839ca-0690-47db-b846-2396a4b10ffe
begin
	density(a_rb1,label="Empirical convolution n=$rb1",title="Binomial Distribution p=0.01")
	plot!(-4:0.1:4, [pdf(Normal(0,1), x) for x in -4:0.1:4],label="Std Normal")
end

# ╔═╡ 744b8483-635c-4472-bfc2-2ffeb7b329d3
begin
	density(a_rb2,label="Empirical convolution n=$rb2",title="Binomial Distribution p=0.5")
	plot!(-4:0.1:4, [pdf(Normal(0,1), x) for x in -4:0.1:4],label="Std Normal")
end

# ╔═╡ f04ebe74-0f61-429a-b593-212e5e1fb700
begin
	density(a_chs,label="Empirical convolution n=$rc",title="Chi Square Distribution v=3")
	plot!(-4:0.1:4, [pdf(Normal(0,1), x) for x in -4:0.1:4],label="Std Normal")
end

# ╔═╡ 0fa6cc69-db4f-4c57-a7a8-94e4e6955a8a
md"# Question 5"

# ╔═╡ ad127bd9-270a-4bfc-bcac-3fcbe3283887
Cs=Chisq(99)

# ╔═╡ 7c5c2a5a-f507-41eb-88e8-565265195002
vslider = @bind σ2 html"<input type=range min=3.5 max=5 step=0.01>"

# ╔═╡ d7a173ec-e228-4840-8a5f-1b8a529505db
md"Set σ2 = 4.21"

# ╔═╡ da3304f8-ac5b-43ed-a3e9-83dafbf86324
σ2

# ╔═╡ 18f102f5-be32-4edf-8f74-ee6e0b4c242a
quadgk(u->pdf(Cs,u),(5*99/σ2,Inf)...)[1]

# ╔═╡ Cell order:
# ╠═63311445-4648-4dc6-a7c5-c81e12c0a073
# ╠═1088eca0-4faf-41fc-aa58-a910fcd9864a
# ╟─bfc01f94-eb5c-42f0-abc8-df7c367be010
# ╟─26812bfb-8242-4b38-b8b3-c11ac861a02b
# ╠═812e388e-3a01-466e-addd-c1a2dbf49a07
# ╟─d8edb3c1-7039-4887-bad7-6f6e6f40727f
# ╠═c9271886-a9fe-42b7-b116-8e52f4e37b7c
# ╟─0c6d761e-a6e6-47a2-9a3a-8949e0bde059
# ╠═e39976cd-0100-4b69-a40c-e669215959dd
# ╠═ad7201b7-d13f-4311-bad2-c3999b07326c
# ╠═eff6b6d4-27c9-4a01-bbe0-2d300851e6de
# ╟─7cd5d3ee-0efa-497f-ad2c-85e74badf281
# ╟─33143f13-5672-4c56-b1a8-113ae95e6556
# ╠═a831df80-2274-45f1-aed3-30b5dc54835f
# ╟─a5def87c-011c-4b3f-b917-80068af55d11
# ╠═74ee48a5-e3c0-485d-86c2-c7e19210df55
# ╠═fd6279df-8aa4-48ce-91f8-517f414eb755
# ╟─6f506655-2f18-4b3a-94a8-e2dbd278afd8
# ╠═d31e72ce-097c-4def-a08f-a2e67c54ed10
# ╟─b71799b8-904b-4447-83ef-c2e6dedeb259
# ╠═f569516c-3e12-4f7d-a0df-a7c52ca285f9
# ╟─9deb5bbf-19bf-4a0f-8f4e-929baee7f2c4
# ╠═b0e0c117-5c35-425e-a38d-bf17621fefef
# ╠═5ee1c396-bbba-4142-af63-e5f483987601
# ╟─95234a4e-86fa-4364-af3b-e5e99958a909
# ╠═57e077b7-2d96-43ab-90ee-1cc4015e8a3c
# ╠═cf4b3121-4dfd-437d-9f98-f6490857efdb
# ╠═b6aafda6-3536-4878-bd1e-43b61ad08ce8
# ╟─cc2829a1-00c0-4bbe-a97c-5c6e03a365c8
# ╠═6b142b5b-c722-4d57-96e7-a8c22d5bacc9
# ╠═75f3b467-32e6-4ca6-a94a-1b56d76213a5
# ╠═42f839ca-0690-47db-b846-2396a4b10ffe
# ╠═744b8483-635c-4472-bfc2-2ffeb7b329d3
# ╠═f04ebe74-0f61-429a-b593-212e5e1fb700
# ╟─0fa6cc69-db4f-4c57-a7a8-94e4e6955a8a
# ╠═ad127bd9-270a-4bfc-bcac-3fcbe3283887
# ╠═7c5c2a5a-f507-41eb-88e8-565265195002
# ╟─d7a173ec-e228-4840-8a5f-1b8a529505db
# ╠═da3304f8-ac5b-43ed-a3e9-83dafbf86324
# ╠═18f102f5-be32-4edf-8f74-ee6e0b4c242a
