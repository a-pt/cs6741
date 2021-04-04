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

# ╔═╡ d1a6b270-9294-11eb-1e2a-477369fb2f39
begin
	using Distributions
	using QuadGK
	using StatsPlots
	using StatsBase
	using Dates
	using DataFrames
	using DelimitedFiles
	using DSP
	using LinearAlgebra
	using Plots
	pyplot()
end

# ╔═╡ b1cbe270-935e-11eb-36b5-e37263386747
md"# Question 1"

# ╔═╡ c69fea70-935e-11eb-323b-072f20d26acd
function KLD(Da,Db)
	return quadgk(x-> pdf(Da,x)*log(pdf(Da,x)/pdf(Db,x)), (-20,20)...)[1]
end

# ╔═╡ d0970860-935e-11eb-32d0-49264cb77471
D_n=Normal(0,1)

# ╔═╡ da3223a2-935e-11eb-12d9-65e2c5ca8f2c
begin
	vslider=@bind v html"<input type=range min=1 max=5 step=1>"
	md"""v: $(vslider)"""
end

# ╔═╡ df9ab8c0-935e-11eb-37aa-21ab6a47ca3f
v

# ╔═╡ ee4377e0-935e-11eb-09ce-454158bfc54b
D_t=TDist(v)

# ╔═╡ f946d5b0-935e-11eb-14ae-910e3d5f0a6a
begin
	plot(-20:0.1:20,[pdf(D_t,x) for x in -20:0.1:20], label="T-Dist",title="v=$v")
	plot!(-20:0.1:20,[pdf(D_n,x) for x in -20:0.1:20], label="Std-Normal")
end

# ╔═╡ 07eb7620-935f-11eb-264d-6b0226cbc32c
md"# Question 2"

# ╔═╡ 0ecf1280-935f-11eb-1611-0b155dfb3639
D=Uniform(0,1)

# ╔═╡ 440fbb70-935f-11eb-3504-e32eb8dea121
function cv(l,u,n)
	if n==2
		return [pdf(Uniform(0,1),x) for x in -5:0.01:5]
	else
		return conv(cv((l/5-1)*5,(u/5-1)*5,n-1),[pdf(Uniform(0,1),x) for x in -5:0.01:5])
	end
end

# ╔═╡ b31b2f05-9aed-49a0-8b04-2e5dd46410ae
function cv_(x,n)
	if n==2
		return quadgk(k->pdf(D,x-k)*pdf(D,k),(0,1)...)[1]
	else
		return quadgk(k-> cv(x-k,n-1)*pdf(D,k),(0,1)...)[1]
	end
end

# ╔═╡ 4940ece0-935f-11eb-0736-9b85e4b47359
begin
	nslider=@bind n html"<input type=range min=2 max=10 step=1>"
	md"""n: $(nslider)"""
end

# ╔═╡ 4e7133f0-935f-11eb-05c5-b97356c497ce
n

# ╔═╡ 5313b9f0-935f-11eb-2b12-138f08756764
begin
	co=cv(-5*n,5*n,n+1)
	co_n=co./norm(co)
	no=[pdf(Normal(n/2,sqrt(n*var(D))),x) for x in -5*n:0.01:5*n]
	no_n=no./norm(no)
	plot(-5*n:0.01:5*n,co_n,label="Convolution",title="n=$n")
	plot!(-5*n:0.01:5*n,no_n,label="Normal")
end

# ╔═╡ 588835ee-935f-11eb-2dd9-af7443ec51e3
function KLD(a,b,l)
	return sum(x-> a[x]*log(a[x]/b[x]), (1:l))
end

# ╔═╡ f2e07fa2-935e-11eb-0459-fbfb3d1ed01e
KLD(D_t,D_n)

# ╔═╡ ffe2e1c0-935e-11eb-3168-dd4f5abfd482
plot(1:1:5,[KLD(TDist(vi),D_n) for vi in 1:5],label="",xlabel="Degree of freedom",ylabel="KLDivergence")

# ╔═╡ 7cda0050-935f-11eb-1048-75ed6bb45d4e
begin
	val=[]
	for n in 2:10
		co=cv(-5*n,5*n,n+1)
		co_n=co./norm(co)
		no=[pdf(Normal(n/2,sqrt(n*var(D))),x) for x in -5*n:0.01:5*n]
		no_n=no./norm(no)
		K_co=co_n[co_n .> 0.00001]
		K_no=no_n[no_n .> 0.00001]
		push!(val,KLD(K_co,K_no,min(length(K_co),length(K_no))))
	end
