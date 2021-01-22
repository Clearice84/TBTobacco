****tbt_master_healtheco_20190624************************

table alloc country

tab d0_behavsupp

table alloc country, c(mean d0_sdh_age sd d0_sdh_age) col

bysort alloc: tab country d0_sdh_gender

table alloc country, c(mean d0_smoke_years sd d0_smoke_years) col

foreach n of numlist 1/6 {
	by alloc: tab country d0_tuqh3_`n'
}

count if d0_tuqh3_6oth != "" & d0_tuqh3_6 == 2
***0***
count if d0_tuqh3_6oth != "" & d0_tuqh3_6 == 1
***61, 2 missing***
by alloc: list d0_tuqh3_6oth if d0_tuqh3_6 == 1 & country == 1
by alloc: list d0_tuqh3_6oth if d0_tuqh3_6 == 1 & country == 2

tab d0_isco
count if d0_isco_oth != ""
tab d0_isco_oth
list d0_isco d0_isco_oth if d0_isco_oth != "" & d0_isco != 15

replace d0_isco = 12 if d0_isco_oth == "BEGGING"
replace d0_isco = 8 if d0_isco_oth == "BOAT MAN" | d0_isco_oth == "BOATSMAN"
replace d0_isco = 1 if d0_isco_oth == "BUSINESS" | d0_isco_oth == "BUSINESS MAN" | d0_isco_oth == "BUSINESS OF RAW MATERIALS." ////
	| d0_isco_oth == "BUSINESSMAN" | d0_isco_oth == "BUSINESSNAN" | d0_isco_oth == "BUSINSESS MAN"
replace d0_isco = 5 if d0_isco_oth == "CARETAKER OF A HOME" | d0_isco_oth == "CATERING"
replace d0_isco = 3 if d0_isco_oth == "CONTRACTOR" | d0_isco_oth == "DECORATOR"
replace d0_isco = 7 if d0_isco_oth == "ELECTRIC WORKER" | d0_isco_oth == "ELECTRICAL" | d0_isco_oth == "ELECTRICIAN"
replace d0_isco = 5 if d0_isco_oth == "FRUIT SELLER" | d0_isco_oth == "GOLD SHOP WORKER" | d0_isco_oth == "GUARDS" ////
	| d0_isco_oth == "HENS SELLER" | d0_isco_oth == "HOUSE SECURITY GUARD"
replace d0_isco = 7 if d0_isco_oth == "GARMENTS WORKER" | d0_isco_oth == "GERMENTS WORKER"
replace d0_isco = 1 if d0_isco_oth == "HOTEL BUSINESS"
replace d0_isco = 13 if d0_isco_oth == "HOUSEWIFE"
replace d0_isco = 3 if d0_isco_oth == "INTERNET CABLE OPERETOR"
replace d0_isco = 7 if d0_isco_oth == "IRON WORKER" | d0_isco_oth == "PAINTER" | d0_isco_oth == "PRINT WORKER" ////
	| d0_isco_oth == "RMG WORKER" | d0_isco_oth == "TAILOR" | d0_isco_oth == "WELDING WORKER"
replace d0_isco = 1 if d0_isco_oth == "MERCHANT" | d0_isco_oth == "RAW MATERIALS BUSINESS"
replace d0_isco = 5 if d0_isco_oth == "NIGHT GUARD" | d0_isco_oth == "SECURITIES GUARD" | d0_isco_oth == "SECURITY GUARD" | ////
	d0_isco_oth == "SELLS FRUITS" | d0_isco_oth == "SERVICE" | d0_isco_oth == "SHOP OWNER" | d0_isco_oth == "TEA STALL" ////
	| d0_isco_oth == "VEGETABLE SELLER"
replace d0_isco = 9 if d0_isco_oth == "RICKSHA PULLER" | d0_isco_oth == "RICKSHAW PULLER" | d0_isco_oth == "RIKSHAW PULLER" ////
	| d0_isco_oth == "STREET VENDOR"
replace d0_isco = 2 if d0_isco_oth == "TRADITIONAL MEDICINE PRACTITIONER" | d0_isco_oth == "TUTOR"


***multi-type tobacco use, excluding others as those are not tobacco****
foreach n of numlist 1/5 {
	recode d0_tuqh3_`n' 2=0
}
egen d0_tuqh3_total = rowtotal(d0_tuqh3_1-d0_tuqh3_5)
foreach n of numlist 1/5 {
	recode d0_tuqh3_`n' 0=2
}
bysort alloc: tab country d0_tuqh3_total

foreach n of numlist 1/5 {
	by alloc: tab country d0_tuqh3_`n' if d0_tuqh3_total == 1
}

count if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_1 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_1 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_1 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_2 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_2 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_2 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_3 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_3 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 2
count if d0_tuqh3_4 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 2

gen d0_tobcom = 0 if d0_tuqh3_total == 1
replace d0_tobcom = 1 if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_total == 2
***cig+bidi
replace d0_tobcom = 2 if d0_tuqh3_1 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_total == 2
***cig+hookah
replace d0_tobcom = 3 if d0_tuqh3_1 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 2
***cig+ecig
replace d0_tobcom = 4 if d0_tuqh3_1 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 2
***cig+smokeless
replace d0_tobcom = 5 if d0_tuqh3_2 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 2
***bidi+smokeless

count if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_1 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_1 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_1 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_2 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_2 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3
count if d0_tuqh3_3 == 1 & d0_tuqh3_3 == 4 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3

