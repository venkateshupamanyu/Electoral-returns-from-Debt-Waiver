

clear
*import excel "Consolidation work.xlsx",sheet("Sheet9") firstrow
*import excel "Consolidation work 1.xlsx",sheet("Sheet1") firstrow
import excel "Consolidation work 1.xlsx",sheet("Sheet2") firstrow
import excel "Consolidation work 1.xlsx",sheet("Sheet3") firstrow

*** ordering variables and generating state and district IDs for fixed effects ***
*order state dist_name year dist_inc_votshr
sort state dist_name year 
egen state_code=group(state)
egen district_code=group(dist_name)
egen state_district_code=group(state dist_name)
order state_code state district_code dist_name

*** Summary of INC district vote share ***
summ dist_inc_votshr dist_incally_votshr dist_upa_votshr
count if dist_inc_votshr==.
count if dist_incally_votshr==.
count if dist_upa_votshr==.
*** Summary of district-level eligible proportion ***
summ indivnum_district_elig_prop2
count if indivnum_district_elig_prop2==.
*** Summary of eligibletotalpop and eligibleruralpop shares ***
summ eligibletotalpop eligibleruralpop


*** generating post-2008 dummy variable ***
tab year
gen post=1 if year==2009
replace post=0 if year==2004
tab post
tab year post

*** generating continuous interaction variable with post2008 and district eligible proportion ***
gen post_prop=post*indivnum_district_elig_prop
gen post_prop2=post*indivnum_district_elig_prop2

count if eligibletotalshare==""
count if eligibletotalshare=="-"
replace eligibletotalshare="." if eligibletotalshare==""
replace eligibletotalshare="." if eligibletotalshare=="-"
destring eligibletotalshare,replace 


count if eligibleruralshare==""
count if eligibleruralshare=="-"
replace eligibleruralshare="." if eligibleruralshare==""
replace eligibleruralshare="." if eligibleruralshare=="-"
destring eligibleruralshare,replace

gen post_prop=post*eligibletotalshare 
gen post_prop2=post*eligibleruralshare


/*
*** generating tercile based on district eligible proportion ***
xtile tercile=indivnum_district_elig_prop2,nq(3)
***generating tercile dummy variable using tercile values ***
tab tercile
gen tercile_1=1 if tercile==3
replace tercile_1=0 if tercile==1
tab tercile_1
count if tercile_1==.
tab tercile tercile_1

*** generating binary interaction variable with post2008 and district eligible proportion ***
gen post_tercile=post*tercile_1
tab year post_tercile
tab post post_tercile
tab post_tercile
count if tercile_1==1
count if post==1
count if tercile_1==1 & post==1
tab year
tab tercile
tab tercile_1

areg dist_inc_votshr     post_tercile i.year if inlist(tercile,1,3),absorb(district_code)
areg dist_incally_votshr post_tercile i.year if inlist(tercile,1,3),absorb(district_code)
areg dist_upa_votshr     post_tercile i.year if inlist(tercile,1,3),absorb(district_code)
*/

label var dist_inc_votshr "INC vote share"
label var dist_incally_votshr "INC-ally vote share"
label var dist_upa_votshr "UPA vote share"
label var post_prop "After 2008 x District eligibility proportion"
label var post_prop2 "After 2008 x District eligibility proportion2"

*** regression of INC district vote share with continuous interaction variable ***
areg dist_inc_votshr 	 post_prop i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop i.year,absorb(state_district_code)
areg dist_upa_votshr 	 post_prop i.year,absorb(state_district_code)

areg pc_dist_wgtseat_inc 	 post_prop i.year,absorb(state_district_code)
areg pc_dist_wgtseat_incally post_prop i.year,absorb(state_district_code)
areg pc_dist_wgtseat_upa 	 post_prop i.year,absorb(state_district_code)

areg pc_distvotes_wgtseat_inc  	  post_prop i.year,absorb(state_district_code)
areg pc_distvotes_wgtseat_incally post_prop i.year,absorb(state_district_code)
areg pc_distvotes_wgtseat_upa 	  post_prop i.year,absorb(state_district_code)







