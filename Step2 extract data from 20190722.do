******tbt_master_healtheco_20190722************************

****drug compliance******************
egen w5_sdc_diff = diff(w5_sdc_days1 w5_sdc_days2)
replace w5_sdc_diff = 2 if mi(w5_sdc_days1) | mi(w5_sdc_days2)
replace w5_sdc_diff = 3 if mi(w5_sdc_days1) & mi(w5_sdc_days2)
tab w5_sdc_diff

sum w5_sdc_days1 if w5_sdc_diff == 2

sum w9_sdc_days1 if w5_sdc_diff == 2


***********SAE*************************

egen num_sae = rownonmiss(sae1_daterep_1 sae2_daterep_1 sae3_daterep_1)
tab num_sae

count if sae1_daterep_1 < m6_ref
count if sae1_daterep_1 > m6_ref & !mi(sae1_daterep_1)
count if sae1_daterep_1 == m6_ref

tab sae1_class1_1 if sae1_daterep_1 < m6_ref
tab sae2_class1_1 if sae2_daterep_1 < m6_ref
tab sae3_class1_1 if sae3_daterep_1 < m6_ref

tab sae1_class1_1 sae1_class3_1 if sae1_daterep_1 < m6_ref
tab sae2_class1_1 if sae2_daterep_1 < m6_ref
tab sae3_class1_1 if sae3_daterep_1 < m6_ref

gen saehos = 1 if sae1_daterep_1 < m6_ref & sae1_class3_1 == 1
replace saehos = 1 if sae1_daterep_1 < m6_ref & sae1_class4_1 == 1
replace saehos = 1 if sae2_daterep_1 < m6_ref & sae2_class3_1 == 1
replace saehos = 1 if sae2_daterep_1 < m6_ref & sae2_class4_1 == 1
replace saehos = 1 if sae3_daterep_1 < m6_ref & sae3_class3_1 == 1
replace saehos = 1 if sae3_daterep_1 < m6_ref & sae3_class4_1 == 1

replace saehos = 2 if sae1_daterep_1 > m6_ref & !mi(sae1_daterep_1) & sae1_class3_1 == 1
replace saehos = 2 if sae1_daterep_1 > m6_ref & !mi(sae1_daterep_1) & sae1_class4_1 == 1
replace saehos = 2 if sae2_daterep_1 > m6_ref & !mi(sae2_daterep_1) & sae2_class3_1 == 1
replace saehos = 2 if sae2_daterep_1 > m6_ref & !mi(sae2_daterep_1) & sae2_class4_1 == 1
replace saehos = 2 if sae3_daterep_1 > m6_ref & !mi(sae3_daterep_1) & sae3_class3_1 == 1
replace saehos = 2 if sae3_daterep_1 > m6_ref & !mi(sae3_daterep_1) & sae3_class4_1 == 1

label define saetime 1 "sae hos before m6" 2 "sae hos after m6"
label val saehos saetime

keep patid d0_costcytisine_* d5_costcytisine_* cost_cytisine_disp pppcost_cytisine_disp d5_datecomp num_sae saehos

****************quit status******************************************
keep patid m6_quit_sqd_bio m6_quit_sqd_biox m12_quit_sqd_bio m12_quit_sqd_biox m6_outcome ///
	m12_outcome cis_full_rip cis_full_dateofdeath

******************tb score*******************************************
keep patid d0_tbsc m6_tbsc
