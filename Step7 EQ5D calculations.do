************EQ5D********************
local time "d0 m6 m12"
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

sort m12_profile
rename m12_profile profile
merge m:1 profile using "P:\\Documents\Literature collection\EQ-5D\EQ5D 5L value set.dta", ///
	keepusing(Thailand UK Zimbabwe) gen(_m12eq5l) keep(1 3)
rename Thailand utility_thailand2_m12
rename UK utility_uk_m12
rename Zimbabwe utility_zimbabwe_m12
rename profile m12_profile

sort _mi_m alloc patid

local name "zimbabwe uk thailand2"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		label var utility_`n'_`t' "crosswalk function valuation"
	}
}

****profile = 00000 -> death, baseline no one died
local time "m6 m12"
foreach t of local time {
	local name "thailand2 uk zimbabwe"
	foreach n of local name {
		replace utility_`n'_`t' = 0 if `t'_profile == "00000"
	}
}

mi register passive utility_thailand2_* utility_uk_* utility_zimbabwe_*

****Thailand***********
matrix EQ5L_t=(0, 0.0661, 0.0866, 0.2110, 0.3712\/*
*/0, 0.0581, 0.0706, 0.1925, 0.2499\/*
*/0, 0.0583, 0.0712, 0.1535, 0.2483\/*
*/0, 0.0564, 0.0665, 0.2069, 0.2564\/*
*/0, 0.0581, 0.0958, 0.2327, 0.2953)

local time "d0 m6 m12"
foreach t of local time {
	gen mobility_`t' = EQ5L_t[1, `t'_eq1[_n]]
	gen selfcare_`t' = EQ5L_t[2, `t'_eq2[_n]]
	gen usualact_`t' = EQ5L_t[3, `t'_eq3[_n]]
	gen paindiscom_`t' = EQ5L_t[4, `t'_eq4[_n]]
	gen antdepres_`t' = EQ5L_t[5, `t'_eq5[_n]]
	gen utility_thailand_`t' = 1 - mobility_`t' - selfcare_`t' - usualact_`t' - paindiscom_`t' - antdepres_`t'
}
drop mobility* selfcare* usualact* paindiscom* antdepres*

mi register passive utility_thailand_*

mi passive: replace utility_thailand_m6 = 0 if m6_eq1 == 0
mi passive: replace utility_thailand_m12 = 0 if m12_eq1 == 0

****Malaysia*************
matrix EQ5L_m=(0, 0.081, 0.108, 0.261, 0.340\/*
*/0, 0.062, 0.083, 0.200, 0.261\/*
*/0, 0.048, 0.064, 0.155, 0.202\/*
*/0, 0.081, 0.107, 0.259, 0.338\/*
*/0, 0.072, 0.095, 0.230, 0.300)

local time "d0 m6 m12"
foreach t of local time {
	gen mobility_`t' = EQ5L_m[1, `t'_eq1[_n]]
	gen selfcare_`t' = EQ5L_m[2, `t'_eq2[_n]]
	gen usualact_`t' = EQ5L_m[3, `t'_eq3[_n]]
	gen paindiscom_`t' = EQ5L_m[4, `t'_eq4[_n]]
	gen antdepres_`t' = EQ5L_m[5, `t'_eq5[_n]]
	gen utility_malaysia_`t' = 1 - mobility_`t' - selfcare_`t' - usualact_`t' - paindiscom_`t' - antdepres_`t'
}

drop mobility* selfcare* usualact* paindiscom* antdepres*

mi register passive utility_malaysia_*

mi passive: replace utility_malaysia_m6 = 0 if m6_eq1 == 0
mi passive: replace utility_malaysia_m12 = 0 if m12_eq1 == 0

****Indonesia***************
matrix EQ5L_i=(0, 0.119, 0.192, 0.410, 0.613\/*
*/0, 0.101, 0.140, 0.248, 0.316\/*
*/0, 0.090, 0.156, 0.301, 0.385\/*
*/0, 0.086, 0.095, 0.198, 0.246\/*
*/0, 0.079, 0.134, 0.227, 0.305)

local time "d0 m6 m12"
foreach t of local time {
	gen mobility_`t' = EQ5L_i[1, `t'_eq1[_n]]
	gen selfcare_`t' = EQ5L_i[2, `t'_eq2[_n]]
	gen usualact_`t' = EQ5L_i[3, `t'_eq3[_n]]
	gen paindiscom_`t' = EQ5L_i[4, `t'_eq4[_n]]
	gen antdepres_`t' = EQ5L_i[5, `t'_eq5[_n]]
	gen utility_indonesia_`t' = 1 - mobility_`t' - selfcare_`t' - usualact_`t' - paindiscom_`t' - antdepres_`t'
}

drop mobility* selfcare* usualact* paindiscom* antdepres*

mi register passive utility_indonesia_*

mi passive: replace utility_indonesia_m6 = 0 if m6_eq1 == 0
mi passive: replace utility_indonesia_m12 = 0 if m12_eq1 == 0

local name "thailand malaysia indonesia"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		label var utility_`n'_`t' "validated valuation set"
	}
}

*****************************
local name "thailand malaysia indonesia thailand2 uk zimbabwe"
foreach n of local name {
	gen qaly_`n' = (utility_`n'_d0 + utility_`n'_m6)*0.5/2 + (utility_`n'_m6 + utility_`n'_m12)*0.5/2
}

mi register passive qaly_*

mi estimate: mean qaly_zimbabwe, over(alloc)
mi estimate: mean qaly_uk, over(alloc)
mi estimate: mean qaly_thailand2, over(alloc)
mi estimate: mean qaly_thailand, over(alloc)
mi estimate: mean qaly_malaysia, over(alloc)
mi estimate: mean qaly_indonesia, over(alloc)

local name "zimbabwe uk thailand thailand2 malaysia indonesia"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`n' `t'"
		mi estimate: mean utility_`n'_`t', over(alloc)
	}
}

mi estimate: mean d0_vas, over(alloc)
mi estimate: mean m6_vas, over(alloc)
mi estimate: mean m12_vas, over(alloc)

********************************************************************
******6 months primary**********************
local name "zimbabwe uk thailand thailand2 malaysia indonesia"
foreach n of local name {
	gen m6_qaly_`n' = (utility_`n'_d0 + utility_`n'_m6)*0.5/2
}

mi register passive m6_qaly_*

mi estimate: mean m6_qaly_zimbabwe, over(alloc)
mi estimate: mean m6_qaly_uk, over(alloc)
mi estimate: mean m6_qaly_thailand2, over(alloc)
mi estimate: mean m6_qaly_thailand, over(alloc)
mi estimate: mean m6_qaly_malaysia, over(alloc)
mi estimate: mean m6_qaly_indonesia, over(alloc)

