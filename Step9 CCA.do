*****death costs replace.dta***********************

***generate CCA file****************
keep if !mi(cost_tb) & !mi(cost_cytisine_disp) & !mi(cost_bs) & !mi(d0_cost_ss) & !mi(m6_cost_ss) ////
	& !mi(d0_cost_doc) & !mi(d0_cost_hos) & !mi(m6_cost_doc) & !mi(m6_cost_hos) & !mi(d0_eq1) & !mi(d0_eq2) ///
	& !mi(d0_eq3) & !mi(d0_eq4) & !mi(d0_eq5) & !mi(m6_eq1) & !mi(m6_eq2) & !mi(m6_eq3) & !mi(m6_eq4) & !mi(m6_eq5)

gen cost_int = cost_cytisine_disp + cost_bs + cost_training + cost_leaflet
gen pppcost_int = pppcost_cytisine_disp + pppcost_bs + pppcost_training + pppcost_leaflet

gen d0_pppcost_noint = d0_pppcost_hc + d0_pppcost_ss
gen m6_pppcost_noint = m6_pppcost_hc + m6_pppcost_ss

gen d0_cost_noint = d0_cost_hc + d0_cost_ss
gen m6_cost_noint = m6_cost_hc + m6_cost_ss

gen trial_cost_m6 = cost_int + cost_tb + m6_cost_noint
gen trial_pppcost_m6 = pppcost_int + pppcost_tb + m6_pppcost_noint

*****************************************************************************
tab alloc country