end

# ╔═╡ 8a6bd130-935f-11eb-045e-bb5fb0716d82
plot(2:1:10,val,label="KL-Divergence",xlabel="Independent RV",ylabel="KLDivergence")

# ╔═╡ 04c27e80-9364-11eb-01d0-69cfe8fad252
md"# Question 3"

# ╔═╡ 28df0810-9364-11eb-2b90-e39fa46803b6
sz=1000

# ╔═╡ 2db54840-9364-11eb-0402-f1efc5518bb6
sp=rand(Beta(2,5),sz)

# ╔═╡ 34ba2840-9364-11eb-3ca3-2957956f3cef
Mn=mean(sp)

# ╔═╡ 38ac4a02-9364-11eb-30c1-f1e21ad558b6
Md=median(sp)

# ╔═╡ 652f22e0-9365-11eb-164b-e3147565851a
Mo=mode(sp)

# ╔═╡ 0e407f60-9365-11eb-067d-9579fa5597e2
begin
	density(sp,title="1000 data points sampled from Beta(2,5)")
	plot!([Mn,Mn],[0,pdf(Beta(2,5),Mn)], label="Mean",line=(1, :dash, :green))
	plot!([Md,Md],[0,pdf(Beta(2,5),Md)], label="Median",line=(1, :dash, :red))
	plot!([Mo,Mo],[0,pdf(Beta(2,5),Mo)], label="Mode",line=(1, :dash, :blue))
end

# ╔═╡ 3f681310-9364-11eb-371f-1f58621eeb03
begin
	data_=copy(sp)
	for _ in 1:500
		x=rand()
		push!(data_,Md+0.05*x)
		push!(data_,Md-0.3*x)
	end
end

# ╔═╡ 40d362e0-9364-11eb-1f6c-2f2d64e5145a
length(data_)

# ╔═╡ 447f05c0-9364-11eb-3180-3f6105d9b950
begin
	histogram(data_,bins=100,normalize=true)
	density!(data_)
end

# ╔═╡ 48684dde-9364-11eb-37cb-cf325cbf19b3
Nmn=mean(data_)

# ╔═╡ 4cea2c80-9364-11eb-2b17-3320f2d82883
Nmd=median(data_)

# ╔═╡ 771b2620-9365-11eb-0b8d-4d891fec795f
Nmo=mode(data_)

# ╔═╡ 57e6ac80-9364-11eb-316a-d322f6730ab0
begin
	density(data_,title="2000 right skewed datapoints with mean<median")
	plot!([Nmn,Nmn],[0,3], label="Mean",line=(1, :dash, :green))
	plot!([Nmd,Nmd],[0,4], label="Median",line=(1, :dash, :red))
end

# ╔═╡ 887cdc00-936b-11eb-13f0-5f5ab220498c
md"# Question 4"

# ╔═╡ 90ea9ad0-936b-11eb-2828-5b74e5d5eaa7
Du=Uniform(0,1)

# ╔═╡ 9c6a5490-936b-11eb-3fea-5169bbb57147
samples=[[rand(Du) for _ in 1:30] for _ in 1:10000]

# ╔═╡ a284d490-936b-11eb-2c08-23df29e9096b
range= [maximum(sample)-minimum(sample) for sample in samples]

# ╔═╡ a8d076b0-936b-11eb-31f2-7da214d671d2
histogram(range,label="Histogram")

# ╔═╡ af67eee0-936b-11eb-11b6-19bdcffc2037
mean(range),median(range),mode(range)

# ╔═╡ bda39450-936b-11eb-3676-f1d97db73925
D_f=fit(Beta,range)

# ╔═╡ c3068420-936b-11eb-3d30-c1b5ffaa4cef
begin
	mn=mean(D_f)
	mo=mode(D_f)
	md=median(D_f)
	(mn,md,mo)
end

# ╔═╡ f41b0f90-936b-11eb-2ce9-31e6f200672c
begin
	plot(0.5:0.001:1.0,[pdf(D_f,x) for x in 0.5:0.001:1.0], label="Pdf",legend=:topleft)
	histogram!(range,fill=0.2,normalize=true,line=(0.1, :blue),label="Histogram")
	plot!([mn, mn], [0, pdf(D_f, mn)], label="Mean", line=(1, :dash, :green))
	plot!([md, md], [0, pdf(D_f, md)], label="Median", line=(1, :dash, :blue))
	plot!([mo, mo], [0, pdf(D_f, mo)], label="Mode", line=(1, :dash, :red))
