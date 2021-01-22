***********analysis based on imputed dataset*********************
********PPP 6 months*******************************************
sysdir set PLUS "P:\\Documents\STATA\"

mi estimate, cmdok: meglm trial_pppcost_m6 ib2.alloc d0_pppcost_noint d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
mimrgns alloc
mat a = r(b)
sca me_1 = a[1,1]
sca me_2 = a[1,2]
dis exp(me_1) - exp(me_2)
sca drop _all

mi estimate, cmdok: meglm m6_qaly_zimbabwe ib2.alloc utility_zimbabwe_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm m6_qaly_uk ib2.alloc utility_uk_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm m6_qaly_thailand ib2.alloc utility_thailand_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm m6_qaly_thailand2 ib2.alloc utility_thailand2_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm m6_qaly_malaysia ib2.alloc utility_malaysia_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm m6_qaly_indonesia ib2.alloc utility_indonesia_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)

***a few cases with null total expenses/productivity loss therefore could not run glm, added 0.001***********************
replace m6_pppexp_all = 0.001 if m6_pppexp_all == 0
mi estimate, cmdok: meglm m6_pppexp_all ib2.alloc d0_pppexp_all d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
mimrgns alloc
mat a = r(b)
sca me_1 = a[1,1]
sca me_2 = a[1,2]
dis exp(me_1) - exp(me_2)
sca drop _all

replace m6_pppprolos = 0.001 if m6_pppprolos == 0
mi estimate, cmdok: meglm m6_pppprolos ib2.alloc d0_pppprolos d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
mimrgns alloc
mat a = r(b)
sca me_1 = a[1,1]
sca me_2 = a[1,2]
dis exp(me_1) - exp(me_2)
sca drop _all

*************PPP 12 months********************************

mi estimate, cmdok: meglm trial_pppcost ib2.alloc d0_pppcost_noint d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
mimrgns alloc
mat a = r(b)
sca me_1 = a[1,1]
sca me_2 = a[1,2]
dis exp(me_1) - exp(me_2)
sca drop _all

mi estimate, cmdok: meglm qaly_zimbabwe ib2.alloc utility_zimbabwe_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm qaly_uk ib2.alloc utility_uk_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm qaly_thailand ib2.alloc utility_thailand_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm qaly_thailand2 ib2.alloc utility_thailand2_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm qaly_malaysia ib2.alloc utility_malaysia_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)
mi estimate, cmdok: meglm qaly_indonesia ib2.alloc utility_indonesia_d0 d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gau)

***a few cases with null total expenses/productivity loss therefore could not run glm, added 0.001***********************
replace trial_pppexp_all = 0.001 if trial_pppexp_all == 0
mi estimate, cmdok: meglm trial_pppexp_all ib2.alloc d0_pppexp_all d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
mimrgns alloc
mat a = r(b)
sca me_1 = a[1,1]
sca me_2 = a[1,2]
dis exp(me_1) - exp(me_2)
sca drop _all

replace trial_pppprolos = 0.001 if trial_pppprolos == 0
mi estimate, cmdok: meglm trial_pppprolos ib2.alloc d0_pppprolos d0_sdh_age i.d0_sdh_gender i.country || d0_siteid:, f(gam)
mimrgns alloc
mat a = r(b)
sca me_1 = a[1,1]
sca me_2 = a[1,2]
dis exp(me_1) - exp(me_2)
sca drop _all

