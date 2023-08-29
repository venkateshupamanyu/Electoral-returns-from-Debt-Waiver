
clear
import excel using "...\AE\State election details.xlsx",sheet("Pre2008 states") firstrow

ren *,lower
egen state_code=group(st_name)
order state_code state
sort state_code dist_name ac

by state_code dist_name: egen dist_votes=sum(votes)
by state_code dist_name: egen dist_incvotes1=sum(votes) if party=="INC"
by state_code dist_name: egen dist_incvotes=mean(dist_incvotes1)
drop dist_incvotes1

by state_code dist_name: egen dist_incallyvotes1=sum(votes) if inlist(party,"AC","TRS","CPI","CPM","NCP")
by state_code dist_name: egen dist_incallyvotes=mean(dist_incallyvotes1)
drop dist_incallyvotes1

by state_code dist_name: egen dist_upavotes1=sum(votes) if inlist(party,"INC","AC","TRS","CPI","CPM","NCP")
by state_code dist_name: egen dist_upavotes=mean(dist_upavotes1)
drop dist_upavotes1

by state_code dist_name: egen dist_oppvotes1=sum(votes) if inlist(party,"BJP","JD(S)","SHS","BSP","BJD","SDF","AITC","INLD","JD(U)")
by state_code dist_name: egen dist_oppvotes=mean(dist_oppvotes1)
drop dist_oppvotes1

gen dist_incvotshr=dist_incvotes/dist_votes
gen dist_incallyvotshr=dist_incallyvotes/dist_votes
gen dist_upavotshr=dist_upavotes/dist_votes
gen dist_oppvotshr=dist_oppvotes/dist_votes

*** Party won ***
sort st_name dist_name ac party
by st_name dist_name ac: egen maxvotes_1=max(votes)
gen partywon=party if votes==maxvotes_1
drop maxvotes_1

drop cand party votes dist_votes dist_incvotes dist_incallyvotes dist_upavotes
duplicates drop

by st_name dist_name ac:gen ac_count=_N
tab ac_count
tab st_name if ac_count==1
tab ac if ac_count==1 & st_name=="Sikkim"
tab ac if ac_count==1 & st_name=="Arunachal Pradesh"
drop ac_count 
*** The above 6 ACs have only one row as they are uncontested ***

sort st_name dist_name ac
by st_name dist_name: gen inc_distseat_1=1 if partywon=="INC"
by st_name dist_name: gen inc_distseat_2=sum(inc_distseat_1)
by st_name dist_name: egen inc_distseat=max(inc_distseat_2)
drop inc_distseat_1 inc_distseat_2

by st_name dist_name: gen incally_distseat_1=1 if inlist(partywon,"AC","TRS","CPI","CPM","NCP")
by st_name dist_name: gen incally_distseat_2=sum(incally_distseat_1)
by st_name dist_name: egen incally_distseat=max(incally_distseat_2)
drop incally_distseat_1 incally_distseat_2

sort st_name dist_name
by st_name dist_name: gen upa_distseat_1=1 if inlist(partywon,"INC","AC","TRS","CPI","CPM","NCP")
by st_name dist_name: gen upa_distseat_2=sum(upa_distseat_1)
by st_name dist_name: egen upa_distseat=max(upa_distseat_2)
drop upa_distseat_1 upa_distseat_2

sort st_name dist_name
by st_name dist_name: gen opp_distseat_1=1 if inlist(partywon,"BJP","JD(S)","SHS","BSP","BJD","SDF","AITC","INLD","JD(U)")
by st_name dist_name: gen opp_distseat_2=sum(opp_distseat_1)
by st_name dist_name: egen opp_distseat=max(opp_distseat_2)
drop opp_distseat_1 opp_distseat_2

drop ac partywon 
duplicates drop

tab st_name

export excel using "...\AE\Pre2008 states.xlsx", firstrow(variables) replace
save "...\AE\Pre2008 states.dta",replace

********************************************************************************

clear
import excel using "...\AE\State election details.xlsx",sheet("Post2008 states") firstrow

ren *,lower
egen state_code=group(st_name)
order state_code state
sort state_code dist_name ac

by state_code dist_name: egen dist_votes=sum(votes)
by state_code dist_name: egen dist_incvotes1=sum(votes) if party=="INC"
by state_code dist_name: egen dist_incvotes=mean(dist_incvotes1)
drop dist_incvotes1

by state_code dist_name: egen dist_incallyvotes1=sum(votes) if party=="NCP"
by state_code dist_name: egen dist_incallyvotes=mean(dist_incallyvotes1)
drop dist_incallyvotes1

