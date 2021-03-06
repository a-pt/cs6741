### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ c80df852-7e34-11eb-138e-bb1ca6f19a68
using DataFrames

# ╔═╡ 11b73d40-7e35-11eb-381d-3f605650723b
using Random

# ╔═╡ 36758510-7e35-11eb-20f5-377ff6284927
using Dates

# ╔═╡ 53e4eb90-7e35-11eb-274f-7742d8d4ac7c
using HTTP

# ╔═╡ 583e0c80-7e35-11eb-24d4-c1c1e1155d6a
using JSON

# ╔═╡ 8599d5b0-7e35-11eb-1807-1b8071e471cb
begin
	using Plots
	pyplot()
end

# ╔═╡ 87c42fc0-7e35-11eb-0f49-a1eaddbe61ab
using MarketData

# ╔═╡ 8dae7800-7e35-11eb-2c67-eba134ccaf7c
using MarketTechnicals

# ╔═╡ d8f38810-7e34-11eb-0fb8-379809052ed9
md"# _Question 1_"

# ╔═╡ f521bc00-7e34-11eb-0be2-e751943c7901
begin
	Religion=["Agnostic","Atheist","Bhuddhist","Catholic","Don't know/ Refused","Evangelical Prot","Hindu","Historically Black Prot","Jehovahs Witness","Jewish"]
	s=36
	Columns=["Religion","<\u00A310k","\u00A310-20k","\u00A320-30k","\u00A330-40k","\u00A340-50k","\u00A350-75k","\u00A3>75k"]
	C1=[27,12,27,418,15,575,1,228,20,19]
	C2=[34,27,21,617,14,869,9,244,27,19]
	C3=[60,37,30,732,15,1064,7,236,24,25]
	C4=[81,52,34,670,11,982,9,238,24,25]
	C5=[76,35,33,638,10,881,11,197,21,30]
	C6=[137,70,58,1116,35,1486,34,223,30,95]
	C7=[452,missing,22,15,37,642,missing,12,10,442]
	Columns
end

# ╔═╡ fac9f22e-7e34-11eb-0080-53f99ef34637
begin
		df1=DataFrame()
		df1.religion=Religion
		df1.c1=C1
		df1.c2=C2
		df1.c3=C3
		df1.c4=C4
		df1.c5=C5
		df1.c6=C6
		df1.c7=C7
	    DataFrames.rename!(df1,Columns)
		df1
end

# ╔═╡ 08e8c0d0-7e35-11eb-3886-4d7d099b1178
begin
	df1_stacked = DataFrames.stack(df1, 2:8, :Religion)
	sort!(df1_stacked)
	DataFrames.rename!(df1_stacked,:variable => :Income,:value => :Frequency)
end

# ╔═╡ e2f63ec0-7e34-11eb-216c-11c79b1839df
md"# _Question 2_"

# ╔═╡ 145fc800-7e35-11eb-0670-116243c7ae03
Random.seed!(1)

# ╔═╡ 18aa1be0-7e35-11eb-05fb-4d6d72d7422f
begin
	df2=DataFrame(Id = String[], Year = Int[], Month= Int[], Element = categorical(String[]), d1 = Union{Missing,Real}[], d2 = Union{Missing,Real}[], d3 = Union{Missing,Real}[], d4 = Union{Missing,Real}[], d5 = Union{Missing,Real}[], d6 = Union{Missing,Real}[], d7 = Union{Missing,Real}[], d8 = Union{Missing,Real}[], d31 = Union{Missing,Real}[])
	id_v=["NB12003","OS23041"]
	year_val=[2015,2020]
	for i in 1:5
		push!(df2, ("MX17004", 2010, i, "tmax", rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35)  ))
		push!(df2, ("MX17004", 2010, i, "tmin", rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25)  ))
	end
	for i in 1:5
		s=rand(id_v)
		y=rand(year_val)
		push!(df2, (s, y, i+5, "tmax", rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35), rand(25:0.1:35)  ))
		push!(df2, (s, y, i+5, "tmin", rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25), rand(10:0.1:25)  ))
	end
	c=[1,2,3,4,5,6,7,8,31]
	index=[(2*rand(1:10)-1) for _ in 1:4]
	date=["d"*string(rand(c)) for _ in 1:4]
	for i in 1:4
		df2[index[i],Symbol(date[i])] = missing
		df2[index[i]+1,Symbol(date[i])]=missing
	end
	month=[2,4,6,9]
	for i in month
		df2[2i-1,:d31]=missing
		df2[2i,:d31]=missing
	end
