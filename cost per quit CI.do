*********cost per quitter***************************
gen CpQuit6int = bootsCint / bootsQ6int
gen CpQuit6con = bootsCcon / bootsQ6con

gen CpQuit12int = bootsCint / bootsQ12int
gen CpQuit12con = bootsCcon / bootsQ12con

gen CpTBcInt = bootsTCint / bootsTBcInt
gen CpTBcCon = bootsTCcon / bootsTBcCon

gen CpTBsInt = bootsTCint / bootsTBsInt
gen CpTBsCon = bootsTCcon / bootsTBsCon

gen CptbscInt = bootsTCintD / bootstbscInt
gen CptbscCon = bootsTCconD / bootstbscCon

local name "Quit6int Quit6con Quit12int Quit12con TBcInt TBcCon TBsInt TBsCon tbscInt tbscCon"
foreach n of local name {
	display "Cost per `n'"
	sort Cp`n'
	list Cp`n' in 125
	list Cp`n' in 4875
}

***********int cost difference and CI*****************
gen diffCint = bootsCint - bootsCcon
sort diffCint
list diffCint in 125
list diffCint in 4875