by state_code dist_name: egen dist_upavotes1=sum(votes) if inlist(party,"INC","NCP")
by state_code dist_name: egen dist_upavotes=mean(dist_upavotes1)
drop dist_upavotes1

by state_code dist_name: egen dist_oppvotes1=sum(votes) if inlist(party,"BJP","JD(S)","SHS","BSP","BJD","SDF","AITC","INLD","JD(U)")
by state_code dist_name: egen dist_oppvotes=mean(dist_oppvotes1)
drop dist_oppvotes1

gen dist_incvotshr=dist_incvotes/dist_votes
gen dist_incallyvotshr=dist_incallyvotes/dist_votes
gen dist_upavotshr=dist_upavotes/dist_votes
gen dist_oppvotshr=dist_oppvotes/dist_votes

*** Party won ***
sort st_name dist_name ac party
by st_name dist_name ac: egen maxvotes_1=max(votes)
gen partywon=party if votes==maxvotes_1
drop maxvotes_1

drop cand party votes dist_votes dist_incvotes dist_incallyvotes dist_upavotes
duplicates drop

by st_name dist_name ac:gen ac_count=_N
tab ac_count
tab st_name if ac_count==1
tab ac if ac_count==1 & st_name=="Arunachal Pradesh"
drop ac_count 
*** The above 3 ACs have only one row as they are uncontested ***

sort st_name dist_name ac
by st_name dist_name: gen inc_distseat_1=1 if partywon=="INC"
by st_name dist_name: gen inc_distseat_2=sum(inc_distseat_1)
by st_name dist_name: egen inc_distseat=max(inc_distseat_2)
drop inc_distseat_1 inc_distseat_2

by st_name dist_name: gen incally_distseat_1=1 if inlist(partywon,"NCP")
by st_name dist_name: gen incally_distseat_2=sum(incally_distseat_1)
by st_name dist_name: egen incally_distseat=max(incally_distseat_2)
drop incally_distseat_1 incally_distseat_2

sort st_name dist_name
by st_name dist_name: gen upa_distseat_1=1 if inlist(partywon,"INC","NCP")
by st_name dist_name: gen upa_distseat_2=sum(upa_distseat_1)
by st_name dist_name: egen upa_distseat=max(upa_distseat_2)
drop upa_distseat_1 upa_distseat_2

sort st_name dist_name
by st_name dist_name: gen opp_distseat_1=1 if inlist(partywon,"BJP","JD(S)","SHS","BSP","BJD","SDF","AITC","INLD","JD(U)")
by st_name dist_name: gen opp_distseat_2=sum(opp_distseat_1)
by st_name dist_name: egen opp_distseat=max(opp_distseat_2)
drop opp_distseat_1 opp_distseat_2

drop ac partywon
duplicates drop

tab st_name

export excel using "...\AE\Post2008 states.xlsx", firstrow(variables) replace
save "...\AE\Post2008 states.dta",replace

********************************************************************************
clear
cd "...\AE"

use "Pre2008 states.dta"

*tab dist_name if _merge==1 & st_name=="Andhra Pradesh"
replace dist_name="Kadapa" if dist_name=="Cuddapah"
replace dist_name="Mahabubnagar" if dist_name=="Mahbubnagar"
replace dist_name="Nellore " if dist_name=="Nellore"
replace dist_name="Prakasam" if dist_name=="Prakasam "
replace dist_name="Visakhapatnam" if dist_name=="Vishakapatnam"

*tab dist_name if _merge==1 & st_name=="Arunachal Pradesh"
replace dist_name="LOHIT" if dist_name=="Lohit"
replace dist_name="TIRAP" if dist_name=="Tirap"

*tab dist_name if _merge==1 & st_name=="Chattisgarh"
replace dist_name="Bastar                        " if dist_name=="Bastar"
replace dist_name="Bilaspur                      " if dist_name=="Bilaspur"
replace dist_name="Durg                          " if dist_name=="Durg"
replace dist_name="Raigarh                       " if dist_name=="Raigarh"
replace dist_name="Raipur                        " if dist_name=="Raipur"
replace dist_name="Rajnandgaon                   " if dist_name=="Rajnandgaon"
replace dist_name="Surguja                       " if dist_name=="Surguja"

*tab dist_name if _merge==1 & st_name=="Haryana"
replace dist_name = strupper(dist_name) if st_name=="Haryana"
*tab dist_name if _merge==1 & st_name=="Haryana" 
replace dist_name="YAMUNANAGAR" if dist_name=="YAMUNA-NAGAR"