areg dist_inc_votshr post_prop i.year,absorb(district_code)
est store r1
areg dist_incally_votshr post_prop i.year,absorb(district_code)
est store r2
areg dist_upa_votshr post_prop i.year,absorb(district_code)
est store r3
outreg2 [r1 r2 r3] using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\r1.xls", drop(2009.year) label addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace

areg dist_inc_votshr post_prop2 i.year,absorb(district_code)
areg dist_incally_votshr post_prop2 i.year,absorb(district_code)
areg dist_upa_votshr post_prop2 i.year,absorb(district_code)


areg dist_inc_votshr eligibletotalpop post_prop i.year,absorb(district_code)
areg dist_incally_votshr eligibletotalpop post_prop i.year,absorb(district_code)
areg dist_upa_votshr eligibletotalpop post_prop i.year,absorb(district_code)

*** generate binary variables based on range ***
gen range1=0
replace range1=1 if eligibletotalpop<0.05
gen range2=0
replace range2=1 if eligibletotalpop>=0.05 & eligibletotalpop<0.1
gen range3=0
replace range3=1 if eligibletotalpop>=0.1 & eligibletotalpop<0.15
gen range4=0
replace range4=1 if eligibletotalpop>=0.15 & eligibletotalpop<0.2
gen range5=0
replace range5=1 if eligibletotalpop>=0.2 & eligibletotalpop<0.25
gen range6=0
replace range6=1 if eligibletotalpop>=0.25

gen post_range1=post*range1
gen post_range2=post*range2
gen post_range3=post*range3
gen post_range4=post*range4
gen post_range5=post*range5
gen post_range6=post*range6

areg dist_inc_votshr post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(district_code)
areg dist_incally_votshr post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(district_code)
areg dist_upa_votshr post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(district_code)

*** Separating the sample using median of district eligible proportion ***
*** Finding median for the district eligible proportion ***
summ indivnum_district_elig_prop2,de
di `r(p50)'
local median1=r(p50)
di `median1'

