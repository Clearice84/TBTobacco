keep if country == 1
keep if country == 2

gen _mj = _mi_m
gen _mi = _mi_id

keep patid trial_cost_m6 alloc d0_cost_noint d0_sdh_age d0_sdh_gender d0_siteid ///
	m6_qaly_zimbabwe utility_zimbabwe_d0 m6_exp_all m6_prols m6_qaly_uk ///
	m6_qaly_uk m6_qaly_thailand m6_qaly_thailand2 m6_qaly_malaysia m6_qaly_indonesia ///
	utility_thailand_d0 utility_malaysia_d0 utility_indonesia_d0 utility_thailand2_d0 ///
	utility_uk_d0 d0_exp_all trial_cost trial_exp_all qaly_zimbabwe ///
	qaly_uk qaly_thailand qaly_thailand2 qaly_malaysia qaly_indonesia _mi _mj
	
sysdir set PLUS "P:\\Documents\STATA\"
capture program drop myboot
program define myboot, rclass
	mim: reg trial_cost_m6 alloc d0_cost_noint
	ret sca TCD6 = el(e(MIM_Q),1,1)
	
	mim: reg m6_exp_all alloc d0_exp_all
	ret sca TED6 = el(e(MIM_Q),1,1)
	
	mim: reg m6_qaly_zimbabwe alloc utility_zimbabwe_d0
	ret sca QDz6 = el(e(MIM_Q),1,1)
	
	mim: reg m6_qaly_uk alloc utility_uk_d0
	ret sca QDu6 = el(e(MIM_Q),1,1)
	
	mim: reg m6_qaly_thailand alloc utility_thailand_d0
	ret sca QDt6 = el(e(MIM_Q),1,1)
	
	mim: reg m6_qaly_thailand2 alloc utility_thailand2_d0
	ret sca QDt26 = el(e(MIM_Q),1,1)
	
	mim: reg m6_qaly_malaysia alloc utility_malaysia_d0
	ret sca QDm6 = el(e(MIM_Q),1,1)
	
	mim: reg m6_qaly_indonesia alloc utility_indonesia_d0
	ret sca QDi6 = el(e(MIM_Q),1,1)
	
	mim: reg trial_cost alloc d0_cost_noint
	ret sca TCD12 = el(e(MIM_Q),1,1)
	
	mim: reg trial_exp_all alloc d0_exp_all
	ret sca TED12 = el(e(MIM_Q),1,1)
	
	mim: reg qaly_zimbabwe alloc utility_zimbabwe_d0
	ret sca QDz12 = el(e(MIM_Q),1,1)
	
	mim: reg qaly_uk alloc utility_uk_d0
	ret sca QDu12 = el(e(MIM_Q),1,1)
	
	mim: reg qaly_thailand alloc utility_thailand_d0
	ret sca QDt12 = el(e(MIM_Q),1,1)
	
	mim: reg qaly_thailand2 alloc utility_thailand2_d0
	ret sca QDt212 = el(e(MIM_Q),1,1)
	
	mim: reg qaly_malaysia alloc utility_malaysia_d0
	ret sca QDm12 = el(e(MIM_Q),1,1)
	
	mim: reg qaly_indonesia alloc utility_indonesia_d0
	ret sca QDi12 = el(e(MIM_Q),1,1)
	
end

set seed 12345
bootstrap bootsTCD6=r(TCD6) bootsTED6=r(TED6) bootsQDz6=r(QDz6) bootsQDu6=r(QDu6) ///
	bootsQDt6=r(QDt6) bootsQDt26=r(QDt26) bootsQDm6=r(QDm6) bootsQDi6=r(QDi6) bootsTCD12=r(TCD12) ///
	bootsTED12=r(TED12) bootsQDz12=r(QDz12) bootsQDu12=r(QDu12) bootsQDt12=r(QDt12) ///
	bootsQDt212=r(QDt212) bootsQDm12=r(QDm12) bootsQDi12=r(QDi12), rep(50) cluster(_mi) strata(alloc) ///
	saving (P:\\Documents\TB n Tobacco\Trial data\results\bootstrap MI test.dta, replace): myboot

	