*tab dist_name if _merge==1 & st_name=="Jharkhand"

*tab dist_name if _merge==1 & st_name=="Karnataka"
replace dist_name = strupper(dist_name) if st_name=="Karnataka"
*tab dist_name if _merge==1 & st_name=="Karnataka"
replace dist_name="BELGAUM " if dist_name=="BELGAUM"
replace dist_name="CHICKMAGALUR" if dist_name=="CHIKMAGALUR"
replace dist_name="KODAGU" if dist_name=="COORG"
replace dist_name="DHARWAD" if dist_name=="DHARWAR"
replace dist_name="UTTARA KANNADA" if dist_name=="NORTH KANARA"
replace dist_name="DAKSHINA KANNADA" if dist_name=="SOUTH KANARA"

*tab dist_name if _merge==1 & st_name=="Madhya Pradesh"
replace dist_name="Datia                         " if dist_name=="Atia"
replace dist_name="Balaghat                      " if dist_name=="Balaghat"
replace dist_name="Betul                         " if dist_name=="Betul"
replace dist_name="Bhind                         " if dist_name=="Bhind"
replace dist_name="Bhopal                        " if dist_name=="Bhopal"
replace dist_name="Chhatarpur                    " if dist_name=="Chhatarpur"
replace dist_name="Chhindwara                    " if dist_name=="Chhindwara"
replace dist_name="Damoh                         " if dist_name=="Damoh"
replace dist_name="Dewas                         " if dist_name=="Dewas"
replace dist_name="Dhar                          " if dist_name=="Dhar"
replace dist_name="Khandwa                       " if dist_name=="East Nimar (Khandwa)"
replace dist_name="Guna                          " if dist_name=="Guna"
replace dist_name="Gwalior                       " if dist_name=="Gwalior"
replace dist_name="Hoshangabad                   " if dist_name=="Hoshangabad"
replace dist_name="Indore                        " if dist_name=="Indore"
replace dist_name="Jabalpur                      " if dist_name=="Jabalpur"
replace dist_name="Jhabua                        " if dist_name=="Jhabua"
replace dist_name="Mandla                        " if dist_name=="Mandla"
replace dist_name="Mandsour                      " if dist_name=="Mandsaur"
replace dist_name="Morena                        " if dist_name=="Morena"
replace dist_name="Narsingpur                    " if dist_name=="Narsimhapur"
replace dist_name="Panna                         " if dist_name=="Panna"
replace dist_name="Raisen                        " if dist_name=="Raisen"
replace dist_name="Rajgarh                       " if dist_name=="Rajgarh"
replace dist_name="Ratlam                        " if dist_name=="Ratlam"
replace dist_name="Rewa                          " if dist_name=="Rewa"
replace dist_name="Sagar                         " if dist_name=="Sagar"
replace dist_name="Satna                         " if dist_name=="Satna"
replace dist_name="Sehore                        " if dist_name=="Sehore"
replace dist_name="Seoni                         " if dist_name=="Seoni"
replace dist_name="Shahdol                       " if dist_name=="Shahdol"
replace dist_name="Shajapur                      " if dist_name=="Shajapur"
replace dist_name="Shivpuri                      " if dist_name=="Shivpuri"
replace dist_name="Sidhi                         " if dist_name=="Sidhi"
replace dist_name="Tikamgarh                     " if dist_name=="Tikamgarh"
replace dist_name="Ujjain                        " if dist_name=="Ujjain"
replace dist_name="Vidisha                       " if dist_name=="Vidisha"
replace dist_name="Khargone                      " if dist_name=="West Nimar (Khargone)"

*tab dist_name if _merge==1 & st_name=="Maharashtra"
replace dist_name = strupper(dist_name) if st_name=="Maharashtra"
replace dist_name="BEED" if dist_name=="BHIR"
replace dist_name=" DHULE" if dist_name=="DHULIA"
replace dist_name="MUMBAI SUBURBAN" if dist_name=="GREATER BOMBAY"
replace dist_name="MUMBAI CITY" if dist_name=="KOLABA"
replace dist_name="KOLHAPUR" if dist_name=="KOLHAPUR "
replace dist_name="NASHIK" if dist_name=="NASIK"
replace dist_name="PUNE" if dist_name=="POONA"
replace dist_name="SOLAPUR" if dist_name=="SHOLAPUR"
replace dist_name="THANE" if dist_name=="THANA"
replace dist_name=" WARDHA" if dist_name=="WARDHA"
replace dist_name="YAVATMAL" if dist_name=="YEOTMAL"

