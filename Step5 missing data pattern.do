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