end

# ╔═╡ 1dbc2c90-7e35-11eb-115d-8135cd856a1d
df2

# ╔═╡ 232a6700-7e35-11eb-39f2-8b07fd17d890
begin
	df2_stacked = DataFrames.stack(df2, 5:13)
	sort!(df2_stacked)
	df2_stacked
end

# ╔═╡ 28b996f0-7e35-11eb-0bed-9ba42934253d
begin
	y_cmp=df2_stacked[!, :Year]
	m_cmp=df2_stacked[!, :Month]
	d_cmp=string.(df2_stacked[!, :variable])
	d1=[(string(y_cmp[i])*"-"*string(m_cmp[i])*"-"*SubString(d_cmp[i], 2)) for i in 1:length(y_cmp)]
	insert!(df2_stacked,2,d1,:Date)
	select!(df2_stacked, Not(:Year))
	select!(df2_stacked, Not(:Month))
	select!(df2_stacked, Not(:variable))
	df2_unstack=unstack(df2_stacked, [:Id,:Date], :Element, :value)
	df2_unstack
end

# ╔═╡ 2f989f70-7e35-11eb-1d0e-dba7a0eb9d14
begin
	st=[SubString(df2_unstack[!, :Date][i],6) for i in 1:90]		
	ind=[]
	for i in 1:length(st)
		if st[i] in ["2-31","4-31","6-31","9-31"]
			push!(ind,i)
		end
	end
	deleterows!(df2_unstack,ind)
end

# ╔═╡ e725b7a0-7e34-11eb-2b8f-e951ce73d410
md"# _Question 3_"

# ╔═╡ 3ba975a2-7e35-11eb-3e0f-3beb8b63be12
tup=[("2Pac",Time(4,22),"Baby Don't Cry",Date(2000,02,26)),("2Ge+her",Time(3,15),"The Hardest Part",Date(2000,09,02)),("3 Doors Down",Time(3,53),"Kryptonite",Date(2000,03,24)),("3 Doors Down",Time(4,24),"Loser",Date(2002,04,01)),("504 Boyz",Time(3,35),"Wobble Wobble",Date(2003,01,01)),("Aaliyah",Time(4,15),"I Dont Wanna",Date(2004,12,09)),("Aaliyah",Time(4,03),"Try Again",Date(2002,03,12))]

# ╔═╡ 3f7a05a0-7e35-11eb-0a43-5953582767d5
begin
	df3 = DataFrame(Year = Int[],Artist = String[], Time = Time[],Track =String[], Date= Date[], Week = Int[], Rank = Int[])
	for i in 1:length(tup)
		push!(df3,(Dates.year(tup[i][4]),tup[i][1],tup[i][2],tup[i][3],tup[i][4],1,rand(50:100)))
		no_wk=rand(1:7)
		for j in 2:no_wk
			push!(df3,(Dates.year(tup[i][4]),tup[i][1],tup[i][2],tup[i][3],tup[i][4]+Dates.Day(7*(j-1)),j,rand(50:100)))
		end
	end
	df3
end

# ╔═╡ 44385100-7e35-11eb-00e0-c5e09c537a1a
begin
	df3_split1=unique(df3[:,[:Artist,:Track,:Time]])
	insert!(df3_split1,1,1:length(tup),:Id)
	df3_split1
end