local name "cytisine_disp training leaflet bs int tb"
foreach n of local name {
	display "PPP adjusted `n' cost"
	table alloc country, c(mean pppcost_`n' sd pppcost_`n') col
	display "`n' cost"
	table alloc country, c(mean cost_`n' sd cost_`n')
}

local time "d0 m6"
foreach t of local time {
	local name "doc hos hc ss noint"
	foreach n of local name {
		display "`t' PPP adjusted `n' cost"
		table alloc country, c(mean `t'_pppcost_`n' sd `t'_pppcost_`n') col
		display "`t' `n' cost"
		table alloc country, c(mean `t'_cost_`n' sd `t'_cost_`n')
	}
}

table alloc country, c(mean trial_pppcost_m6 sd trial_pppcost_m6) col
table alloc country, c(mean trial_cost_m6 sd trial_cost_m6)

************EQ5D**************************************************************************
local time "d0 m6"
foreach t of local time {
	egen `t'_profile = concat(`t'_eq1 `t'_eq2 `t'_eq3 `t'_eq4 `t'_eq5)
}
sort d0_profile
rename d0_profile profile
merge m:1 profile using "P:\\Documents\Literature collection\EQ-5D\EQ5D 5L value set.dta", ///
	keepusing(Thailand UK Zimbabwe) gen(_d0eq5l) keep(1 3)
rename Thailand utility_thailand2_d0
rename UK utility_uk_d0
rename Zimbabwe utility_zimbabwe_d0
rename profile d0_profile

sort m6_profile
rename m6_profile profile
merge m:1 profile using "P:\\Documents\Literature collection\EQ-5D\EQ5D 5L value set.dta", ///
	keepusing(Thailand UK Zimbabwe) gen(_m6eq5l) keep(1 3)
rename Thailand utility_thailand2_m6
rename UK utility_uk_m6
rename Zimbabwe utility_zimbabwe_m6
rename profile m6_profile

sort alloc patid

local name "zimbabwe uk thailand2"
foreach n of local name {
	local time "d0 m6"
	foreach t of local time {
		label var utility_`n'_`t' "crosswalk function valuation"
	}
}

****profile = 00000 -> death, baseline no one died
local name "thailand2 uk zimbabwe"
foreach n of local name {
	replace utility_`n'_m6 = 0 if m6_profile == "00000"
}

****Thailand***********
matrix EQ5L_t=(0, 0.0661, 0.0866, 0.2110, 0.3712\/*
*/0, 0.0581, 0.0706, 0.1925, 0.2499\/*
*/0, 0.0583, 0.0712, 0.1535, 0.2483\/*
*/0, 0.0564, 0.0665, 0.2069, 0.2564\/*
*/0, 0.0581, 0.0958, 0.2327, 0.2953)

local time "d0 m6"
foreach t of local time {
	gen mobility_`t' = EQ5L_t[1, `t'_eq1[_n]]
	gen selfcare_`t' = EQ5L_t[2, `t'_eq2[_n]]
	gen usualact_`t' = EQ5L_t[3, `t'_eq3[_n]]
	gen paindiscom_`t' = EQ5L_t[4, `t'_eq4[_n]]
	gen antdepres_`t' = EQ5L_t[5, `t'_eq5[_n]]
	gen utility_thailand_`t' = 1 - mobility_`t' - selfcare_`t' - usualact_`t' - paindiscom_`t' - antdepres_`t'
}
drop mobility* selfcare* usualact* paindiscom* antdepres*

replace utility_thailand_m6 = 0 if m6_eq1 == 0

****Malaysia*************
matrix EQ5L_m=(0, 0.081, 0.108, 0.261, 0.340\/*
*/0, 0.062, 0.083, 0.200, 0.261\/*
*/0, 0.048, 0.064, 0.155, 0.202\/*
*/0, 0.081, 0.107, 0.259, 0.338\/*
*/0, 0.072, 0.095, 0.230, 0.300)

local time "d0 m6"
foreach t of local time {
	gen mobility_`t' = EQ5L_m[1, `t'_eq1[_n]]
	gen selfcare_`t' = EQ5L_m[2, `t'_eq2[_n]]
	gen usualact_`t' = EQ5L_m[3, `t'_eq3[_n]]
	gen paindiscom_`t' = EQ5L_m[4, `t'_eq4[_n]]
	gen antdepres_`t' = EQ5L_m[5, `t'_eq5[_n]]
	gen utility_malaysia_`t' = 1 - mobility_`t' - selfcare_`t' - usualact_`t' - paindiscom_`t' - antdepres_`t'
}

drop mobility* selfcare* usualact* paindiscom* antdepres*

replace utility_malaysia_m6 = 0 if m6_eq1 == 0


****Indonesia***************
matrix EQ5L_i=(0, 0.119, 0.192, 0.410, 0.613\/*
*/0, 0.101, 0.140, 0.248, 0.316\/*
*/0, 0.090, 0.156, 0.301, 0.385\/*
*/0, 0.086, 0.095, 0.198, 0.246\/*
*/0, 0.079, 0.134, 0.227, 0.305)

local time "d0 m6"
foreach t of local time {
	gen mobility_`t' = EQ5L_i[1, `t'_eq1[_n]]
	gen selfcare_`t' = EQ5L_i[2, `t'_eq2[_n]]
	gen usualact_`t' = EQ5L_i[3, `t'_eq3[_n]]
	gen paindiscom_`t' = EQ5L_i[4, `t'_eq4[_n]]
	gen antdepres_`t' = EQ5L_i[5, `t'_eq5[_n]]
	gen utility_indonesia_`t' = 1 - mobility_`t' - selfcare_`t' - usualact_`t' - paindiscom_`t' - antdepres_`t'
}

drop mobility* selfcare* usualact* paindiscom* antdepres*

replace utility_indonesia_m6 = 0 if m6_eq1 == 0


local name "thailand malaysia indonesia"
foreach n of local name {
	local time "d0 m6"
	foreach t of local time {
		label var utility_`n'_`t' "validated valuation set"
	}
}

*****************************

local time "d0 m6"
foreach t of local time {
	display "`t' utility"
	table alloc country, c(mean utility_zimbabwe_`t' sd utility_zimbabwe_`t') col
	display "`t' VAS"
	table alloc country, c(mean `t'_vas sd `t'_vas) col
}


local name "zimbabwe uk thailand thailand2 malaysia indonesia"
foreach n of local name {
	gen m6_qaly_`n' = (utility_`n'_d0 + utility_`n'_m6)*0.5/2
}

table alloc country, c(mean m6_qaly_zimbabwe sd m6_qaly_zimbabwe) col

*****************************************************************************************************************
meglm trial_pppcost_m6 ib2.alloc d0_pppcost_noint d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
margins, dydx(alloc)

meglm m6_qaly_zimbabwe ib2.alloc utility_zimbabwe_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)

