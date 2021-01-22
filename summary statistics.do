******death costs replace.dta********************************
local name "pubdoc privdoc pubhos privhos"
foreach n of local name {
	replace m6_`n' = 0 if death == 1 | death == 2
	replace m12_`n' = 0 if death == 1 | death == 2 | death == 3
}

*******summary of resources use************************
local name "pubdoc privdoc pubhos privhos"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		dis "0 `t' `n'"
		tab alloc country if `t'_`n' == 0
		dis "missing `t' `n'"
		tab alloc country if mi(`t'_`n')
		dis "`t' `n'"
		table alloc country if `t'_`n' != 0, c(n `t'_`n' med `t'_`n' p25 `t'_`n' p75 `t'_`n') col
	}
}

******summary of smoking cessation service*******************
local name "pubadv privadv pubcoun privcoun rxnrt tradmed"
foreach n of local name {
	local time "d0 m6 m12"
	foreach t of local time {
		dis "`t' `n'"
		table alloc country if `t'_ss`n' != 0, c(n `t'_ss`n' min `t'_ss`n' max `t'_ss`n') col
	}
}

***ec refill only appear in m6, traditional medicine only in m6 & m12
table alloc country if m6_ssrefillec != 0, c(n m6_ssrefillec min m6_ssrefillec max m6_ssrefillec) col
table alloc country if m6_sstradmed != 0, c(n m6_sstradmed min m6_sstradmed max m6_sstradmed) col
table alloc country if m12_sstradmed != 0, c(n m12_sstradmed min m12_sstradmed max m12_sstradmed) col

*******costs**************************************
local time "d0 m6 m12"
foreach t of local time {
	local name "doc hos ss"
	foreach n of local name {
		display "`t' cost `n'"
		table alloc country, c(n `t'_cost_`n' mean `t'_cost_`n' sd `t'_cost_`n')
		display "`t' PPP adjusted cost `n'"
		table alloc country, c(n `t'_pppcost_`n' mean `t'_pppcost_`n' sd `t'_pppcost_`n') col
	}
}


************TB treatment**********************************
bysort alloc: tab tbmed_phase country, m

table alloc country, c(n cost_tb mean cost_tb sd cost_tb)
table alloc country, c(n pppcost_tb mean pppcost_tb sd pppcost_tb) col

***************OOP********************************************

local time "d0 m6 m12"
foreach t of local time {
	local name "tb ss doc hos"
	foreach n of local name {
		display "`t' OOP `n'"
		table alloc country, c(n `t'_exp_`n' mean `t'_exp_`n' sd `t'_exp_`n')
		display "`t' PPP adjusted OOP `n'"
		table alloc country, c(n `t'_pppexp_`n' mean `t'_pppexp_`n' sd `t'_pppexp_`n') col
	}
}

local time "d0 m6 m12"
foreach t of local time {
	display "`t' OOP tobacco"
	table alloc country, c(n `t'_exp_tob mean `t'_exp_tob sd `t'_exp_tob)
	display "`t' PPP adjusted OOP tobacco"
	table alloc country, c(n `t'_pppexp_tob mean `t'_pppexp_tob sd `t'_pppexp_tob) col
}

*********Productivity loss***************************************

local time "d0 m6 m12"
foreach t of local time {
	display "`t' productivity loss by relative/friends due to TB"
	table alloc country, c(n `t'_tbprolos_fri mean `t'_tbprolos_fri sd `t'_tbprolos_fri)
	display "`t' PPP adjusted productivity loss by relative/friends due to TB"
	table alloc country, c(n `t'_ppptbprolos_fri mean `t'_ppptbprolos_fri sd `t'_ppptbprolos_fri) col
	
	display "`t' productivity loss by relative/friends due to doctor visit"
	table alloc country, c(n `t'_docprolos_fri mean `t'_docprolos_fri sd `t'_docprolos_fri)
	display "`t' PPP adjusted productivity loss by relative/friends due to doctor visit"
	table alloc country, c(n `t'_pppdocprolos_fri mean `t'_pppdocprolos_fri sd `t'_pppdocprolos_fri) col
	
	display "`t' productivity loss by participants due to sick leave"
	table alloc country, c(n `t'_prolos_sick mean `t'_prolos_sick sd `t'_prolos_sick)
	display "`t' PPP adjusted productivity loss by participants due to sick leave"
	table alloc country, c(n `t'_pppprolos_sick mean `t'_pppprolos_sick sd `t'_pppprolos_sick) col
}

**********EQ5D**********************************************

local time "d0 m6 m12"
foreach t of local time {
	display "`t' VAS"
	table alloc country, c(n `t'_vas mean `t'_vas sd `t'_vas) col
}

local time "d0 m6 m12"
foreach t of local time {
	foreach n of numlist 1/5 {
		display "`t' EQ-`n'"
		bysort alloc: tab `t'_eq`n' country
	}
}


**********TB score**********************************************
table alloc country, c(n d0_tbsc mean d0_tbsc sd d0_tbsc) col

table alloc country if m6_tbsc != 9, c(n m6_tbsc mean m6_tbsc sd m6_tbsc) col

