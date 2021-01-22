*****adding cost variables****************
**************merge compliance and sae data to death replace.dta**************************************
***original file has a duplicate for P23020, drop it***********
merge 1:1 patid using "P:\\Documents\TB n Tobacco\Trial data\compliance sae from 20190722.dta"
drop _merge
***intervention costs************
gen uc_bs1_bd = 16.27
gen uc_bs1_pk = 22.15
gen uc_bs2_bd = 8.13
gen uc_bs2_pk = 11.08

gen cost_bs = 0 if d0_behavsupp == 2
replace cost_bs = uc_bs1_pk if d0_behavsupp == 1 & country == 1
replace cost_bs = uc_bs1_bd if d0_behavsupp == 1 & country == 2
replace cost_bs = uc_bs1_pk + uc_bs2_pk if d0_behavsupp == 1 & country == 1 & !mi(d5_datecomp)
replace cost_bs = uc_bs1_bd + uc_bs2_bd if d0_behavsupp == 1 & country == 2 & !mi(d5_datecomp)

gen pppcost_bs = cost_bs/29.3 if country == 1
replace pppcost_bs = cost_bs/30.9 if country == 2

gen cost_cytisine100_bd = 1306
gen cost_cytisine100_pk = 1907

gen cost_cytisine = cost_cytisine100_bd if country == 2
replace cost_cytisine = cost_cytisine100_pk if country == 1

****PPP Pakistan 29.3/USD, Bangladesh 30.9/USD in 2017, 2018 has come out yet 26/06/2019
gen pppcost_cytisine = cost_cytisine / 29.3 if country == 1
replace pppcost_cytisine = cost_cytisine / 30.9 if country == 2


***TB-related costs**************
***per month costs*********
gen uc_tbIP_bd = 1675
gen uc_tbCP_bd = 977
gen uc_tbIP_pk = 3176
gen uc_tbCP_pk = 1853

gen tbmed_phase = 0 if m6_mth1_tbtaken == 0
foreach n of numlist 1/6 {
	replace tbmed_phase = `n' if m6_mth`n'_tbtaken > 0 & !mi(m6_mth`n'_tbtaken)
}
label define tbphase 0 "not started" 1 "IP mon1" 2 "IP mon2" 3 "CP mon1" 4 "CP mon2" 5 "CP mon3" 6 "CP mon4"
label val tbmed_phase tbphase
by alloc: tab tbmed_phase country, m

gen cost_tb = .
***Pakistan*************
replace cost_tb = uc_tbIP_pk if country == 1 & tbmed_phase == 1
replace cost_tb = uc_tbIP_pk * 2 if country == 1 & tbmed_phase == 2
replace cost_tb = uc_tbIP_pk * 2 + uc_tbCP_pk if country == 1 & tbmed_phase == 3
replace cost_tb = uc_tbIP_pk * 2 + uc_tbCP_pk * 2 if country == 1 & tbmed_phase == 4
replace cost_tb = uc_tbIP_pk * 2 + uc_tbCP_pk * 3 if country == 1 & tbmed_phase == 5
replace cost_tb = uc_tbIP_pk * 2 + uc_tbCP_pk * 4 if country == 1 & tbmed_phase == 6
***Bangladesh***********
replace cost_tb = uc_tbIP_bd if country == 2 & tbmed_phase == 1
replace cost_tb = uc_tbIP_bd * 2 if country == 2 & tbmed_phase == 2
replace cost_tb = uc_tbIP_bd * 2 + uc_tbCP_bd if country == 2 & tbmed_phase == 3
replace cost_tb = uc_tbIP_bd * 2 + uc_tbCP_bd * 2 if country == 2 & tbmed_phase == 4
replace cost_tb = uc_tbIP_bd * 2 + uc_tbCP_bd * 3 if country == 2 & tbmed_phase == 5
replace cost_tb = uc_tbIP_bd * 2 + uc_tbCP_bd * 4 if country == 2 & tbmed_phase == 6

replace cost_tb = 0 if tbmed_phase == 0

table alloc country, c(n cost_tb mean cost_tb sd cost_tb min cost_tb max cost_tb)

****PPP Pakistan 29.3/USD, Bangladesh 30.9/USD in 2017, 2018 has come out yet 26/06/2019
gen pppcost_tb = cost_tb / 29.3 if country == 1
replace pppcost_tb = cost_tb/ 30.9 if country == 2

table alloc, c(n pppcost_tb mean pppcost_tb sd pppcost_tb min pppcost_tb max pppcost_tb)



