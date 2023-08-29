
/*
clear
import excel using "...\GE\2009-PC-AC temp - working.xlsx",sheet(Consolidated sheet (2)) firstrow
*/
*** If import does not work, so paste the data ***

order state dist_name 
sort state dist_name pc ac cand

gen inc=0
replace inc=1 if party=="INC"
/*
gen incally=0
replace incally=1 if inlist(party,"AIMIM","JMM","MUL","IUML","KEC(M)")
replace incally=1 if inlist(party,"NCP","DMK","VCK","RLD","AITC")
*/
*** https://en.wikipedia.org/wiki/List_of_United_Progressive_Alliance_candidates_in_the_2009_Indian_general_election ***
*gen incally20042009=0
*replace incally20042009=1 if inlist(party,"AIMIM","JMM","MUL","IUML","KEC(M)")
*replace incally20042009=1 if inlist(party,"NCP","DMK","VCK","RLD","AITC")
gen incally20042009=0
replace incally20042009=1 if inlist(party,"AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace incally20042009=1 if inlist(party,"RPI(A)","MD")

gen incallyconst20042009=0
replace incallyconst20042009=1 if inlist(party,"DMK","JMM","NCP","MUL")

gen incallyconst2004=0
replace incallyconst2004=1 if inlist(party,"AC","TRS","LJP","RJD","NCP")
replace incallyconst2004=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")

*gen incallyconst2009=0
*replace incallyconst2009=1 if inlist(party,"AIMIM","JMM","MUL","IUML","KEC(M)")
*replace incallyconst2009=1 if inlist(party,"NCP","DMK","VCK","RLD","AITC")
gen incallyconst2009=0
replace incallyconst2009=1 if inlist(party,"AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace incallyconst2009=1 if inlist(party,"RPI(A)","MD")


/*
gen upa=0
replace upa=1 if inlist(party,"INC","AIMIM","JMM","MUL","IUML","KEC(M)")
replace upa=1 if inlist(party,"NCP","DMK","VCK","RLD","AITC")
*/

*gen upa20042009=0
*replace upa20042009=1 if inlist(party,"INC","AIMIM","JMM","MUL","IUML","KEC(M)")
*replace upa20042009=1 if inlist(party,"NCP","DMK","VCK","RLD","AITC")
gen upa20042009=0
replace upa20042009=1 if inlist(party,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace upa20042009=1 if inlist(party,"RPI(A)","MD")

gen upaconst20042009=0
replace upaconst20042009=1 if inlist(party,"INC","DMK","JMM","NCP","MUL")

gen upaconst2004=0
replace upaconst2004=1 if inlist(party,"INC","AC","TRS","LJP","RJD","NCP")
replace upaconst2004=1 if inlist(party,"JMM","MUL","DMK","MDMK","PMK")

gen upaconst2009=0
replace upaconst2009=1 if inlist(party,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace upaconst2009=1 if inlist(party,"RPI(A)","MD")

***	https://en.wikipedia.org/wiki/National_Democratic_Alliance#Candidates_in_elections ***
*gen nda20042009=0
*replace nda20042009=1 if inlist(party,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")
gen bjp=0
replace bjp=1 if inlist(party,"BJP")

gen bjpally20042009=0
replace bjpally20042009=1 if inlist(party,"JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")

gen nda20042009=0
replace nda20042009=1 if inlist(party,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")

gen oth20042009=0
replace oth20042009=1 if inlist(party,"ADMK","AUDF","BSP","BVA","BJD","BOPF","CPI","CPM","HJCBL")
replace oth20042009=1 if inlist(party,"JD(S)","JVM(P)","MDMK","NPLF","PRAP","RJD","SP")
replace oth20042009=1 if inlist(party,"IND","SDF","SWP","TDP")

*replace oth20042009=1 if !inlist(party,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
*replace oth20042009=1 if !inlist(party,"RPI(A)","MD")
*replace oth20042009=1 if !inlist(party,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")

*gen oth20042009=0
*replace oth20042009=1 if upa20042009==0 & nda20042009==0

gen opp20042009=0
replace opp20042009=1 if inlist(party,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")
replace opp20042009=1 if inlist(party,"ADMK","AUDF","BSP","BVA","BJD","BOPF","CPI","CPM","HJCBL")
replace opp20042009=1 if inlist(party,"JD(S)","JVM(P)","MDMK","NPLF","PRAP","RJD","SP")
replace opp20042009=1 if inlist(party,"IND","SDF","SWP","TDP")

*** INC vote share ***
by state dist_name: gen dist_inc_votes1=sum(votes) if inc==1
by state dist_name: egen dist_inc_votes=max(dist_inc_votes1)
drop dist_inc_votes1

*** INC allies vote share ***
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

*** UPA vote share ***
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

*** Total District votes ***
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
gen dist_incallyconst2004_votshr	=dist_incallyconst2004_votes/dist_votes
gen dist_incallyconst2009_votshr	=dist_incallyconst2009_votes/dist_votes

gen dist_upa20042009_votshr			=dist_upa20042009_votes/dist_votes
gen dist_upaconst20042009_votshr	=dist_upaconst20042009_votes/dist_votes
gen dist_upaconst2004_votshr		=dist_upaconst2004_votes/dist_votes
gen dist_upaconst2009_votshr		=dist_upaconst2009_votes/dist_votes

gen dist_bjp_votshr			        =dist_bjp_votes/dist_votes
gen dist_bjpally20042009_votshr		=dist_bjpally20042009_votes/dist_votes
gen dist_nda20042009_votshr			=dist_nda20042009_votes/dist_votes
gen dist_oth20042009_votshr			=dist_oth20042009_votes/dist_votes
gen dist_opp20042009_votshr			=dist_opp20042009_votes/dist_votes

*** Party won ***
sort state pc party
by state pc party: gen pc_votes_1=sum(votes)
by state pc party: egen pc_votes=max(pc_votes_1)
drop pc_votes_1
by state pc:egen partywonvotes=max(pc_votes) 
gen partywon=party if partywonvotes==pc_votes
drop pc_votes partywonvotes

order state dist_name 
sort state dist_name pc ac cand

by state dist_name pc ac:gen ac_votes_1=sum(votes)
by state dist_name pc ac: egen ac_votes=max(ac_votes_1)
drop ac_votes_1 

drop cand party votes
duplicates drop

*** Following 4 lines of comments are not needed, it was followed when 2 sets of district output were obtained ***
********************************************************************************
*** save the above data to 2009-PC-AC temp - working.xlsx (in Matching req data GE_2009 sheet) ***
*** After matching the above data with "GE_2009.xlsx's (Required data) sheet", ***
*** we get the merged clean data in "Matching req data GE_2009_clean" sheet ***
*** Use the sheet thereby obtained, for below code ***
********************************************************************************

/*clear
import excel using "...\GE\2009-PC-AC temp - working.xlsx",sheet(Matching req data GE_2009_clean) firstrow
*** import does not work, so paste the data ***
*/

sort state dist_name pc
gen incwon=0
replace incwon=1 if partywon=="INC"
/*
gen incallywon=0
replace incallywon=1 if inlist(partywon,"AIMIM","JMM","MUL","IUML","KEC(M)")
replace incallywon=1 if inlist(partywon,"NCP","DMK","VCK","RLD","AITC")
*/
gen incally20042009won=0
replace incally20042009won=1 if inlist(partywon,"AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace incally20042009won=1 if inlist(partywon,"RPI(A)","MD")

gen incallyconst20042009won=0
replace incallyconst20042009won=1 if inlist(partywon,"DMK","JMM","MUL","NCP")

gen incallyconst2004won=0
replace incallyconst2004won=1 if inlist(partywon,"AC","TRS","LJP","RJD","NCP")
replace incallyconst2004won=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")

gen incallyconst2009won=0
replace incallyconst2009won=1 if inlist(partywon,"AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace incallyconst2009won=1 if inlist(partywon,"RPI(A)","MD")

/*
gen upawon=0
replace upawon=1 if inlist(partywon,"INC","AIMIM","JMM","MUL","IUML","KEC(M)")
replace upawon=1 if inlist(partywon,"NCP","DMK","VCK","RLD","AITC")
*/
gen upa20042009won=0
replace upa20042009won=1 if inlist(partywon,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace upa20042009won=1 if inlist(partywon,"RPI(A)","MD")

gen upaconst20042009won=0
replace upaconst20042009won=1 if inlist(partywon,"INC","DMK","JMM","MUL","NCP")

gen upaconst2004won=0
replace upaconst2004won=1 if inlist(partywon,"INC","AC","TRS","LJP","RJD","NCP")
replace upaconst2004won=1 if inlist(partywon,"JMM","MUL","DMK","MDMK","PMK")

gen upaconst2009won=0
replace upaconst2009won=1 if inlist(partywon,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
replace upaconst2009won=1 if inlist(partywon,"RPI(A)","MD")
***
gen bjpwon=0
replace bjpwon=1 if inlist(partywon,"BJP")

gen bjpally20042009won=0
replace bjpally20042009won=1 if inlist(partywon,"JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")

gen nda20042009won=0
replace nda20042009won=1 if inlist(partywon,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")

gen oth20042009won=0
replace oth20042009won=1 if inlist(partywon,"ADMK","AUDF","BSP","BVA","BJD","BOPF","CPI","CPM","HJCBL")
replace oth20042009won=1 if inlist(partywon,"JD(S)","JVM(P)","MDMK","NPLF","PRAP","RJD","SP")
replace oth20042009won=1 if inlist(partywon,"IND","SDF","SWP","TDP")

*replace oth20042009won=1 if !inlist(partywon,"INC","AITC","NCP","DMK","JMM","IUML","MUL","VCK","KEC(M)")
*replace oth20042009won=1 if !inlist(partywon,"RPI(A)","MD")
*replace oth20042009won=1 if !inlist(partywon,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")

gen opp20042009won=0
replace opp20042009won=1 if inlist(partywon,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")
replace opp20042009won=1 if inlist(partywon,"ADMK","AUDF","BSP","BVA","BJD","BOPF","CPI","CPM","HJCBL")
replace opp20042009won=1 if inlist(partywon,"JD(S)","JVM(P)","MDMK","NPLF","PRAP","RJD","SP")
replace opp20042009won=1 if inlist(partywon,"IND","SDF","SWP","TDP")

*gen oth20042009won=0
*replace oth20042009won=1 if upa20042009won==0 & nda20042009won==0

*gen opp20042009won=0
*replace opp20042009won=1 if nda20042009won==1 | oth20042009won==0

*gen oth20042009won=0
*replace oth20042009won=1 if inlist(partywon,"BJP","JD(U)","SHS","SAD","RLD","AGP","INLD","NPF")
*replace oth20042009won=1 if inlist(partywon,"ADMK","AUDF","BSP","BVA","BJD","BOPF","CPI","CPM","HJCBL")
*replace oth20042009won=1 if inlist(partywon,"JD(S)","JVM(P)","MDMK","NPLF","PRAP","RJD","SP")
*replace oth20042009won=1 if inlist(partywon,"IND","SDF","SWP","TDP")

*** PC-AC count method ***
sort state pc dist_name
by state pc :gen pc_ac_count=_N

sort state dist_name pc
by state dist_name pc:gen pc_dist_ac_count=_N

gen pc_dist_wgt=pc_dist_ac_count/pc_ac_count

gen pc_dist_inc_1=pc_dist_wgt if incwon==1    
*gen pc_dist_incally_1=pc_dist_wgt if incallywon==1
gen pc_dist_incally20042009_1	  =pc_dist_wgt if incally20042009won==1
gen pc_dist_incallyconst20042009_1=pc_dist_wgt if incallyconst20042009won==1
gen pc_dist_incallyconst2004_1	  =pc_dist_wgt if incallyconst2004won==1
gen pc_dist_incallyconst2009_1	  =pc_dist_wgt if incallyconst2009won==1
*gen pc_dist_upa_1=pc_dist_wgt if upawon==1
gen pc_dist_upa20042009_1	  =pc_dist_wgt if upa20042009won==1
gen pc_dist_upaconst20042009_1=pc_dist_wgt if upaconst20042009won==1
gen pc_dist_upaconst2004_1	  =pc_dist_wgt if upaconst2004won==1
gen pc_dist_upaconst2009_1	  =pc_dist_wgt if upaconst2009won==1

gen pc_dist_bjp_1	          =pc_dist_wgt if bjpwon==1
gen pc_dist_bjpally20042009_1 =pc_dist_wgt if bjpally20042009won==1
gen pc_dist_nda20042009_1	  =pc_dist_wgt if nda20042009won==1
gen pc_dist_oth20042009_1	  =pc_dist_wgt if oth20042009won==1
gen pc_dist_opp20042009_1	  =pc_dist_wgt if opp20042009won==1

*** PC-AC votes method ***
sort state pc dist_name
by state pc :gen pc_votes_1=sum(ac_votes)
by state pc :egen pc_votes=max(pc_votes_1)
drop pc_votes_1

sort state dist_name pc
by state dist_name pc:gen pc_dist_votes_1=sum(ac_votes)
by state dist_name pc:egen pc_dist_votes=max(pc_dist_votes_1)
drop pc_dist_votes_1

gen pc_distv_wgt=pc_dist_votes/pc_votes

gen pc_distv_inc_1=pc_distv_wgt if incwon==1     
*gen pc_distv_incally_1=pc_distv_wgt if incallywon==1
gen pc_distv_incally20042009_1=pc_distv_wgt if incally20042009won==1
gen pc_distv_incallyconst20042009_1=pc_distv_wgt if incallyconst20042009won==1
gen pc_distv_incallyconst2004_1=pc_distv_wgt if incallyconst2004won==1
gen pc_distv_incallyconst2009_1=pc_distv_wgt if incallyconst2009won==1

*gen pc_distvotes_wgtseat_upa_1=pc_distvotes_wgt if upawon==1
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

drop pc partywon inc incally20042009 incallyconst20042009 incallyconst2004 incallyconst2009 upa20042009 upaconst20042009 upaconst2004 upaconst2009 bjp bjpally20042009 nda20042009 oth20042009 opp20042009 /// 
	 incwon incally20042009won incallyconst20042009won incallyconst2004won incallyconst2009won upa20042009won upaconst20042009won upaconst2004won upaconst2009won bjpwon bjpally20042009won nda20042009won oth20042009won opp20042009won ///
	 dist_votes dist_inc_votes dist_incally20042009_votes dist_incallyconst20042009_votes dist_incallyconst2004_votes dist_incallyconst2009_votes ///
	 dist_upa20042009_votes dist_upaconst20042009_votes dist_upaconst2004_votes dist_upaconst2009_votes dist_bjp_votes dist_bjpally20042009_votes dist_nda20042009_votes dist_oth20042009_votes dist_opp20042009_votes ///
	 pc_ac_count pc_dist_ac_count pc_dist_wgt pc_votes pc_dist_votes pc_distv_wgt
duplicates drop

export excel using "...\GE\2009 dist output new1.xls", firstrow(variables) replace
save               "...\GE\2009 dist output new1.dta",replace

append using "...\GE\2004 dist output new1.dta"
********************************************************************************
*** State and District renaming as that of 2004 dist output file ***
tab state
replace state="ANDHRA PRADESH" if state=="S01 - Andhra Pradesh"
replace state="ARUNACHAL PRADESH" if state=="S02 - Arunachal Pradesh" 
replace state="ASSAM" if state=="S03 - Assam"
replace state="BIHAR" if state=="S04 - Bihar"
replace state="GOA" if state=="S05 - Goa"
replace state="GUJARAT" if state=="S06 - Gujarat"
replace state="HARYANA" if state=="S07 - Haryana"
replace state="HIMACHAL PRADESH" if state=="S08 - Himachal Pradesh"
replace state="KARNATAKA" if state=="S10 - Karnataka"
replace state="KERALA" if state=="S11 - Kerala"
replace state="MADHYA PRADESH" if state=="S12 - Madhya Pradesh"
replace state="MAHARASHTRA" if state=="S13 - Maharashtra"
replace state="MANIPUR" if state=="S14 - Manipur"
replace state="MEGHALAYA" if state=="S15 - Meghalaya"
replace state="MIZORAM" if state=="S16 - Mizoram"
replace state="NAGALAND" if state=="S17 - Nagaland"
replace state="ORISSA" if state=="S18 - Orissa"
replace state="PUNJAB" if state=="S19 - Punjab"
replace state="RAJASTHAN" if state=="S20 - Rajasthan"
replace state="SIKKIM" if state=="S21 - Sikkim"
replace state="TAMIL NADU" if state=="S22 - Tamil Nadu"
replace state="TRIPURA" if state=="S23 - Tripura"
replace state="UTTAR PRADESH" if state=="S24 - Uttar Pradesh"
replace state="WEST BENGAL" if state=="S25 - West Bengal"
replace state="UTTARAKHAND" if state=="S28 - Uttarakhand"
replace state="CHHATTISGARH" if state=="S26 - Chattisgarh"
replace state="JHARKHAND" if state=="S27 - Jharkhand"
tab state

*** Districts ***
tab dist_name if state=="ANDHRA PRADESH" & year==2004
tab dist_name if state=="ANDHRA PRADESH" & year==2009
replace dist_name="Cuddapah" if dist_name=="Kadapa" & state=="ANDHRA PRADESH"
replace dist_name="Mahbubnagar" if dist_name=="Mahabubnagar" & state=="ANDHRA PRADESH"
replace dist_name="Nellore" if dist_name=="Nellore " & state=="ANDHRA PRADESH"
replace dist_name="Vishakapatnam" if dist_name=="Visakhapatnam" & state=="ANDHRA PRADESH"
replace dist_name="Prakasam " if dist_name=="Prakasam" & state=="ANDHRA PRADESH"
tab dist_name if state=="ANDHRA PRADESH"

tab dist_name if state=="CHHATTISGARH" & year==2004
tab dist_name if state=="CHHATTISGARH" & year==2009
replace dist_name = proper(dist_name) if state=="CHHATTISGARH"
tab dist_name if state=="CHHATTISGARH"
replace dist_name="Koriya" if dist_name=="Koria" & state=="CHHATTISGARH"

tab dist_name if state=="GUJARAT" & year==2004
tab dist_name if state=="GUJARAT" & year==2009
tab dist_name if state=="GUJARAT"
replace dist_name="Broach" if dist_name=="Bharuch" & state=="GUJARAT"
replace dist_name="Dohad" if dist_name=="Dahod" & state=="GUJARAT"
replace dist_name="Kutch" if dist_name=="Kachchh" & state=="GUJARAT"
replace dist_name="Mehsana" if dist_name=="Mahesana" & state=="GUJARAT"
replace dist_name="Baroda" if dist_name=="Vadodara" & state=="GUJARAT"
replace dist_name="Bulsar" if dist_name=="Valsad" & state=="GUJARAT"
replace dist_name="Kaira" if dist_name=="Kheda" & state=="GUJARAT"
tab dist_name if state=="GUJARAT"

tab dist_name if state=="HARYANA" & year==2004
tab dist_name if state=="HARYANA" & year==2009
replace dist_name = proper(dist_name) if state=="HARYANA"
tab dist_name if state=="HARYANA"
replace dist_name="Yamuna-Nagar" if dist_name=="Yamunanagar" & state=="HARYANA"
tab dist_name if state=="HARYANA"

tab dist_name if state=="HIMACHAL PRADESH"
replace dist_name = proper(dist_name) if state=="HIMACHAL PRADESH"
tab dist_name if state=="HIMACHAL PRADESH"

tab dist_name if state=="KARNATAKA" & year==2004
tab dist_name if state=="KARNATAKA" & year==2009
replace dist_name = proper(dist_name) if state=="KARNATAKA"
tab dist_name if state=="KARNATAKA"
replace dist_name="Chikmagalur" if dist_name=="Chickmagalur" & state=="KARNATAKA"
replace dist_name="South Kanara" if dist_name=="Dakshina Kannada" & state=="KARNATAKA"
replace dist_name="Dharwar" if dist_name=="Dharwad" & state=="KARNATAKA"
replace dist_name="Coorg" if dist_name=="Kodagu" & state=="KARNATAKA"
replace dist_name="North Kanara" if dist_name=="Uttara Kannada" & state=="KARNATAKA"
tab dist_name if state=="KARNATAKA"

tab dist_name if state=="MADHYA PRADESH" & year==2004
tab dist_name if state=="MADHYA PRADESH" & year==2009
tab dist_name if state=="MADHYA PRADESH"
replace dist_name = proper(dist_name) if state=="MADHYA PRADESH"
replace dist_name="Atia" if dist_name=="Datia" & state=="MADHYA PRADESH"
replace dist_name="Chhatarpur" if dist_name=="Chhatrapur" & state=="MADHYA PRADESH"
replace dist_name="East Nimar (Khandwa)" if dist_name=="East Nimar" & state=="MADHYA PRADESH"
replace dist_name="Narsimhapur" if dist_name=="Narsinhpur" & state=="MADHYA PRADESH"
replace dist_name="West Nimar (Khargone)" if dist_name=="West Nimar" & state=="MADHYA PRADESH"

tab dist_name if state=="MAHARASHTRA" & year==2004
tab dist_name if state=="MAHARASHTRA" & year==2009
tab dist_name if state=="MAHARASHTRA"
replace dist_name = proper(dist_name) if state=="MAHARASHTRA"
replace dist_name="Mumbai suburban" if dist_name=="Mumbai Suburban" & state=="MAHARASHTRA"
replace dist_name="Mumbai city" if dist_name=="Mumbai City" & state=="MAHARASHTRA"
replace dist_name="Dhule" if dist_name==" Dhule" & state=="MAHARASHTRA"
replace dist_name="Wardha" if dist_name==" Wardha" & state=="MAHARASHTRA"
replace dist_name="Gondia" if dist_name=="Gondiya" & state=="MAHARASHTRA"

tab dist_name if state=="MEGHALAYA" & year==2004
tab dist_name if state=="MEGHALAYA" & year==2009
tab dist_name if state=="MEGHALAYA"
replace dist_name="WILLIAMNAGAR, DC" if dist_name=="EAST GARO HILLS" & state=="MEGHALAYA"
replace dist_name="KHLIEHRIAT, SDO(C )" if dist_name=="EAST JAINTIA HILLS" & state=="MEGHALAYA"
replace dist_name="SHILLONG, DC" if dist_name=="EAST KHASI HILLS" & state=="MEGHALAYA"
replace dist_name="RESUBELPARA,  SDO(C )" if dist_name=="NORTH GARO HILLS" & state=="MEGHALAYA"
replace dist_name="NONGPOH, DC" if dist_name=="RI BHOI" & state=="MEGHALAYA"
replace dist_name="BAGHMARA, DC" if dist_name=="SOUTH GARO HILLS" & state=="MEGHALAYA"
replace dist_name="AMPATIGIRI,  SDO(C )" if dist_name=="WEST GARO HILLS" & state=="MEGHALAYA"
replace dist_name="JOWAI, DC" if dist_name=="WEST JAINTIA HILLS" & state=="MEGHALAYA"
replace dist_name="NONGSTOIN, DC" if dist_name=="WEST KHASI HILLS" & state=="MEGHALAYA"
replace dist_name="MAWKYRWAT, SDO(C )" if dist_name=="SOUTH WEST KHASI HILLS" & state=="MEGHALAYA"
tab dist_name if state=="MEGHALAYA"

tab dist_name if state=="MIZORAM"
replace dist_name = strupper(dist_name) if state=="MIZORAM"
replace dist_name="AIZAWL" if dist_name=="AIZAWL                        " & state=="MIZORAM"
replace dist_name="CHAMPHAI" if dist_name=="CHAMPHAI                      " & state=="MIZORAM"
replace dist_name="KOLASIB" if dist_name=="KOLASIB                       " & state=="MIZORAM"
replace dist_name="LAWNGTLAI" if dist_name=="LAWNGTLAI                     " & state=="MIZORAM"
replace dist_name="LUNGLEI" if dist_name=="LUNGLEI                       " & state=="MIZORAM"
replace dist_name="MAMIT" if dist_name=="MAMIT                         " & state=="MIZORAM"
replace dist_name="SAIHA" if dist_name=="SAIHA                         " & state=="MIZORAM"
replace dist_name="SERCHHIP" if dist_name=="SERCHHIP                      " & state=="MIZORAM"
tab dist_name if state=="MIZORAM"

tab dist_name if state=="ORISSA" & year==2004
tab dist_name if state=="ORISSA" & year==2009
tab dist_name if state=="ORISSA"
replace dist_name = proper(dist_name) if state=="ORISSA"
replace dist_name="Koraput " if dist_name=="Koraput" & state=="ORISSA"
replace dist_name="Boudh-Khondmals" if dist_name=="Boudh" & state=="ORISSA"

tab dist_name if state=="PUNJAB" & year==2004
tab dist_name if state=="PUNJAB" & year==2009
tab dist_name if state=="PUNJAB"
replace dist_name = proper(dist_name) if state=="PUNJAB"
replace dist_name="Bhatinda" if dist_name=="Bathinda" & state=="PUNJAB"
replace dist_name="Ferozepur" if dist_name=="Firozpur" & state=="PUNJAB"
replace dist_name="Jullundur" if dist_name=="Jalandhar" & state=="PUNJAB"
replace dist_name="Ropar" if dist_name=="Rupnagar" & state=="PUNJAB"

tab dist_name if state=="RAJASTHAN" & year==2004
tab dist_name if state=="RAJASTHAN" & year==2009
tab dist_name if state=="RAJASTHAN"
replace dist_name = proper(dist_name) if state=="RAJASTHAN"
replace dist_name="Jhunjhunu" if dist_name=="Jhunjhunun" & state=="RAJASTHAN"
replace dist_name="Sawaimadhopur" if dist_name=="Sawai Madhopur" & state=="RAJASTHAN"

tab dist_name if state=="SIKKIM" & year==2004
tab dist_name if state=="SIKKIM" & year==2009
tab dist_name if state=="SIKKIM"
replace dist_name="Sikkim East" if dist_name=="East Sikkim" & state=="SIKKIM"
replace dist_name="Sikkim South" if dist_name=="South Sikkim" & state=="SIKKIM"
replace dist_name="Sikkim North" if dist_name=="North Sikkim" & state=="SIKKIM"
replace dist_name="Sikkim West" if dist_name=="West Sikkim" & state=="SIKKIM"

tab dist_name if state=="TAMIL NADU" & year==2004
tab dist_name if state=="TAMIL NADU" & year==2009
tab dist_name if state=="TAMIL NADU"
replace dist_name = proper(dist_name) if state=="TAMIL NADU"
replace dist_name="Tiruvallur" if dist_name=="Thiruvallur" & state=="TAMIL NADU"
replace dist_name="Villupuram" if dist_name=="Viluppuram" & state=="TAMIL NADU"
replace dist_name="Dharmapuri" if dist_name==" Dharmapuri" & state=="TAMIL NADU"
replace dist_name="Kancheepuram" if dist_name==" Kancheepuram" & state=="TAMIL NADU"
replace dist_name="Vellore" if dist_name==" Vellore" & state=="TAMIL NADU"
replace dist_name="Thoothukudi" if dist_name=="Thoothukkudi" & state=="TAMIL NADU"

tab dist_name if state=="TRIPURA"
replace dist_name = proper(dist_name) if state=="TRIPURA"

tab dist_name if state=="UTTAR PRADESH" & year==2004
tab dist_name if state=="UTTAR PRADESH" & year==2009
tab dist_name if state=="UTTAR PRADESH"
replace dist_name = proper(dist_name) if state=="UTTAR PRADESH"
replace dist_name="Buland Shahr" if dist_name=="Bulandshahr" & state=="UTTAR PRADESH"
replace dist_name="Chitrakut" if dist_name=="Chitrakoot" & state=="UTTAR PRADESH"
replace dist_name="Gauttam Budh Nagar" if dist_name=="Gautam Buddha Nagar" & state=="UTTAR PRADESH"
replace dist_name="Hathras" if dist_name=="Mahamayanagar" & state=="UTTAR PRADESH"
replace dist_name="Jyotiba Pholey Nagar" if dist_name=="Jyotiba Phule Nagar" & state=="UTTAR PRADESH"
replace dist_name="Muzaffar Nagar" if dist_name=="Muzaffarnagar" & state=="UTTAR PRADESH"
replace dist_name="Sant Ravidas Nagar" if dist_name=="Sant Ravidas Nagar " & state=="UTTAR PRADESH"
replace dist_name="Siddharth Nagar" if dist_name=="Siddharthnagar" & state=="UTTAR PRADESH"

tab dist_name if state=="UTTARAKHAND" & year==2004
tab dist_name if state=="UTTARAKHAND" & year==2009
tab dist_name if state=="UTTARAKHAND"
replace dist_name = proper(dist_name) if state=="UTTARAKHAND"
replace dist_name="Pauri Garhwal" if dist_name=="Garhwal" & state=="UTTARAKHAND"

tab dist_name if state=="WEST BENGAL" & year==2004
tab dist_name if state=="WEST BENGAL" & year==2009
tab dist_name if state=="WEST BENGAL"
replace dist_name = proper(dist_name) if state=="WEST BENGAL"
replace dist_name="Burdwan" if dist_name=="Bardhaman" & state=="WEST BENGAL"
replace dist_name="Kolkatta" if dist_name=="Kolkata" & state=="WEST BENGAL"
replace dist_name="Malda" if dist_name=="Maldaha" & state=="WEST BENGAL"
replace dist_name="North 24-Parganas" if dist_name=="North 24 Parganas" & state=="WEST BENGAL"
replace dist_name="South 24-Parganas" if dist_name=="South 24 Parganas" & state=="WEST BENGAL"
replace dist_name="Murshidabad" if dist_name==" Murshidabad" & state=="WEST BENGAL"
replace dist_name="Pashchim Medinipur" if dist_name=="Paschim Medinipur" & state=="WEST BENGAL"

sort state dist_name year
by state dist_name: gen dist_count=_N
tab dist_count
ta dist_name if dist_count==1
unique state dist_name if year==2004
unique state dist_name if year==2009

replace dist_inc_votshr=0 if dist_inc_votshr==.
replace dist_incally20042009_votshr=0 if dist_incally20042009_votshr==.
replace dist_incallyconst20042009_votshr=0 if dist_incallyconst20042009_votshr==.
replace dist_incallyconst2004_votshr=0 if dist_incallyconst2004_votshr==.
replace dist_incallyconst2009_votshr=0 if dist_incallyconst2009_votshr==.
replace dist_upa20042009_votshr=0 if dist_upa20042009_votshr==.
replace dist_upaconst20042009_votshr=0 if dist_upaconst20042009_votshr==.
replace dist_upaconst2004_votshr=0 if dist_upaconst2004_votshr==.
replace dist_upaconst2009_votshr=0 if dist_upaconst2009_votshr==.
replace dist_bjp_votshr=0 if dist_bjp_votshr==.
replace dist_bjpally20042009_votshr=0 if dist_bjpally20042009_votshr==.
replace dist_nda20042009_votshr=0 if dist_nda20042009_votshr==. 
replace dist_oth20042009_votshr=0 if dist_oth20042009_votshr==. 
replace dist_opp20042009_votshr=0 if dist_opp20042009_votshr==.

export excel using "...\GE\2004-2009 dist output new1.xls", firstrow(variables) replace
save "...\GE\2004-2009 dist output new1.dta",replace

********************************************************************************
********************************************************************************
********************************************************************************

cd "...\GE"
clear
use "2004-2009 dist output new1.dta"

replace dist_inc_votshr=0 if dist_inc_votshr==.
replace dist_incally20042009_votshr=0 if dist_incally20042009_votshr==.
replace dist_incallyconst20042009_votshr=0 if dist_incallyconst20042009_votshr==.
replace dist_incallyconst2004_votshr=0 if dist_incallyconst2004_votshr==.
replace dist_incallyconst2009_votshr=0 if dist_incallyconst2009_votshr==.
replace dist_upa20042009_votshr=0 if dist_upa20042009_votshr==.
replace dist_upaconst20042009_votshr=0 if dist_upaconst20042009_votshr==.
replace dist_upaconst2004_votshr=0 if dist_upaconst2004_votshr==.
replace dist_upaconst2009_votshr=0 if dist_upaconst2009_votshr==.
replace dist_bjp_votshr=0 if dist_bjp_votshr==.
replace dist_bjpally20042009_votshr=0 if dist_bjpally20042009_votshr==.
replace dist_nda20042009_votshr=0 if dist_nda20042009_votshr==. 
replace dist_oth20042009_votshr=0 if dist_oth20042009_votshr==. 
replace dist_opp20042009_votshr=0 if dist_opp20042009_votshr==.


merge m:1 state dist_name using "Agricultural census data 2005-06 GE cleaned.dta"
tab _merge

********************************************************************************
********************************************************************************
********************************************************************************
*** Regression works ***
sort state dist_name year 
egen state_code=group(state)
egen district_code=group(dist_name)
egen state_district_code=group(state dist_name)
order state_code state district_code dist_name

*** generating post-2008 dummy variable ***
tab year
gen post=1 if year==2009
replace post=0 if year==2004
tab post
tab year post

*** generating continuous interaction variable with post2008 and district eligible proportion ***
gen post_prop=post*eligibletotalshare
gen post_prop2=post*eligibleruralshare

count if eligibletotalshare==.
count if eligibleruralshare==.

label var dist_inc_votshr "INC vote share"
label var dist_incally20042009_votshr "INC Ally vote share"
label var dist_incallyconst20042009_votshr "INC Constant Ally vote share"
label var dist_incallyconst2004_votshr "INC 2004 Ally vote share"
label var dist_incallyconst2009_votshr "INC 2009 Ally vote share"
label var dist_upa20042009_votshr "UPA vote share"
label var dist_upaconst20042009_votshr "UPA Constant vote share"
label var dist_upaconst2004_votshr "UPA 2004 vote share"
label var dist_upaconst2009_votshr "UPA 2009 vote share"

label var dist_bjp_votshr "BJP vote share"
label var dist_bjpally20042009_votshr "BJP Ally vote share"
label var dist_nda20042009_votshr "NDA vote share"
label var dist_oth20042009_votshr "Others vote share"
label var dist_opp20042009_votshr "Opposition vote share"
********************************************************************************
label var pc_dist_inc "Seats won by INC in District"
label var pc_dist_incally20042009 "Seats won by INC Ally in District"
label var pc_dist_incallyconst20042009 "Seats won by INC Constant Ally in District"
label var pc_dist_incallyconst2004 "Seats won by INC 2004 Ally in District"
label var pc_dist_incallyconst2009 "Seats won by INC 2009 Ally in District"
label var pc_dist_upa20042009 "Seats won by UPA in District"
label var pc_dist_upaconst20042009 "Seats won by UPA Constant in District"
label var pc_dist_upaconst2004 "Seats won by UPA 2004 in District"
label var pc_dist_upaconst2009 "Seats won by UPA 2009 in District"

label var pc_dist_bjp "Seats won by BJP in District"
label var pc_dist_bjpally20042009 "Seats won by BJP Ally in District"
label var pc_dist_nda20042009 "Seats won by NDA in District"
label var pc_dist_oth20042009 "Seats won by Others in District"
label var pc_dist_opp20042009 "Seats won by Opposition in District"

label var post_prop "After 2008 x District Eligibility Proportion"
label var post_prop2 "After 2008 x District Eligibility Proportion (using Rural Population)"

cd "...\GE"

*** regression of INC district vote share with continuous interaction variable ***
areg dist_inc_votshr 	 post_prop i.year,absorb(state_district_code)
est store r1
*areg dist_incally_votshr post_prop i.year,absorb(state_district_code)
areg dist_incally20042009_votshr 		post_prop i.year,absorb(state_district_code)
est store r2
areg dist_incallyconst20042009_votshr 	post_prop i.year,absorb(state_district_code)
est store r3
areg dist_incallyconst2004_votshr 		post_prop i.year,absorb(state_district_code)
est store r4
areg dist_incallyconst2009_votshr 		post_prop i.year,absorb(state_district_code)
est store r5

areg dist_upa20042009_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r6
areg dist_upaconst20042009_votshr 	post_prop i.year,absorb(state_district_code)
est store r7
areg dist_upaconst2004_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r8
areg dist_upaconst2009_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r9

areg dist_bjp_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r10
areg dist_bjpally20042009_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r11
areg dist_nda20042009_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r12
areg dist_oth20042009_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r13
areg dist_opp20042009_votshr 	 	post_prop i.year,absorb(state_district_code)
est store r14
outreg2 [r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14] using "Baseline vote share1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Baseline vote share1.txt"
********************************************************************************
areg dist_inc_votshr 	 		 		post_prop2 i.year,absorb(state_district_code)
areg dist_incally20042009_votshr 		post_prop2 i.year,absorb(state_district_code)
areg dist_incallyconst20042009_votshr 	post_prop2 i.year,absorb(state_district_code)
areg dist_incallyconst2004_votshr 		post_prop2 i.year,absorb(state_district_code)
areg dist_incallyconst2009_votshr 		post_prop2 i.year,absorb(state_district_code)
areg dist_upa20042009_votshr 	 	post_prop2 i.year,absorb(state_district_code)
areg dist_upaconst20042009_votshr 	post_prop2 i.year,absorb(state_district_code)
areg dist_upaconst2004_votshr 	 	post_prop2 i.year,absorb(state_district_code)
areg dist_upaconst2009_votshr 	 	post_prop2 i.year,absorb(state_district_code)

areg dist_inc_votshr 	 		 		post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_incally20042009_votshr 		post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_incallyconst20042009_votshr 	post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_incallyconst2004_votshr 		post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_incallyconst2009_votshr 		post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_upa20042009_votshr 	 	post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_upaconst20042009_votshr 	post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_upaconst2004_votshr 	 	post_prop i.year if _merge==3,absorb(state_district_code)
areg dist_upaconst2009_votshr 	 	post_prop i.year if _merge==3,absorb(state_district_code)
*** Using _merge==3 gives same no. of observations giving same results ***
********************************************************************************
*** Also, since the values for district weighted seats are almost same by both the methods (AC counts and AC votes method), ***
*** we use only the AC counts method variables for convenience ***
areg pc_dist_inc 	 post_prop i.year,absorb(state_district_code)
est store a1
*areg pc_dist_wgtseat_incally post_prop i.year,absorb(state_district_code)
areg pc_dist_incally20042009 		post_prop i.year,absorb(state_district_code)
est store a2
areg pc_dist_incallyconst20042009 	post_prop i.year,absorb(state_district_code)
est store a3
areg pc_dist_incallyconst2004 		post_prop i.year,absorb(state_district_code)
est store a4
areg pc_dist_incallyconst2009 		post_prop i.year,absorb(state_district_code)
est store a5

areg pc_dist_upa20042009 	 		post_prop i.year,absorb(state_district_code)
est store a6
areg pc_dist_upaconst20042009 		post_prop i.year,absorb(state_district_code)
est store a7
areg pc_dist_upaconst2004 	 		post_prop i.year,absorb(state_district_code)
est store a8
areg pc_dist_upaconst2009 	 		post_prop i.year,absorb(state_district_code)
est store a9

areg pc_dist_bjp 	 		post_prop i.year,absorb(state_district_code)
est store a10
areg pc_dist_bjpally20042009 	 		post_prop i.year,absorb(state_district_code)
est store a11
areg pc_dist_nda20042009 	 		post_prop i.year,absorb(state_district_code)
est store a12
areg pc_dist_oth20042009 	 		post_prop i.year,absorb(state_district_code)
est store a13
areg pc_dist_opp20042009 	 		post_prop i.year,absorb(state_district_code)
est store a14
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14] using "Baseline seats1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Baseline seats1.txt"

areg pc_distv_upa20042009 		 post_prop i.year,absorb(state_district_code)
areg pc_distv_upaconst20042009 	 post_prop i.year,absorb(state_district_code)
areg pc_distv_upaconst2004 		 post_prop i.year,absorb(state_district_code)
areg pc_distv_upaconst2009 		 post_prop i.year,absorb(state_district_code)

*** Using Rural population eligibility ratio ***
areg pc_distv_inc 	 				post_prop2 i.year,absorb(state_district_code)
areg pc_distv_incally20042009 		post_prop2 i.year,absorb(state_district_code)
areg pc_distv_incallyconst20042009 	post_prop2 i.year,absorb(state_district_code)
areg pc_distv_incallyconst2004 		post_prop2 i.year,absorb(state_district_code)
areg pc_distv_incallyconst2009 		post_prop2 i.year,absorb(state_district_code)

summ eligibletotalshare
summ eligibletotalshare,de

*** generate binary variables based on range ***
gen range1=0
replace range1=1 if eligibletotalshare<0.05 & eligibletotalshare!=.
gen range2=0
replace range2=1 if eligibletotalshare>=0.05 & eligibletotalshare<0.1 & eligibletotalshare!=.
gen range3=0
replace range3=1 if eligibletotalshare>=0.1 & eligibletotalshare<0.15 & eligibletotalshare!=.
gen range4=0
replace range4=1 if eligibletotalshare>=0.15 & eligibletotalshare<0.2 & eligibletotalshare!=.
gen range5=0
replace range5=1 if eligibletotalshare>=0.2 & eligibletotalshare<0.25 & eligibletotalshare!=.
gen range6=0
replace range6=1 if eligibletotalshare>=0.25 & eligibletotalshare!=.
********************************************************************************
count if range1==1
count if range2==1
count if range3==1
count if range4==1
count if range5==1
count if range6==1

xtile rangequintile=eligibletotalshare,nq(5)
tab rangequintile
summ eligibletotalshare if rangequintile==1
summ eligibletotalshare if rangequintile==2
summ eligibletotalshare if rangequintile==3
summ eligibletotalshare if rangequintile==4
summ eligibletotalshare if rangequintile==5

gen range1_1=0
replace range1_1=1 if rangequintile==1
gen range2_1=0
replace range2_1=1 if rangequintile==2
gen range3_1=0
replace range3_1=1 if rangequintile==3
gen range4_1=0
replace range4_1=1 if rangequintile==4
gen range5_1=0
replace range5_1=1 if rangequintile==5

gen post_range1_1=post*range1_1
gen post_range2_1=post*range2_1
gen post_range3_1=post*range3_1
gen post_range4_1=post*range4_1
gen post_range5_1=post*range5_1

********************************************************************************
gen post_range1=post*range1
gen post_range2=post*range2
gen post_range3=post*range3
gen post_range4=post*range4
gen post_range5=post*range5
gen post_range6=post*range6

areg dist_inc_votshr 	 				post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c1
areg dist_incally20042009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c2
areg dist_incallyconst20042009_votshr 	post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c3
areg dist_incallyconst2004_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c4
areg dist_incallyconst2009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c5

areg dist_upa20042009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c6
areg dist_upaconst20042009_votshr 	post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c7
areg dist_upaconst2004_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c8
areg dist_upaconst2009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c9

areg dist_bjp_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c10
areg dist_bjpally20042009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c11
areg dist_nda20042009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c12
areg dist_oth20042009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c13
areg dist_opp20042009_votshr 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c14
outreg2 [c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14] using "Range vote share1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Range vote share1.txt"
***
areg dist_inc_votshr 	 				post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c1
areg dist_incally20042009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c2
areg dist_incallyconst20042009_votshr 	post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c3
areg dist_incallyconst2004_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c4
areg dist_incallyconst2009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c5

areg dist_upa20042009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c6
areg dist_upaconst20042009_votshr 	post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c7
areg dist_upaconst2004_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c8
areg dist_upaconst2009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c9

areg dist_bjp_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c10
areg dist_bjpally20042009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c11
areg dist_nda20042009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c12
areg dist_oth20042009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c13
areg dist_opp20042009_votshr 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store c14
outreg2 [c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14] using "Range vote share2.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Range vote share2.txt"
***
areg pc_dist_inc 	 				post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d1
areg pc_dist_incally20042009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d2
areg pc_dist_incallyconst20042009 	post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d3
areg pc_dist_incallyconst2004 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d4
areg pc_dist_incallyconst2009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d5

areg pc_dist_upa20042009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d6
areg pc_dist_upaconst20042009 	post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d7
areg pc_dist_upaconst2004		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d8
areg pc_dist_upaconst2009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d9

areg pc_dist_bjp 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d10
areg pc_dist_bjpally20042009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d11
areg pc_dist_nda20042009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d12
areg pc_dist_oth20042009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d13
areg pc_dist_opp20042009 		post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store d14
outreg2 [d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14] using "Range seat1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Range seat1.txt"
***
areg pc_dist_inc 	 				post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d1
areg pc_dist_incally20042009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d2
areg pc_dist_incallyconst20042009 	post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d3
areg pc_dist_incallyconst2004 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d4
areg pc_dist_incallyconst2009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d5

areg pc_dist_upa20042009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d6
areg pc_dist_upaconst20042009 	post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d7
areg pc_dist_upaconst2004		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d8
areg pc_dist_upaconst2009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d9

areg pc_dist_bjp 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d10
areg pc_dist_bjpally20042009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d11
areg pc_dist_nda20042009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d12
areg pc_dist_oth20042009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d13
areg pc_dist_opp20042009 		post_range2_1 post_range3_1 post_range4_1 post_range5_1  i.year,absorb(state_district_code)
est store d14
outreg2 [d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14] using "Range seat2.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Range seat2.txt"
***
********************************************************************************
*** Party in power at states ***
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
gen opp_ruling_state=0
replace opp_ruling_state=1 if (bjp_ruling_state==1 | bjpally_ruling_state==1 | oth_ruling_state==1)

ta state if inc_ruling_state==0 & incally_ruling_state==0 & bjp_ruling_state==0 & bjpally_ruling_state==0 & oth_ruling_state==0
********************************************************************************
*** State ruling party effect by interaction ***
global ruling_party "inc incally upa bjp bjpally nda oth opp"
foreach y in $ruling_party {
gen post_prop_`y'=post*eligibletotalshare*`y'_ruling_state
gen eligibletotalshare_`y'=eligibletotalshare*`y'_ruling_state
gen post_`y'=post*`y'_ruling_state
}
********************************************************************************
*** District seats won ***
foreach y in $ruling_party {
areg dist_inc_votshr 					post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_1
areg dist_incally20042009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_2
areg dist_incallyconst20042009_votshr 	post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_3
areg dist_incallyconst2004_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_4
areg dist_incallyconst2009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_5

areg dist_upa20042009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_6
areg dist_upaconst20042009_votshr 	post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_7
areg dist_upaconst2004_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_8
areg dist_upaconst2009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_9

areg dist_bjp_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_10
areg dist_bjpally20042009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_11
areg dist_nda20042009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_12
areg dist_oth20042009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_13
areg dist_opp20042009_votshr 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_14
outreg2 [`y'_1 `y'_2 `y'_3 `y'_4 `y'_5 `y'_6 `y'_7 `y'_8 `y'_9 `y'_10 `y'_11 `y'_12 `y'_13 `y'_14] using "`y' ruling vote share1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "`y' ruling vote share1.txt"
}
********************************************************************************
*** District seats won ***
foreach y in $ruling_party {
areg pc_dist_inc 					post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_1
areg pc_dist_incally20042009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_2
areg pc_dist_incallyconst20042009 	post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_3
areg pc_dist_incallyconst2004 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_4
areg pc_dist_incallyconst2009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_5

areg pc_dist_upa20042009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_6
areg pc_dist_upaconst20042009 	post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_7
areg pc_dist_upaconst2004 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_8
areg pc_dist_upaconst2009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_9

areg pc_dist_bjp 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_10
areg pc_dist_bjpally20042009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_11
areg pc_dist_nda20042009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_12
areg pc_dist_oth20042009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_13
areg pc_dist_opp20042009 		post_prop_`y' post_prop post_`y' eligibletotalshare_`y' i.year,absorb(state_district_code)
est store `y'_14
outreg2 [`y'_1 `y'_2 `y'_3 `y'_4 `y'_5 `y'_6 `y'_7 `y'_8 `y'_9 `y'_10 `y'_11 `y'_12 `y'_13 `y'_14] using "`y' ruling seats1.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "`y' ruling seats1.txt"
}
********************************************************************************
*export excel using "2004-2009 dist output new_Agricultural census data 2005-06 GE cleaned1.xls", firstrow(variables) replace
save "2004-2009 dist output new_Agricultural census data 2005-06 GE cleaned1.dta",replace

summ dist_inc_votshr dist_incally20042009_votshr dist_incallyconst20042009_votshr dist_incallyconst2004_votshr dist_incallyconst2009_votshr ///
	 dist_upa20042009_votshr dist_upaconst20042009_votshr dist_upaconst2004_votshr dist_upaconst2009_votshr dist_bjp_votshr ///
	 dist_bjpally20042009_votshr dist_nda20042009_votshr dist_oth20042009_votshr dist_opp20042009_votshr 
summ pc_dist_inc pc_dist_incally20042009 pc_dist_incallyconst20042009 pc_dist_incallyconst2004 pc_dist_incallyconst2009 pc_dist_upa20042009 ///
	 pc_dist_upaconst20042009 pc_dist_upaconst2004 pc_dist_upaconst2009 pc_dist_bjp pc_dist_bjpally20042009 pc_dist_nda20042009 ///
	 pc_dist_oth20042009 pc_dist_opp20042009	 

********************************************************************************
********************************************************************************
********************************************************************************

/*
qreg dist_inc_votshr
qreg dist_inc_votshr,quantile(0.75)

qreg dist_inc_votshr post_prop i.year i.state_district_code
sqreg dist_inc_votshr post_prop i.year i.state_district_code,q(0.25 0.5 0.75)

sqreg dist_inc_votshr post_prop,q(0.25 0.5 0.75)
sqreg pc_dist_wgtseat_inc post_prop,q(0.25 0.5 0.75)
*/

/*
sort state year
global ruling_party "dist_inc_votshr dist_incally20042009_votshr dist_incallyconst20042009_votshr dist_incallyconst2004_votshr dist_incallyconst2009_votshr dist_upa20042009_votshr dist_upaconst20042009_votshr dist_upaconst2004_votshr dist_upaconst2009_votshr dist_bjp_votshr dist_bjpally20042009_votshr dist_nda20042009_votshr dist_oth20042009_votshr dist_opp20042009_votshr"
foreach y in $ruling_party {
egen `y'_mean=mean(`y')
egen `y'_m=mean(`y') if year==2004
egen `y'_minc=mean(`y') if year==2004 & inc_ruling_state==1
egen `y'_mincally=mean(`y') if year==2004 & incally_ruling_state==1
egen `y'_mbjp=mean(`y') if year==2004 & bjp_ruling_state==1
egen `y'_mbjpally=mean(`y') if year==2004 & bjpally_ruling_state==1
egen `y'_mupa=mean(`y') if year==2004 & upa_ruling_state==1
egen `y'_mnda=mean(`y') if year==2004 & nda_ruling_state==1
egen `y'_moth=mean(`y') if year==2004 & oth_ruling_state==1
egen `y'_mopp=mean(`y') if year==2004 & opp_ruling_state==1
}
*/
global voteshare "dist_inc_votshr dist_incally20042009_votshr dist_incallyconst20042009_votshr dist_incallyconst2004_votshr dist_incallyconst2009_votshr dist_upa20042009_votshr dist_upaconst20042009_votshr dist_upaconst2004_votshr dist_upaconst2009_votshr dist_bjp_votshr dist_bjpally20042009_votshr dist_nda20042009_votshr dist_oth20042009_votshr dist_opp20042009_votshr"
foreach y in $voteshare {
summ `y',de
}
foreach y in $voteshare {
summ `y' if year==2009,de
}
foreach y in $voteshare {
summ `y' if year==2009 & inc_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & incally_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & bjp_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & bjpally_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & upa_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & nda_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & oth_ruling_state==1,de
}
foreach y in $voteshare {
summ `y' if year==2009 & opp_ruling_state==1,de
}

/*
global seatswon "pc_dist_inc pc_dist_incally20042009 pc_dist_incallyconst20042009 pc_dist_incallyconst2004 pc_dist_incallyconst2009 pc_dist_upa20042009 pc_dist_upaconst20042009 pc_dist_upaconst2004 pc_dist_upaconst2009 pc_dist_bjp pc_dist_bjpally20042009 pc_dist_nda20042009 pc_dist_oth20042009 pc_dist_opp20042009"
foreach y in $seatswon {
gen `y'_summ=sum(`y')
egen `y'_sum=max(`y'_summ)
drop `y'_summ
}
*/