replace d0_tobcom = 6 if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_total == 3
***cig+bidi+hookah
replace d0_tobcom = 7 if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3
***cig+bidi+smokeless
replace d0_tobcom = 8 if d0_tuqh3_1 == 1 & d0_tuqh3_4 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 3
***cig+ecig+smokeless

replace d0_tobcom = 9 if d0_tuqh3_1 == 1 & d0_tuqh3_2 == 1 & d0_tuqh3_3 == 1 & d0_tuqh3_5 == 1 & d0_tuqh3_total == 4
***cig+bidi+hookah+smokeless

label define tobcom 0 "single" 1 "cig+bidi" 2 "cig+hookah" 3 "cig+ecig" 4 "cig+smokeless" 5 "bidi+smokeless" ////
		6 "cig+bidi+hookah" 7 "cig+bidi+smokeless" 8 "cig+ecig+smokeless" 9 "cig+bidi+hookah+smokeless"

label val d0_tobcom tobcom

by alloc: tab d0_tobcom country

bysort alloc: tab country d0_tuqh6

table alloc country, c(n d0_suts1 mean d0_suts1 sd d0_suts1) col

table alloc country, c(n d0_htui mean d0_htui sd d0_htui) col

table alloc country, c(n d0_tbsc mean d0_tbsc sd d0_tbsc) col

by alloc: tab country d0_tbsc_cat

by alloc: sum d0_eco* d0_eq5d*

****TB medication records********************
***only d0 & m6 contains these data******
sum *_tbmth*
**d0 only have data on month 1-2, m6 also report month 1-2, only need to look at m6
foreach n of numlist 1/6 {
	gen m6_mth`n'_tbtaken = m6_tbmth`n'_med1
	label var m6_mth`n'_tbtaken "days anti-TB med taken"
	gen m6_mth`n'_tbnottaken = d0_tbmth`n'_med2
	label var m6_mth`n'_tbnottaken "days anti-TB med not taken"
	gen m6_mth`n'_tbmiss = d0_tbmth`n'_med3
	label var m6_mth`n'_tbmiss "days anti-TB med unrecorded"
}

foreach n of numlist 1/6 {
	egen temp = rowtotal(m6_mth`n'_tbtaken-m6_mth`n'_tbmiss), m
	display "Month `n'"
	tab temp, m
	drop temp
}


egen tbtaken_total = rowtotal(m6_mth1_tbtaken m6_mth2_tbtaken m6_mth3_tbtaken m6_mth4_tbtaken m6_mth5_tbtaken m6_mth6_tbtaken), m
sum m6_mth1_tbtaken-m6_mth6_tbmiss if mi(tbtaken_total)
****month1 198 recording empty cells, all other all missing

sum tbtaken_total

tab alloc country if tbtaken_total == 0
tab alloc country if mi(tbtaken_total)
by alloc: table country if tbtaken_total > 0 & !mi(tbtaken_total), c(n tbtaken_total mean tbtaken_total ////
	sd tbtaken_total min tbtaken_total max tbtaken_total)

egen tbtaken_IP = rowtotal(m6_mth1_tbtaken m6_mth2_tbtaken), m
replace tbtaken_IP = tbtaken_IP / 60
replace tbtaken_IP = 2 if tbtaken_IP > 2 & !mi(tbtaken_IP)

egen tbtaken_CP = rowtotal(m6_mth3_tbtaken m6_mth4_tbtaken m6_mth5_tbtaken m6_mth6_tbtaken), m
replace tbtaken_CP = tbtaken_CP / 120
replace tbtaken_CP = 4 if tbtaken_CP > 4 & !mi(tbtaken_CP)

count if tbtaken_CP > 0 & !mi(tbtaken_CP) & tbtaken_IP == 0
count if tbtaken_CP > 0 & !mi(tbtaken_CP) & mi(tbtaken_IP)
***0 reported CP when no IP reported

tab alloc country if tbtaken_IP == 0
tab alloc country if mi(tbtaken_IP)
by alloc: table country if tbtaken_IP > 0 & !mi(tbtaken_IP), c(n tbtaken_IP mean tbtaken_IP sd tbtaken_IP ////
	min tbtaken_IP max tbtaken_IP)

tab alloc country if tbtaken_CP == 0
tab alloc country if mi(tbtaken_CP)
by alloc: table country if tbtaken_CP > 0 & !mi(tbtaken_CP), c(n tbtaken_CP mean tbtaken_CP sd tbtaken_CP ////
	min tbtaken_CP max tbtaken_CP)

***************************************************************************************
recode d0_datecomp 0=0 nonm=1, g(temp1)
recode d0_datetreat 0=0 nonm=1, g(temp2)
tab temp1 temp2, m
drop temp*

sysdir set PLUS "P:\Documents\STATA"
gen d0_daysintreat = d0_datecomp - d0_datetreat
sum d0_daysintreat
tab d0_daysintreat
***-365, -1, >31, 661090
list patid rand_date d0_datecomp d0_datetreat if d0_daysintreat < 0 | d0_daysintreat > 31

gen float temp = date(m6_datetreat, "DMY")
format temp %td
drop m6_datetreat
rename temp m6_datetreat

recode m6_datecomp 0=0 nonm=1, g(temp1)
recode m6_datetreat 0=0 nonm=1, g(temp2)
tab temp1 temp2, m
drop temp*

gen m6_daysintreat = m6_datecomp - m6_datetreat
sum m6_daysintreat
tab m6_daysintreat
list patid m6_datecomp m6_datetreat if m6_daysintreat < 0
list patid m6_datecomp m6_datetreat if !mi(m6_daysintreat) & m6_daysintreat > 211

