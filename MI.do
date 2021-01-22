***********Baseline mean imputation**************************
******costs******************************
*****cost doc visit*************
list country d0_eco2 if mi(d0_cost_doc)
***only one missing in Bangladesh, yes to doc
sum d0_cost_doc if d0_eco2 == 1 & country == 2
replace d0_cost_doc = r(mean) if mi(d0_cost_doc)
replace d0_pppcost_doc = d0_cost_doc / 30.9 if country == 2
******cost hos stay*************
list country d0_eco3 if mi(d0_cost_hos)
***3 in Bangladesh, 1 in Pakistan, all yes to hos
sum d0_cost_hos if d0_eco3 == 1 & country == 1
replace d0_cost_hos = r(mean) if mi(d0_cost_hos) & country == 1
replace d0_pppcost_hos = d0_cost_hos / 29.3 if country == 1
sum d0_cost_hos if d0_eco3 == 1 & country == 2
replace d0_cost_hos = r(mean) if mi(d0_cost_hos) & country == 2
replace d0_pppcost_hos = d0_cost_hos / 30.9 if country == 2
*******cost ss*********************
list country d0_ssyn if mi(d0_cost_ss)
***none missing

*****OOP**********************************
****OOP tb**************
list country d0_eco1 if mi(d0_exp_tb)
***only one missing in Pakistan, yes to oop tb
sum d0_exp_tb if d0_eco1 == 1 & country == 1
replace d0_exp_tb = r(mean) if mi(d0_exp_tb)
replace d0_pppexp_tb = d0_exp_tb / 29.3 if mi(d0_pppexp_tb) & country == 1
****OOP ss**************
list country d0_ssyn if mi(d0_exp_ss)
***4 in Bangladesh, 2 in Pakistan, all yes to ss
sum d0_exp_ss if d0_ssyn == 1 & country == 1
**2 yes in Pakistan, all missing, need to use MI
sum d0_exp_ss if d0_ssyn == 1 & country == 2
replace d0_exp_ss = r(mean) if mi(d0_exp_ss) & country == 2
replace d0_pppexp_ss = d0_exp_ss / 30.9 if mi(d0_pppexp_ss) & country == 2
****OOP doc************
****d0_eco1, eco2, eco3, ssyn none missing, so the exp missing must be yes
sum d0_exp_doc if d0_eco2 ==1 & country == 1
replace d0_exp_doc = r(mean) if mi(d0_exp_doc) & country == 1
replace d0_pppexp_doc = d0_exp_doc / 29.3 if mi(d0_pppexp_doc) & country == 1
sum d0_exp_doc if d0_eco2 == 1 & country == 2
replace d0_exp_doc = r(mean) if mi(d0_exp_doc) & country == 2
replace d0_pppexp_doc = d0_exp_doc / 30.9 if mi(d0_pppexp_doc) & country == 2
****OOP hos****************
sum d0_exp_hos if d0_eco3 == 1 & country == 1
replace d0_exp_hos = r(mean) if mi(d0_exp_hos) & country == 1
replace d0_pppexp_hos = d0_exp_hos / 29.3 if mi(d0_pppexp_hos) & country == 1
sum d0_exp_hos if country == 2
replace d0_exp_hos = r(mean) if mi(d0_exp_hos) & country == 2
replace d0_pppexp_hos = d0_exp_hos / 30.9 if mi(d0_pppexp_hos) & country == 2
****OOP tobacco**************
sum d0_exp_tob if country == 1
replace d0_exp_tob = r(mean) if mi(d0_exp_tob) & country == 1
replace d0_pppexp_tob = d0_exp_tob / 29.3 if mi(d0_pppexp_tob) & country == 1
sum d0_exp_tob if country == 2
replace d0_exp_tob = r(mean) if mi(d0_exp_tob) & country == 2
replace d0_pppexp_tob = d0_exp_tob / 30.9 if mi(d0_pppexp_tob) & country == 2

*****productivity loss*********************************
****Company for TB***********
sum d0_tbprolos_fri if d0_eco1 == 1 & country == 1
replace d0_tbprolos_fri = r(mean) if mi(d0_tbprolos_fri) & country == 1
replace d0_ppptbprolos_fri = d0_tbprolos_fri / 29.3 if mi(d0_ppptbprolos_fri) & country == 1
sum d0_tbprolos_fri if d0_eco1 == 1 & country == 2
replace d0_tbprolos_fri = r(mean) if mi(d0_tbprolos_fri) & country == 2
replace d0_ppptbprolos_fri = d0_tbprolos_fri / 30.9 if mi(d0_ppptbprolos_fri) & country == 2
****Company for doctor**********
sum d0_docprolos_fri if d0_eco2 == 1 & country == 1
replace d0_docprolos_fri = r(mean) if mi(d0_docprolos_fri) & country == 1
replace d0_pppdocprolos_fri = d0_docprolos_fri / 29.3 if mi(d0_pppdocprolos_fri) & country == 1
sum d0_docprolos_fri if d0_eco2 == 1 & country == 2
replace d0_docprolos_fri = r(mean) if mi(d0_docprolos_fri) & country == 2
replace d0_pppdocprolos_fri = d0_docprolos_fri / 30.9 if mi(d0_pppdocprolos_fri) & country == 2
****sick leave****************
sum d0_prolos_sick if d0_eco9 == 1 & country == 1
replace d0_prolos_sick = r(mean) if mi(d0_prolos_sick) & d0_eco9 == 1 & country == 1
replace d0_pppprolos_sick = d0_prolos_sick / 29.3 if mi(d0_pppprolos_sick) & d0_eco9 == 1 & country == 1
sum d0_prolos_sick if d0_eco9 == 1 & country == 2
replace d0_prolos_sick = r(mean) if mi(d0_prolos_sick) & d0_eco9 == 1 & country == 2
replace d0_pppprolos_sick = d0_prolos_sick / 30.9 if mi(d0_pppprolos_sick) & d0_eco9 == 1 & country == 2