end

# ╔═╡ 8479df70-936d-11eb-163b-af461973e40c
md"# Question 5"

# ╔═╡ 8add7660-936d-11eb-3ebd-8d623fc02996
 cdf_b(x)=cdf(D_f, x)

# ╔═╡ 90c48a50-936d-11eb-3f76-3dcac8271e75
plot(0.5:0.001:1, [(1-cdf_b(x)) for x in 0.5:0.001:1],title="From Experiment",label="P(range>θ)")

# ╔═╡ 9771382e-936d-11eb-3dc5-33cc342051fd
plot(0.5:0.001:1,[1-(30*(quadgk(x->x^29,(0,θ)...)[1]+quadgk(x-> θ^29,(θ,1)...)[1])) for θ in 0.5:0.001:1],title="Analytical Computation",label="P(range>θ)")

# ╔═╡ 2dbb6e60-9296-11eb-1dbb-7d7ca699d2df
md"# Question 6"

# ╔═╡ 30db3377-7dea-4e0d-93f1-f06d98aedc46
begin				m=readdlm(download("https://api.covid19india.org/csv/latest/states.csv"),',')
	df=DataFrame(Any[@view m[2:end, i] for i in 1:size(m, 2)], Symbol.(m[1, :]))
end

# ╔═╡ 4f081db2-dd61-4635-afa0-b2cb7f51a556
begin
	select!(df,[:Date,:State,:Confirmed])
	c1=parse.(Date,df[!,:Date])
	select!(df, Not(:Date))
	insertcols!(df,1,:Date => c1)	
	df1=df[df.State .!= "India", :]
end

# ╔═╡ d2a41e65-6387-4bfa-9a49-02f1c22f85e8
begin
	c2=[]
	for i in 1:size(df1)[1]
		if ((year(df1[!,:Date][i])==2021) && (week(df[!,:Date][i])<53))
			push!(c2,week(df1[!,:Date][i])+53)
		else 
			push!(c2,week(df1[!,:Date][i]))
		end
	end
	insertcols!(df1,1,:Week => c2)
end

# ╔═╡ 8f116d62-caf6-4129-bd26-54066da1bfe2
gdf= groupby(df1, [:Week,:State])

# ╔═╡ d9a2d68e-65e1-47c1-ae80-1f7d23ed68f1
begin
	data=combine(gdf, :Confirmed => sum)
	state_data=unstack(data,:Week,:State,:Confirmed_sum)
	select!(state_data,Not(names(state_data)[37]))
	select!(state_data, Not(names(state_data)[37]))
	select!(state_data, Not(names(state_data)[34]))
	select!(state_data, Not(names(state_data)[28]))
	select!(state_data, Not(names(state_data)[20]))
	select!(state_data, Not(names(state_data)[18]))
	select!(state_data, Not(names(state_data)[8]))
	select!(state_data, Not(names(state_data)[3]))
	state_data
end

# ╔═╡ 365d1905-424e-4104-bd7d-61cc0c11fe38
function covmat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		   sx, sy = skipmissings(c1, c2)
		   t[i, j] = cov(collect(sx), collect(sy))
	   end
   end
   return t
   end

# ╔═╡ 25bfc6ea-f5ea-4bcc-8a71-fd33af7fdfce
Covariance=covmat(select(state_data, Not(:Week)))

# ╔═╡ e1264fbc-bff6-46df-9adc-4b0249fcf61e
function pearson_cormat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		   sx, sy = skipmissings(c1, c2)
		   t[i, j] = cor(collect(sx), collect(sy))
	   end
   end
   return t
   end

# ╔═╡ d24bdc8e-3d09-4889-8039-3d153dd9781c
Ps_correlation=pearson_cormat(select(state_data, Not(:Week)))

# ╔═╡ 11e14c74-0a9c-4c26-a52e-ba4c3593b85b
findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]

# ╔═╡ 9dc89b24-1d7d-4f35-8d7b-d25797a7116a
function spearman_cormat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		   sx, sy = skipmissings(c1, c2)
		   t[i, j] = cor(findpos(collect(sx)), findpos(collect(sy)))
	   end
   end
   return t
   end

# ╔═╡ 1c93d028-9c30-4057-a805-304725770eed
Sp_correlation=spearman_cormat(select(state_data, Not(:Week)))