*** Regression for above median districts ***
areg dist_inc_votshr post_prop2 i.year if indivnum_district_elig_prop2>`median1',absorb(state_district_code)
areg dist_incally_votshr post_prop2 i.year if indivnum_district_elig_prop2>`median1',absorb(state_district_code)
areg dist_upa_votshr post_prop2 i.year if indivnum_district_elig_prop2>`median1',absorb(state_district_code)
est store r2
di `median1'
*** Regression for below median districts ***
areg dist_inc_votshr post_prop2 i.year if indivnum_district_elig_prop2<=`median1',absorb(state_district_code)
areg dist_incally_votshr post_prop2 i.year if indivnum_district_elig_prop2<=`median1',absorb(state_district_code)
areg dist_upa_votshr post_prop2 i.year if indivnum_district_elig_prop2<=`median1',absorb(state_district_code)
est store r3

summ indivnum_district_elig_prop2,de
gen above_median_distprop2=0
replace above_median_distprop2=1 if indivnum_district_elig_prop2>0.8373775
gen post_prop2_above_median_dprop2=post*indivnum_district_elig_prop2*above_median_distprop2

areg dist_inc_votshr     post_prop2_above_median_dprop2 i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop2_above_median_dprop2 i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop2_above_median_dprop2 i.year,absorb(state_district_code)

summ indivnum_district_elig_prop,de
gen above_median_distprop=0
replace above_median_distprop=1 if indivnum_district_elig_prop>0.0239525
gen post_prop2_above_median_dprop=post*indivnum_district_elig_prop2*above_median_distprop

areg dist_inc_votshr     post_prop2_above_median_dprop i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop2_above_median_dprop i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop2_above_median_dprop i.year,absorb(state_district_code)



/*
*** Regression of INC district vote share with binary interaction variable ***
areg distvotes_inc_votshr post_tercile i.year,absorb(district_code)
*** Regression for above median districts ***
areg distvotes_inc_votshr post_tercile i.year if indivnum_district_elig_prop2>`median1',absorb(district_code)
*** Regression for below median districts ***
areg distvotes_inc_votshr post_tercile i.year if indivnum_district_elig_prop2<=`median1',absorb(district_code)
*/

********************************************************************************
*** State renaming ***
tab state
replace state="ANDHRA PRADESH" if state=="S01 - Andhra Pradesh"
replace state="GUJARAT" if state=="S06 - Gujarat"
replace state="HARYANA" if state=="S07 - Haryana"
replace state="KARNATAKA" if state=="S10 - Karnataka"
replace state="MADHYA PRADESH" if state=="S12 - Madhya Pradesh"
replace state="ORISSA" if state=="S18 - Orissa"
replace state="RAJASTHAN" if state=="S20 - Rajasthan"
replace state="CHHATTISGARH" if state=="S26 - Chattisgarh"
replace state="JHARKHAND" if state=="S27 - Jharkhand"
replace state="UTTARAKHAND" if state=="Uttarakhand"
tab state
********************************************************************************




*** Party in power at states ***
gen ruling_state="INC" if inlist(state,"ARUNACHAL PRADESH","ANDHRA PRADESH","ASSAM","GOA","HARYANA","MANIPUR","MEGHALAYA","NAGALAND")
replace ruling_state="NDA" if inlist(state,"BIHAR","CHHATTISGARH","GUJARAT","HIMACHAL PRADESH","JHARKHAND")
replace ruling_state="NDA" if inlist(state,"MADHYA PRADESH","ORISSA","PUNJAB","S20 - Rajasthan","Uttarakhand")
replace ruling_state="UPA" if inlist(state,"KARNATAKA","MAHARASHTRA","TAMIL NADU")
replace ruling_state="OTH" if inlist(state,"KERALA","MIZORAM","SIKKIM","TRIPURA","UTTAR PRADESH","WEST BENGAL")
replace ruling_state="BJP" if inlist(state,"CHHATTISGARH","GUJARAT","HIMACHAL PRADESH","JHARKHAND","MADHYA PRADESH")
replace ruling_state="BJP" if inlist(state,"RAJASTHAN","UTTARAKHAND")

********************************************************************************
areg dist_inc_votshr post_prop i.year if ruling_state=="INC",absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if ruling_state=="INC",absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if ruling_state=="INC",absorb(state_district_code)
********************************************************************************
areg dist_inc_votshr post_prop i.year if inlist(ruling_state,"INC","UPA"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if inlist(ruling_state,"INC","UPA"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if inlist(ruling_state,"INC","UPA"),absorb(state_district_code)
********************************************************************************
areg dist_inc_votshr post_prop i.year if ruling_state=="BJP",absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if ruling_state=="BJP",absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if ruling_state=="BJP",absorb(state_district_code)
********************************************************************************
areg dist_inc_votshr post_prop i.year if inlist(ruling_state,"BJP","NDA"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if inlist(ruling_state,"BJP","NDA"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if inlist(ruling_state,"BJP","NDA"),absorb(state_district_code)
********************************************************************************

gen inc=0
replace inc=1 if inlist(ruling_state,"INC")
gen post_prop_inc=post_prop*inc
gen post_prop2_inc=post_prop2*inc

areg dist_inc_votshr     post_prop_inc i.year,absorb(state_district_code)
est store s1
areg dist_incally_votshr post_prop_inc i.year,absorb(state_district_code)
est store s2
areg dist_upa_votshr     post_prop_inc i.year,absorb(state_district_code)
est store s3
outreg2 [s1 s2 s3] using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\s1.xls", drop(2009.year) label addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace

********************************************************************************
gen upa=0
replace upa=1 if inlist(ruling_state,"INC","UPA")
gen post_prop_upa=post_prop*upa
gen post_prop2_upa=post_prop2*upa

areg dist_upa_votshr     post_prop_upa i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upa i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upa i.year,absorb(state_district_code)
********************************************************************************
gen upa1=0
replace upa1=1 if inlist(ruling_state,"UPA")
gen post_prop_upa1=post_prop*upa1
gen post_prop2_upa1=post_prop2*upa1

areg dist_upa_votshr     post_prop_upa1 i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upa1 i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upa1 i.year,absorb(state_district_code)
********************************************************************************
gen bjp=0
replace bjp=1 if inlist(ruling_state,"BJP")
gen post_prop_bjp=post_prop*bjp
gen post_prop2_bjp=post_prop2*bjp

areg dist_inc_votshr     post_prop_bjp i.year,absorb(state_district_code)
est store t1
areg dist_incally_votshr post_prop_bjp i.year,absorb(state_district_code)
est store t2
areg dist_upa_votshr     post_prop_bjp i.year,absorb(state_district_code)
est store t3
outreg2 [t1 t2 t3] using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\t1.xls", drop(2009.year) label addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace
********************************************************************************
gen nda=0
replace nda=1 if inlist(ruling_state,"BJP","NDA")
gen post_prop_nda=post_prop*nda
gen post_prop2_nda=post_prop2*nda

areg dist_inc_votshr     post_prop_nda i.year,absorb(state_district_code)
est store u1
areg dist_incally_votshr post_prop_nda i.year,absorb(state_district_code)
est store u2
areg dist_upa_votshr     post_prop_nda i.year,absorb(state_district_code)
est store u3
outreg2 [u1 u2 u3] using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\u1.xls", drop(2009.year) label addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace
********************************************************************************
gen oth=0
replace oth=1 if inlist(ruling_state,"OTH")
gen post_prop_oth=post_prop*oth
gen post_prop2_oth=post_prop2*oth

areg dist_inc_votshr     post_prop_oth i.year,absorb(state_district_code)
est store v1
areg dist_incally_votshr post_prop_oth i.year,absorb(state_district_code)
est store v2
areg dist_upa_votshr     post_prop_oth i.year,absorb(state_district_code)
est store v3
outreg2 [v1 v2 v3] using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\v1.xls", drop(2009.year) label addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace
********************************************************************************
gen upa_nda=1 if inlist(ruling_state,"INC","UPA")
replace upa_nda=0 if inlist(ruling_state,"NDA")
gen post_prop_upa_nda=post_prop*upa_nda

areg dist_inc_votshr     post_prop_upa_nda i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upa_nda i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upa_nda i.year,absorb(state_district_code)
********************************************************************************
gen inc_nda=1 if inlist(ruling_state,"INC")
replace inc_nda=0 if inlist(ruling_state,"NDA")
gen post_prop_inc_nda=post_prop*inc_nda

areg dist_inc_votshr     post_prop_inc_nda i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_inc_nda i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_inc_nda i.year,absorb(state_district_code)
********************************************************************************
gen inc_bjp=1 if inlist(ruling_state,"INC")
replace inc_bjp=0 if inlist(ruling_state,"BJP")
gen post_prop_inc_bjp=post_prop*inc_bjp

areg dist_inc_votshr     post_prop_inc_bjp i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_inc_bjp i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_inc_bjp i.year,absorb(state_district_code)
********************************************************************************
gen inc_oth=1 if inlist(ruling_state,"INC")
replace inc_oth=0 if inlist(ruling_state,"OTH")
gen post_prop_inc_oth=post_prop*inc_oth

areg dist_inc_votshr     post_prop_inc_oth i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_inc_oth i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_inc_oth i.year,absorb(state_district_code)
********************************************************************************
gen incoth_nda=1 if inlist(ruling_state,"INC","OTH")
replace incoth_nda=0 if inlist(ruling_state,"NDA")
gen post_prop_incoth_nda=post_prop*incoth_nda

areg dist_inc_votshr     post_prop_incoth_nda i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_incoth_nda i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_incoth_nda i.year,absorb(state_district_code)
********************************************************************************
gen upaoth_nda=1 if inlist(ruling_state,"INC","OTH","UPA")
replace upaoth_nda=0 if inlist(ruling_state,"NDA")
gen post_prop_upaoth_nda=post_prop*upaoth_nda

areg dist_inc_votshr     post_prop_upaoth_nda i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upaoth_nda i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upaoth_nda i.year,absorb(state_district_code)
********************************************************************************
gen upaoth_bjp=1 if inlist(ruling_state,"INC","OTH","UPA")
replace upaoth_bjp=0 if inlist(ruling_state,"BJP")
gen post_prop_upaoth_bjp=post_prop*upaoth_bjp

areg dist_inc_votshr     post_prop_upaoth_bjp i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upaoth_bjp i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upaoth_bjp i.year,absorb(state_district_code)
********************************************************************************
gen upaoth_bjpnda=1 if inlist(ruling_state,"INC","OTH","UPA")
replace upaoth_bjpnda=0 if inlist(ruling_state,"BJP","NDA")
gen post_prop_upaoth_bjpnda=post_prop*upaoth_bjpnda

areg dist_inc_votshr     post_prop_upaoth_bjpnda i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upaoth_bjpnda i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upaoth_bjpnda i.year,absorb(state_district_code)
********************************************************************************
gen inc_bjpoth=1 if inlist(ruling_state,"INC")
replace inc_bjpoth=0 if inlist(ruling_state,"BJP","OTH")
gen post_prop_inc_bjpoth=post_prop*inc_bjpoth

areg dist_inc_votshr     post_prop_inc_bjpoth i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_inc_bjpoth i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_inc_bjpoth i.year,absorb(state_district_code)
********************************************************************************
gen upa_bjpoth=1 if inlist(ruling_state,"INC","UPA")
replace upa_bjpoth=0 if inlist(ruling_state,"BJP","OTH")
gen post_prop_upa_bjpoth=post_prop*upa_bjpoth

areg dist_inc_votshr     post_prop_upa_bjpoth i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upa_bjpoth i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upa_bjpoth i.year,absorb(state_district_code)
********************************************************************************
gen upa_bjp=1 if inlist(ruling_state,"INC","UPA")
replace upa_bjp=0 if inlist(ruling_state,"BJP")
gen post_prop_upa_bjp=post_prop*upa_bjpoth

areg dist_inc_votshr     post_prop_upa_bjp i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_upa_bjp i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_upa_bjp i.year,absorb(state_district_code)
********************************************************************************

*** State-level beneficiaries as percentage of all beneficiaries in India ***
areg dist_inc_votshr post_prop i.year if inlist(state,"ANDHRA PRADESH","UTTAR PRADESH","MAHARASHTRA","ORISSA"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if inlist(state,"ANDHRA PRADESH","UTTAR PRADESH","MAHARASHTRA","ORISSA"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if inlist(state,"ANDHRA PRADESH","UTTAR PRADESH","MAHARASHTRA","ORISSA"),absorb(state_district_code)

*** above median states  - full waiver beneficiaries as proportion of all beneficiaries in India (1st column) ***
areg dist_inc_votshr post_prop i.year if (state=="ANDHRA PRADESH" | state=="UTTAR PRADESH" | state=="MAHARASHTRA" | state=="ORISSA" | state=="MADHYA PRADESH" | state=="BIHAR" | state=="WEST BENGAL" | state=="TAMIL NADU" | state=="KERALA" | state=="KARNATAKA" | state=="RAJASTHAN" | state=="JHARKHAND" | state=="GUJARAT"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if (state=="ANDHRA PRADESH" | state=="UTTAR PRADESH" | state=="MAHARASHTRA" | state=="ORISSA" | state=="MADHYA PRADESH" | state=="BIHAR" | state=="WEST BENGAL" | state=="TAMIL NADU" | state=="KERALA" | state=="KARNATAKA" | state=="RAJASTHAN" | state=="JHARKHAND" | state=="GUJARAT"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if (state=="ANDHRA PRADESH" | state=="UTTAR PRADESH" | state=="MAHARASHTRA" | state=="ORISSA" | state=="MADHYA PRADESH" | state=="BIHAR" | state=="WEST BENGAL" | state=="TAMIL NADU" | state=="KERALA" | state=="KARNATAKA" | state=="RAJASTHAN" | state=="JHARKHAND" | state=="GUJARAT"),absorb(state_district_code)

*** above median states - full waiver beneficiaries as proportion of all beneficiaries in State (2nd column) ***
areg dist_inc_votshr post_prop i.year if (state=="SIKKIM" | state=="MIZORAM" | state=="ASSAM" | state=="BIHAR" | state=="ORISSA" | state=="MEGHALAYA" | state=="JHARKHAND" | state=="HIMACHAL PRADESH" | state=="KERALA" | state=="MANIPUR" | state=="TRIPURA" | state=="WEST BENGAL"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if (state=="SIKKIM" | state=="MIZORAM" | state=="ASSAM" | state=="BIHAR" | state=="ORISSA" | state=="MEGHALAYA" | state=="JHARKHAND" | state=="HIMACHAL PRADESH" | state=="KERALA" | state=="MANIPUR" | state=="TRIPURA" | state=="WEST BENGAL"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if (state=="SIKKIM" | state=="MIZORAM" | state=="ASSAM" | state=="BIHAR" | state=="ORISSA" | state=="MEGHALAYA" | state=="JHARKHAND" | state=="HIMACHAL PRADESH" | state=="KERALA" | state=="MANIPUR" | state=="TRIPURA" | state=="WEST BENGAL"),absorb(state_district_code)

*** below median states - full waiver beneficiaries as proportion of all beneficiaries in State (2nd column) ***
areg dist_inc_votshr post_prop i.year if (state=="UTTARAKHAND" | state=="UTTAR PRADESH" | state=="ANDHRA PRADESH" | state=="NAGALAND" | state=="TAMIL NADU" | state=="MADHYA PRADESH" | state=="MAHARASHTRA" | state=="CHHATTISGARH" | state=="KARNATAKA" | state=="RAJASTHAN" | state=="HARYANA" | state=="GUJARAT" | state=="PUNJAB"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if (state=="UTTARAKHAND" | state=="UTTAR PRADESH" | state=="ANDHRA PRADESH" | state=="NAGALAND" | state=="TAMIL NADU" | state=="MADHYA PRADESH" | state=="MAHARASHTRA" | state=="CHHATTISGARH" | state=="KARNATAKA" | state=="RAJASTHAN" | state=="HARYANA" | state=="GUJARAT" | state=="PUNJAB"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if (state=="UTTARAKHAND" | state=="UTTAR PRADESH" | state=="ANDHRA PRADESH" | state=="NAGALAND" | state=="TAMIL NADU" | state=="MADHYA PRADESH" | state=="MAHARASHTRA" | state=="CHHATTISGARH" | state=="KARNATAKA" | state=="RAJASTHAN" | state=="HARYANA" | state=="GUJARAT" | state=="PUNJAB"),absorb(state_district_code)

*** Median based on column2 values (median=89.7%) ***
gen above_median_column2=0
replace above_median_column2=1 if (state=="ARUNACHAL PRADESH" | state=="SIKKIM" | state=="MIZORAM" | state=="ORISSA" | state=="BIHAR" | state=="ASSAM" | state=="MEGHALAYA" | state=="JHARKHAND" | state=="HIMACHAL PRADESH" | state=="KERALA" | state=="MANIPUR" | state=="TRIPURA" | state=="WEST BENGAL")
gen post_prop_above_median_column2=post*indivnum_district_elig_prop*above_median_column2

areg dist_inc_votshr post_prop_above_median_column2 i.year,absorb(state_district_code)
est store p1
areg dist_incally_votshr post_prop_above_median_column2 i.year,absorb(state_district_code)
est store p2
areg dist_upa_votshr post_prop_above_median_column2 i.year,absorb(state_district_code)
est store p3
outreg2 [p1 p2 p3] using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\p1.xls", drop(2009.year) label addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace
********************************************************************************
summ indivnum_state_elig_prop,de
di `r(p50)'
local median_stateprop=r(p50)
di `median_stateprop'

gen above_median_stateprop=0
replace above_median_stateprop=1 if indivnum_state_elig_prop>`median_stateprop'
gen post_prop_above_median_stateprop=post*indivnum_district_elig_prop*above_median_stateprop