# ╔═╡ 48bf11a0-7e35-11eb-29bb-a13d3d364e0e
df3_split2=innerjoin(df3_split1, df3, on = [:Artist,:Track,:Time])[:,[:Id,:Week,:Date,:Rank]]

# ╔═╡ eb836c72-7e34-11eb-2f31-b92c0faa3333
md"# _Question 4_"

# ╔═╡ 5d061be0-7e35-11eb-240c-73e82770927d
begin
	resp = HTTP.get("https://api.covid19india.org/data.json")
	str = String(resp.body)
	jobj = JSON.Parser.parse(str)
end

# ╔═╡ 618b55e2-7e35-11eb-1667-876d09cc3e9f
function jsontodf(a)
    ka = union([keys(r) for r in a]...)
    df = DataFrame(;Dict(Symbol(k)=>get.(a,k,missing) for k in ka)...)
    return df
end

# ╔═╡ 69b46a90-7e35-11eb-3961-03f9758133ca
df4=jsontodf(jobj["cases_time_series"])

# ╔═╡ 6c0dc3e0-7e35-11eb-2c0c-194830ce3e73
begin
	c1=parse.(Int64,df4[!,:totalconfirmed])
	select!(df4, Not(:totalconfirmed))
	insert!(df4,1,c1,:totalconfirmed)
	c2=parse.(Date,df4[!,:dateymd])
	select!(df4, Not(:dateymd))
	insert!(df4,2,c2,:dateymd)	
	c3=parse.(Int64,df4[!,:totaldeceased])
	select!(df4, Not(:totaldeceased))
	insert!(df4,3,c3,:totaldeceased)
	c4=parse.(Int64,df4[!,:dailydeceased])
	select!(df4, Not(:dailydeceased))
	insert!(df4,4,c4,:dailydeceased)
	c5=parse.(Int64,df4[!,:dailyrecovered])
	select!(df4, Not(:dailyrecovered))
	insert!(df4,5,c5,:dailyrecovered)
	c6=parse.(Int64,df4[!,:totalrecovered])
	select!(df4, Not(:totalrecovered))
	insert!(df4,6,c6,:totalrecovered)
	c8=parse.(Int64,df4[!,:dailyconfirmed])
	select!(df4, Not(:dailyconfirmed))
	insert!(df4,8,c8,:dailyconfirmed)
	df4
end

# ╔═╡ 731a1dee-7e35-11eb-2e42-6736fa6f88cb
begin
	insert!(df4,1,Month.(c2),:Month)
	insert!(df4,1,Year.(c2),:Year)
	df4
end

# ╔═╡ 77ca1170-7e35-11eb-35d0-4393123c9089
gdf = groupby(df4, [:Year,:Month])

# ╔═╡ 7d142210-7e35-11eb-3380-15fa84534eb5
combine(gdf,:dailyconfirmed => sum =>:Confirmed_Agg, :dailydeceased => sum => :Deceased_Agg, :dailyrecovered => sum => :Recovered_Agg)

# ╔═╡ eedf1a90-7e34-11eb-321a-dfbc32230756
md"# _Question 5_"

# ╔═╡ 94d3b140-7e35-11eb-062b-89ffc7defab1
begin
	dd=sma(df4.dailydeceased,7)[:,1]
	dr=sma(df4.dailyrecovered,7)[:,1]
	dc=sma(df4.dailyconfirmed,7)[:,1]
	pushfirst!(dc, 0,0,0,0,0,0)
	pushfirst!(dr, 0,0,0,0,0,0)
	pushfirst!(dd, 0,0,0,0,0,0)
end

# ╔═╡ 96bb0ee0-7e35-11eb-0f32-ed32fc815e6b
begin
	insert!(df4,4,dd,:Ma_deceased)
	insert!(df4,4,dr,:Ma_recovered)
	insert!(df4,4,dc,:Ma_confirmed)
	select!(df4, Not(:Year))
	select!(df4, Not(:Month))
	df4
end