*******************MI*******************************************************************
mi set flong

mi register imputed pppcost_tb pppcost_bs m6_pppcost_doc m12_pppcost_doc m6_pppcost_hos ///
		m12_pppcost_hos m6_pppcost_ss m12_pppcost_ss m6_pppexp_tb m12_pppexp_tb m6_pppexp_ss ///
		m12_pppexp_ss m6_pppexp_doc m12_pppexp_doc m6_pppexp_hos m12_pppexp_hos m6_pppexp_tob ///
		m12_pppexp_tob m6_tbsc m6_vas m12_vas d0_eq1 d0_eq2 d0_eq3 d0_eq4 d0_eq5 ///
		m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_eq5 ///
		m6_ppptbprolos_fri m12_ppptbprolos_fri m6_pppdocprolos_fri m12_pppdocprolos_fri ///
		m6_pppprolos_sick m12_pppprolos_sick d0_pppexp_ss d0_eco9 m6_eco1 m6_eco2 m6_eco3 m6_ssyn ///
		m6_eco8 m6_eco9 m12_eco1 m12_eco2 m12_eco3 m12_ssyn m12_eco8 m12_eco9 d0_pppprolos_sick

mi register passive cost_tb cost_cytisine cost_bs d0_cost_doc m6_cost_doc m12_cost_doc ///
		d0_cost_hos m6_cost_hos m12_cost_hos d0_cost_hc m6_cost_hc m12_cost_hc ///
		d0_pppcost_hc m6_pppcost_hc m12_pppcost_hc d0_cost_ss m6_cost_ss m12_cost_ss ///
		d0_exp_tb m6_exp_tb m12_exp_tb d0_exp_ss m6_exp_ss m12_exp_ss ///
		d0_exp_doc m6_exp_doc m12_exp_doc d0_exp_hos m6_exp_hos m12_exp_hos ///
		d0_exp_hc m6_exp_hc m12_exp_hc d0_pppexp_hc m6_pppexp_hc m12_pppexp_hc ///
		d0_exp_tob m6_exp_tob m12_exp_tob
mi register passive d0_tbprolos_fri m6_tbprolos_fri m12_tbprolos_fri d0_docprolos_fri ///
		m6_docprolos_fri m12_docprolos_fri d0_prolos_sick m6_prolos_sick m12_prolos_sick ///
		cost_cytisine_disp


mi register regular pppcost_cytisine_disp d0_pppcost_doc d0_pppcost_hos d0_pppcost_ss ///
		d0_pppexp_tb d0_pppexp_doc d0_pppexp_hos d0_pppexp_tob d0_tbsc d0_vas ///
		d0_sdh_age d0_sdh_gender d0_isco d0_smoke_years d0_siteid country death ///
		d0_ppptbprolos_fri d0_pppdocprolos_fri d0_eco1 d0_eco2 d0_eco3 d0_ssyn ///
		d0_eco8 m6_quit_sqd_biox m12_quit_sqd_biox m6_tbcure m6_tbsuccess num_sae