*tab dist_name if _merge==1 & st_name=="Mizoram"
replace dist_name = strupper(dist_name) if st_name=="Mizoram"
replace dist_name="AIZAWL                        " if dist_name=="AIZAWL"
replace dist_name="LUNGLEI                       " if dist_name=="LUNGLEI"

replace st_name="Orissa" if st_name=="Odisha"
*tab dist_name if _merge==1 & st_name=="Orissa"
replace dist_name="Boudh" if dist_name=="Boudh-Khondmals"
replace dist_name="Koraput" if dist_name=="Koraput "
replace dist_name="Mayrabhanja" if dist_name=="Mayurbhanj"

*tab dist_name if _merge==1 & st_name=="Rajasthan"
replace dist_name = strupper(dist_name) if st_name=="Rajasthan"
replace dist_name="AJMER                         " if dist_name=="AJMER"
replace dist_name="ALWAR                         " if dist_name=="ALWAR"
replace dist_name="BANSWARA                      " if dist_name=="BANSWARA"
replace dist_name="BARMER                        " if dist_name=="BARMER"
replace dist_name="BHARATPUR                     " if dist_name=="BHARATPUR"
replace dist_name="BHILWARA                      " if dist_name=="BHILWARA"
replace dist_name="BUNDI                         " if dist_name=="BUNDI"
replace dist_name="CHITTORGARH                   " if dist_name=="CHITTORGARH"
replace dist_name="CHURU                         " if dist_name=="CHURU"
replace dist_name="DUNGARPUR                     " if dist_name=="DUNGARPUR"
replace dist_name="GANGANAGAR                    " if dist_name=="GANGANAGAR"
replace dist_name="JAIPUR                        " if dist_name=="JAIPUR"
replace dist_name="JAISALMER                     " if dist_name=="JAISALMER"
replace dist_name="JALORE                        " if dist_name=="JALORE"
replace dist_name="JHALAWAR                      " if dist_name=="JHALAWAR"
replace dist_name="JHUNJHUNU                     " if dist_name=="JHUNJHUNU"
replace dist_name="JODHPUR                       " if dist_name=="JODHPUR"
replace dist_name="KOTA                          " if dist_name=="KOTA"
replace dist_name="NAGAUR                        " if dist_name=="NAGAUR"
replace dist_name="PALI                          " if dist_name=="PALI"
replace dist_name="SAWAI MADHOPUR                " if dist_name=="SAWAIMADHOPUR"
replace dist_name="SIKAR                         " if dist_name=="SIKAR"
replace dist_name="SIROHI                        " if dist_name=="SIROHI"
replace dist_name="TONK                          " if dist_name=="TONK"
replace dist_name="UDAIPUR                       " if dist_name=="UDAIPUR"

*tab dist_name if _merge==1 & st_name=="Sikkim"
replace dist_name="EAST" if dist_name=="Sikkim East"
replace dist_name="NORTH" if dist_name=="Sikkim North"
replace dist_name="SOUTH" if dist_name=="Sikkim South"
replace dist_name="WEST" if dist_name=="Sikkim West"

append using "Post2008 states.dta"

sort st_name dist_name year
by st_name dist_name:gen dist_count=_N
tab dist_count

export excel using "...\AE\Prepost states.xlsx", firstrow(variables) replace
save "...\AE\Prepost states.dta",replace
********************************************************************************
/*
clear
import excel using "...\Agricultural census data 2005-06.xlsx",sheet(clean data with pop ratio) firstrow
replace dist_name=proper(dist_name)
 
save "...\AE\Agricultural census data 2005-06 AE.dta",replace
*/
*** Below we use the sheet from Consolidation work which we got using fuzzy-lookup and manual cleaning ***
clear
import excel using "...\AE\Consolidation work.xlsx",sheet(Sheet9) firstrow

cd "...\AE"

replace dist_incvotshr=0 if dist_incvotshr==.
replace dist_incallyvotshr=0 if dist_incallyvotshr==.
replace dist_upavotshr=0 if dist_upavotshr==.
replace dist_oppvotshr=0 if dist_oppvotshr==.


egen stat_dist_code=group(st_name dist_name)

gen post1=0
replace post1=1 if st_name=="Karnataka" & month==5 & year==2008
*replace post1=0 if st_name=="Karnataka" & month==5 & year==2004 
tab post1 st_name
tab post1 month
tab post1 year