areg dist_inc_votshr post_prop_above_median_stateprop i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_above_median_stateprop i.year,absorb(state_district_code)
areg dist_upa_votshr post_prop_above_median_stateprop i.year,absorb(state_district_code)
********************************************************************************







*** States with INC seat increase ***
areg dist_inc_votshr post_prop i.year if (state=="MADHYA PRADESH" | state=="UTTAR PRADESH" | state=="MAHARASHTRA" | state=="ANDHRA PRADESH" | state=="PUNJAB"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if (state=="MADHYA PRADESH" | state=="UTTAR PRADESH" | state=="MAHARASHTRA" | state=="ANDHRA PRADESH" | state=="PUNJAB"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if (state=="MADHYA PRADESH" | state=="UTTAR PRADESH" | state=="MAHARASHTRA" | state=="ANDHRA PRADESH" | state=="PUNJAB"),absorb(state_district_code)

*** States with INC vote share increase ***
areg dist_inc_votshr post_prop i.year if (state=="PUNJAB" | state=="KERALA" | state=="UTTAR PRADESH" | state=="MADHYA PRADESH" | state=="RAJASTHAN" | state=="BIHAR"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if (state=="PUNJAB" | state=="KERALA" | state=="UTTAR PRADESH" | state=="MADHYA PRADESH" | state=="RAJASTHAN" | state=="BIHAR"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if (state=="PUNJAB" | state=="KERALA" | state=="UTTAR PRADESH" | state=="MADHYA PRADESH" | state=="RAJASTHAN" | state=="BIHAR"),absorb(state_district_code)

*** State with INC rule *** didn't work :(
areg dist_inc_votshr post_prop i.year if (state=="ANDHRA PRADESH" | state=="ASSAM" | state=="GOA" | state=="HARYANA"),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if (state=="ANDHRA PRADESH" | state=="ASSAM" | state=="GOA" | state=="HARYANA"),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if (state=="ANDHRA PRADESH" | state=="ASSAM" | state=="GOA" | state=="HARYANA"),absorb(state_district_code)
***









*** Separating the sample using median of state eligible proportion ***
summ indivnum_state_elig_prop,de
di `r(p50)'
local median2=r(p50)
di `median2'

summ indivnum_state_elig_prop,de
gen above_median_stateprop=0
replace above_median_stateprop=1 if indivnum_state_elig_prop>0.835211
gen post_prop_above_median_stprop=post*indivnum_district_elig_prop*above_median_stateprop

areg dist_inc_votshr     post_prop_above_median_stprop i.year,absorb(state_district_code)
areg dist_incally_votshr post_prop_above_median_stprop i.year,absorb(state_district_code)
areg dist_upa_votshr     post_prop_above_median_stprop i.year,absorb(state_district_code)


summ indivnum_state_elig_prop,de
gen above_median_stateprop=0
replace above_median_stateprop=1 if indivnum_state_elig_prop>0.045193
gen post_prop_above_median_stprop=post*indivnum_district_elig_prop*above_median_stateprop

areg dist_inc_votshr     post_prop_above_median_stprop i.year i.state_code,absorb(state_district_code)
areg dist_incally_votshr post_prop_above_median_stprop i.year i.state_code,absorb(state_district_code)
areg dist_upa_votshr     post_prop_above_median_stprop i.year i.state_code,absorb(state_district_code)




*** Regression for above median states ***
areg dist_inc_votshr post_prop i.year if indivnum_state_elig_prop>`median2',absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if indivnum_state_elig_prop>`median2',absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if indivnum_state_elig_prop>`median2',absorb(state_district_code)
est store r4
di `median2'
*** Regression for below median states ***
areg dist_inc_votshr post_prop i.year if indivnum_state_elig_prop<=`median2',absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if indivnum_state_elig_prop<=`median2',absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if indivnum_state_elig_prop<=`median2',absorb(state_district_code)
est store r5

*** t-test for states ***
forvalues i = 1(1)9 {
di "state_code - "`i'
ttest dist_inc_votshr if state_code==`i',by(post)
}

forvalues i = 11(1)27 {
di "state_code - "`i'
ttest dist_inc_votshr if state_code==`i',by(post)
}

forvalues i = 1(1)27 {
di "state_code - "`i'
areg dist_inc_votshr post_prop i.year if state_code==`i',absorb(state_district_code)
}

gen state_topttest=0
replace state_topttest=1 if inlist(state_code,1,24,12,8,17,25,11,19,27)
replace state_topttest=1 if inlist(state_code,6,22,7,2,26,14,16)

areg dist_inc_votshr post_prop i.year if state_topttest==1,absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if state_topttest==1,absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if state_topttest==1,absorb(state_district_code) 
********************************************************************************
*** 2009-2004 mean values - top 9 states ***
areg dist_inc_votshr post_prop i.year if inlist(state_code,1,24,12,8,17,25,11,19,27),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if inlist(state_code,1,24,12,8,17,25,11,19,27) ,absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if inlist(state_code,1,24,12,8,17,25,11,19,27),absorb(state_district_code) 
********************************************************************************
*** 2009-2004 seats and 2009-2004 vote share ***
areg dist_inc_votshr post_prop i.year if inlist(state_code,1,8,12,6,25,17,3,19,26),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if inlist(state_code,1,8,12,6,25,17,3,19,26),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if inlist(state_code,1,8,12,6,25,17,3,19,26),absorb(state_district_code) 
***********************************************************************************
*** +ve regression co-efficients ***
gen state_positive=0
replace state_positive=1 if inlist(state_code,12,8,25,17,11,19,6,15,9)
replace state_positive=1 if inlist(state_code,23,5,21,3)

areg dist_inc_votshr post_prop i.year if state_positive==1,absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if state_positive==1,absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if state_positive==1,absorb(state_district_code) 

areg dist_inc_votshr post_prop i.year if inlist(state_code,1,8,12),absorb(state_district_code)
areg dist_incally_votshr post_prop i.year if inlist(state_code,1,8,12),absorb(state_district_code)
areg dist_upa_votshr post_prop i.year if inlist(state_code,1,8,12),absorb(state_district_code)
********************************************************************************
gen post_state_prop=post*indivnum_state_elig_prop
gen post_state_prop2=post*indivnum_state_elig_prop2

areg dist_inc_votshr post_state_prop2 i.year,absorb(state_code)
areg dist_incally_votshr post_state_prop2 i.year,absorb(state_code)
areg dist_upa_votshr post_state_prop2 i.year,absorb(state_code)



*outreg2 [r1 r2 r3 r4 r5] using "Results.xls", drop(2009.year) addstat(Adj R-squared,e(r2_a)) nocons dec(3) excel replace

/*
*** Finding median for the national eligible proportion of state ***
summ indivnum_state_elig_prop,de
di `r(p50)'
local median3=r(p50)
di `median3'
*** for above median districts ***
areg distvotes_inc_votshr post_prop2 i.year if indivnum_state_elig_prop>`median3',absorb(district_code)
di `median3'
*** for below median districts ***
areg distvotes_inc_votshr post_prop2 i.year if indivnum_state_elig_prop<=`median3',absorb(district_code)
*/

/*
summ indivnum_district_elig_prop2,de
di `r(p50)'
local median1=r(p50)
di `median1'
gen above_median=1 if indivnum_district_elig_prop2>`median1'
replace above_median=0 if indivnum_district_elig_prop2<=`median1'
summ indivnum_district_elig_prop2,de
tab above_median
summ indivnum_district_elig_prop2 if above_median==0,de
summ indivnum_district_elig_prop2 if above_median==1,de

gen post_prop2_abovemedian=post*indivnum_district_elig_prop2*above_median
tab post_prop2_abovemedian

areg dist_inc_votshr post_prop2_abovemedian i.year ,absorb(state_district_code)
*/

save "Consolidation work_v2.dta",replace

log close 
