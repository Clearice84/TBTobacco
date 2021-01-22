*************Scenario 1******************************
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


*************Scenario 2**********************************
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