mi describe
****************ologit failed to converge**********************************************************
mi impute chained ///
		(pmm, knn(10) noimp) pppcost_bs ///
		(pmm, knn(10) include(d0_tbsc) omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss i.d0_eq4 ///
                i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppprolos_sick ///
				m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 ///
				m6_pppcost_doc m6_pppcost_hos m6_pppcost_ss m12_pppprolos_sick ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
				m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 ///
                m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) pppcost_tb ///
		(pmm, knn(10) omit(i.d0_eq1 i.d0_eq2 i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs ///
                d0_pppprolos_sick m6_pppprolos_sick m6_vas i.m6_eq1 i.m6_eq2 ///
				i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppexp_doc m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc ///
                m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas ///
				i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri ///
				m12_pppdocprolos_fri i.m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
                m6_pppdocprolos_fri)) d0_pppexp_ss ///
		(pmm, knn(10) include(d0_vas d0_tbsc d0_pppcost_doc d0_pppexp_doc d0_pppcost_hos ///
				d0_pppexp_hos d0_ppptbprolos_fri d0_pppdocprolos_fri) noimp) d0_pppprolos_sick ///
		(ologit, include(d0_vas d0_tbsc) omit(d0_pppexp_ss pppcost_bs d0_pppprolos_sick ///
				m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m12_pppprolos_sick m12_pppcost_doc ///
                m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob ///
				m12_ppptbprolos_fri m12_pppdocprolos_fri pppcost_tb m6_ppptbprolos_fri ///
                m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m6_vas m6_tbsc ///
				m12_vas)) d0_eq1 d0_eq2 d0_eq3 d0_eq4 d0_eq5 ///
		(pmm, knn(10) cond(if death !=1 & death !=2) include(d0_pppcost_doc ///
				d0_pppexp_doc) omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss i.d0_eq4 ///
                i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppexp_tob m6_vas ///
				i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppexp_tb m6_pppcost_ss ///
				m12_pppprolos_sick m12_pppexp_tb m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 ///
				i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss m12_pppexp_ss ///
				m6_pppexp_ss m12_pppcost_hos m12_pppexp_hos)) m6_pppcost_doc m6_pppexp_doc ///
		(pmm, knn(10) cond(if death != 1 & death != 2) include(d0_pppcost_hos ///
				d0_pppexp_hos) omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 ///
				i.d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 ///
                i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppexp_tb m6_pppcost_ss m12_pppprolos_sick ///
				m12_pppexp_tb m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 ///
                m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
				m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m12_pppcost_doc ///
				m12_pppexp_doc)) ///
				m6_pppcost_hos m6_pppexp_hos ///
		(pmm, knn(10) cond(if death != 1 & death != 2) include(d0_pppexp_tb) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
				m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_ss ///
				m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
				m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 ///
				m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 m6_ppptbprolos_fri ///
				m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m6_pppexp_tb ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_pppcost_ss) omit(i.d0_eq1 i.d0_eq2 ///
				i.d0_eq4 i.d0_eq3 i.d0_eq5 d0_pppprolos_sick m6_pppprolos_sick m6_vas i.m6_eq1 ///
				i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppexp_doc m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc ///
				m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas i.m12_eq1 ///
				i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m6_pppdocprolos_fri)) m6_pppcost_ss m6_pppexp_ss ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_pppexp_tob d0_pppcost_ss) ///
				omit(i.d0_eq1 i.d0_eq2 i.d0_eq4 i.d0_eq3 i.d0_eq5 ///
				d0_pppprolos_sick m6_pppprolos_sick m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 ///
				i.m6_eq4 i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc ///
                m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas i.m12_eq1 i.m12_eq2 ///
				i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m6_pppdocprolos_fri)) m6_pppexp_tob ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_ppptbprolos_fri) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_doc ///
				m6_pppcost_hos m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m12_pppprolos_sick ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb ///
				m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_pppdocprolos_fri ///
				i.m12_eq5 m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss)) ///
				m6_ppptbprolos_fri ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_pppdocprolos_fri) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_hos ///
                m6_pppexp_tb m6_pppcost_ss m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc ///
				m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob ///
                m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri ///
				i.m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m12_pppexp_ss m6_pppexp_ss)) m6_pppdocprolos_fri ///
		(pmm, knn(10) cond(if death != 1 & death !=2) omit(i.d0_eq1 i.d0_eq2 ///
				d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs m6_pppexp_tob ///
				i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_ss ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
                m12_pppexp_tb m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 ///
                i.m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 ///
				m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss)) ///
				m6_pppprolos_sick ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_tbsc) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
				m6_pppprolos_sick m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 ///
                i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 ///
				m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 m6_ppptbprolos_fri ///
				m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m6_tbsc ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_vas) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs ///
				d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc ///
				m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos ///
				m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob i.m12_eq1 i.m12_eq2 ///
                i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss m6_pppdocprolos_fri ///
				m12_pppexp_ss m6_pppexp_ss)) m6_vas ///
		(ologit, cond(if death != 1 & death !=2) include(d0_vas) omit(d0_pppexp_ss pppcost_bs ///
				d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc ///
				m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos ///
				m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob m12_ppptbprolos_fri ///
				m12_pppdocprolos_fri pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
                m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_doc ///
				d0_pppexp_doc) omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 ///
				i.d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob ///
				m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppexp_tb ///
				m6_pppcost_ss m6_tbsc m12_pppprolos_sick m12_pppexp_tb m12_pppexp_tob ///
				m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri ///
                m12_pppdocprolos_fri i.m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m6_pppcost_hos m6_pppexp_hos)) ///
				m12_pppcost_doc m12_pppexp_doc ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_hos ///
				d0_pppexp_hos) omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 ///
				i.d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob ///
				m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppexp_tb ///
				m6_pppcost_ss m6_tbsc m12_pppprolos_sick m12_pppexp_tb m12_pppexp_tob ///
				m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri ///
                m12_pppdocprolos_fri i.m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m6_pppcost_doc m6_pppexp_doc)) ///
				m12_pppcost_hos m12_pppexp_hos ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppexp_tb) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 ///
				i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos ///
                m12_pppexp_tob m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m12_pppdocprolos_fri ///
				i.m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss m6_pppdocprolos_fri ///
                m12_pppexp_ss m6_pppexp_ss)) ///
				m12_pppexp_tb ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_ss) omit(i.d0_eq1 ///
				i.d0_eq2 i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 ///
				i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppexp_doc m6_pppexp_hos ///
                m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tb m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 ///
                m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
				m6_pppdocprolos_fri)) m12_pppcost_ss m12_pppexp_ss ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_ss d0_pppexp_tob) ///
				omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 d0_pppprolos_sick ///
                m6_pppprolos_sick m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 ///
				m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc ///
                m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas i.m12_eq1 i.m12_eq2 ///
				i.m12_eq3 i.m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri i.m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m6_pppdocprolos_fri)) ///
				m12_pppexp_tob ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_ppptbprolos_fri) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 ///
				i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
				m12_pppexp_tob i.m12_eq5 pppcost_tb  m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss ///
				m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 m6_pppdocprolos_fri)) ///
				m12_ppptbprolos_fri ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppdocprolos_fri) omit(i.d0_eq1 ///
				i.d0_eq2 d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_vas i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 ///
				i.m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob ///
                m12_vas i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 i.m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
                m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss)) ///
				m12_pppdocprolos_fri ///
		(pmm, knn(10) cond(if death ==0 | death ==4) omit(i.d0_eq1 i.d0_eq2 d0_pppexp_ss ///
				i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs m6_pppexp_tob m6_vas i.m6_eq1 ///
				i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 m6_pppcost_doc m6_pppcost_hos ///
                m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m6_tbsc ///
				i.m12_eq1 i.m12_eq2 i.m12_eq3 i.m12_eq4 i.m12_eq5 pppcost_tb m12_pppcost_ss ///
				m12_pppexp_ss m6_pppexp_ss m6_ppptbprolos_fri m6_pppdocprolos_fri)) ///
				m12_pppprolos_sick ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_vas) omit(i.d0_eq1 i.d0_eq2 ///
				d0_pppexp_ss i.d0_eq4 i.d0_eq3 i.d0_eq5 pppcost_bs d0_pppprolos_sick ///
				m6_pppprolos_sick m6_pppexp_tob i.m6_eq1 i.m6_eq2 i.m6_eq3 i.m6_eq4 i.m6_eq5 ///
				m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc ///
                m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob m12_ppptbprolos_fri ///
                m12_pppdocprolos_fri pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m12_vas ///
		(ologit, cond(if death ==0 | death ==4) omit(d0_pppexp_ss pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m6_tbsc m12_pppprolos_sick ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb ///
				m12_pppexp_tob m12_ppptbprolos_fri m12_pppdocprolos_fri pppcost_tb ///
				m6_ppptbprolos_fri m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss ///
				m6_pppexp_ss m6_vas)) m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_eq5 ///
		= d0_sdh_age i.d0_sdh_gender i.d0_isco d0_smoke_years i.m6_COquit i.m12_COquit i.m6_tboutcome ///
		i.d0_siteid i.country, add(15) rseed(999) by(alloc)
		
************ologit failed to converge, using pmm instead*************************************
mi impute chained ///
		(pmm, knn(10) noimp) pppcost_bs ///
		(pmm, knn(10) include(d0_tbsc) omit(d0_eq1 d0_eq2 d0_pppexp_ss d0_eq4 ///
                d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppprolos_sick ///
				m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 ///
				m6_pppcost_doc m6_pppcost_hos m6_pppcost_ss m12_pppprolos_sick ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
				m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 ///
                m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) pppcost_tb ///
		(pmm, knn(10) omit(d0_eq1 d0_eq2 d0_eq4 d0_eq3 d0_eq5 pppcost_bs ///
                d0_pppprolos_sick m6_pppprolos_sick m6_vas m6_eq1 m6_eq2 ///
				m6_eq3 m6_eq4 m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppexp_doc m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc ///
                m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas ///
				m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_ppptbprolos_fri ///
				m12_pppdocprolos_fri m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
                m6_pppdocprolos_fri)) d0_pppexp_ss ///
		(pmm, knn(10) include(d0_vas d0_tbsc d0_pppcost_doc d0_pppexp_doc d0_pppcost_hos ///
				d0_pppexp_hos d0_ppptbprolos_fri d0_pppdocprolos_fri) noimp) d0_pppprolos_sick ///
		(pmm, knn(10) include(d0_vas d0_tbsc) omit(d0_pppexp_ss pppcost_bs d0_pppprolos_sick ///
				m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m12_pppprolos_sick m12_pppcost_doc ///
                m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob ///
				m12_ppptbprolos_fri m12_pppdocprolos_fri pppcost_tb m6_ppptbprolos_fri ///
                m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m6_vas m6_tbsc ///
				m12_vas)) d0_eq1 d0_eq2 d0_eq3 d0_eq4 d0_eq5 ///
		(pmm, knn(10) cond(if death !=1 & death !=2) include(d0_pppcost_doc ///
				d0_pppexp_doc) omit(d0_eq1 d0_eq2 d0_pppexp_ss d0_eq4 ///
                d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppexp_tob m6_vas ///
				m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppexp_tb m6_pppcost_ss ///
				m12_pppprolos_sick m12_pppexp_tb m12_pppexp_tob m12_vas m12_eq1 m12_eq2 ///
				m12_eq3 m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss m12_pppexp_ss ///
				m6_pppexp_ss m12_pppcost_hos m12_pppexp_hos)) m6_pppcost_doc m6_pppexp_doc ///
		(pmm, knn(10) cond(if death != 1 & death != 2) include(d0_pppcost_hos ///
				d0_pppexp_hos num_sae) omit(d0_eq1 d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 ///
				d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppexp_tob m6_vas m6_eq1 m6_eq2 ///
                m6_eq3 m6_eq4 m6_eq5 m6_pppexp_tb m6_pppcost_ss m12_pppprolos_sick ///
				m12_pppexp_tb m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 ///
                m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
				m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m12_pppcost_doc ///
				m12_pppexp_doc)) m6_pppcost_hos m6_pppexp_hos ///
		(pmm, knn(10) cond(if death != 1 & death != 2) include(d0_pppexp_tb) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
				m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppcost_ss ///
				m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
				m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 ///
				m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 m6_ppptbprolos_fri ///
				m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m6_pppexp_tb ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_pppcost_ss) omit(d0_eq1 d0_eq2 ///
				d0_eq4 d0_eq3 d0_eq5 d0_pppprolos_sick m6_pppprolos_sick m6_vas m6_eq1 ///
				m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppexp_doc m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc ///
				m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas m12_eq1 ///
				m12_eq2 m12_eq3 m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m6_pppdocprolos_fri)) m6_pppcost_ss m6_pppexp_ss ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_pppexp_tob d0_pppcost_ss) ///
				omit(d0_eq1 d0_eq2 d0_eq4 d0_eq3 d0_eq5 ///
				d0_pppprolos_sick m6_pppprolos_sick m6_vas m6_eq1 m6_eq2 m6_eq3 ///
				m6_eq4 m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc ///
                m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas m12_eq1 m12_eq2 ///
				m12_eq3 m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m6_pppdocprolos_fri)) m6_pppexp_tob ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_ppptbprolos_fri) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppcost_doc ///
				m6_pppcost_hos m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m12_pppprolos_sick ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb ///
				m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_pppdocprolos_fri ///
				m12_eq5 m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss)) ///
				m6_ppptbprolos_fri ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_pppdocprolos_fri) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppcost_hos ///
                m6_pppexp_tb m6_pppcost_ss m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc ///
				m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob ///
                m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_ppptbprolos_fri ///
				m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m12_pppexp_ss m6_pppexp_ss)) m6_pppdocprolos_fri ///
		(pmm, knn(10) cond(if death != 1 & death !=2) omit(d0_eq1 d0_eq2 ///
				d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs m6_pppexp_tob ///
				m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppcost_ss ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
                m12_pppexp_tb m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 ///
                m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 ///
				m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss)) ///
				m6_pppprolos_sick ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_tbsc) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
				m6_pppprolos_sick m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 ///
                m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 ///
				m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 m6_ppptbprolos_fri ///
				m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m6_tbsc ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_vas num_sae) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs ///
				d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc ///
				m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos ///
				m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob m12_eq1 m12_eq2 ///
                m12_eq3 m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss m6_pppdocprolos_fri ///
				m12_pppexp_ss m6_pppexp_ss)) m6_vas ///
		(pmm, knn(10) cond(if death != 1 & death !=2) include(d0_vas num_sae) omit(d0_pppexp_ss pppcost_bs ///
				d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc ///
				m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos ///
				m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob m12_ppptbprolos_fri ///
				m12_pppdocprolos_fri pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
                m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_doc ///
				d0_pppexp_doc) omit(d0_eq1 d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 ///
				d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob ///
				m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppexp_tb ///
				m6_pppcost_ss m6_tbsc m12_pppprolos_sick m12_pppexp_tb m12_pppexp_tob ///
				m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_ppptbprolos_fri ///
                m12_pppdocprolos_fri m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m6_pppcost_hos m6_pppexp_hos)) ///
				m12_pppcost_doc m12_pppexp_doc ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_hos ///
				d0_pppexp_hos num_sae) omit(d0_eq1 d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 ///
				d0_eq5 pppcost_bs d0_pppprolos_sick m6_pppprolos_sick m6_pppexp_tob ///
				m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppexp_tb ///
				m6_pppcost_ss m6_tbsc m12_pppprolos_sick m12_pppexp_tb m12_pppexp_tob ///
				m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_ppptbprolos_fri ///
                m12_pppdocprolos_fri m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss m6_pppcost_doc m6_pppexp_doc)) ///
				m12_pppcost_hos m12_pppexp_hos ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppexp_tb) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 ///
				m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos ///
                m12_pppexp_tob m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_pppdocprolos_fri ///
				m12_eq5 pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss m6_pppdocprolos_fri ///
                m12_pppexp_ss m6_pppexp_ss)) ///
				m12_pppexp_tb ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_ss) omit(d0_eq1 ///
				d0_eq2 d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 ///
				m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppexp_doc m6_pppexp_hos ///
                m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos ///
				m12_pppexp_hos m12_pppexp_tb m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 ///
                m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
				m6_pppdocprolos_fri)) m12_pppcost_ss m12_pppexp_ss ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppcost_ss d0_pppexp_tob) ///
				omit(d0_eq1 d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 d0_pppprolos_sick ///
                m6_pppprolos_sick m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 ///
				m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc ///
                m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_vas m12_eq1 m12_eq2 ///
				m12_eq3 m12_eq4 m12_ppptbprolos_fri m12_pppdocprolos_fri m12_eq5 ///
				pppcost_tb m6_ppptbprolos_fri m6_pppdocprolos_fri)) ///
				m12_pppexp_tob ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_ppptbprolos_fri) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 ///
				m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos ///
				m12_pppexp_tob m12_eq5 pppcost_tb  m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss ///
				m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m6_pppdocprolos_fri)) ///
				m12_ppptbprolos_fri ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_pppdocprolos_fri) omit(d0_eq1 ///
				d0_eq2 d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_vas m6_eq1 m6_eq2 m6_eq3 m6_eq4 ///
				m6_eq5 m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob ///
                m12_vas m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_eq5 pppcost_tb m6_ppptbprolos_fri ///
                m12_pppcost_ss m12_pppexp_ss m6_pppexp_ss)) ///
				m12_pppdocprolos_fri ///
		(pmm, knn(10) cond(if death ==0 | death ==4) omit(d0_eq1 d0_eq2 d0_pppexp_ss ///
				d0_eq4 d0_eq3 d0_eq5 pppcost_bs m6_pppexp_tob m6_vas m6_eq1 ///
				m6_eq2 m6_eq3 m6_eq4 m6_eq5 m6_pppcost_doc m6_pppcost_hos ///
                m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m6_tbsc ///
				m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_eq5 pppcost_tb m12_pppcost_ss ///
				m12_pppexp_ss m6_pppexp_ss m6_ppptbprolos_fri m6_pppdocprolos_fri)) ///
				m12_pppprolos_sick ///
		(pmm, knn(10) cond(if death ==0 | death ==4) include(d0_vas num_sae) omit(d0_eq1 d0_eq2 ///
				d0_pppexp_ss d0_eq4 d0_eq3 d0_eq5 pppcost_bs d0_pppprolos_sick ///
				m6_pppprolos_sick m6_pppexp_tob m6_eq1 m6_eq2 m6_eq3 m6_eq4 m6_eq5 ///
				m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb m6_pppcost_ss m6_pppexp_doc ///
				m6_pppexp_hos m6_tbsc m12_pppprolos_sick m12_pppcost_doc m12_pppexp_doc ///
                m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb m12_pppexp_tob m12_ppptbprolos_fri ///
                m12_pppdocprolos_fri pppcost_tb m6_ppptbprolos_fri m12_pppcost_ss ///
				m6_pppdocprolos_fri m12_pppexp_ss m6_pppexp_ss)) ///
				m12_vas ///
		(pmm, knn(10) cond(if death ==0 | death ==4) omit(d0_pppexp_ss pppcost_bs d0_pppprolos_sick ///
                m6_pppprolos_sick m6_pppexp_tob m6_pppcost_doc m6_pppcost_hos m6_pppexp_tb ///
				m6_pppcost_ss m6_pppexp_doc m6_pppexp_hos m6_tbsc m12_pppprolos_sick ///
				m12_pppcost_doc m12_pppexp_doc m12_pppcost_hos m12_pppexp_hos m12_pppexp_tb ///
				m12_pppexp_tob m12_ppptbprolos_fri m12_pppdocprolos_fri pppcost_tb ///
				m6_ppptbprolos_fri m12_pppcost_ss m6_pppdocprolos_fri m12_pppexp_ss ///
				m6_pppexp_ss m6_vas) include(num_sae)) m12_eq1 m12_eq2 m12_eq3 m12_eq4 m12_eq5 ///
		= d0_sdh_age i.d0_sdh_gender i.d0_isco d0_smoke_years i.m6_quit_sqd_biox i.m12_quit_sqd_biox i.m6_tbsuccess ///
		i.d0_siteid i.country, add(15) rseed(999) by(alloc)
		

