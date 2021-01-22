********death costs replace/imputation************
gen cost_leaflet = 50 if country == 1
replace cost_leaflet = 5 if country == 2

gen pppcost_leaflet = cost_leaflet / 29.3 if country == 1
replace pppcost_leaflet = cost_leaflet / 30.9 if country == 2

gen cost_training = 398 if country == 1
replace cost_training = 287 if country == 2

gen pppcost_training = cost_training / 29.3 if country == 1
replace pppcost_training = cost_training / 30.9 if country == 2

********MI**************************
gen cost_leaflet = 50 if country == 1
replace cost_leaflet = 5 if country == 2

gen pppcost_leaflet = cost_leaflet / 29.3 if country == 1
replace pppcost_leaflet = cost_leaflet / 30.9 if country == 2

gen cost_training = 398 if country == 1
replace cost_training = 287 if country == 2

gen pppcost_training = cost_training / 29.3 if country == 1
replace pppcost_training = cost_training / 30.9 if country == 2

mi register regular pppcost_leaflet pppcost_training
mi register passive cost_leaflet cost_training

mi passive: replace pppcost_int = pppcost_int + pppcost_leaflet + pppcost_training
mi passive: replace cost_int = cost_int + cost_leaflet + cost_training

********CCA**************************
gen cost_leaflet = 50 if country == 1
replace cost_leaflet = 5 if country == 2

gen pppcost_leaflet = cost_leaflet / 29.3 if country == 1
replace pppcost_leaflet = cost_leaflet / 30.9 if country == 2

gen cost_training = 398 if country == 1
replace cost_training = 287 if country == 2

gen pppcost_training = cost_training / 29.3 if country == 1
replace pppcost_training = cost_training / 30.9 if country == 2

replace pppcost_int = pppcost_int + pppcost_leaflet + pppcost_training
replace cost_int = cost_int + cost_leaflet + cost_training