# ╔═╡ 3574984e-cc30-4cf6-aa30-a2dfd50e90e1
States= [names(state_data)[i] for i in 2:length(names(state_data))]

# ╔═╡ 84e718d5-4b03-4291-87fc-efa99c7b9e94
Index=[i for i in 1:29]

# ╔═╡ 2eaa317f-5825-4ca8-aece-a8e56bc09e00
heatmap(Index, States, Covariance,title="Covariance")

# ╔═╡ 6359bce0-e105-45c0-9ae3-daee14b1fb68
heatmap(Index, States, Ps_correlation,title="Pearson Correlation")

# ╔═╡ 913bb2f7-3222-436c-8f11-e9108971e7d5
heatmap(Index, States, Sp_correlation,title="Spearman Correlation")

# ╔═╡ 5e129d40-9296-11eb-1475-4355ca675a69
md"# Question 7"

# ╔═╡ 63f45a00-9296-11eb-1dd0-e1e7300e44e5
Dn=Normal(0,1)

# ╔═╡ 597e351e-92a3-11eb-3b88-0dd8f665d294
Dt=TDist(10)

# ╔═╡ 608203b0-92a3-11eb-0654-c5466cf12546
function OneSidedTail(x,D)
	t=0
	for p in -5:0.001:5
		if quadgk(u-> pdf(D,u),(-Inf,p)...)[1] >= (100-x)/100
			t=p
			break
		end
	end
	return t
end

# ╔═╡ 68be7950-92a3-11eb-12f4-1bf507307b05
begin
	pslider=@bind p html"<input type=range min=0 max=100 step=1>"
	md"""p: $(pslider)"""
end

# ╔═╡ 8354cf30-92a3-11eb-3d3b-a794b13201d4
p

# ╔═╡ 8b95155e-92a3-11eb-3a56-91eb0fbfd67d
xt=OneSidedTail(p,Dt)

# ╔═╡ 926529c0-92a3-11eb-39f0-0906f5fc22a8
xn=OneSidedTail(p,Dn)

# ╔═╡ 422db730-936e-11eb-370e-535ecacfcf74
begin
	plot(-5:0.01:5,[pdf(Dn,p) for p in -5:0.01:5], label="Normal Distribution")
	plot!(-5:0.01:xn,[pdf(Dn,p) for p in -5:0.01:xn], fill=(0,:red),label="Area Normal",seriesalpha = 0.4)
	plot!([xn,xn],[0,pdf(Dn,xn)],label=string(100-p)*" Percentile-N", line=(1, :blue))
	plot!(-5:0.01:5,[pdf(Dt,p) for p in -5:0.01:5], label="T Distribution")
	plot!(-5:0.01:xt,[pdf(Dt,p) for p in -5:0.01:xt], fill=(0,:blue),label="AreaT",seriesalpha = 0.4)
	plot!([xt,xt],[0,pdf(Dt,xt)],label=string(100-p)*" Percentile-T", line=(1, :red))
end