mi passive: replace cost_tb = pppcost_tb * 29.3 if country == 1
mi passive: replace cost_tb = pppcost_tb * 30.9 if country == 2

mi passive: replace cost_bs = pppcost_bs * 29.3 if country == 1
mi passive: replace cost_bs = pppcost_bs * 30.9 if country == 2

local name "cost_doc cost_hos cost_ss exp_tb exp_ss exp_doc exp_hos exp_tob tbprolos_fri docprolos_fri prolos_sick"
foreach n of local name {
	mi passive: replace d0_`n' = d0_ppp`n' * 29.3 if country == 1
	mi passive: replace d0_`n' = d0_ppp`n' * 30.9 if country == 2
	
	mi passive: replace m6_`n' = m6_ppp`n' * 29.3 if country == 1
	mi passive: replace m6_`n' = m6_ppp`n' * 30.9 if country == 2
	
	mi passive: replace m12_`n' = m12_ppp`n' * 29.3 if country == 1
	mi passive: replace m12_`n' = m12_ppp`n' * 30.9 if country == 2
}

mi passive: replace d0_pppcost_hc = d0_pppcost_doc + d0_pppcost_hos
mi passive: replace m6_pppcost_hc = m6_pppcost_doc + m6_pppcost_hos
mi passive: replace m12_pppcost_hc = m12_pppcost_doc + m12_pppcost_hos