# ╔═╡ 9c26ff60-7e35-11eb-1940-2bc2f432bef7
begin
	plot(df4.dateymd,df4.dailydeceased,label="Original Dataset",xlabel="Date",ylabel="Deceased")
	plot!(df4.dateymd,dd,label="Moving Average")
end

# ╔═╡ a2e5fcc0-7e35-11eb-13ed-af35d802780c
begin
	plot(df4.dateymd,df4.dailyconfirmed,label="Original Dataset",xlabel="Date",ylabel="Confirmed")
	plot!(df4.dateymd,dc,label="Moving Average")
end

# ╔═╡ a772fef0-7e35-11eb-304e-89b5fa123d42
begin
	plot(df4.dateymd,df4.dailyrecovered,label="Original Dataset",xlabel="Date",ylabel="Recovered")
	plot!(df4.dateymd,dr,label="Moving Average")
end

# ╔═╡ Cell order:
# ╠═c80df852-7e34-11eb-138e-bb1ca6f19a68
# ╟─d8f38810-7e34-11eb-0fb8-379809052ed9
# ╠═f521bc00-7e34-11eb-0be2-e751943c7901
# ╠═fac9f22e-7e34-11eb-0080-53f99ef34637
# ╠═08e8c0d0-7e35-11eb-3886-4d7d099b1178
# ╟─e2f63ec0-7e34-11eb-216c-11c79b1839df
# ╠═11b73d40-7e35-11eb-381d-3f605650723b
# ╠═145fc800-7e35-11eb-0670-116243c7ae03
# ╠═18aa1be0-7e35-11eb-05fb-4d6d72d7422f
# ╠═1dbc2c90-7e35-11eb-115d-8135cd856a1d
# ╠═232a6700-7e35-11eb-39f2-8b07fd17d890
# ╠═28b996f0-7e35-11eb-0bed-9ba42934253d
# ╠═2f989f70-7e35-11eb-1d0e-dba7a0eb9d14
# ╟─e725b7a0-7e34-11eb-2b8f-e951ce73d410
# ╠═36758510-7e35-11eb-20f5-377ff6284927
# ╠═3ba975a2-7e35-11eb-3e0f-3beb8b63be12
# ╠═3f7a05a0-7e35-11eb-0a43-5953582767d5
# ╠═44385100-7e35-11eb-00e0-c5e09c537a1a
# ╠═48bf11a0-7e35-11eb-29bb-a13d3d364e0e
# ╟─eb836c72-7e34-11eb-2f31-b92c0faa3333
# ╠═53e4eb90-7e35-11eb-274f-7742d8d4ac7c
# ╠═583e0c80-7e35-11eb-24d4-c1c1e1155d6a
# ╠═5d061be0-7e35-11eb-240c-73e82770927d
# ╠═618b55e2-7e35-11eb-1667-876d09cc3e9f
# ╠═69b46a90-7e35-11eb-3961-03f9758133ca
# ╠═6c0dc3e0-7e35-11eb-2c0c-194830ce3e73
# ╠═731a1dee-7e35-11eb-2e42-6736fa6f88cb
# ╠═77ca1170-7e35-11eb-35d0-4393123c9089
# ╠═7d142210-7e35-11eb-3380-15fa84534eb5
# ╟─eedf1a90-7e34-11eb-321a-dfbc32230756
# ╠═8599d5b0-7e35-11eb-1807-1b8071e471cb
# ╠═87c42fc0-7e35-11eb-0f49-a1eaddbe61ab
# ╠═8dae7800-7e35-11eb-2c67-eba134ccaf7c
# ╠═94d3b140-7e35-11eb-062b-89ffc7defab1
# ╠═96bb0ee0-7e35-11eb-0f32-ed32fc815e6b
# ╠═9c26ff60-7e35-11eb-1940-2bc2f432bef7
# ╠═a2e5fcc0-7e35-11eb-13ed-af35d802780c
# ╠═a772fef0-7e35-11eb-304e-89b5fa123d42