egen match_datetreat = diff(d0_datetreat m6_datetreat)
replace match_datetreat = 0 if mi(m6_datetreat) | mi(d0_datetreat)
tab match_datetreat
list patid d0_datecomp d0_datetreat m6_datecomp m6_datetreat if match_datetreat == 1
****m6_daysintreat doesn't work as some m6 followup were late
***do not use datetreat************************************************************************



****************HE part baseline*******************************************
local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	foreach n of numlist 1/4 6 9 {
		by alloc: tab country `t'_eco`n'
	}
}

*************Eco1**********************************************************
local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	egen temp = rownonmiss(`t'_eco1a-`t'_eco1e_mins)
	count if `t'_eco1 == 2 & temp != 0
	count if `t'_eco1 == 1 & temp == 0
	drop temp
}
***all No with no answers in following Qs
***bl: 1 yes all missing
***6m: 4 yes all missing
***12m: 1 yes all missing

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	egen temp = rownonmiss(`t'_eco1a-`t'_eco1e_mins)
	list alloc country `t'_eco1a-`t'_eco1e_mins if `t'_eco1 == 1 & temp == 0
	drop temp
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	egen temp = rownonmiss(`t'_eco1a-`t'_eco1e_mins)
	tab temp if `t'_eco1 == 1
	drop temp
}
***overall majority are complete but some are missing some items

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	recode `t'_eco1a 0=0 nonm=1 if `t'_eco1 == 1, g(temp1)
	recode `t'_eco1b 0=0 nonm=1 if `t'_eco1 == 1, g(temp2)
	tab temp1 temp2 if `t'_eco1 == 1, m
	list alloc country `t'_eco1a-`t'_eco1b_1 if temp1 == 0 & temp2 == 0
	drop temp1 temp2
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	recode `t'_eco1b 0=0 nonm=1 if `t'_eco1 == 1, g(temp1)
	recode `t'_eco1b_1 0=0 nonm=1 if `t'_eco1 == 1, g(temp2)
	tab temp1 temp2 if `t'_eco1 == 1, m
	list alloc country `t'_eco1a-`t'_eco1b_1 if temp1 == 1 & temp2 == 0
	drop temp1 temp2
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	gen `t'_tbclinic = `t'_eco1a
	gen `t'_tbprivclin = `t'_eco1b
	gen `t'_exp_tbprivclin = `t'_eco1b_1
	
	replace `t'_tbclinic = 0 if `t'_eco1 == 2
	replace `t'_tbclinic = . if `t'_eco1 == 1 & `t'_eco1a == 0 & `t'_eco1b == 0 & `t'_eco1b_1 == 0
	replace `t'_tbclinic = . if `t'_eco1 == 1 & `t'_eco1a == 0 & `t'_eco1b == 0 & mi(`t'_eco1b_1)
	replace `t'_tbclinic = 0 if `t'_eco1 == 1 & mi(`t'_eco1a) & !mi(`t'_eco1b) & `t'_eco1b > 0
	replace `t'_tbclinic = 0 if `t'_eco1 == 1 & mi(`t'_eco1a) & !mi(`t'_eco1b_1) & `t'_eco1b_1 > 0
	
	replace `t'_tbprivclin = 0 if `t'_eco1 == 2
	replace `t'_tbprivclin = . if `t'_eco1 == 1 & `t'_eco1b == 0 & `t'_eco1b_1 > 0 & !mi(`t'_eco1b_1)
	replace `t'_tbprivclin = . if `t'_eco1 == 1 & `t'_eco1a == 0 & `t'_eco1b == 0 & `t'_eco1b_1 == 0
	replace `t'_tbprivclin = . if `t'_eco1 == 1 & `t'_eco1a == 0 & `t'_eco1b == 0 & mi(`t'_eco1b_1)
	replace `t'_tbprivclin = 0 if `t'_eco1 == 1 & !mi(`t'_eco1a) & `t'_eco1a > 0 & mi(`t'_eco1b) & mi(`t'_eco1b_1)
	
	replace `t'_exp_tbprivclin = 0 if `t'_eco1 == 2
	replace `t'_exp_tbprivclin = . if `t'_eco1 == 1 & `t'_eco1a == 0 & `t'_eco1b == 0 & `t'_eco1b_1 == 0
	replace `t'_exp_tbprivclin = 0 if `t'_eco1 == 1 & !mi(`t'_eco1a) & `t'_eco1a > 0 & mi(`t'_eco1b) & mi(`t'_eco1b_1)
	
	display "`t' public vs private TB"
	recode `t'_tbclinic 0=0 nonm=1, g(temp1)
	recode `t'_tbprivclin 0=0 nonm=1, g(temp2)
	replace temp2 = 1 if mi(temp2) & !mi(`t'_exp_tbprivclin) & `t'_exp_tbprivclin > 0
	tab temp1 temp2, m
	drop temp1 temp2
	
	display "`t' private TB vs exp private TB"
	recode `t'_tbprivclin 0=0 nonm=1, g(temp1)
	recode `t'_exp_tbprivclin 0=0 nonm=1, g(temp2)
	tab temp1 temp2, m
	drop temp1 temp2
	
}