mi passive: replace d0_pppexp_hc = d0_pppexp_doc + d0_pppexp_hos
mi passive: replace m6_pppexp_hc = m6_pppexp_doc + m6_pppexp_hos
mi passive: replace m12_pppexp_hc = m12_pppexp_doc + m12_pppexp_hos

mi passive: gen d0_pppprolos = d0_ppptbprolos_fri + d0_pppdocprolos_fri + d0_pppprolos_sick
mi passive: gen m6_pppprolos = m6_ppptbprolos_fri + m6_pppdocprolos_fri + m6_pppprolos_sick
mi passive: gen m12_pppprolos = m12_ppptbprolos_fri + m12_pppdocprolos_fri + m12_pppprolos_sick

mi passive: gen d0_pppcost_noint = d0_pppcost_hc + d0_pppcost_ss
mi passive: gen m6_pppcost_noint = m6_pppcost_hc + m6_pppcost_ss
mi passive: gen m12_pppcost_noint = m12_pppcost_hc + m12_pppcost_ss

mi passive: gen d0_pppexp_all = d0_pppexp_hc + d0_pppexp_ss + d0_pppexp_tob + d0_pppexp_tb
mi passive: gen m6_pppexp_all = m6_pppexp_hc + m6_pppexp_ss + m6_pppexp_tob + m6_pppexp_tb
mi passive: gen m12_pppexp_all = m12_pppexp_hc + m12_pppexp_ss + m12_pppexp_tob + m12_pppexp_tb

