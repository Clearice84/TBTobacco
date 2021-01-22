dotplot pppcost_tb if mistab_cost_tb | _mi_m == 0, over(_mi_m)
graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\ppp cost_tb.gph"

local name "cost_doc cost_hos cost_ss"
foreach n of local name {
	foreach i of numlist 6 12 {
		dotplot m`i'_ppp`n' if mistab_m`i'_`n' | _mi_m == 0, over(_mi_m)
		graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m`i' ppp`n'.gph"
	}
}

local name "exp_tb exp_doc exp_hos exp_ss exp_tob"
foreach n of local name {
	foreach i of numlist 6 12 {
		dotplot m`i'_ppp`n' if mistab_m`i'_`n' | _mi_m == 0, over(_mi_m)
		graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m`i' ppp`n'.gph"
	}
}

local name "tbprolos_fri docprolos_fri prolos_sick"
foreach n of local name {
	foreach i of numlist 6 12 {
		dotplot m`i'_ppp`n' if mistab_m`i'_`n' | _mi_m == 0, over(_mi_m)
		graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m`i' ppp`n'.gph"
	}
}

foreach n of numlist 1/5 {
	foreach i of numlist 6 12 {
		dotplot m`i'_eq`n' if (mistab_m`i'_eq`n' | _mi_m == 0) & m`i'_eq`n' != 0, over(_mi_m)
		graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m`i' eq`n'.gph"
	}
}

foreach i of numlist 6 12 {
	dotplot m`i'_vas if (mistab_m`i'_vas | _mi_m == 0) & m`i'_vas != 0, over(_mi_m)
	graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m`i' vas.gph"
}

dotplot m6_tbsc if (mistab_m6_tbsc | _mi_m == 0) & m6_tbsc != 9, over(_mi_m)
graph save Graph "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 TBsc.gph"

graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\ppp cost_tb.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppcost_doc.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppcost_hos.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppcost_ss.gph", c(2)

graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppcost_doc.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppcost_hos.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppcost_ss.gph", c(2)
	
graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppexp_tb.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppexp_doc.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppexp_hos.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppexp_ss.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppexp_tob.gph", c(2)

graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppexp_tb.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppexp_doc.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppexp_hos.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppexp_ss.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppexp_tob.gph", c(2)

graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 ppptbprolos_fri.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppdocprolos_fri.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 pppprolos_sick.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 ppptbprolos_fri.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppdocprolos_fri.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 pppprolos_sick.gph", c(2)

graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 eq1.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 eq2.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 eq3.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 eq4.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 eq5.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m6 vas.gph", c(2)
	
graph combine "P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 eq1.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 eq2.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 eq3.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 eq4.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 eq5.gph" ///
	"P:\\Documents\TB n Tobacco\Trial data\results\dotplot MI\m12 vas.gph", c(2)

