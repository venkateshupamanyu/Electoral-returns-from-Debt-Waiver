********************************************************************************
*** Here, we use the "Consolidated sheet (3)" sheet from "2004-PC-AC temp_2 - working.xls" and obtain the following in same code ***
*** - District vote shares ***
*** - District weighted PC seats - using 2 methods ***
*** We get a single district output file "2004 dist output.xlsx" *** 
*** Previously, we did both the outputs separately, now derived partywon variable and completed in single .do file ***
*** FYI - Below, we import the excel sheet for 2004 year getting 36071 rows and 9 variables ***

clear
import excel using "...\GE\2004-PC-AC temp_2 - working.xls",sheet(Consolidated sheet (3)) firstrow

ren DIST_NAME dist_name
order state dist_name 

*** District vote shares ***
sort state dist_name pc
gen inc=0
replace inc=1 if party=="INC"
/*
gen incally=0
replace incally=1 if inlist(party,"AC","TRS","LJNSP","RJD","NCP")
replace incally=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")
*/

gen incally20042009=0
replace incally20042009=1 if inlist(party,"AC","TRS","LJNSP","RJD","NCP")
replace incally20042009=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")

gen incallyconst20042009=0
replace incallyconst20042009=1 if inlist(party,"DMK","JMM","NCP","MUL")

gen incallyconst2004=0
replace incallyconst2004=1 if inlist(party,"AC","TRS","LJNSP","RJD","NCP")
replace incallyconst2004=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")