local name "cost_hc exp_hc"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		mi passive: replace `t'_`n' = `t'_ppp`n' * 29.3 if country == 1
		mi passive: replace `t'_`n' = `t'_ppp`n' * 30.9 if country == 2
	}
}

local name "prolos cost_noint exp_all"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		mi passive: gen `t'_`n' = `t'_ppp`n' * 29.3 if country == 1
		mi passive: replace `t'_`n' = `t'_ppp`n' * 30.9 if country == 2
	}
}

local name "cost_noint exp_all prolos"
foreach n of local name {
	mi passive: gen trial_ppp`n' = m6_ppp`n' + m12_ppp`n'
	mi passive: gen trial_`n' = trial_ppp`n' * 29.3 if country == 1
	mi passive: replace trial_`n' = trial_ppp`n' * 30.9 if country == 2
}

mi passive: gen pppcost_int = pppcost_cytisine_disp + pppcost_bs + pppcost_training + pppcost_leaflet
mi passive: gen cost_int = cost_cytisine_disp + cost_bs + cost_training + cost_leaflet

mi passive: gen trial_pppcost = pppcost_int + pppcost_tb + trial_pppcost_noint
mi passive: gen trial_cost = cost_int + cost_tb + trial_cost_noint

mi passive: gen trial_pppexp_tob = m6_pppexp_tob + m12_pppexp_tob
mi passive: gen trial_exp_tob = m6_exp_tob + m12_exp_tob


mi estimate: mean pppcost_cytisine_disp, over(alloc)

mi estimate: mean pppcost_bs, over(alloc)

mi est: mean pppcost_training, over(alloc)
mi est: mean pppcost_leaflet, over(alloc)
mi estimate: mean pppcost_int, over(alloc)

mi estimate: mean pppcost_tb, over(alloc)

local name "ss doc hos hc noint"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`t' pppcost `n'"
		mi estimate: mean `t'_pppcost_`n', over(alloc)
	}
}


mi estimate: mean trial_pppcost_noint, over(alloc)
mi estimate: mean trial_pppcost, over(alloc)