# ╔═╡ Cell order:
# ╠═d1a6b270-9294-11eb-1e2a-477369fb2f39
# ╟─b1cbe270-935e-11eb-36b5-e37263386747
# ╠═c69fea70-935e-11eb-323b-072f20d26acd
# ╠═d0970860-935e-11eb-32d0-49264cb77471
# ╠═da3223a2-935e-11eb-12d9-65e2c5ca8f2c
# ╠═df9ab8c0-935e-11eb-37aa-21ab6a47ca3f
# ╠═ee4377e0-935e-11eb-09ce-454158bfc54b
# ╠═f2e07fa2-935e-11eb-0459-fbfb3d1ed01e
# ╠═f946d5b0-935e-11eb-14ae-910e3d5f0a6a
# ╠═ffe2e1c0-935e-11eb-3168-dd4f5abfd482
# ╟─07eb7620-935f-11eb-264d-6b0226cbc32c
# ╠═0ecf1280-935f-11eb-1611-0b155dfb3639
# ╠═b31b2f05-9aed-49a0-8b04-2e5dd46410ae
# ╠═440fbb70-935f-11eb-3504-e32eb8dea121
# ╠═4940ece0-935f-11eb-0736-9b85e4b47359
# ╠═4e7133f0-935f-11eb-05c5-b97356c497ce
# ╠═5313b9f0-935f-11eb-2b12-138f08756764
# ╠═588835ee-935f-11eb-2dd9-af7443ec51e3
# ╠═7cda0050-935f-11eb-1048-75ed6bb45d4e
# ╠═8a6bd130-935f-11eb-045e-bb5fb0716d82
# ╟─04c27e80-9364-11eb-01d0-69cfe8fad252
# ╠═28df0810-9364-11eb-2b90-e39fa46803b6
# ╠═2db54840-9364-11eb-0402-f1efc5518bb6
# ╠═34ba2840-9364-11eb-3ca3-2957956f3cef
# ╠═38ac4a02-9364-11eb-30c1-f1e21ad558b6
# ╠═652f22e0-9365-11eb-164b-e3147565851a
# ╠═0e407f60-9365-11eb-067d-9579fa5597e2
# ╠═3f681310-9364-11eb-371f-1f58621eeb03
# ╠═40d362e0-9364-11eb-1f6c-2f2d64e5145a
# ╠═447f05c0-9364-11eb-3180-3f6105d9b950
# ╠═48684dde-9364-11eb-37cb-cf325cbf19b3
# ╠═4cea2c80-9364-11eb-2b17-3320f2d82883
# ╠═771b2620-9365-11eb-0b8d-4d891fec795f
# ╠═57e6ac80-9364-11eb-316a-d322f6730ab0
# ╟─887cdc00-936b-11eb-13f0-5f5ab220498c
# ╠═90ea9ad0-936b-11eb-2828-5b74e5d5eaa7
# ╠═9c6a5490-936b-11eb-3fea-5169bbb57147
# ╠═a284d490-936b-11eb-2c08-23df29e9096b
# ╠═a8d076b0-936b-11eb-31f2-7da214d671d2
# ╠═af67eee0-936b-11eb-11b6-19bdcffc2037
# ╠═bda39450-936b-11eb-3676-f1d97db73925
# ╠═c3068420-936b-11eb-3d30-c1b5ffaa4cef
# ╠═f41b0f90-936b-11eb-2ce9-31e6f200672c
# ╟─8479df70-936d-11eb-163b-af461973e40c
# ╠═8add7660-936d-11eb-3ebd-8d623fc02996
# ╠═90c48a50-936d-11eb-3f76-3dcac8271e75
# ╠═9771382e-936d-11eb-3dc5-33cc342051fd
# ╟─2dbb6e60-9296-11eb-1dbb-7d7ca699d2df
# ╠═30db3377-7dea-4e0d-93f1-f06d98aedc46
# ╠═4f081db2-dd61-4635-afa0-b2cb7f51a556
# ╠═d2a41e65-6387-4bfa-9a49-02f1c22f85e8
# ╠═8f116d62-caf6-4129-bd26-54066da1bfe2
# ╠═d9a2d68e-65e1-47c1-ae80-1f7d23ed68f1
# ╠═365d1905-424e-4104-bd7d-61cc0c11fe38
# ╠═25bfc6ea-f5ea-4bcc-8a71-fd33af7fdfce
# ╠═e1264fbc-bff6-46df-9adc-4b0249fcf61e
# ╠═d24bdc8e-3d09-4889-8039-3d153dd9781c
# ╠═11e14c74-0a9c-4c26-a52e-ba4c3593b85b
# ╠═9dc89b24-1d7d-4f35-8d7b-d25797a7116a
# ╠═1c93d028-9c30-4057-a805-304725770eed
# ╠═3574984e-cc30-4cf6-aa30-a2dfd50e90e1
# ╠═84e718d5-4b03-4291-87fc-efa99c7b9e94
# ╠═2eaa317f-5825-4ca8-aece-a8e56bc09e00
# ╠═6359bce0-e105-45c0-9ae3-daee14b1fb68
# ╠═913bb2f7-3222-436c-8f11-e9108971e7d5
# ╟─5e129d40-9296-11eb-1475-4355ca675a69
# ╠═63f45a00-9296-11eb-1dd0-e1e7300e44e5
# ╠═597e351e-92a3-11eb-3b88-0dd8f665d294
# ╠═608203b0-92a3-11eb-0654-c5466cf12546
# ╠═68be7950-92a3-11eb-12f4-1bf507307b05
# ╠═8354cf30-92a3-11eb-3d3b-a794b13201d4
# ╠═8b95155e-92a3-11eb-3a56-91eb0fbfd67d
# ╠═926529c0-92a3-11eb-39f0-0906f5fc22a8
# ╠═422db730-936e-11eb-370e-535ecacfcf74