gen incallyconst2009=0
replace incallyconst2009=1 if inlist(party,"AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace incallyconst2009=1 if inlist(party,"RPI(A)","MD")

/*
gen upa=0
replace upa=1 if inlist(party,"INC","AC","TRS","LJNSP","RJD","NCP")
replace upa=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")
*/

gen upa20042009=0
replace upa20042009=1 if inlist(party,"INC","AC","TRS","LJNSP","RJD","NCP")
replace upa20042009=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")

gen upaconst20042009=0
replace upaconst20042009=1 if inlist(party,"INC","DMK","JMM","NCP","MUL")

gen upaconst2004=0
replace upaconst2004=1 if inlist(party,"INC","AC","TRS","LJNSP","RJD","NCP")
replace upaconst2004=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")

gen upaconst2009=0
replace upaconst2009=1 if inlist(party,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace upaconst2009=1 if inlist(party,"RPI(A)","MD")

***	https://en.wikipedia.org/wiki/National_Democratic_Alliance#Candidates_in_elections ***										
gen bjp=0
replace bjp=1 if inlist(party,"BJP")

gen bjpally20042009=0
replace bjpally20042009=1 if inlist(party,"JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
*replace bjpally20042009=1 if inlist(party,"SDF","NPF","MNF")

gen nda20042009=0
replace nda20042009=1 if inlist(party,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
*replace nda20042009=1 if inlist(party,"SDF","NPF","MNF")

*gen nda20042009=0
*replace nda20042009=1 if inlist(party,"BJP","JD(U)","SHS","SAD")

gen oth20042009=0
replace oth20042009=1 if inlist(party,"AIFB","AGP","BSP","CPI","CPM","EU","HVP","INLD","JD(S)")
replace oth20042009=1 if inlist(party,"IND","RSP","SP","SHRP","SSP")

*replace oth20042009=1 if !inlist(party,"INC","AC","TRS","LJNSP","RJD","NCP")
*replace oth20042009=1 if !inlist(party,"JMM","MUL","DMK","MDMK","PMK")
*replace oth20042009=1 if !inlist(party,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")


*gen oth20042009=0
*replace oth20042009=1 if upa20042009==0 & nda20042009==0

gen opp20042009=0
replace opp20042009=1 if inlist(party,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
replace opp20042009=1 if inlist(party,"AIFB","AGP","BSP","CPI","CPM","EU","HVP","INLD","JD(S)")
replace opp20042009=1 if inlist(party,"IND","RSP","SP","SHRP","SSP")
*gen opp20042009=0
*replace opp20042009=1 if nda20042009==1 | oth20042009==1
*gen opp20042009=0
*replace opp20042009=1 if inlist(party,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
*replace opp20042009=1 if inlist(party,"SDF","NPF","MNF")
*replace opp20042009=1 if inlist(party,"AIFB","AGP","BSP","CPI","CPM","EU","HVP","INLD","JD(S)")
*replace opp20042009=1 if inlist(party,"IND","RSP","SP","SHRP","SSP")
***

********************************************************************************
*** Following code is used to get vote shares for tables in the draft ***
/*
gen inc_ruling_state=0
replace inc_ruling_state=1 if inlist(state,"ARUNACHAL PRADESH","ANDHRA PRADESH","ASSAM","GOA","HARYANA","MANIPUR","MEGHALAYA","NAGALAND")
gen incally_ruling_state=0
replace incally_ruling_state=1 if inlist(state,"KARNATAKA","MAHARASHTRA","TAMIL NADU")
gen bjp_ruling_state=0
replace bjp_ruling_state=1 if inlist(state,"CHHATTISGARH","GUJARAT","HIMACHAL PRADESH","MADHYA PRADESH","RAJASTHAN","UTTARAKHAND")
gen bjpally_ruling_state=0
replace bjpally_ruling_state=1 if inlist(state,"BIHAR","JHARKHAND","ORISSA","PUNJAB") 
gen oth_ruling_state=0
replace oth_ruling_state=1 if inlist(state,"KERALA","MIZORAM","SIKKIM","TRIPURA","UTTAR PRADESH","WEST BENGAL")
gen upa_ruling_state=0
replace upa_ruling_state=1 if (inc_ruling_state==1 | incally_ruling_state==1)
gen nda_ruling_state=0
replace nda_ruling_state=1 if (bjp_ruling_state==1 | bjpally_ruling_state==1)

drop votes1 - votes_upaconst2009
sort state
egen votes1=total(votes) if oth_ruling_state==1
egen votes_inc=total(votes) if party=="INC" & oth_ruling_state==1
format votes1 votes_inc %12.0g
egen votes_incally20042009=total(votes) if incally20042009==1 & oth_ruling_state==1
egen votes_incallyconst20042009=total(votes) if incallyconst20042009==1 & oth_ruling_state==1
egen votes_incallyconst2004=total(votes) if incallyconst2004==1 & oth_ruling_state==1
egen votes_incallyconst2009=total(votes) if incallyconst2009==1 & oth_ruling_state==1
egen votes_upa20042009=total(votes) if upa20042009==1 & oth_ruling_state==1
egen votes_upaconst20042009=total(votes) if upaconst20042009==1 & oth_ruling_state==1
egen votes_upaconst2004=total(votes) if upaconst2004==1 & oth_ruling_state==1
egen votes_upaconst2009=total(votes) if upaconst2009==1 & oth_ruling_state==1
format votes_incally20042009 votes_incallyconst20042009 votes_incallyconst2004 votes_incallyconst2009 %12.0g
format votes_upa20042009 votes_upaconst20042009 votes_upaconst2004 votes_upaconst2009 %12.0g

unique pc 
unique pc if inc_ruling_state==1
unique pc if incally_ruling_state==1
unique pc if upa_ruling_state==1
unique pc if bjp_ruling_state==1
unique pc if bjpally_ruling_state==1
unique pc if nda_ruling_state==1
unique pc if oth_ruling_state==1

*/
********************************************************************************

*** District-wise INC vote share ***
by state dist_name: gen dist_inc_votes1=sum(votes) if inc==1
by state dist_name: egen dist_inc_votes=max(dist_inc_votes1)
drop dist_inc_votes1

*** District-wise INC allies vote share ***
/*
by state dist_name: gen dist_incally_votes1=sum(votes) if incally==1
by state dist_name: egen dist_incally_votes=max(dist_incally_votes1)
drop dist_incally_votes1
*/
by state dist_name: gen dist_incally20042009_votes1=sum(votes) if incally20042009==1
by state dist_name: egen dist_incally20042009_votes=max(dist_incally20042009_votes1)
drop dist_incally20042009_votes1

by state dist_name: gen dist_incallyconst20042009_votes1=sum(votes) if incallyconst20042009==1
by state dist_name: egen dist_incallyconst20042009_votes=max(dist_incallyconst20042009_votes1)
drop dist_incallyconst20042009_votes1

by state dist_name: gen dist_incallyconst2004_votes1=sum(votes) if incallyconst2004==1
by state dist_name: egen dist_incallyconst2004_votes=max(dist_incallyconst2004_votes1)
drop dist_incallyconst2004_votes1

by state dist_name: gen dist_incallyconst2009_votes1=sum(votes) if incallyconst2009==1
by state dist_name: egen dist_incallyconst2009_votes=max(dist_incallyconst2009_votes1)
drop dist_incallyconst2009_votes1

*** District-wise UPA vote share ***
*by state dist_name: gen dist_upa_votes1=sum(votes) if inlist(party,"INC","TRS","LJNSP","RJD","NCP","JMM","MUL","DMK","MDMK","PMK")
/*
by state dist_name: gen dist_upa_votes1=sum(votes) if upa==1
by state dist_name: egen dist_upa_votes=max(dist_upa_votes1)
drop dist_upa_votes1
*/

by state dist_name: gen dist_upa20042009_votes1=sum(votes) if upa20042009==1
by state dist_name: egen dist_upa20042009_votes=max(dist_upa20042009_votes1)
drop dist_upa20042009_votes1

by state dist_name: gen dist_upaconst20042009_votes1=sum(votes) if upaconst20042009==1
by state dist_name: egen dist_upaconst20042009_votes=max(dist_upaconst20042009_votes1)
drop dist_upaconst20042009_votes1

by state dist_name: gen dist_upaconst2004_votes1=sum(votes) if upaconst2004==1
by state dist_name: egen dist_upaconst2004_votes=max(dist_upaconst2004_votes1)
drop dist_upaconst2004_votes1

by state dist_name: gen dist_upaconst2009_votes1=sum(votes) if upaconst2009==1
by state dist_name: egen dist_upaconst2009_votes=max(dist_upaconst2009_votes1)
drop dist_upaconst2009_votes1

by state dist_name: gen dist_bjp_votes1=sum(votes) if bjp==1
by state dist_name: egen dist_bjp_votes=max(dist_bjp_votes1)
drop dist_bjp_votes1

by state dist_name: gen dist_bjpally20042009_votes1=sum(votes) if bjpally20042009==1
by state dist_name: egen dist_bjpally20042009_votes=max(dist_bjpally20042009_votes1)
drop dist_bjpally20042009_votes1

by state dist_name: gen dist_nda20042009_votes1=sum(votes) if nda20042009==1
by state dist_name: egen dist_nda20042009_votes=max(dist_nda20042009_votes1)
drop dist_nda20042009_votes1

by state dist_name: gen dist_oth20042009_votes1=sum(votes) if oth20042009==1
by state dist_name: egen dist_oth20042009_votes=max(dist_oth20042009_votes1)
drop dist_oth20042009_votes1

by state dist_name: gen dist_opp20042009_votes1=sum(votes) if opp20042009==1
by state dist_name: egen dist_opp20042009_votes=max(dist_opp20042009_votes1)
drop dist_opp20042009_votes1

*** Total district votes ***
by state dist_name: gen dist_votes1=sum(votes)
by state dist_name: egen dist_votes=max(dist_votes1)
drop dist_votes1

*** District vote shares ***
gen dist_inc_votshr=dist_inc_votes/dist_votes
/*
gen dist_incally_votshr=dist_incally_votes/dist_votes
gen dist_upa_votshr=dist_upa_votes/dist_votes
*/
gen dist_incally20042009_votshr		=dist_incally20042009_votes/dist_votes
gen dist_incallyconst20042009_votshr=dist_incallyconst20042009_votes/dist_votes
gen dist_incallyconst2004_votshr    =dist_incallyconst2004_votes/dist_votes
gen dist_incallyconst2009_votshr	=dist_incallyconst2009_votes/dist_votes

gen dist_upa20042009_votshr		=dist_upa20042009_votes/dist_votes
gen dist_upaconst20042009_votshr=dist_upaconst20042009_votes/dist_votes
gen dist_upaconst2004_votshr	=dist_upaconst2004_votes/dist_votes
gen dist_upaconst2009_votshr	=dist_upaconst2009_votes/dist_votes

gen dist_bjp_votshr		        =dist_bjp_votes/dist_votes
gen dist_bjpally20042009_votshr	=dist_bjpally20042009_votes/dist_votes
gen dist_nda20042009_votshr		=dist_nda20042009_votes/dist_votes
gen dist_oth20042009_votshr		=dist_oth20042009_votes/dist_votes
gen dist_opp20042009_votshr		=dist_opp20042009_votes/dist_votes

*** Party won ***
sort state pc party
by state pc party: gen pc_votes_1=sum(votes)
by state pc party: egen pc_votes=max(pc_votes_1)
drop pc_votes_1
by state pc:egen partywonvotes=max(pc_votes) 
gen partywon=party if partywonvotes==pc_votes
drop pc_votes partywonvotes

sort state dist_name pc ac candno
by state dist_name pc ac:gen ac_votes_1=sum(votes)
by state dist_name pc ac: egen ac_votes=max(ac_votes_1)
drop ac_votes_1 

drop candno candname party votes
duplicates drop
*** District vote shares ***
********************************************************************************
********************************************************************************
********************************************************************************
*** District weighted no. of seats ***
gen incwon=0
replace incwon=1 if party=="INC"
/*
gen incallywon=0
replace incallywon=1 if inlist(party,"AC","TRS","LJNSP","RJD","NCP")
replace incallywon=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")
*/
gen incally20042009won=0
replace incally20042009won=1 if inlist(partywon,"AC","TRS","LJNSP","RJD","NCP")
replace incally20042009won=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")

gen incallyconst20042009won=0
replace incallyconst20042009won=1 if inlist(partywon,"DMK","JMM","MUL","NCP")

gen incallyconst2004won=0
replace incallyconst2004won=1 if inlist(partywon,"AC","TRS","LJNSP","RJD","NCP")
replace incallyconst2004won=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")

*gen incallyconst2009won=0
*replace incallyconst2009won=1 if inlist(partywon,"AIMIM","JMM","MUL","IUML","KEC(M)")
*replace incallyconst2009won=1 if inlist(partywon,"NCP","DMK","VCK","RLD","AITC")

gen incallyconst2009won=0
replace incallyconst2009won=1 if inlist(partywon,"AITC","NCP","DMK","JMM","IUML","MUL","CVK","KEC(M)")
replace incallyconst2009won=1 if inlist(partywon,"RPI(A)","MD")

/*
gen upawon=0
replace upawon=1 if inlist(partywon,"INC","AC","TRS","LJNSP","RJD","NCP")
replace upawon=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")
*/
gen upa20042009won=0
replace upa20042009won=1 if inlist(partywon,"INC","AC","TRS","LJNSP","RJD","NCP")
replace upa20042009won=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")

gen upaconst20042009won=0
replace upaconst20042009won=1 if inlist(partywon,"INC","DMK","JMM","MUL","NCP")

gen upaconst2004won=0
replace upaconst2004won=1 if inlist(partywon,"INC","AC","TRS","LJNSP","RJD","NCP")
replace upaconst2004won=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")

gen upaconst2009won=0
replace upaconst2009won=1 if inlist(partywon,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace upaconst2009won=1 if inlist(partywon,"RPI(A)","MD")

***	
gen bjpwon=0
replace bjpwon=1 if inlist(partywon,"BJP")

gen bjpally20042009won=0
replace bjpally20042009won=1 if inlist(partywon,"JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
*replace bjpally20042009won=1 if inlist(partywon,"SDF","NPF","MNF")

gen nda20042009won=0
replace nda20042009won=1 if inlist(partywon,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
*replace nda20042009won=1 if inlist(partywon,"SDF","NPF","MNF")

*gen nda20042009won=0
*replace nda20042009won=1 if inlist(partywon,"BJP","JD(U)","SHS","SAD")

*gen oth20042009won=0
*replace oth20042009won=1 if upa20042009won==0 & nda20042009won==0
gen oth20042009won=0
replace oth20042009won=1 if inlist(partywon,"AIFB","AGP","BSP","CPI","CPM","EU","HVP","INLD","JD(S)")
replace oth20042009won=1 if inlist(partywon,"IND","RSP","SP","SHRP","SSP")

*replace oth20042009won=1 if !inlist(partywon,"INC","AC","TRS","LJNSP","RJD","NCP")
*replace oth20042009won=1 if !inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")
*replace oth20042009won=1 if !inlist(partywon,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")

*replace oth20042009won=1 if !inlist(partywon,"SDF","NPF","MNF")

*gen opp20042009won=0
*replace opp20042009won=1 if nda20042009won==1 | oth20042009won==1
gen opp20042009won=0
replace opp20042009won=1 if inlist(partywon,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
replace opp20042009won=1 if inlist(partywon,"AIFB","AGP","BSP","CPI","CPM","EU","HVP","INLD","JD(S)")
replace opp20042009won=1 if inlist(partywon,"IND","RSP","SP","SHRP","SSP")

*replace opp20042009won=1 if inlist(partywon,"BJP","JD(U)","TDP","ADMK","AITC","SHS","BJD","SAD","IFDP")
*replace opp20042009won=1 if inlist(partywon,"SDF","NPF","MNF")
*replace opp20042009won=1 if !inlist(partywon,"INC","AC","TRS","LJNSP","RJD","NCP")
*replace opp20042009won=1 if !inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")


*** PC-AC count method ***
sort state pc dist_name
by state pc :gen pc_ac_count=_N

sort state dist_name pc
by state dist_name pc:gen pc_dist_ac_count=_N
gen pc_dist_wgt=pc_dist_ac_count/pc_ac_count

gen pc_dist_inc_1=pc_dist_wgt if incwon==1
*gen pc_dist_wgtseat_incally_1=pc_dist_wgt if incallywon==1

gen pc_dist_incally20042009_1=pc_dist_wgt if incally20042009won==1
gen pc_dist_incallyconst20042009_1=pc_dist_wgt if incallyconst20042009won==1
gen pc_dist_incallyconst2004_1=pc_dist_wgt if incallyconst2004won==1
gen pc_dist_incallyconst2009_1=pc_dist_wgt if incallyconst2009won==1

*gen pc_dist_wgtseat_upa_1=pc_dist_wgt if upawon==1
gen pc_dist_upa20042009_1=pc_dist_wgt if upa20042009won==1
gen pc_dist_upaconst20042009_1=pc_dist_wgt if upaconst20042009won==1
gen pc_dist_upaconst2004_1=pc_dist_wgt if upaconst2004won==1
gen pc_dist_upaconst2009_1=pc_dist_wgt if upaconst2009won==1

gen pc_dist_bjp_1=pc_dist_wgt if bjpwon==1
gen pc_dist_bjpally20042009_1=pc_dist_wgt if bjpally20042009won==1
gen pc_dist_nda20042009_1=pc_dist_wgt if nda20042009won==1
gen pc_dist_oth20042009_1=pc_dist_wgt if oth20042009won==1
gen pc_dist_opp20042009_1=pc_dist_wgt if opp20042009won==1

*** PC-AC votes method ***
sort state pc dist_name
by state pc :gen pc_votes_1=sum(ac_votes)
by state pc :egen pc_votes=max(pc_votes_1)
drop pc_votes_1

sort state dist_name pc
by state dist_name pc:gen pc_dist_votes_1=sum(ac_votes)
by state dist_name pc:egen pc_dist_votes=max(pc_dist_votes_1)
drop pc_dist_votes_1
*** xxx ***
gen pc_distv_wgt=pc_dist_votes/pc_votes

gen pc_distv_inc_1=pc_distv_wgt if incwon==1

*gen pc_distvotes_wgtseat_incally_1=pc_distvotes_wgt if incallywon==1
gen pc_distv_incally20042009_1=pc_distv_wgt if incally20042009won==1
gen pc_distv_incallyconst20042009_1=pc_distv_wgt if incallyconst20042009won==1
gen pc_distv_incallyconst2004_1=pc_distv_wgt if incallyconst2004won==1
gen pc_distv_incallyconst2009_1=pc_distv_wgt if incallyconst2009won==1

*gen pc_distv_wgtseat_upa_1=pc_distv_wgt if upawon==1
gen pc_distv_upa20042009_1=pc_distv_wgt if upa20042009won==1
gen pc_distv_upaconst20042009_1=pc_distv_wgt if upaconst20042009won==1
gen pc_distv_upaconst2004_1=pc_distv_wgt if upaconst2004won==1
gen pc_distv_upaconst2009_1=pc_distv_wgt if upaconst2009won==1

gen pc_distv_bjp_1=pc_distv_wgt if bjpwon==1
gen pc_distv_bjpally20042009_1=pc_distv_wgt if bjpally20042009won==1
gen pc_distv_nda20042009_1=pc_distv_wgt if nda20042009won==1
gen pc_distv_oth20042009_1=pc_distv_wgt if oth20042009won==1
gen pc_distv_opp20042009_1=pc_distv_wgt if opp20042009won==1
                                                              
drop ac ac_votes
duplicates drop
********************************************************************************
*** PC-AC count method ***
sort state dist_name pc
by state dist_name: gen pc_dist_inc_2=sum(pc_dist_inc_1)
by state dist_name: egen pc_dist_inc=max(pc_dist_inc_2)
drop pc_dist_inc_1 pc_dist_inc_2 

/*
by state dist_name: gen pc_dist_incally_2=sum(pc_dist_incally_1)
by state dist_name: egen pc_dist_incally=max(pc_dist_incally_2)
drop pc_dist_incally_1 pc_dist_incally_2
*/
by state dist_name: gen pc_dist_incally20042009_2=sum(pc_dist_incally20042009_1)
by state dist_name: egen pc_dist_incally20042009=max(pc_dist_incally20042009_2)
drop pc_dist_incally20042009_1 pc_dist_incally20042009_2

by state dist_name: gen pc_dist_incallyconst20042009_2=sum(pc_dist_incallyconst20042009_1)
by state dist_name: egen pc_dist_incallyconst20042009=max(pc_dist_incallyconst20042009_2)
drop pc_dist_incallyconst20042009_1 pc_dist_incallyconst20042009_2

by state dist_name: gen pc_dist_incallyconst2004_2=sum(pc_dist_incallyconst2004_1)
by state dist_name: egen pc_dist_incallyconst2004=max(pc_dist_incallyconst2004_2)
drop pc_dist_incallyconst2004_1 pc_dist_incallyconst2004_2

by state dist_name: gen pc_dist_incallyconst2009_2=sum(pc_dist_incallyconst2009_1)
by state dist_name: egen pc_dist_incallyconst2009=max(pc_dist_incallyconst2009_2)
drop pc_dist_incallyconst2009_1 pc_dist_incallyconst2009_2

/*
by state dist_name: gen pc_dist_upa_2=sum(pc_dist_upa_1)
by state dist_name: egen pc_dist_upa=max(pc_dist_upa_2)
drop pc_dist_upa_1 pc_dist_upa_2
*/
by state dist_name: gen pc_dist_upa20042009_2=sum(pc_dist_upa20042009_1)
by state dist_name: egen pc_dist_upa20042009=max(pc_dist_upa20042009_2)
drop pc_dist_upa20042009_1 pc_dist_upa20042009_2

by state dist_name: gen pc_dist_upaconst20042009_2=sum(pc_dist_upaconst20042009_1)
by state dist_name: egen pc_dist_upaconst20042009=max(pc_dist_upaconst20042009_2)
drop pc_dist_upaconst20042009_1 pc_dist_upaconst20042009_2

by state dist_name: gen pc_dist_upaconst2004_2=sum(pc_dist_upaconst2004_1)
by state dist_name: egen pc_dist_upaconst2004=max(pc_dist_upaconst2004_2)
drop pc_dist_upaconst2004_1 pc_dist_upaconst2004_2

by state dist_name: gen pc_dist_upaconst2009_2=sum(pc_dist_upaconst2009_1)
by state dist_name: egen pc_dist_upaconst2009=max(pc_dist_upaconst2009_2)
drop pc_dist_upaconst2009_1 pc_dist_upaconst2009_2

by state dist_name: gen pc_dist_bjp_2=sum(pc_dist_bjp_1)
by state dist_name: egen pc_dist_bjp=max(pc_dist_bjp_2)
drop pc_dist_bjp_1 pc_dist_bjp_2

by state dist_name: gen pc_dist_bjpally20042009_2=sum(pc_dist_bjpally20042009_1)
by state dist_name: egen pc_dist_bjpally20042009=max(pc_dist_bjpally20042009_2)
drop pc_dist_bjpally20042009_1 pc_dist_bjpally20042009_2

by state dist_name: gen pc_dist_nda20042009_2=sum(pc_dist_nda20042009_1)
by state dist_name: egen pc_dist_nda20042009=max(pc_dist_nda20042009_2)
drop pc_dist_nda20042009_1 pc_dist_nda20042009_2

by state dist_name: gen pc_dist_oth20042009_2=sum(pc_dist_oth20042009_1)
by state dist_name: egen pc_dist_oth20042009=max(pc_dist_oth20042009_2)
drop pc_dist_oth20042009_1 pc_dist_oth20042009_2

by state dist_name: gen pc_dist_opp20042009_2=sum(pc_dist_opp20042009_1)
by state dist_name: egen pc_dist_opp20042009=max(pc_dist_opp20042009_2)
drop pc_dist_opp20042009_1 pc_dist_opp20042009_2

*** PC-AC votes method ***
sort state dist_name pc
by state dist_name: gen pc_distv_inc_2=sum(pc_distv_inc_1)
by state dist_name: egen pc_distv_inc=max(pc_distv_inc_2)
drop pc_distv_inc_1 pc_distv_inc_2 
/*
by state dist_name: gen pc_distv_incally_2=sum(pc_distv_incally_1)
by state dist_name: egen pc_distv_incally=max(pc_distv_incally_2)
drop pc_distv_incally_1 pc_distv_incally_2
*/
by state dist_name: gen pc_distv_incally20042009_2=sum(pc_distv_incally20042009_1)
by state dist_name: egen pc_distv_incally20042009=max(pc_distv_incally20042009_2)
drop pc_distv_incally20042009_1 pc_distv_incally20042009_2

by state dist_name: gen pc_distv_incallyconst20042009_2=sum(pc_distv_incallyconst20042009_1)
by state dist_name: egen pc_distv_incallyconst20042009=max(pc_distv_incallyconst20042009_2)
drop pc_distv_incallyconst20042009_1 pc_distv_incallyconst20042009_2

by state dist_name: gen pc_distv_incallyconst2004_2=sum(pc_distv_incallyconst2004_1)
by state dist_name: egen pc_distv_incallyconst2004=max(pc_distv_incallyconst2004_2)
drop pc_distv_incallyconst2004_1 pc_distv_incallyconst2004_2

by state dist_name: gen pc_distv_incallyconst2009_2=sum(pc_distv_incallyconst2009_1)
by state dist_name: egen pc_distv_incallyconst2009=max(pc_distv_incallyconst2009_2)
drop pc_distv_incallyconst2009_1 pc_distv_incallyconst2009_2

/*
by state dist_name: gen pc_distv_upa_2=sum(pc_distv_upa_1)
by state dist_name: egen pc_distv_upa=max(pc_distv_upa_2)
drop pc_distv_upa_1 pc_distv_upa_2
*/
by state dist_name: gen pc_distv_upa20042009_2=sum(pc_distv_upa20042009_1)
by state dist_name: egen pc_distv_upa20042009=max(pc_distv_upa20042009_2)
drop pc_distv_upa20042009_1 pc_distv_upa20042009_2

by state dist_name: gen pc_distv_upaconst20042009_2=sum(pc_distv_upaconst20042009_1)
by state dist_name: egen pc_distv_upaconst20042009=max(pc_distv_upaconst20042009_2)
drop pc_distv_upaconst20042009_1 pc_distv_upaconst20042009_2

by state dist_name: gen pc_distv_upaconst2004_2=sum(pc_distv_upaconst2004_1)
by state dist_name: egen pc_distv_upaconst2004=max(pc_distv_upaconst2004_2)
drop pc_distv_upaconst2004_1 pc_distv_upaconst2004_2

by state dist_name: gen pc_distv_upaconst2009_2=sum(pc_distv_upaconst2009_1)
by state dist_name: egen pc_distv_upaconst2009=max(pc_distv_upaconst2009_2)
drop pc_distv_upaconst2009_1 pc_distv_upaconst2009_2

by state dist_name: gen pc_distv_bjp_2=sum(pc_distv_bjp_1)
by state dist_name: egen pc_distv_bjp=max(pc_distv_bjp_2)
drop pc_distv_bjp_1 pc_distv_bjp_2 

by state dist_name: gen pc_distv_bjpally20042009_2=sum(pc_distv_bjpally20042009_1)
by state dist_name: egen pc_distv_bjpally20042009=max(pc_distv_bjpally20042009_2)
drop pc_distv_bjpally20042009_1 pc_distv_bjpally20042009_2

by state dist_name: gen pc_distv_nda20042009_2=sum(pc_distv_nda20042009_1)
by state dist_name: egen pc_distv_nda20042009=max(pc_distv_nda20042009_2)
drop pc_distv_nda20042009_1 pc_distv_nda20042009_2

by state dist_name: gen pc_distv_oth20042009_2=sum(pc_distv_oth20042009_1)
by state dist_name: egen pc_distv_oth20042009=max(pc_distv_oth20042009_2)
drop pc_distv_oth20042009_1 pc_distv_oth20042009_2

by state dist_name: gen pc_distv_opp20042009_2=sum(pc_distv_opp20042009_1)
by state dist_name: egen pc_distv_opp20042009=max(pc_distv_opp20042009_2)
drop pc_distv_opp20042009_1 pc_distv_opp20042009_2

/*
drop pc partywon inc incally upa incwon incallywon upawon dist_inc_votes dist_incally_votes dist_upa_votes dist_votes ///
	 pc_ac_count pc_dist_ac_count pc_dist_wgt pc_votes pc_dist_votes pc_distvotes_wgt 
*/
drop pc partywon inc incally20042009 incallyconst20042009 incallyconst2004 incallyconst2009 upa20042009 upaconst20042009 upaconst2004 upaconst2009 bjp bjpally20042009 nda20042009 oth20042009 opp20042009 ///
	 incwon incally20042009won incallyconst20042009won incallyconst2004won incallyconst2009won upa20042009won upaconst20042009won upaconst2004won upaconst2009won bjpwon bjpally20042009won nda20042009won oth20042009won opp20042009won ///
	 dist_inc_votes dist_incally20042009_votes dist_incallyconst20042009_votes dist_incallyconst2004_votes dist_incallyconst2009_votes ///
	 dist_upa20042009_votes dist_upaconst20042009_votes dist_upaconst2004_votes dist_upaconst2009_votes dist_bjp_votes dist_bjpally20042009_votes dist_nda20042009_votes dist_oth20042009_votes dist_opp20042009_votes ///
	 dist_votes pc_ac_count pc_dist_ac_count pc_dist_wgt pc_votes pc_dist_votes pc_distv_wgt 
duplicates drop

export excel using "...\GE\2004 dist output new1.xls", firstrow(variables) replace
save               "...\GE\2004 dist output new1.dta",replace

*save "...\GE\2004_dist_inc_votshr_2.dta",replace
*** District weighted no. of seats ***
********************************************************************************
********************************************************************************
********************************************************************************

*save "...\GE\2004_dist_votshr.dta",replace