local name "tb ss doc hos tob hc all"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`t' pppexp `n'"
		mi estimate: mean `t'_pppexp_`n', over(alloc)
	}
}


mi estimate: mean trial_pppexp_tob, over(alloc)
mi estimate: mean trial_pppexp_all, over(alloc)

local time "d0 m6 m12"
foreach t of local time {
	display "`t' TB pppprolos friend"
	mi estimate: mean `t'_ppptbprolos_fri, over(alloc)
	display "`t' doc pppprolos friend"
	mi estimate: mean `t'_pppdocprolos_fri, over(alloc)
	display "`t' pppprolos sick leave"
	mi estimate: mean `t'_pppprolos_sick, over(alloc)
	display "`t' pppprolos"
	mi estimate: mean `t'_pppprolos, over(alloc)
}

mi estimate: mean trial_pppprolos, over(alloc)

local time "d0 m6 m12"
foreach t of local time {
	display "`t' TB pppprolos friend"
	mi estimate: mean `t'_ppptbprolos_fri if death == 0, over(alloc)
	display "`t' doc pppprolos friend"
	mi estimate: mean `t'_pppdocprolos_fri if death == 0, over(alloc)
	display "`t' pppprolos sick leave"
	mi estimate: mean `t'_pppprolos_sick if death == 0, over(alloc)
	display "`t' productivity loss"
	mi est: mean `t'_pppprolos if death == 0, over(alloc)
}
mi estimate: mean trial_pppprolos if death == 0, over(alloc)

*************************************************************************************
mi estimate: mean cost_cytisine_disp if country == 1, over(alloc)
mi estimate: mean cost_bs if country == 1, over(alloc)
mi estimate: mean cost_tb if country == 1, over(alloc)
mi est: mean cost_training if country == 1, over(alloc)
mi est: mean cost_leaflet if country == 1, over(alloc)
mi estimate: mean cost_int if country == 1, over(alloc)

****at least one mi set imputes placebo all zero cost ss, drop from command
local name "doc hos hc noint"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`t' cost `n'"
		mi estimate: mean `t'_cost_`n' if country == 1, over(alloc)
	}
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' cost ss"
	mi est: mean `t'_cost_ss if country == 1, over(alloc)
}

mi estimate: mean trial_cost_noint if country == 1, over(alloc)
mi estimate: mean trial_cost if country == 1, over(alloc)

****at least one mi set imputes placebo all zero exp ss, drop from command 
local name "tb doc hos tob hc all"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`t' exp `n'"
		mi estimate: mean `t'_exp_`n' if country == 1, over(alloc)
	}
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' exp ss"
	mi est: mean `t'_exp_ss if country == 1, over(alloc)
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' exp notob"
	mi est: mean `t'_exp_notob if country == 1, over(alloc)
}

mi estimate: mean trial_exp_tob if country == 1, over(alloc)
mi estimate: mean trial_exp_all if country == 1, over(alloc)
mi estimate: mean trial_exp_notob if country == 1, over(alloc)

local time "d0 m6 m12"
foreach t of local time {
	display "`t' TB prolos friend"
	mi estimate: mean `t'_tbprolos_fri if country == 1, over(alloc)
	display "`t' doc prolos friend"
	mi estimate: mean `t'_docprolos_fri if country == 1, over(alloc)
	display "`t' prolos sick leave"
	mi estimate: mean `t'_prolos_sick if country == 1, over(alloc)
	display "`t' prolos"
	mi estimate: mean `t'_prolos if country == 1, over(alloc)
}

mi estimate: mean trial_prolos if country == 1, over(alloc)


*********************************************************************************

mi estimate: mean cost_cytisine_disp if country == 2, over(alloc)
mi estimate: mean cost_bs if country == 2, over(alloc)
mi estimate: mean cost_tb if country == 2, over(alloc)
mi est: mean cost_training if country == 2, over(alloc)
mi est: mean cost_leaflet if country == 2, over(alloc)
mi estimate: mean cost_int if country == 2, over(alloc)

local name "ss doc hos hc noint"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`t' cost `n'"
		mi estimate: mean `t'_cost_`n' if country == 2, over(alloc)
	}
}

mi estimate: mean trial_cost_noint if country == 2, over(alloc)
mi estimate: mean trial_cost if country == 2, over(alloc)

****at least one mi set imputes placebo all zero exp hos, drop from command 
local name "ss tb doc tob hc all"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		display "`t' exp `n'"
		mi estimate: mean `t'_exp_`n' if country == 2, over(alloc)
	}
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' exp hos"
	mi est: mean `t'_exp_hos if country == 2, over(alloc)
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' exp notob"
	mi est: mean `t'_exp_notob if country == 2, over(alloc)
}

mi estimate: mean trial_exp_tob if country == 2, over(alloc)
mi estimate: mean trial_exp_all if country == 2, over(alloc)
mi estimate: mean trial_exp_notob if country == 2, over(alloc)