*********************************************************************
local name "TCD TED QDz QDu QDt QDt2 QDm QDi"
foreach n of local name {
	replace boots`n'6 = 0 - boots`n'6
	replace boots`n'12 = 0 - boots`n'12
}


gen bootsICER6 = bootsTCD6/bootsQDz6
gen bootsICER12 = bootsTCD12/bootsQDz12


local name "TCD TED QDz QDu QDt QDt2 QDm QDi ICER"
foreach n of local name {
	foreach i of numlist 6 12 {
		dis "`n'`i'"
		sort boots`n'`i'
		list boots`n'`i' in 125
		list boots`n'`i' in 4875
	}
}


********CEP*************
**check axis range
sum bootsTCD6 bootsQDz6

twoway (scatter bootsTCD6 bootsQDz6,msize(Small)), ///
	ytitle(Incremental Costs) yscale(range(-200 1600))yline(0) ylabel(-200(400)1600) ///
	xtitle(Incremental QALY) xscale(range(-0.010 0.005)) xline(0) xlabel(-0.010(0.003)0.005) ///
	title(Cost-effectiveness plane) 

****CEAC***
matrix CEAC = J(100000/600,2,0)
local ind = 0
local lambda = 0
while `lambda'<= 100000 {
 local ind=`ind'+1  
 local lambda= `lambda'+600  
*INDI represents a cost-effectiveness realisation*

qui gen INDI=(bootsICER6<`lambda') if bootsQDz6>0
qui replace INDI=(bootsICER6>`lambda') if bootsQDz6<0
qui sum INDI if bootsICER6<.
matrix CEAC [`ind',1]=`lambda'  
matrix CEAC [`ind',2]= `r(mean)'  
drop INDI 
}
svmat CEAC  

twoway (line CEAC2 CEAC1), ytitle(Probability cost-effective) yscale(range(0 1)) ///
yline(0.5, lpattern(dash) lcolor(black)) ylabel(0  (0.2) 1, labsize(medsmall) ///
format(%02.1f)) xtitle(Willingness to pay) xscale(range(0 100000)) ///
xlabel(0 (10000) 100000, labsize(medsmall) angle(forty_five) format(%9.0fc)) ///
 xline(10400, lpattern(dash))  xline(71200, lpattern(dash)) title(Cost-effectiveness acceptability curve)  

drop CEAC*

********CEP*************
**check axis range
sum bootsTCD12 bootsQDz12

twoway (scatter bootsTCD12 bootsQDz12,msize(Small)), ///
	ytitle(Incremental Costs) yscale(range(-200 1600))yline(0) ylabel(-200(200)1600) ///
	xtitle(Incremental QALY) xscale(range(-0.04 0.02)) xline(0) xlabel(-0.04(0.01)0.02) ///
	title(Cost-effectiveness plane) 

****CEAC***
matrix CEAC = J(100000/600,2,0)
local ind = 0
local lambda = 0
while `lambda'<= 100000 {
 local ind=`ind'+1  
 local lambda= `lambda'+600  
*INDI represents a cost-effectiveness realisation*

qui gen INDI=(bootsICER6<`lambda') if bootsQDz12>0
qui replace INDI=(bootsICER6>`lambda') if bootsQDz12<0
qui sum INDI if bootsICER12<.
matrix CEAC [`ind',1]=`lambda'  
matrix CEAC [`ind',2]= `r(mean)'  
drop INDI 
}
svmat CEAC  

twoway (line CEAC2 CEAC1), ytitle(Probability cost-effective) yscale(range(0 1)) ///
yline(0.5, lpattern(dash) lcolor(black)) ylabel(0  (0.2) 1, labsize(medsmall) ///
format(%02.1f)) xtitle(Willingness to pay (Rs)) xscale(range(0 100000)) ///
xlabel(0 (10000) 100000, labsize(medsmall) angle(forty_five) format(%9.0fc)) ///
 xline(10400, lpattern(dash))  xline(71200, lpattern(dash)) title(Cost-effectiveness acceptability curve) 
 
 
***************************CCA************************************************************************** 
capture program drop myboot
program define myboot, rclass
	sureg (trial_pppcost_m6 alloc d0_pppcost_noint) (m6_qaly_zimbabwe alloc utility_zimbabwe_d0)
	sca CD = el(r(table),1,1)
	sca QD = el(r(table),1,4)
end
bootstrap bootsCD=CD bootsQD=QD, rep(5000) strata(alloc country) ///
saving (P:\\Documents\TB n Tobacco\Trial data\bootstrap CCA.dta, replace): myboot

replace bootsCD = 0 - bootsCD
replace bootsQD = 0 - bootsQD

sort bootsCD
list bootsCD in 125
list bootsCD in 4875

sort bootsQD
list bootsQD in 125
list bootsQD in 4875

sum bootsCD bootsQD

twoway (scatter bootsCD bootsQD, msize(Small)), ///
	ytitle(Incremental Costs) yscale(range(-100 150))yline(0) ylabel(-100(50)150) ///
	xtitle(Incremental QALY) xscale(range(-0.005 0.003)) xline(0) xlabel(-0.005(0.001)0.003) ///
	title(Cost-effectiveness plane) 

**********************************
keep if country == 1
keep if country == 2

capture program drop myboot
program define myboot, rclass
	sureg (trial_cost_m6 alloc d0_cost_noint) (m6_qaly_zimbabwe alloc utility_zimbabwe_d0)
	sca CD = el(r(table),1,1)
	sca QD = el(r(table),1,4)
end
bootstrap bootsCD=CD bootsQD=QD, rep(5000) strata(alloc) ///
saving (P:\\Documents\TB n Tobacco\Trial data\bootstrap Bangladesh CCA.dta, replace): myboot

replace bootsCD = 0 - bootsCD
replace bootsQD = 0 - bootsQD

sort bootsCD
list bootsCD in 125
list bootsCD in 4875

sort bootsQD
list bootsQD in 125
list bootsQD in 4875

********CEP*************
**check axis range
sum bootsCD bootsQD

twoway (scatter bootsCD bootsQD, msize(Small)), ///
	ytitle(Incremental Costs) yscale(range(-200 1600))yline(0) ylabel(-200(600)1600) ///
	xtitle(Incremental QALY) xscale(range(-0.005 0.005)) xline(0) xlabel(-0.005(0.0025)0.005) ///
	title(Cost-effectiveness plane) 

***********************************************************************************************
keep if country == 1
keep if country == 2

gen _mj = _mi_m
gen _mi = _mi_id

keep patid trial_pppcost_m6 alloc _mi _mj tbsc_impr mistab_m6_tbsc m6_tbsc
	
sysdir set PLUS "P:\\Documents\STATA\"
capture program drop myboot
program define myboot, rclass

	mim: mean trial_pppcost_m6 if mistab_m6_tbsc == 0 & m6_tbsc != 9, over(alloc)
	sca TCintM = el(e(MIM_Q),1,1)
	sca TCconM = el(e(MIM_Q),1,2)
	
	mim: mean tbsc_impr if mistab_m6_tbsc == 0 & m6_tbsc != 9, over(alloc)
	sca tbscIntM = el(e(MIM_Q),1,1)
	sca tbscConM = el(e(MIM_Q),1,2)
	
end

set seed 12345
bootstrap bootsTCintM=TCintM bootsTCconM=TCconM bootstbscIntM=tbscIntM bootstbscConM=tbscConM, ///
	rep(5000) cluster(_mi) strata(alloc) ///
	saving (P:\\Documents\TB n Tobacco\Trial data\bootstrap MI cost tbsc without missing.dta, replace): myboot

gen CptbscIntM = bootsTCintM/bootstbscIntM
gen CptbscConM = bootsTCconM/bootstbscConM

sort CptbscIntM
list CptbscIntM in 125
list CptbscIntM in 4875

sort CptbscConM
list CptbscConM in 125
list CptbscConM in 4875

*************************************************************************************************

local name "CD ED QDz QDu QDt QDt2 QDm QDi"
foreach n of local name {
	replace boots`n'6 = 0 - boots`n'6
	replace boots`n'12 = 0 - boots`n'12
}



local name "CD ED QDz QDu QDt QDt2 QDm QDi"
foreach n of local name {
	foreach i of numlist 6 12 {
		dis "`n'`i'"
		sort boots`n'`i'
		list boots`n'`i' in 125
		list boots`n'`i' in 4875
	}
}