local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	display "0 public TB clinic"
	tab alloc country if `t'_tbclinic == 0
	display "missing public TB clinic"
	tab alloc country if `t'_tbclinic == .
	table alloc country if `t'_tbclinic > 0 & !mi(`t'_tbclinic), c(n `t'_tbclinic mean `t'_tbclinic sd ////
		`t'_tbclinic min `t'_tbclinic max `t'_tbclinic)
	table alloc if `t'_tbclinic > 0 & !mi(`t'_tbclinic), c(n `t'_tbclinic mean `t'_tbclinic sd ////
		`t'_tbclinic min `t'_tbclinic max `t'_tbclinic)
	
	display "0 private TB clinic expense"
	tab alloc country if `t'_exp_tbprivclin == 0
	display "missing private TB clinic expense"
	tab alloc country if `t'_exp_tbprivclin == .	
	table alloc country if `t'_exp_tbprivclin > 0 & !mi(`t'_exp_tbprivclin), c(n `t'_exp_tbprivclin mean ////
		`t'_exp_tbprivclin sd `t'_exp_tbprivclin min `t'_exp_tbprivclin max `t'_exp_tbprivclin)

}

****PPP Pakistan 29.3/USD, Bangladesh 30.9/USD in 2017, 2018 has come out yet 26/06/2019
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_pppexp_tbprivclin = `t'_exp_tbprivclin / 29.3 if country == 1
	replace `t'_pppexp_tbprivclin = `t'_exp_tbprivclin / 30.9 if country == 2
	table alloc country if `t'_pppexp_tbprivclin > 0 & !mi(`t'_pppexp_tbprivclin), c(n `t'_pppexp_tbprivclin mean ////
		`t'_pppexp_tbprivclin sd `t'_pppexp_tbprivclin min `t'_pppexp_tbprivclin max `t'_pppexp_tbprivclin)
	table alloc if `t'_pppexp_tbprivclin > 0 & !mi(`t'_pppexp_tbprivclin), c(n `t'_pppexp_tbprivclin mean ////
		`t'_pppexp_tbprivclin sd `t'_pppexp_tbprivclin min `t'_pppexp_tbprivclin max `t'_pppexp_tbprivclin)
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_tbtravel = `t'_eco1c
	replace `t'_exp_tbtravel = 0 if `t'_eco1 == 2
	display "`t'"
	display "0 travel expense"
	tab alloc country if `t'_exp_tbtravel == 0 & `t'_eco1 == 1
	display "missing travel expense"
	tab alloc country if `t'_exp_tbtravel == . & `t'_eco1 == 1
	table alloc country if `t'_exp_tbtravel > 0 & !mi(`t'_exp_tbtravel) & `t'_eco1 == 1, c(n `t'_exp_tbtravel mean `t'_exp_tbtravel ////
		sd `t'_exp_tbtravel min `t'_exp_tbtravel max `t'_exp_tbtravel)
	
	gen `t'_pppexp_tbtravel = `t'_exp_tbtravel/29.3 if country == 1
	replace `t'_pppexp_tbtravel = `t'_exp_tbtravel/30.9 if country == 2
	table alloc country if `t'_pppexp_tbtravel > 0 & !mi(`t'_pppexp_tbtravel) & `t'_eco1 == 1, c(n `t'_pppexp_tbtravel mean `t'_pppexp_tbtravel ////
		sd `t'_pppexp_tbtravel min `t'_pppexp_tbtravel max `t'_pppexp_tbtravel) col
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_tbcompany = `t'_eco1d
	replace `t'_tbcompany = 0 if `t'_eco1 == 2
	display "`t'"
	display "no company for visit"
	tab alloc country if `t'_tbcompany == 0 & `t'_eco1 == 1
	display "missing company for visit"
	tab alloc country if `t'_tbcompany == . & `t'_eco1 == 1
	table alloc country if `t'_tbcompany > 0 & !mi(`t'_tbcompany)  & `t'_eco1 == 1, c(n `t'_tbcompany mean `t'_tbcompany sd `t'_tbcompany ////
		min `t'_tbcompany max `t'_tbcompany) col
}

local time "d0 m6 m12"
foreach t of local time {
	egen temp1 = rowtotal(`t'_tbclinic `t'_tbprivclin), m
	gen temp2 = temp1 - `t'_tbcompany
	list `t'_tbclinic `t'_tbprivclin `t'_tbcompany if temp2 < 0 & `t'_eco1 == 1
	drop temp*
}

local time "d0 m6 m12"
foreach t of local time {
	egen temp1 = rowtotal(`t'_tbclinic `t'_tbprivclin), m
	gen temp2 = temp1 - `t'_tbcompany
	replace `t'_tbcompany = . if temp2 < 0 & `t'_eco1 == 1
	drop temp*
}

sum d0_eco1e_* m6_eco1e_* m12_eco1e_*
tab1 d0_eco1e_hrs m6_eco1e_hrs m12_eco1e_hrs

local time "d0 m6 m12"
foreach t of local time {
	gen temp = `t'_eco1e_mins/60
	egen `t'_tbvisittime = rowtotal(`t'_eco1e_hrs temp), m
	drop temp
	replace `t'_tbvisittime = 0 if `t'_eco1 == 2
	display "`t'"
	display "0 hours"
	tab alloc country if `t'_tbvisittime == 0 & `t'_eco1 ==1
	display "missing visit time"
	tab alloc country if `t'_tbvisittime == . & `t'_eco1 ==1
	table alloc country if `t'_tbvisittime > 0 & !mi(`t'_tbvisittime)  & `t'_eco1 == 1, c(n `t'_tbvisittime mean `t'_tbvisittime sd `t'_tbvisittime ////
		min `t'_tbvisittime max `t'_tbvisittime) col
}



local time "d0 m6 m12"
foreach t of local time {
	sum `t'_eco2a-`t'_eco2f_mins if `t'_eco2 == 2
}
***all missing following No to eco2

local time "d0 m6 m12"
foreach t of local time {
	sum `t'_eco2a-`t'_eco2f_mins if `t'_eco2 == 2
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	egen temp = rownonmiss(`t'_eco2a-`t'_eco2f_mins)
	list alloc country `t'_eco2a-`t'_eco2f_mins if `t'_eco2 == 1 & temp == 0
	drop temp
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	recode `t'_eco2a 0=0 nonm=1 if `t'_eco2 == 1, g(temp1)
	recode `t'_eco2a_1 0=0 nonm=1 if `t'_eco2 == 1, g(temp2)
	recode `t'_eco2b 0=0 nonm=1 if `t'_eco2 == 1, g(temp3)
	recode `t'_eco2b_1 0=0 nonm=1 if `t'_eco2 == 1, g(temp4)
	
	display "public vs priate doctor"
	tab temp1 temp3 if `t'_eco2 == 1, m
	display "public doctor"
	tab temp1 temp2 if `t'_eco2 == 1, m
	display "private doctor"
	tab temp3 temp4 if `t'_eco2 ==1, m
	
	drop temp*
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	gen `t'_pubdoc = `t'_eco2a
	gen `t'_exp_pubdoc = `t'_eco2a_1
	gen `t'_privdoc = `t'_eco2b
	gen `t'_exp_privdoc = `t'_eco2b_1
	
	replace `t'_pubdoc = 0 if `t'_eco2 == 2
	replace `t'_exp_pubdoc = 0 if `t'_eco2 == 2
	replace `t'_privdoc = 0 if `t'_eco2 == 2
	replace `t'_exp_privdoc = 0 if `t'_eco2 == 2
	
	recode `t'_eco2a 0=0 nonm=1 mis=2, g(temp1)
	recode `t'_eco2a_1 0=0 nonm=1 mis=2, g(temp2)
	recode `t'_eco2b 0=0 nonm=1 mis=2, g(temp3)
	recode `t'_eco2b_1 0=0 nonm=1 mis=2, g(temp4)
	
	replace `t'_pubdoc = . if `t'_eco2 == 1 & temp1 == 0 & temp2 == 0 & temp3 == 0 & temp4 == 0
	replace `t'_exp_pubdoc = . if `t'_eco2 == 1 & temp1 == 0 & temp2 == 0 & temp3 == 0 & temp4 == 0
	replace `t'_privdoc = . if `t'_eco2 == 1 & temp1 == 0 & temp2 == 0 & temp3 == 0 & temp4 == 0
	replace `t'_exp_privdoc = . if `t'_eco2 == 1 & temp1 == 0 & temp2 == 0 & temp3 == 0 & temp4 == 0
	
	replace `t'_pubdoc = . if temp1 == 0 & temp2 == 1
	replace `t'_pubdoc = 0 if temp1 == 2 & temp2 == 2 & temp3 == 1
	replace `t'_pubdoc = 0 if temp1 == 2 & temp2 == 2 & temp4 == 1
	replace `t'_exp_pubdoc = 0 if temp1 == 2 & temp2 == 2 & temp3 == 1
	replace `t'_exp_pubdoc = 0 if temp1 == 2 & temp2 == 2 & temp4 == 1
	
	replace `t'_privdoc = . if temp3 == 0 & temp4 == 1
	replace `t'_privdoc = 0 if temp3 == 2 & temp4 == 2 & temp1 == 1
	replace `t'_privdoc = 0 if temp3 == 2 & temp4 == 2 & temp2 == 1
	replace `t'_exp_privdoc = 0 if temp3 == 2 & temp4 == 2 & temp1 == 1
	replace `t'_exp_privdoc = 0 if temp3 == 2 & temp4 == 2 & temp2 == 1
	
	drop temp*
	
	recode `t'_pubdoc 0=0 nonm=1, g(temp1)
	recode `t'_exp_pubdoc 0=0 nonm=1, g(temp2)
	recode `t'_privdoc 0=0 nonm=1, g(temp3)
	recode `t'_exp_privdoc 0=0 nonm=1, g(temp4)
	display "`t' public vs private doc"
	tab temp1 temp3, m
	display "`t' public vs exp public doc"
	tab temp1 temp2, m
	display "`t' private TB vs exp private doc"
	tab temp3 temp4, m
	
	drop temp*
	
}

replace d0_exp_privdoc = 0 if mi(d0_exp_privdoc) & d0_privdoc == 0
replace m6_exp_privdoc = 0 if mi(m6_exp_privdoc) & m6_privdoc == 0

local time "d0 m6 m12"
local name "pubdoc exp_pubdoc privdoc exp_privdoc"
foreach t of local time {
	foreach n of local name {
		display "`t' 0 `n'"
		tab alloc country if `t'_`n' == 0
		display "`t' missing `n'"
		tab alloc country if `t'_`n' == .
		table alloc country if `t'_`n' > 0 & !mi(`t'_`n'), c(n `t'_`n' mean `t'_`n' sd `t'_`n' ////
		min `t'_`n' max `t'_`n') col
	}
}

local time "d0 m6 m12"
local name "exp_pubdoc exp_privdoc"
foreach t of local time {
	foreach n of local name {
		gen `t'_ppp`n' = `t'_`n' / 29.3 if country == 1
		replace `t'_ppp`n' = `t'_`n' / 30.9 if country == 2
		display "`t' PPP `n'"
		table alloc country if `t'_ppp`n' > 0 & !mi(`t'_ppp`n'), c(n `t'_ppp`n' mean `t'_ppp`n' sd `t'_ppp`n' ////
		min `t'_ppp`n' max `t'_ppp`n') col
	}
}

sum d0_eco2c_* m6_eco2c_* m12_eco2c_*
sum d0_eco2f_* m6_eco2f_* m12_eco2f_*

local time "d0 m6 m12"
foreach t of local time {
	gen temp = `t'_eco2c_mins/60
	egen `t'_docf2ftime = rowtotal(`t'_eco2c_hrs temp), m
	drop temp
	replace `t'_docf2ftime = 0 if `t'_eco2 == 2
	
	gen temp = `t'_eco2f_mins/60
	egen `t'_docvisittime = rowtotal(`t'_eco2f_hrs temp), m
	drop temp
	replace `t'_docvisittime = 0 if `t'_eco2 == 2
	
	gen temp = `t'_docvisittime - `t'_docf2ftime if !mi(`t'_docvisittime & `t'_docf2ftime)
	list patid alloc country `t'_eco2c_* `t'_eco2f_* if temp < 0
	drop temp
}

local time "d0 m6 m12"
foreach t of local time {
	gen temp = `t'_docvisittime - `t'_docf2ftime if !mi(`t'_docvisittime & `t'_docf2ftime)
	replace `t'_docf2ftime = . if temp < 0
	replace `t'_docvisittime = . if temp < 0
	drop temp
}

local time "d0 m6 m12"
local name "docf2ftime docvisittime"
foreach t of local time {
	foreach n of local name {
		display "`t' 0 hours `n'"
		tab alloc country if `t'_`n' == 0 & `t'_eco2 == 1
		display "`t' missing `n'"
		tab alloc country if `t'_`n' == . & `t'_eco2 == 1
		table alloc country if `t'_`n' > 0 & !mi(`t'_`n')  & `t'_eco2 == 1, c(n `t'_`n' mean `t'_`n' sd `t'_`n' ////
			min `t'_`n' max `t'_`n') col
	}
}


local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_doctravel = `t'_eco2d
	replace `t'_exp_doctravel = 0 if `t'_eco2 == 2
	
	gen `t'_pppexp_doctravel = `t'_exp_doctravel/29.3 if country == 1
	replace `t'_pppexp_doctravel = `t'_exp_doctravel/29.3 if country == 2
	
	gen `t'_doccompany = `t'_eco2e
	replace `t'_doccompany = 0 if `t'_eco2 == 2
}

local time "d0 m6 m12"		
local name "exp_doctravel pppexp_doctravel doccompany"
foreach t of local time {
	foreach n of local name {
		display "`t' 0 `n'"
		tab alloc country if `t'_`n' == 0 & `t'_eco2 == 1
		display "`t' missing `n'"
		tab alloc country if `t'_`n' == . & `t'_eco2 == 1
		table alloc country if `t'_`n' > 0 & !mi(`t'_`n')  & `t'_eco2 == 1, c(n `t'_`n' mean `t'_`n' sd `t'_`n' ////
			min `t'_`n' max `t'_`n') col
	}
}

local time "d0 m6 m12"
foreach t of local time {
	egen temp1 = rowtotal(`t'_pubdoc `t'_privdoc), m
	gen temp2 = temp1 - `t'_doccompany
	list `t'_pubdoc `t'_privdoc `t'_doccompany if temp2 < 0 & `t'_eco2 == 1
	drop temp*
}

local time "d0 m6 m12"
foreach t of local time {
	egen temp1 = rowtotal(`t'_pubdoc `t'_privdoc), m
	gen temp2 = temp1 - `t'_doccompany
	replace `t'_doccompany = . if temp2 < 0 & `t'_eco2 == 1
	drop temp*
}


local time "d0 m6 m12"
local name "docf2ftime docvisittime"
foreach t of local time {
	foreach n of local name {
		replace `t'_`n' = . if `t'_`n' == 0 & `t'_eco2 == 1
	}
}


sum d0_eco3a-d0_eco3c if d0_eco3 == 2
sum m6_eco3a-m6_eco3c if m6_eco3 == 2
sum m12_eco3a-m12_eco3c if m12_eco3 == 2
***eco3 no, all following missing

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_pubhos = `t'_eco3a
	gen `t'_exp_pubhos = `t'_eco3a_1
	gen `t'_privhos = `t'_eco3b
	gen `t'_exp_privhos = `t'_eco3b_1
	
	replace `t'_pubhos = 0 if `t'_eco3 == 2
	replace `t'_exp_pubhos = 0 if `t'_eco3 == 2
	replace `t'_privhos = 0 if `t'_eco3 == 2
	replace `t'_exp_privhos = 0 if `t'_eco3 == 2
	
	recode `t'_pubhos 0=0 nonm=1, g(temp1)
	recode `t'_exp_pubhos 0=0 nonm=1, g(temp2)
	tab temp1 temp2 if `t'_eco3 == 1, m
	drop temp*
	
	recode `t'_privhos 0=0 nonm=1, g(temp1)
	recode `t'_exp_privhos 0=0 nonm=1, g(temp2)
	tab temp1 temp2 if `t'_eco3 == 1, m
	drop temp*
	
}

local time "d0 m6 m12"
foreach t of local time {
	replace `t'_privhos = . if `t'_privhos == 0 & `t'_exp_privhos > 0 & !mi(`t'_exp_privhos)
}

list d0_eco3a-d0_eco3b_1 if d0_eco3 == 1 & mi(d0_pubhos)
list m6_eco3a-m6_eco3b_1 if m6_eco3 == 1 & mi(m6_eco3b)
***2 missing all, 4 answered 3a missing 3b
replace m6_privhos = 0 if mi(m6_eco3b) & !mi(m6_eco3a) & m6_eco3 == 1

local time "d0 m6 m12"
local name "exp_pubhos exp_privhos"
foreach t of local time {
	foreach n of local name {
		gen `t'_ppp`n' = `t'_`n' / 29.3 if country == 1
		replace `t'_ppp`n' = `t'_`n' / 30.9 if country == 2
	}
}


local time "d0 m6 m12"
local name "pubhos exp_pubhos pppexp_pubhos privhos exp_privhos pppexp_privhos"
foreach t of local time {
	foreach n of local name {
		display "`t' 0 `n'"
		tab alloc country if `t'_`n' == 0 & `t'_eco3 ==  1
		display "`t' missing `n'"
		tab alloc country if mi(`t'_`n') & `t'_eco3 == 1
		
		table alloc country if `t'_`n' > 0 & !mi(`t'_`n') & `t'_eco3 == 1, c(n `t'_`n' mean `t'_`n' sd `t'_`n' ////
		min `t'_`n' max `t'_`n') col
	}
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_hostravel = `t'_eco3c
	replace `t'_exp_hostravel = 0 if `t'_eco3 == 2
	
	gen `t'_pppexp_hostravel = `t'_exp_hostravel / 29.3  if country == 1
	replace `t'_pppexp_hostravel = `t'_exp_hostravel / 30.9 if country == 2
	
	display "`t' 0 exp on travel"
	tab alloc country if `t'_eco3 == 1 & `t'_exp_hostravel == 0
	display "`t' missing exp on travel"
	tab alloc country if `t'_eco3 == 1 & mi(`t'_exp_hostravel)
	display "`t' expense in local currency"
	table alloc country if `t'_exp_hostravel > 0 & !mi(`t'_exp_hostravel) & `t'_eco3 == 1, c(n `t'_exp_hostravel ////
		mean `t'_exp_hostravel sd `t'_exp_hostravel min `t'_exp_hostravel max `t'_exp_hostravel)
	display "`t' expense in PPP US$"
	table alloc country if `t'_pppexp_hostravel > 0 & !mi(`t'_pppexp_hostravel) & `t'_eco3 == 1, c(n `t'_pppexp_hostravel ////
		mean `t'_pppexp_hostravel sd `t'_pppexp_hostravel min `t'_pppexp_hostravel max `t'_pppexp_hostravel) col
}

sum d0_eco5_1-d0_eco5_23 if d0_eco4 == 2
sum m6_eco5_1-m6_eco5_23 if m6_eco4 == 2
sum m12_eco5_1-m12_eco5_23 if m12_eco4 == 2
****all no with following missing

local time "d0 m6 m12"
foreach t of local time {
	egen temp = rownonmiss(`t'_eco5_1-`t'_eco5_20 `t'_eco5_22 `t'_eco5_23)
	list `t'_eco5_1-`t'_eco5_23 if temp > 0
	drop temp
}

sum d0_eco5_1-d0_eco5_23
***2,4,8-10, 13-20 all 0
list d0_eco5_21-d0_eco5_23 if !mi(d0_eco5_22) | !mi(d0_eco5_23)
***only 1 answered 22 23 but missing 21, no use

sum m6_eco5_1-m6_eco5_20
***9-12,15-18 all 0
list m6_eco5_21-m6_eco5_23 if m6_eco5_21 != ""
gen m6_brac = .
replace m6_brac = m6_eco5_22 if m6_eco5_21 == "SWASTHOSEBIKA" | m6_eco5_21 == "VILLAGE DOCTOR" | ////
	m6_eco5_21 == "BRAC STAFF" | m6_eco5_21 == "SWASTHYASEBIKA" | m6_eco5_21 == "SHASTHA SHEBIKA"

sum m12_eco5_1-m12_eco5_20
***6-10,13-18 all 0
list m12_eco5_21-m12_eco5_23 if m12_eco5_21 != ""
gen m12_brac = .
replace m12_brac = m12_eco5_22 if m12_eco5_21 == "SWASTHOSEBIKA" | m12_eco5_21 == "BRAC SWASTHOSEBIKA"

gen d0_brac = .
****9-10, 15-18 no one answer************
local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	foreach i of numlist 1(2)7 11(2)13 19 {
		local n = `i' + 1
		recode `t'_eco5_`i' 0=0 nonm=1, g(temp1)
		recode `t'_eco5_`n' 0=0 nonm=1, g(temp2)
		tab temp1 temp2, m
		drop temp*
	}
}

local time "d0 m6 m12"
foreach t of local time {
	egen temp1 = rowtotal(`t'_eco5_1-`t'_eco5_8 `t'_eco5_11-`t'_eco5_14 `t'_eco5_19-`t'_eco5_20 `t'_brac), m
	egen temp2 = rowmiss(`t'_eco5_1-`t'_eco5_8 `t'_eco5_11-`t'_eco5_14 `t'_eco5_19-`t'_eco5_20 `t'_brac)
	tab temp1 temp2 if `t'_eco4 == 1
	drop temp*
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_sspubadv = `t'_eco5_1
	replace `t'_sspubadv = 0 if `t'_eco4 == 2
	gen `t'_exp_sspubadv = `t'_eco5_2
	replace `t'_exp_sspubadv = 0 if `t'_eco4 == 2
	
	gen `t'_ssprivadv = `t'_eco5_3
	replace `t'_ssprivadv = 0 if `t'_eco4 == 2
	gen `t'_exp_ssprivadv = `t'_eco5_4
	replace `t'_exp_ssprivadv = 0 if `t'_eco4 == 2
	
	gen `t'_sspubcoun = `t'_eco5_5
	replace `t'_sspubcoun = 0 if `t'_eco4 == 2
	gen `t'_exp_sspubcoun = `t'_eco5_6
	replace `t'_exp_sspubcoun = 0 if `t'_eco4 == 2
	
	gen `t'_ssprivcoun = `t'_eco5_7
	replace `t'_ssprivcoun = 0 if `t'_eco4 == 2
	gen `t'_exp_ssprivcoun = `t'_eco5_8
	replace `t'_exp_ssprivcoun = 0 if `t'_eco4 == 2
	
	gen `t'_ssrxnrt = `t'_eco5_11
	replace `t'_ssrxnrt = 0 if `t'_eco4 == 2
	gen `t'_exp_ssrxnrt = `t'_eco5_12
	replace `t'_exp_ssrxnrt = 0 if `t'_eco4 == 2
	
	gen `t'_ssrefillec = `t'_eco5_13
	replace `t'_ssrefillec = 0 if `t'_eco4 == 2
	gen `t'_exp_ssrefillec = `t'_eco5_14
	replace `t'_exp_ssrefillec = 0 if `t'_eco4 == 2
	
	gen `t'_sstradmed = `t'_eco5_19
	replace `t'_sstradmed = 0 if `t'_eco4 == 2
	gen `t'_exp_sstradmed = `t'_eco5_20
	replace `t'_exp_sstradmed = 0 if `t'_eco4 == 2
}

local time "d0 m6 m12"
local name "sspubadv ssprivadv sspubcoun ssprivcoun ssrxnrt ssrefillec sstradmed"
foreach t of local time {
	egen temp1 = rowtotal(`t'_eco5_1-`t'_eco5_8 `t'_eco5_11-`t'_eco5_14 `t'_eco5_19-`t'_eco5_20 `t'_brac), m
	egen temp2 = rowmiss(`t'_eco5_1-`t'_eco5_8 `t'_eco5_11-`t'_eco5_14 `t'_eco5_19-`t'_eco5_20 `t'_brac)
	gen `t'_ssyn = `t'_eco4
	replace `t'_ssyn = 2 if temp1 == 0 & temp2 != 15
	
	foreach n of local name {
		replace `t'_`n' = 0 if `t'_ssyn == 2
		replace `t'_`n' = 0 if mi(`t'_`n') & temp1 > 0 & !mi(temp1)
	}
	drop temp*
}

local time "d0 m6 m12"
local name "sspubadv ssprivadv sspubcoun ssprivcoun ssrxnrt ssrefillec sstradmed"
foreach t of local time {
	foreach n of local name {
		gen `t'_pppexp_`n' = `t'_exp_`n' / 29.3 if country == 1
		replace `t'_pppexp_`n' = `t'_exp_`n' / 30.9 if country == 2
	}
}

local time "d0 m6 m12"
local name "sspubadv sspubcoun ssrxnrt"
foreach t of local time {
	foreach n of local name {
		sum `t'_`n' if `t'_`n' != 0
	}
}

sum d0_eco7* if d0_eco6 == 2
sum m6_eco7* if m6_eco6 == 2
sum m12_eco7* if m12_eco6 == 2
***all no with following missing

sum d0_eco7* if d0_eco6 == 1
***1606 yes, 5 answered 7b none answered 7a -> baseline possibly just about to start TB treatment
sum m6_eco7* if m6_eco6 == 1
***2275 yes, 2273 answered 7a none other
sum m12_eco7* if m12_eco6 == 1
***288 yes, some answered 7
***m6 only have data on tablets per day with no duration, baseline almost all missing, only m12 has more or less complete /*
*\data

label define paidjob 1 "full time job" 2 "part time job" 3 "no job"
local time "d0 m6 m12"
foreach t of local time {
	label val `t'_eco8 paidjob
	by alloc: tab `t'_eco8 country, m
}

sum d0_eco9_1 if d0_eco9 == 2
sum m6_eco9_1 if m6_eco9 == 2
sum m12_eco9_1 if m12_eco9 == 2
***all no with following missing

sum d0_eco9_1 if d0_eco9 == 1
sum m6_eco9_1 if m6_eco9 == 1
sum m12_eco9_1 if m12_eco9 == 1

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_sickleave = `t'_eco9_1
	replace `t'_sickleave = 0 if `t'_eco9 == 2
	
	recode `t'_sickleave 0=0 nonm=1, g(temp)
	tab temp `t'_eco8, m
	drop temp
}

local time "d0 m6 m12"
foreach t of local time {
	replace `t'_sickleave = 0 if `t'_eco8 == 3 & mi(`t'_sickleave)
}

local time "d0 m6 m12"
foreach t of local time {
	replace `t'_eco9 = 3 if `t'_eco8 == 3
	label var `t'_eco9 "3=no job, n/a"
}

sum *_eco10
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_tob = `t'_eco10
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_pppexp_tob = `t'_eco10 / 29.3 if country == 1
	replace `t'_pppexp_tob = `t'_eco10 / 30.9 if country == 2
}

****************EQ5D*************************************************
sum *eq5d*

local time "d0 m6 m12"
foreach t of local time {
	foreach n of numlist 1/5 {
		gen `t'_eq`n' = `t'_eq5d_0`n'_5l
	}
	gen `t'_vas = `t'_eq5d_therm_5l
}

local time "d0 m6 m12"
foreach t of local time {
	foreach n of numlist 1/5 {
		display "`t' EQ5D-`n'"
		by alloc: tab `t'_eq`n' country
	}
	display "`t' VAS"
	table alloc country, c(n `t'_vas mean `t'_vas sd `t'_vas min `t'_vas max `t'_vas) col
}
	