local time "d0 m6 m12"
foreach t of local time {
	display "`t' TB prolos friend"
	mi estimate: mean `t'_tbprolos_fri if country == 2, over(alloc)
	display "`t' doc prolos friend"
	mi estimate: mean `t'_docprolos_fri if country == 2, over(alloc)
	display "`t' prolos sick leave"
	mi estimate: mean `t'_prolos_sick if country == 2, over(alloc)
	display "`t' prolos"
	mi estimate: mean `t'_prolos if country == 2, over(alloc)
}

mi estimate: mean trial_prolos if country == 2, over(alloc)

********************************************************************************
***6 month primary**********
mi passive: gen trial_cost_m6 = cost_int + cost_tb + m6_cost_noint
mi passive: gen trial_pppcost_m6 = pppcost_int + pppcost_tb + m6_pppcost_noint
mi est: mean trial_pppcost_m6, over(alloc)
***non-tobacco expense******
mi passive: gen d0_exp_notob = d0_exp_all - d0_exp_tob
mi passive: gen d0_pppexp_notob = d0_pppexp_all - d0_pppexp_tob
mi passive: gen m6_exp_notob = m6_exp_all - m6_exp_tob
mi passive: gen m6_pppexp_notob = m6_pppexp_all - m6_pppexp_tob
mi passive: gen m12_exp_notob = m12_exp_all - m12_exp_tob
mi passive: gen m12_pppexp_notob = m12_pppexp_all - m12_pppexp_tob
mi passive: gen trial_exp_notob = trial_exp_all - trial_exp_tob
mi passive: gen trial_pppexp_notob = trial_pppexp_all - trial_pppexp_tob

mi est: mean d0_pppexp_notob, over(alloc)
mi est: mean m6_pppexp_notob, over(alloc)
mi est: mean m12_pppexp_notob, over(alloc)

mi est: mean trial_pppexp_notob, over(alloc)

****TB*********************

mi passive: gen tbsc_impr = d0_tbsc - m6_tbsc

replace tbsc_impr = . if _mi_m == 0 & m6_tbsc == 9

mi est: mean trial_pppcost_m6, over(alloc)

mi estimate: mean m6_quit_sqd_biox, over(alloc)
tab m6_quit_sqd_biox alloc if _mi_m == 0

mi estimate: mean m12_quit_sqd_biox, over(alloc)
tab m12_quit_sqd_biox alloc if _mi_m == 0

recode m6_tbcure 2=0
mi estimate: mean m6_tbcure, over(alloc)
tab m6_tbcure alloc if _mi_m == 0

recode m6_tbsuccess 2=0
mi estimate: mean m6_tbsuccess, over(alloc)
tab m6_tbsuccess alloc if _mi_m == 0

mi estimate: mean d0_tbsc if m6_tbsc !=9, over(alloc)
mi estimate: mean m6_tbsc if m6_tbsc !=9, over(alloc)
mi estimate: mean tbsc_impr if m6_tbsc !=9, over(alloc)
mi est: mean trial_pppcost_m6 if m6_tbsc != 9, over(alloc)

mi est: mean tbsc_impr if mistab_m6_tbsc == 0 & m6_tbsc! = 9, over(alloc)
mi est: mean trial_pppcost_m6 if mistab_m6_tbsc == 0  & m6_tbsc! = 9, over(alloc)

************************************************************
mi est: mean trial_cost_m6 if country == 1, over(alloc)

mi estimate: mean m6_quit_sqd_biox if country == 1, over(alloc)
tab m6_quit_sqd_biox alloc if _mi_m == 0 & country == 1

mi estimate: mean m12_quit_sqd_biox if country == 1, over(alloc)
tab m12_quit_sqd_biox alloc if _mi_m == 0 & country == 1

mi estimate: mean m6_tbcure if country == 1, over(alloc)
tab m6_tbcure alloc if _mi_m == 0 & country == 1

mi estimate: mean m6_tbsuccess if country == 1, over(alloc)
tab m6_tbsuccess alloc if _mi_m == 0 & country == 1

mi est: mean d0_exp_notob if country == 1, over(alloc)
mi est: mean m6_exp_notob if country == 1, over(alloc)
mi est: mean m12_exp_notob if country == 1, over(alloc)

mi estimate: mean d0_tbsc if m6_tbsc !=9 & country == 1, over(alloc)
mi estimate: mean m6_tbsc if m6_tbsc !=9 & country == 1, over(alloc)
mi estimate: mean tbsc_impr if m6_tbsc !=9 & country == 1, over(alloc)
mi est: mean trial_cost_m6 if m6_tbsc != 9 & country == 1, over(alloc)

mi est: mean tbsc_impr if mistab_m6_tbsc == 0 & country == 1 & m6_tbsc != 9, over(alloc)
mi est: mean trial_cost_m6 if mistab_m6_tbsc == 0 & country == 1 & m6_tbsc != 9, over(alloc)

mi est: mean trial_exp_notob if country == 1, over(alloc)

**********************************************************************
mi est: mean trial_cost_m6 if country == 2, over(alloc)

mi estimate: mean m6_quit_sqd_biox if country == 2, over(alloc)
tab m6_quit_sqd_biox alloc if _mi_m == 0 & country == 2

mi estimate: mean m12_quit_sqd_biox if country == 2, over(alloc)
tab m12_quit_sqd_biox alloc if _mi_m == 0 & country == 2

mi estimate: mean m6_tbcure if country == 2, over(alloc)
tab m6_tbcure alloc if _mi_m == 0 & country == 2

mi estimate: mean m6_tbsuccess if country == 2, over(alloc)
tab m6_tbsuccess alloc if _mi_m == 0 & country == 2

mi est: mean d0_exp_notob if country == 2, over(alloc)
mi est: mean m6_exp_notob if country == 2, over(alloc)
mi est: mean m12_exp_notob if country == 2, over(alloc)

mi estimate: mean d0_tbsc if m6_tbsc !=9 & country == 2, over(alloc)
mi estimate: mean m6_tbsc if m6_tbsc !=9 & country == 2, over(alloc)
mi estimate: mean tbsc_impr if m6_tbsc !=9 & country == 2, over(alloc)
mi est: mean trial_cost_m6 if m6_tbsc != 9 & country == 2, over(alloc)

mi est: mean tbsc_impr if mistab_m6_tbsc == 0 & country == 2 & m6_tbsc != 9, over(alloc)
mi est: mean trial_cost_m6 if mistab_m6_tbsc == 0 & country == 2 & m6_tbsc != 9, over(alloc)

mi est: mean trial_exp_notob if country == 2, over(alloc)


