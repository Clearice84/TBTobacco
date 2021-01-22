**********Scenario 1************************
***those who died incurred higher hospital costs in the period of death
forvalues i = 5(5)30 {
	gen TCdeath_hosd`i' = trial_cost_m6
	replace TCdeath_hosd`i' = TCdeath_hosd`i' + uc_hosday_pk * `i' if country == 1 & death != 0 & death < 3
	replace TCdeath_hosd`i' = TCdeath_hosd`i' + uc_hosday_bd * `i' if country == 2 & death != 0 & death < 3
	gen pppTCdeath_hosd`i' = TCdeath_hosd`i' / 29.3 if country == 1
	replace pppTCdeath_hosd`i' = TCdeath_hosd`i' / 30.9 if country == 2
}

sysdir set PLUS "P:\\Documents\STATA\"

forvalues i = 5(5)30 {
	mi estimate, cmdok: meglm pppTCdeath_hosd`i' ib2.alloc d0_pppcost_noint d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
	mimrgns alloc
	mat a = r(b)
	sca me_1 = a[1,1]
	sca me_2 = a[1,2]
	dis exp(me_1) - exp(me_2)
	sca drop _all
}

*****************************************************************************************
keep if country == 1
keep if country == 2

sysdir set PLUS "P:\\Documents\STATA\"

forvalues i = 5(5)30 {
	mi estimate, cmdok: meglm TCdeath_hosd`i' ib2.alloc d0_cost_noint d0_sdh_age i.d0_sdh_gender || d0_siteid:, f(gam)
	mimrgns alloc
	mat a = r(b)
	sca me_1 = a[1,1]
	sca me_2 = a[1,2]
	dis exp(me_1) - exp(me_2)
	sca drop _all
}

*************Scenario 2******************************
***increase imputed costs by 10%-30% in both arms
misstable summ trial_cost_m6 if _mi_m == 0, gen(mistab_tc6)
mi register regular mistab_tc6

forvalues i = 10(10)30 {
	gen TCplus`i' = trial_cost_m6
	replace TCplus`i' = trial_cost_m6*(100+`i')/100 if mistab_tc6 == 1
	gen pppTCplus`i' = TCplus`i' / 29.3 if country == 1
	replace pppTCplus`i' = TCplus`i' / 30.9 if country == 2
}

sysdir set PLUS "P:\\Documents\STATA\"

forvalues i = 10(10)30 {
	mi estimate, cmdok: meglm pppTCplus`i' ib2.alloc d0_pppcost_noint d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
	mimrgns alloc
	mat a = r(b)
	sca me_1 = a[1,1]
	sca me_2 = a[1,2]
	dis exp(me_1) - exp(me_2)
	sca drop _all
}

keep if country == 1
keep if country == 2

sysdir set PLUS "P:\\Documents\STATA\"
forvalues i = 10(10)30 {
	mi estimate, cmdok: meglm TCplus`i' ib2.alloc d0_cost_noint d0_sdh_age i.d0_sdh_gender || d0_siteid:, f(gam)
	mimrgns alloc
	mat a = r(b)
	sca me_1 = a[1,1]
	sca me_2 = a[1,2]
	dis exp(me_1) - exp(me_2)
	sca drop _all
}

*************Scenario 3**********************************
***reduce imputed QALYs by 10%-30% in both arms
misstable summ m6_qaly_zimbabwe if _mi_m == 0, gen(mistab_qaly6z)
mi register regular mistab_qaly6z

forvalues i = 10(10)30 {
	gen qalyminus`i' = m6_qaly_zimbabwe
	replace qalyminus`i' = m6_qaly_zimbabwe*(100-`i')/100 if mistab_qaly6z == 1
}

sysdir set PLUS "P:\\Documents\STATA\"
forvalues i = 10(10)30 {
	mi estimate, cmdok: meglm qalyminus`i' ib2.alloc utility_zimbabwe_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
}

keep if country == 1
keep if country == 2

sysdir set PLUS "P:\\Documents\STATA\"
forvalues i = 10(10)30 {
	mi estimate, cmdok: meglm qalyminus`i' ib2.alloc utility_zimbabwe_d0 d0_sdh_age i.d0_sdh_gender || d0_siteid:, f(gau)
}

*************Scenario 4**************************************
***cost of placebo************************
gen sacost_placebo = d0_costcytisine_pk if country == 1
replace sacost_placebo = d0_costcytisine_bd if country == 2

replace sacost_placebo = sacost_placebo + d5_costcytisine_pk if country == 1 & !mi(d5_datecomp)
replace sacost_placebo = sacost_placebo + d5_costcytisine_bd if country == 2 & !mi(d5_datecomp)

replace sacost_placebo = 0 if alloc == 1

gen pppsacost_placebo = sacost_placebo / 29.3 if country == 1
replace pppsacost_placebo = sacost_placebo / 30.9 if country == 2

forvalues i = 10(10)50 {
	gen tcplacebo`i' = trial_cost_m6 + sacost_placebo*`i'/100
	gen ppptcplacebo`i' = tcplacebo`i'/29.3 if country == 1
	replace ppptcplacebo`i' = tcplacebo`i'/30.9 if country == 2
	
	gen intcplacebo`i' = cost_int + sacost_placebo*`i'/100
	gen pppintcplacebo`i' = intcplacebo`i'/29.3 if country == 1
	replace pppintcplacebo`i' = intcplacebo`i'/30.9 if country == 2
}

sysdir set PLUS "P:\\Documents\STATA\"
forvalues i = 10(10)50 {
	mi est: mean pppintcplacebo`i', over(alloc)
	
	mi estimate, cmdok: meglm ppptcplacebo`i' ib2.alloc d0_pppcost_noint d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
	mimrgns alloc
	mat a = r(b)
	sca me_1 = a[1,1]
	sca me_2 = a[1,2]
	dis exp(me_1) - exp(me_2)
	sca drop _all
}

keep if country == 1
keep if country == 2

sysdir set PLUS "P:\\Documents\STATA\"
forvalues i = 10(10)50 {
	mi est: mean intcplacebo`i', over(alloc)
	
	mi estimate, cmdok: meglm tcplacebo`i' ib2.alloc d0_cost_noint d0_sdh_age i.d0_sdh_gender || d0_siteid:, f(gam)
	mimrgns alloc
	mat a = r(b)
	sca me_1 = a[1,1]
	sca me_2 = a[1,2]
	dis exp(me_1) - exp(me_2)
	sca drop _all
}