*************smoking cessation costs***************************************
gen uc_sspubadv_bd = 21
gen uc_sspubadv_pk = 26
gen uc_sspubcoun_bd = 29
gen uc_sspubcoun_pk = 37

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_cost_sspubadv = uc_sspubadv_pk * `t'_sspubadv if country == 1
	replace `t'_cost_sspubadv = uc_sspubadv_bd * `t'_sspubadv if country == 2
	
	gen `t'_cost_sspubcoun = uc_sspubcoun_pk * `t'_sspubcoun if country == 1
	replace `t'_cost_sspubcoun = uc_sspubadv_bd * `t'_sspubcoun if country == 2
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t'"
	count if mi(`t'_cost_sspubadv) & !mi(`t'_exp_sspubadv)
	count if mi(`t'_cost_sspubcoun) & !mi(`t'_exp_sspubcoun)
}
***all 0

local time "d0 m6 m12"
foreach t of local time {
	display "`t' sss advice from public"
	table alloc country, c(n `t'_cost_sspubadv mean `t'_cost_sspubadv sd `t'_cost_sspubadv min `t'_cost_sspubadv max `t'_cost_sspubadv)
	
	display "`t' sss counselling from public"
	table alloc country, c(n `t'_cost_sspubcoun mean `t'_cost_sspubcoun sd `t'_cost_sspubcoun min `t'_cost_sspubcoun max `t'_cost_sspubcoun)
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_cost_ss = `t'_cost_sspubadv + `t'_cost_sspubcoun
	gen `t'_pppcost_ss = `t'_cost_ss / 29.3 if country == 1
	replace `t'_pppcost_ss = `t'_cost_ss / 30.9 if country == 2
	
	display "`t' cost of smoking cessation"
	table alloc country, c(n `t'_cost_ss mean `t'_cost_ss sd `t'_cost_ss min `t'_cost_ss max `t'_cost_ss)
	display "`t' PPP adjusted cost of smoking cessation"
	table alloc country, c(n `t'_pppcost_ss mean `t'_pppcost_ss sd `t'_pppcost_ss min `t'_pppcost_ss max `t'_pppcost_ss) col
}


******************wider health service costs***************************************
gen uc_doc_bd = 142
gen uc_hosday_bd = 589
gen uc_doc_pk = 200
gen uc_hosday_pk = 971

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_cost_doc = `t'_pubdoc * uc_doc_pk if country == 1
	replace `t'_cost_doc = `t'_pubdoc * uc_doc_bd if country == 2
	
	gen `t'_cost_hos = `t'_pubhos * uc_hosday_pk if country == 1
	replace `t'_cost_hos = `t'_pubhos * uc_hosday_bd if country == 2
	
	gen `t'_pppcost_doc = `t'_cost_doc / 29.3 if country == 1
	replace `t'_pppcost_doc = `t'_cost_doc / 30.9 if country == 2
	
	gen `t'_pppcost_hos = `t'_cost_hos / 29.3 if country == 1
	replace `t'_pppcost_hos = `t'_cost_hos / 30.9 if country == 2
	
	display "`t' cost public doctor visit"
	table alloc country, c(n `t'_cost_doc mean `t'_cost_doc sd `t'_cost_doc min `t'_cost_doc max `t'_cost_doc)
	display "`t' PPP adjusted cost public doctor visit"
	table alloc country, c(n `t'_pppcost_doc mean `t'_pppcost_doc sd `t'_pppcost_doc min `t'_pppcost_doc max `t'_pppcost_doc) col
	
	display "`t' cost public hospital"
	table alloc country, c(n `t'_cost_hos mean `t'_cost_hos sd `t'_cost_hos min `t'_cost_hos max `t'_cost_hos)
	display "`t' PPP adjusted cost public hospital"
	table alloc country, c(n `t'_pppcost_hos mean `t'_pppcost_hos sd `t'_pppcost_hos min `t'_pppcost_hos max `t'_pppcost_hos) col
}

local time "d0 m6 m12"
foreach t of local time {
	gen temp1 = `t'_exp_pubdoc - `t'_cost_doc
	gen temp2 = `t'_exp_pubhos - `t'_cost_hos
	sum temp1 temp2
	drop temp*
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_cost_hc = `t'_cost_doc + `t'_cost_hos
	gen `t'_pppcost_hc = `t'_pppcost_doc + `t'_pppcost_hos
	
	display "`t' cost of health care services"
	table alloc country, c(n `t'_cost_hc mean `t'_cost_hc sd `t'_cost_hc min `t'_cost_hc max `t'_cost_hc)
	display "`t' PPP adjusted cost of health care services"
	table alloc country, c(n `t'_pppcost_hc mean `t'_pppcost_hc sd `t'_pppcost_hc min `t'_pppcost_hc max `t'_pppcost_hc) col
}


*****OOP expenses******************************************************
*********TB*********************
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_tb = `t'_exp_tbprivclin + `t'_exp_tbtravel
	gen `t'_pppexp_tb = `t'_pppexp_tbprivclin + `t'_pppexp_tbtravel
	
	display "`t' OOP for TB"
	table alloc country, c(n `t'_exp_tb mean `t'_exp_tb sd `t'_exp_tb min `t'_exp_tb max `t'_exp_tb)
	display "`t' PPP adjusted OOP for TB"
	table alloc country, c(n `t'_pppexp_tb mean `t'_pppexp_tb sd `t'_pppexp_tb min `t'_pppexp_tb max `t'_pppexp_tb) col
}

*******smoking cessation*************
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_ss = `t'_exp_sspubadv + `t'_exp_ssprivadv + `t'_exp_sspubcoun + `t'_exp_ssprivcoun + `t'_exp_ssrxnrt + `t'_exp_ssrefillec + `t'_exp_sstradmed
	gen `t'_pppexp_ss = `t'_pppexp_sspubadv + `t'_pppexp_ssprivadv + `t'_pppexp_sspubcoun + `t'_pppexp_ssprivcoun + `t'_pppexp_ssrxnrt + `t'_pppexp_ssrefillec + `t'_pppexp_sstradmed
	
	display "`t' OOP for smoking cessation"
	table alloc country, c(n `t'_exp_ss mean `t'_exp_ss sd `t'_exp_ss min `t'_exp_ss max `t'_exp_ss)
	display "`t' PPP adjusted OOP for smoking cessation"
	table alloc country, c(n `t'_pppexp_ss mean `t'_pppexp_ss sd `t'_pppexp_ss min `t'_pppexp_ss max `t'_pppexp_ss) col
}

**********health care services****************
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_doc = `t'_exp_pubdoc + `t'_exp_privdoc + `t'_exp_doctravel
	gen `t'_pppexp_doc = `t'_pppexp_pubdoc + `t'_pppexp_privdoc + `t'_pppexp_doctravel
	
	gen `t'_exp_hos = `t'_exp_pubhos + `t'_exp_privhos + `t'_exp_hostravel
	gen `t'_pppexp_hos = `t'_pppexp_pubhos + `t'_pppexp_privhos + `t'_pppexp_hostravel
	
	display "`t' OOP for doctor"
	table alloc country, c(n `t'_exp_doc mean `t'_exp_doc sd `t'_exp_doc min `t'_exp_doc max `t'_exp_doc)
	display "`t' PPP adjusted OOP for doctor"
	table alloc country, c(n `t'_pppexp_doc mean `t'_pppexp_doc sd `t'_pppexp_doc min `t'_pppexp_doc max `t'_pppexp_doc) col
	
	display "`t' OOP for hospital"
	table alloc country, c(n `t'_exp_hos mean `t'_exp_hos sd `t'_exp_hos min `t'_exp_hos max `t'_exp_hos)
	display "`t' PPP adjusted OOP for hospital"
	table alloc country, c(n `t'_pppexp_hos mean `t'_pppexp_hos sd `t'_pppexp_hos min `t'_pppexp_hos max `t'_pppexp_hos) col
}

local time "d0 m6 m12"
foreach t of local time {
	gen `t'_exp_hc = `t'_exp_doc + `t'_exp_hos
	gen `t'_pppexp_hc = `t'_pppexp_doc + `t'_pppexp_hos
	
	display "`t' OOP for health care services"
	table alloc country, c(n `t'_exp_hc mean `t'_exp_hc sd `t'_exp_hc min `t'_exp_hc max `t'_exp_hc)
	display "`t' PPP adjusted OOP for health care services"
	table alloc country, c(n `t'_pppexp_hc mean `t'_pppexp_hc sd `t'_pppexp_hc min `t'_pppexp_hc max `t'_pppexp_hc) col
}


*****Productivity loss*************************************************************
******hourly wage************
***Bangladesh********
gen wagebd_isco1_m = 176
gen wagebd_isco1_f = 158
gen wagebd_isco1_t = 174

gen wagebd_isco2_m = 131
gen wagebd_isco2_f = 121
gen wagebd_isco2_t = 128

gen wagebd_isco3_m = 103
gen wagebd_isco3_f = 99
gen wagebd_isco3_t = 103

gen wagebd_isco4_m = 79
gen wagebd_isco4_f = 72
gen wagebd_isco4_t = 78

gen wagebd_isco5_m = 58
gen wagebd_isco5_f = 54
gen wagebd_isco5_t = 58

gen wagebd_isco6_m = 46
gen wagebd_isco6_f = 38
gen wagebd_isco6_t = 45

gen wagebd_isco7_m = 52
gen wagebd_isco7_f = 48
gen wagebd_isco7_t = 51

gen wagebd_isco8_m = 59
gen wagebd_isco8_f = 55
gen wagebd_isco8_t = 58

gen wagebd_isco9_m = 43
gen wagebd_isco9_f = 35
gen wagebd_isco9_t = 41

gen wagebd_m = 66
gen wagebd_f = 60
gen wagebd_t = 64

******Pakistan***************
gen wagepk_isco1_m = 283
gen wagepk_isco1_f = 25
gen wagepk_isco1_t = 280

gen wagepk_isco2_m = 177
gen wagepk_isco2_f = 113
gen wagepk_isco2_t = 155

gen wagepk_isco3_m = 137
gen wagepk_isco3_f = 96
gen wagepk_isco3_t = 132

gen wagepk_isco4_m = 137
gen wagepk_isco4_f = 93
gen wagepk_isco4_t = 136

gen wagepk_isco5_m = 83
gen wagepk_isco5_f = 69
gen wagepk_isco5_t = 83

gen wagepk_isco6_m = 89
gen wagepk_isco6_f = 29
gen wagepk_isco6_t = 87

gen wagepk_isco7_m = 88
gen wagepk_isco7_f = 26
gen wagepk_isco7_t = 78

gen wagepk_isco8_m = 87
gen wagepk_isco8_f = 57
gen wagepk_isco8_t = 86

gen wagepk_isco9_m = 70
gen wagepk_isco9_f = 32
gen wagepk_isco9_t = 63

gen wagepk_m = 98
gen wagepk_f = 59
gen wagepk_t = 92

***********TB*******************************
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_tbprolos_pat = 0 if d0_isco > 10
	replace `t'_tbprolos_pat = `t'_tbvisittime * wagepk_m if country == 1 & d0_sdh_gender == 1 & d0_isco == 10
	replace `t'_tbprolos_pat = `t'_tbvisittime * wagepk_f if country == 1 & d0_sdh_gender == 2 & d0_isco == 10
	replace `t'_tbprolos_pat = `t'_tbvisittime * wagebd_m if country == 2 & d0_sdh_gender == 1 & d0_isco == 10
	replace `t'_tbprolos_pat = `t'_tbvisittime * wagebd_f if country == 2 & d0_sdh_gender == 2 & d0_isco == 10
	
	foreach n of numlist 1/9 {
		replace `t'_tbprolos_pat = `t'_tbvisittime * wagepk_isco`n'_m if country == 1 & d0_sdh_gender == 1 & d0_isco == `n'
		replace `t'_tbprolos_pat = `t'_tbvisittime * wagepk_isco`n'_f if country == 1 & d0_sdh_gender == 2 & d0_isco == `n'
		replace `t'_tbprolos_pat = `t'_tbvisittime * wagebd_isco`n'_m if country == 2 & d0_sdh_gender == 1 & d0_isco == `n'
		replace `t'_tbprolos_pat = `t'_tbvisittime * wagebd_isco`n'_f if country == 2 & d0_sdh_gender == 2 & d0_isco == `n'
	}
	
	gen `t'_tbprolos_fri = `t'_tbvisittime * `t'_tbcompany * wagepk_t if country == 1
	replace `t'_tbprolos_fri = `t'_tbvisittime * `t'_tbcompany * wagepk_t if country == 2
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' productivity loss by participant due to TB"
	table alloc country, c(n `t'_tbprolos_pat mean `t'_tbprolos_pat sd `t'_tbprolos_pat min `t'_tbprolos_pat max `t'_tbprolos_pat)
	gen `t'_ppptbprolos_pat = `t'_tbprolos_pat / 29.3 if country == 1
	replace `t'_ppptbprolos_pat = `t'_tbprolos_pat / 30.9 if country == 2
	display "`t' PPP adjusted productivity loss by participant due to TB"
	table alloc country, c(n `t'_ppptbprolos_pat mean `t'_ppptbprolos_pat sd `t'_ppptbprolos_pat min `t'_ppptbprolos_pat max `t'_ppptbprolos_pat) col
	
	display "`t' productivity loss by relative/friends due to TB"
	table alloc country, c(n `t'_tbprolos_fri mean `t'_tbprolos_fri sd `t'_tbprolos_fri min `t'_tbprolos_fri max `t'_tbprolos_fri)
	gen `t'_ppptbprolos_fri = `t'_tbprolos_fri / 29.3 if country == 1
	replace `t'_ppptbprolos_fri = `t'_tbprolos_fri / 30.9 if country == 2
	display "`t' PPP adjusted productivity loss by relative/friends due to TB"
	table alloc country, c(n `t'_ppptbprolos_fri mean `t'_ppptbprolos_fri sd `t'_ppptbprolos_fri min `t'_ppptbprolos_fri max `t'_ppptbprolos_fri) col
}


*********doctor*****************************
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_docprolos_pat = 0 if d0_isco > 10
	replace `t'_docprolos_pat = `t'_docvisittime * wagepk_m if country == 1 & d0_sdh_gender == 1 & d0_isco == 10
	replace `t'_docprolos_pat = `t'_docvisittime * wagepk_f if country == 1 & d0_sdh_gender == 2 & d0_isco == 10
	replace `t'_docprolos_pat = `t'_docvisittime * wagebd_m if country == 2 & d0_sdh_gender == 1 & d0_isco == 10
	replace `t'_docprolos_pat = `t'_docvisittime * wagebd_f if country == 2 & d0_sdh_gender == 2 & d0_isco == 10
	
	foreach n of numlist 1/9 {
		replace `t'_docprolos_pat = `t'_docvisittime * wagepk_isco`n'_m if country == 1 & d0_sdh_gender == 1 & d0_isco == `n'
		replace `t'_docprolos_pat = `t'_docvisittime * wagepk_isco`n'_f if country == 1 & d0_sdh_gender == 2 & d0_isco == `n'
		replace `t'_docprolos_pat = `t'_docvisittime * wagebd_isco`n'_m if country == 2 & d0_sdh_gender == 1 & d0_isco == `n'
		replace `t'_docprolos_pat = `t'_docvisittime * wagebd_isco`n'_f if country == 2 & d0_sdh_gender == 2 & d0_isco == `n'
	}
	
	gen `t'_docprolos_fri = `t'_docvisittime * `t'_tbcompany * wagepk_t if country == 1
	replace `t'_docprolos_fri = `t'_docvisittime * `t'_tbcompany * wagepk_t if country == 2
	
	gen `t'_pppdocprolos_pat = `t'_docprolos_pat / 29.3 if country == 1
	replace `t'_pppdocprolos_pat = `t'_docprolos_pat / 30.9 if country == 2
	gen `t'_pppdocprolos_fri = `t'_docprolos_fri / 29.3 if country == 1
	replace `t'_pppdocprolos_fri = `t'_docprolos_fri / 30.9 if country == 2
	
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' productivity loss by participant due to doctor visit"
	table alloc country, c(n `t'_docprolos_pat mean `t'_docprolos_pat sd `t'_docprolos_pat min `t'_docprolos_pat max `t'_docprolos_pat)
	display "`t' PPP adjusted productivity loss by participant due to doctor visit"
	table alloc country, c(n `t'_pppdocprolos_pat mean `t'_pppdocprolos_pat sd `t'_pppdocprolos_pat min `t'_pppdocprolos_pat max `t'_pppdocprolos_pat) col
	
	display "`t' productivity loss by relative/friends due to doctor visit"
	table alloc country, c(n `t'_docprolos_fri mean `t'_docprolos_fri sd `t'_docprolos_fri min `t'_docprolos_fri max `t'_docprolos_fri)
	display "`t' PPP adjusted productivity loss by relative/friends due to doctor visit"
	table alloc country, c(n `t'_pppdocprolos_fri mean `t'_pppdocprolos_fri sd `t'_pppdocprolos_fri min `t'_pppdocprolos_fri max `t'_pppdocprolos_fri) col
}

******sick leave*************************************
**assuming working day 8 hours******
local time "d0 m6 m12"
foreach t of local time {
	gen `t'_prolos_sick = 0 if d0_isco > 10
	replace `t'_prolos_sick = `t'_sickleave * 8 * wagepk_m if country == 1 & d0_sdh_gender == 1 & d0_isco == 10
	replace `t'_prolos_sick = `t'_sickleave * 8 * wagepk_f if country == 1 & d0_sdh_gender == 2 & d0_isco == 10
	replace `t'_prolos_sick = `t'_sickleave * 8 * wagebd_m if country == 2 & d0_sdh_gender == 1 & d0_isco == 10
	replace `t'_prolos_sick = `t'_sickleave * 8 * wagebd_f if country == 2 & d0_sdh_gender == 2 & d0_isco == 10
	
	foreach n of numlist 1/9 {
		replace `t'_prolos_sick = `t'_sickleave * wagepk_isco`n'_m if country == 1 & d0_sdh_gender == 1 & d0_isco == `n'
		replace `t'_prolos_sick = `t'_sickleave * wagepk_isco`n'_f if country == 1 & d0_sdh_gender == 2 & d0_isco == `n'
		replace `t'_prolos_sick = `t'_sickleave * wagebd_isco`n'_m if country == 2 & d0_sdh_gender == 1 & d0_isco == `n'
		replace `t'_prolos_sick = `t'_sickleave * wagebd_isco`n'_f if country == 2 & d0_sdh_gender == 2 & d0_isco == `n'
	}
	
	gen `t'_pppprolos_sick = `t'_prolos_sick / 29.3 if country == 1
	replace `t'_pppprolos_sick = `t'_prolos_sick / 30.9 if country == 2
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' productivity loss by participant due to sick leave"
	table alloc country, c(n `t'_prolos_sick mean `t'_prolos_sick sd `t'_prolos_sick min `t'_prolos_sick max `t'_prolos_sick)
	display "`t' PPP adjusted productivity loss by participant due to sick leave"
	table alloc country, c(n `t'_pppprolos_sick mean `t'_pppprolos_sick sd `t'_pppprolos_sick min `t'_pppprolos_sick max `t'_pppprolos_sick) col
}

***********merge from 20190722 data file, correct quit/tb outcome/death to death replace********************
************replace old variable with new***************************
drop m6_COquit m12_COquit mistab_m6_COquit mistab_m12_COquit m6_outcome m12_outcome m6_tboutcome m12_tboutcome ///
	cis_full_rip cis_full_dateofdeath death deathfromd0
merge 1:1 patid using "P:\\Documents\TB n Tobacco\Trial data\new quit tb death from 20190722.dta"
drop _merge
******Death*****************
gen death = 0 if cis_full_rip != 1
gen deathfromd0 = cis_full_dateofdeath - d0_datecomp
replace death = 1 if cis_full_rip == 1 & deathfromd0 < 26
replace death = 2 if cis_full_rip == 1 & deathfromd0 < 184 & deathfromd0 > 25
replace death = 3 if cis_full_rip == 1 & deathfromd0 > 183 & deathfromd0 <366
replace death = 4 if cis_full_rip == 1 & deathfromd0 > 365 & !mi(deathfromd0)
label define deathtime 0 "alive" 1 "dead before intervention complete" 2 "death before m6 after intervention" 3 "death before m12 after m6" 4 "death after m12"
label var deathfromd0 "days from d0 complete date to date of death"
label val death deathtime

******correction 25102019 two more death from statistician**************************************************************************
replace death = 2 if patid == "P22006" | patid == "P24007"
********************************************************************************************
tab death
table death alloc country

replace m6_exp_tb = 0 if death == 1 | death == 2
replace m12_exp_tb = 0 if death == 1 | death == 2 | death == 3

replace m6_pppexp_tb = 0 if death == 1 | death == 2
replace m12_pppexp_tb = 0 if death == 1 | death == 2 | death == 3

local name "ss doc hos hc"
foreach n of local name {
	replace m6_cost_`n' = 0 if death == 1 | death == 2
	replace m6_exp_`n' = 0 if death == 1 | death == 2
	replace m12_cost_`n' = 0 if death == 1 | death == 2 | death == 3
	replace m12_exp_`n' = 0 if death == 1 | death == 2 | death == 3
	
	replace m6_pppcost_`n' = 0 if death == 1 | death == 2
	replace m6_pppexp_`n' = 0 if death == 1 | death == 2
	replace m12_pppcost_`n' = 0 if death == 1 | death == 2 | death == 3
	replace m12_pppexp_`n' = 0 if death == 1 | death == 2 | death == 3
}

replace m6_exp_tob = 0 if death == 1 | death == 2
replace m12_exp_tob = 0 if death == 1 | death == 2 | death == 3

replace m6_pppexp_tob = 0 if death == 1 | death == 2
replace m12_pppexp_tob = 0 if death == 1 | death == 2 | death == 3

replace m6_eco8 = 4 if death == 1 | death == 2
replace m12_eco8 = 4 if death == 1 | death == 2 | death == 3
label var m6_eco8 "4=dead, n/a"
label var m12_eco8 "4=dead, n/a"

replace m6_eco9 = 4 if death == 1 | death == 2
replace m12_eco9 = 4 if death == 1 | death == 2 | death == 3

*****tbprolos_pat & docprolos_pat possibly overlap with prolos_sick, so only use friend/relative********

local name "tbprolos_fri docprolos_fri prolos_sick"
foreach n of local name {
	replace m6_`n' = 0 if death == 1 | death == 2
	replace m12_`n' = 0 if death == 1 | death == 2 | death == 3
	
	replace m6_ppp`n' = 0 if death == 1 | death == 2
	replace m12_ppp`n' = 0 if death == 1 | death == 2 | death == 3
}

local time "d0 m6 m12"
foreach t of local time {
	local name "tb doc"
	foreach n of local name {
		display "`t' no `n' company"
		tab alloc country if `t'_`n'company == 0
		display "`t' missing `n' company"
		tab alloc country if mi(`t'_`n'company)
		display "`t' `n' company visit time"
		table alloc country if `t'_`n'company > 0 & !mi(`t'_`n'company), c(n `t'_`n'company med `t'_`n'company p25 `t'_`n'company ///
			p75 `t'_`n'company) col
		table alloc country if `t'_`n'company > 0 & !mi(`t'_`n'company), c(med `t'_`n'visittime p25 `t'_`n'visittime p75 `t'_`n'visittime) col
	}
	display "`t' 0 sick leave"
	tab alloc country if `t'_sickleave == 0
	display "`t' missing sick leave"
	tab alloc country if mi(`t'_sickleave)
	display "`t' sickleave"
	table alloc country if `t'_sickleave > 0 & !mi(`t'_sickleave), c(n `t'_sickleave med `t'_sickleave p25 `t'_sickleave p75 `t'_sickleave) col
}


*************EQ5D death*************************
replace m6_vas = 0 if death == 1 | death == 2
replace m12_vas = 0 if death == 1 | death == 2 | death == 3

replace m6_tbsc = 9 if death == 1 | death == 2
label var m6_tbsc "9 = participant dead before m6"

foreach n of numlist 1/5 {
	replace m6_eq`n' = 0 if death == 1 | death == 2
}

foreach n of numlist 1/5 {
	replace m12_eq`n' = 0 if death == 1 | death == 2 | death == 3
}

local name "zimbabwe uk thailand thailand2 malaysia indonesia"
foreach n of local name {
	replace utility_`n'_m6 = 0 if death == 1 | death == 2
	replace utility_`n'_m12 = 0 if death == 1 | death == 2 | death == 3
}

*************other outcome**********************
label define outcome 1 "cured" 2 "completed treatment" 3 "treatment failure" 4 "defaulted" 5 "transferred out" 6 "lost to follow up" 7 "died" 8 "not evaluated"
label val m6_outcome outcome
label val m12_outcome outcome

tab1 *_outcome

table alloc country if m6_outcome == 1, c(n m6_outcome) col
table m6_outcome country alloc, row
table m12_outcome country alloc, row
***************************************************************************
recode m6_outcome 1=1 2/8=0, g(m6_tbcure)
replace m6_tbcure = 2 if death == 1 | death == 2
label define cure 0 "not cured or not evaluated" 1 "cured" 2 "dead"
label val m6_tbcure cure
replace m6_tbcure = 0 if mi(m6_tbcure)
label var m6_tbcure "TB cured"

recode m6_outcome 1/2=1 3/8=0, g(m6_tbsuccess)
replace m6_tbsuccess = 2 if death == 1 | death == 2
label define success 0 "treatment incompleted" 1 "treatment completed or cured" 2 "dead"
label val m6_tbsuccess success
replace m6_tbsuccess = 0 if mi(m6_tbsuccess)
label var m6_tbsuccess "TB treatment success"

table m6_tbcure country alloc, row
table m6_tbsuccess country alloc, row
*******************************************************************************
*****using statistician's quit rate to be consistent**************************
tab1 *_quit_sqd_bio *_quit_sqd_biox
*********Russell standard*********************
table m6_quit_sqd_biox country alloc, row
table m12_quit_sqd_biox country alloc, row

table alloc country, c(n m6_quit_sqd_biox mean m6_quit_sqd_biox sd m6_quit_sqd_biox) col
table alloc country, c(n m12_quit_sqd_biox mean m12_quit_sqd_biox sd m12_quit_sqd_biox) col

******correct entry errors**************************************************
replace m12_tbvisittime = 1.5 if patid == "B54008"
replace d0_docf2ftime = 0.5 if patid == "P10003"
replace d0_docf2ftime = 0.25 if patid == "P10001"
replace d0_docvisittime = 8+20/60 if patid == "P24004"

replace m12_tbprolos_pat = m12_tbvisittime * wagebd_isco9_m if patid == "B54008"
replace m12_tbprolos_fri = m12_tbvisittime * m12_tbcompany * wagebd_t if patid == "B54008"
replace m12_ppptbprolos_pat = m12_tbprolos_pat/30.9 if patid == "B54008"
replace m12_ppptbprolos_fri = m12_tbprolos_fri/30.9 if patid == "B54008"

****P24004 unemployed
replace d0_docprolos_fri = d0_docvisittime * d0_doccompany * wagepk_t if patid == "P24004"
replace d0_pppdocprolos_fri = d0_docprolos_fri/29.3 if patid == "P24004"

*******merge TB score*****************************************************
merge 1:1 patid using "P:\\Documents\TB n Tobacco\Trial data\tb score from 20190722.dta", update replace
rename _merge _tbscupdate

**********missing data table*********************************

misstable summ cost_bs cost_tb *_cost_ss *_cost_doc *_cost_hos, gen(mistab_)

misstable summ *_exp_tb *_exp_ss *_exp_doc *_exp_hos *_exp_tob, gen(mistab_)

misstable summ d0_eq* m6_eq* m12_eq* *_vas, gen(mistab_)

misstable summ d0_isco d0_sdh_age d0_sdh_gender d0_smoke_years d0_siteid country, gen(mistab_)

misstable summ *_tbsc, gen(mistab_)

misstable summ *_tbprolos_fri *_docprolos_fri *_prolos_sick, gen(mistab_)

drop mistab_*eq5d*

*************by group missing data**********************************
by alloc: tab1 mistab_*

*********association between baseline covariates and missingness****
local name "cost_bs cost_tb d0_cost_doc m6_cost_doc m12_cost_doc d0_cost_hos m6_cost_hos m12_cost_hos m6_cost_ss m12_cost_ss"
foreach n of local name {
	xi: logistic mistab_`n' alloc
	xi: logistic mistab_`n' d0_sdh_age
	xi: logistic mistab_`n' i.country
	xi: logistic mistab_`n' d0_smoke_years
}

local name "d0_exp_tb m6_exp_tb m12_exp_tb d0_exp_ss m6_exp_ss m12_exp_ss d0_exp_doc m6_exp_doc m12_exp_doc d0_exp_hos m6_exp_hos m12_exp_hos"
foreach n of local name {
	xi: logistic mistab_`n' alloc
	xi: logistic mistab_`n' d0_sdh_age
	xi: logistic mistab_`n' i.country
	xi: logistic mistab_`n' d0_smoke_years
}

local name "d0_tbprolos_fri m6_tbprolos_fri m12_tbprolos_fri d0_docprolos_fri m6_docprolos_fri m12_docprolos_fri d0_prolos_sick m6_prolos_sick m12_prolos_sick"
foreach n of local name {
	xi: logistic mistab_`n' alloc
	xi: logistic mistab_`n' d0_sdh_age
	xi: logistic mistab_`n' i.country
	xi: logistic mistab_`n' d0_smoke_years
}

local name "d0_exp_tob m6_exp_tob m12_exp_tob"
foreach n of local name {
	xi: logistic mistab_`n' alloc
	xi: logistic mistab_`n' d0_sdh_age
	xi: logistic mistab_`n' i.country
	xi: logistic mistab_`n' d0_smoke_years
}

local time "m6 m12"
foreach t of local time {
	egen temp = rowtotal(mistab_`t'_eq1-mistab_`t'_eq5 mistab_`t'_vas)
	recode temp 6=1 nonm=0, g(mistab_`t'_eq5d)
	drop temp
}

local name "m6_eq5d m12_eq5d"
foreach n of local name {
	xi: logistic mistab_`n' alloc
	xi: logistic mistab_`n' d0_sdh_age
	xi: logistic mistab_`n' i.country
	xi: logistic mistab_`n' d0_smoke_years
}

xi: logistic mistab_m6_tbsc alloc
xi: logistic mistab_m6_tbsc d0_sdh_age
xi: logistic mistab_m6_tbsc i.country
xi: logistic mistab_m6_tbsc d0_smoke_years

************association between missingness and observed outcomes********************************
local name "cost_doc cost_hos cost_ss exp_tb exp_ss exp_doc exp_hos exp_tob tbprolos_fri docprolos_fri prolos_sick"
foreach n of local name {
	xi: logistic mistab_m6_`n' d0_ppp`n'
	xi: logistic mistab_m12_`n' d0_ppp`n'
	xi: logistic mistab_m12_`n' m6_ppp`n'
}

misstable summ utility_zimbabwe_*, gen(mistab_)

local name "utility_zimbabwe"
foreach n of local name {
	xi: logistic mistab_`n'_m6 `n'_d0
	xi: logistic mistab_`n'_m12 `n'_d0
	xi: logistic mistab_`n'_m12 `n'_m6
}

xi: logistic mistab_m6_vas d0_vas
xi: logistic mistab_m12_vas d0_vas
xi: logistic mistab_m12_vas m6_vas