gen post2=0
replace post2=1 if inlist(st_name,"Chattisgarh","Mizoram","Madhya Pradesh","Rajasthan") ///
                 & month==10 & year==2008
*replace post2=0 if inlist(st_name,"Chattisgarh","Mizoram","Madhya Pradesh","Rajasthan") ///
*                 & month==10 & year==2003
tab post2 st_name
tab post2 month
tab post2 year

gen post3=0
replace post3=1 if inlist(st_name,"Andhra Pradesh","Odisha","Sikkim") ///
                 & month==3 & year==2009
*replace post3=0 if inlist(st_name,"Andhra Pradesh","Odisha","Sikkim") ///
*                 & month==3 & year==2004				 
tab post3 st_name
tab post3 month
tab post3 year

gen post4=0
replace post4=1 if inlist(st_name,"Haryana","Arunachal Pradesh","Maharashtra") & month==8 & year==2009
tab post4 st_name
tab post4 mont
tab post4 year

gen post5=0
replace post5=1 if st_name=="Jharkhand" & month==10 & year==2009
tab post5 st_name
tab post5 mont
tab post5 year

gen post1_elig1=post1*eligibletotalshare
gen post2_elig1=post2*eligibletotalshare
gen post3_elig1=post3*eligibletotalshare
gen post4_elig1=post4*eligibletotalshare
gen post5_elig1=post5*eligibletotalshare

gen post1_elig2=post1*eligibleruralshare
gen post2_elig2=post2*eligibleruralshare
gen post3_elig2=post3*eligibleruralshare
gen post4_elig2=post4*eligibleruralshare
gen post5_elig2=post5*eligibleruralshare

label var dist_incvotshr "INC Vote Share"
label var dist_incallyvotshr "INC Allies Vote Share"
label var dist_upavotshr "UPA Vote Share"
label var dist_oppvotshr "Opposition Vote Share"
label var inc_distseat "Seats won by INC in District"
label var incally_distseat "Seats won by INC Allies in District"
label var upa_distseat "Seats won by UPA Coalition in District"
label var opp_distseat "Seats won by Opposition in District"
label var post1_elig1 "May 2008 Elections x District Eligibility Proportion"
label var post2_elig1 "October 2008 Elections x District Eligibility Proportion"
label var post3_elig1 "March 2009 Elections x District Eligibility Proportion"
label var post4_elig1 "August 2009 Elections x District Eligibility Proportion"
label var post5_elig1 "October 2009 Elections x District Eligibility Proportion"

areg dist_incvotshr post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a1
areg dist_incallyvotshr post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a2
areg dist_upavotshr post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a3
areg dist_oppvotshr post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a4
areg inc_distseat post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a5
areg incally_distseat post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a6
areg upa_distseat post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a7
areg opp_distseat post1_elig1 post2_elig1 post3_elig1 post4_elig1 post5_elig1 i.year,absorb(stat_dist_code)
est store a8
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8] using "States baseline 1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "States baseline 1.txt"

***
summ dist_incvotshr dist_incallyvotshr dist_upavotshr dist_oppvotshr
summ inc_distseat   incally_distseat   upa_distseat   opp_distseat 
***
areg dist_incvotshr post1_elig2 post2_elig2 post3_elig2 post4_elig2 post5_elig2 i.year,absorb(stat_dist_code)

drop post4 post4_elig1 post4_elig2 post5 post5_elig1 post5_elig2

gen post4=0
replace post4=1 if inlist(st_name,"Haryana","Arunachal Pradesh","Maharashtra") & month==8 & year==2009
replace post4=1 if st_name=="Jharkhand" & month==10 & year==2009
tab post4 st_name
tab post4 mont
tab post4 year

gen post4_elig1=post4*eligibletotalshare
gen post4_elig2=post4*eligibleruralshare

label var post4_elig1 "After 2008 x August 2009 Election"

areg dist_incvotshr 	post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b1
areg dist_incallyvotshr post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b2
areg dist_upavotshr 	post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b3
areg dist_oppvotshr 	post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b4
areg inc_distseat 		post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b5
areg incally_distseat 	post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b6
areg upa_distseat 		post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b7
areg opp_distseat 		post1_elig1 post2_elig1 post3_elig1 post4_elig1 i.year,absorb(stat_dist_code)
est store b8
outreg2 [b1 b2 b3 b4 b5 b6 b7 b8] using "States baseline 2.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "States baseline 2.txt"

export excel using "Working data.xlsx", firstrow(variables) replace
save "Working data.dta",replace
********************************************************************************
********************************************************************************
********************************************************************************




