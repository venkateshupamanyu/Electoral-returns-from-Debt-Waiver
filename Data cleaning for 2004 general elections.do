
*** Before starting with the .do file perform ***
*** - re-arrange the 125 rows in column 5 where the columns are misaligned ****
*** - delete the top few rows ***

import excel using "...\GE\2004 (Vol III)-pages-9-1270.xlsx",sheet(Sheet1 (2)) 

ren A var1
ren B var2
ren C var3
ren D var4

tab var2 if var1=="Candidate No  & Name"
tab var3 if var1=="Candidate No  & Name"
tab var4 if var1=="Candidate No  & Name"

drop if var1=="Candidate No  & Name"

tab var2 if var1=="General Elections, 2004 - Details for Assembly Segments of Parliamentary Constituencies"
tab var3 if var1=="General Elections, 2004 - Details for Assembly Segments of Parliamentary Constituencies"
tab var4 if var1=="General Elections, 2004 - Details for Assembly Segments of Parliamentary Constituencies"

drop if var1=="General Elections, 2004 - Details for Assembly Segments of Parliamentary Constituencies"


tab var2 if var1=="Election Commission of India - GE-2004 AC Segment Details for PCs"
tab var3 if var1=="Election Commission of India - GE-2004 AC Segment Details for PCs"
tab var4 if var1=="Election Commission of India - GE-2004 AC Segment Details for PCs"

drop if var1=="Election Commission of India - GE-2004 AC Segment Details for PCs" 

count if var1!="" & var2=="" & var3=="" & var4==""
tab var1 if var2=="" & var3=="" & var4==""
count if var1=="" & var2=="" & var3=="" & var4==""

drop if var2=="" & var3=="" & var4==""

tab var2 if var1=="" & var3=="" & var4==""
gen var5=var2 if var1=="" & var3=="" & var4==""
drop var5

count if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"
tab var1 if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"
tab var3 if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"
tab var4 if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"

drop if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"

count if var1=="" & var2=="" & var3=="" & var4==""

count if var1=="Total Valid Votes for the PC:"
count if var2=="Total Valid Votes for the PC:"
count if var3=="Total Valid Votes for the PC:"
count if var4=="Total Valid Votes for the PC:"

tab var2 if var1=="Total Valid Votes for the PC:"
tab var3 if var1=="Total Valid Votes for the PC:"
tab var4 if var1=="Total Valid Votes for the PC:"

tab var1 if var2=="Total Valid Votes for the PC:"
tab var3 if var2=="Total Valid Votes for the PC:"
tab var4 if var2=="Total Valid Votes for the PC:"

count if var1=="Total Valid Votes for the AC :"
count if var2=="Total Valid Votes for the AC :"
count if var3=="Total Valid Votes for the AC :"
count if var4=="Total Valid Votes for the AC :"

tab var2 if var1=="Total Valid Votes for the AC :"
tab var3 if var1=="Total Valid Votes for the AC :"
tab var4 if var1=="Total Valid Votes for the AC :"

tab var1 if var2=="Total Valid Votes for the AC :"
tab var3 if var2=="Total Valid Votes for the AC :"
tab var4 if var2=="Total Valid Votes for the AC :"

drop if var1=="Total Valid Votes for the AC :"
drop if var2=="Total Valid Votes for the AC :"

gen id=_n
order id

count if var1=="Total Valid Votes for the PC:"
count if var2=="Total Valid Votes for the PC:"
count if var3=="Total Valid Votes for the PC:"
count if var4=="Total Valid Votes for the PC:"

tab var2 if var1=="Total Valid Votes for the PC:"
tab var3 if var1=="Total Valid Votes for the PC:"
tab var4 if var1=="Total Valid Votes for the PC:"

tab var1 if var2=="Total Valid Votes for the PC:"
tab var3 if var2=="Total Valid Votes for the PC:"
tab var4 if var2=="Total Valid Votes for the PC:"

drop if var1=="Total Valid Votes for the PC:"
drop if var2=="Total Valid Votes for the PC:"


*** Just check ***
count if var1=="PC No. & Name :"
count if var2=="PC No. & Name :"
count if var3=="PC No. & Name :"
count if var4=="PC No. & Name :"

count if var1=="AC Number and AC Name :"
count if var2=="AC Number and AC Name :"
count if var3=="AC Number and AC Name :"
count if var4=="AC Number and AC Name :"
tab id if var2=="AC Number and AC Name :"
*** Just check ***

count if var1=="Total Valid Postal Ballots for the PC"
count if var2=="Total Valid Postal Ballots for the PC"
count if var3=="Total Valid Postal Ballots for the PC"
count if var4=="Total Valid Postal Ballots for the PC"

count if var1=="Valid Postal Ballots for each candidate in the PC"
count if var2=="Valid Postal Ballots for each candidate in the PC"
count if var3=="Valid Postal Ballots for each candidate in the PC"
count if var4=="Valid Postal Ballots for each candidate in the PC"

drop if var1=="Total Valid Postal Ballots for the PC"
drop if var2=="Total Valid Postal Ballots for the PC"



count if var2=="Total Valid Votes for the State/UT:"

tab id if var1=="Total Valid Votes for the State/UT:"
tab id if var2=="Total Valid Votes for the State/UT:"

count if var1=="Total Valid Votes for the State/UT:"
tab var2 if var1=="Total Valid Votes for the State/UT:"
tab var3 if var1=="Total Valid Votes for the State/UT:"
tab var4 if var1=="Total Valid Votes for the State/UT:"

count if var2=="Total Valid Votes for the State/UT:"
tab var1 if var2=="Total Valid Votes for the State/UT:"
tab var3 if var2=="Total Valid Votes for the State/UT:"
tab var4 if var2=="Total Valid Votes for the State/UT:"

drop if var1=="Total Valid Votes for the State/UT:"
drop if var2=="Total Valid Votes for the State/UT:"

tab var2 if var1=="" & var3=="" & var4==""
tab var2 if var1=="" & var3=="" & var4=="" & var2!="Valid Postal Ballots for each candidate in the PC"

gen state=var2 if var1=="" & var3=="" & var4=="" & var2!="Valid Postal Ballots for each candidate in the PC"
*** PC name ***
count if var1=="PC No. & Name :"
count if var2=="PC No. & Name :"
count if var3=="PC No. & Name :"
count if var4=="PC No. & Name :"

tab var2 if var1=="PC No. & Name :"
tab var3 if var1=="PC No. & Name :"
tab var4 if var1=="PC No. & Name :"

gen pcnamehead=var1 if var1=="PC No. & Name :"

tab var2 if var1=="PC No. & Name :"
tab var3 if var1=="PC No. & Name :"
tab var4 if var1=="PC No. & Name :"

tab var2 if var3=="" & var1=="PC No. & Name :"
tab var3 if var2=="" & var1=="PC No. & Name :"

gen pc=var2 if var3=="" & var1=="PC No. & Name :"
tab pc
replace pc=var3 if var2=="" & var1=="PC No. & Name :"
tab pc

*** AC name ***
count if var1=="AC Number and AC Name :"
count if var2=="AC Number and AC Name :"
count if var3=="AC Number and AC Name :"
count if var4=="AC Number and AC Name :"

tab var2 if var1=="AC Number and AC Name :"
tab var3 if var1=="AC Number and AC Name :"
tab var4 if var1=="AC Number and AC Name :"

tab var1 if var2=="AC Number and AC Name :"
tab var3 if var2=="AC Number and AC Name :"
tab var4 if var2=="AC Number and AC Name :"

tab var2 if var1=="AC Number and AC Name :"
tab var3 if var2=="" & var1=="AC Number and AC Name :"
tab var3 if var1=="AC Number and AC Name :"
tab var4 if var3!="" & var1=="AC Number and AC Name :"

gen ac=var2 if var1=="AC Number and AC Name :"
replace ac=var3 if var2=="" & var1=="AC Number and AC Name :"
tab ac
replace ac=var3 if var2=="AC Number and AC Name :"
tab ac
replace ac=var2 if var2=="Valid Postal Ballots for each candidate in the PC"
tab ac

*** Candidate details ***
tab var1
tab var1 if !inlist(var1,"AC Number and AC Name :","PC No. & Name :")
gen candno=var1 if !inlist(var1,"AC Number and AC Name :","PC No. & Name :")
tab candno

count if var2=="1"
count if var2=="2"
count if var2=="3"
count if var2=="4"
count if var3=="1"
count if var3=="2"
count if var3=="3"
count if var3=="4"
count if var4=="1"
count if var4=="2"
count if var4=="3"
count if var4=="4"

tab var2
tab var3
tab candno

gen candname=var2 if candno=="1"
forvalues i = 2/40 {
replace candname=var2 if candno=="`i'"
}

*** Party ***
tab var3

gen party=var3 if candno=="1"
forvalues i = 2/40 {
replace party=var3 if candno=="`i'"
}

*** Votes ***
tab var4

gen votes=var4 if candno=="1"
forvalues i = 2/40 {
replace votes=var4 if candno=="`i'"
}

save "...\GE\2004-PC-AC temp.dta", replace

clear

use "...\GE\2004-PC-AC temp_1.dta"

drop var1 var2 var3 var4 
count if id==.
count if state=="" & pc=="" & ac=="" & candno=="" & candname=="" & party=="" & votes==""

drop id
gen id=_n-1

egen stateid=group(state)
gen stateid1=stateid-id

egen stateid1=group(stateid id)

tab stateid
sort id
sort id stateid
sort stateid
by id stateid:egen stateid1=min(stateid)

drop stateid


gen state1="1" if state==""
replace state1=state if state!=""

encode state1,replace
sort state1 
drop state1
encode votes,replace

drop id
gen id=_n
gen totalid=_N

gen state1=state

sort totalid id state1

by totalid id state1: egen temp=max(id)

gen stateid=id if state!=""
-sort state


egen statetag=tag(state)
egen statetag1=tag(state id)

gen state1=state
replace state1=state[_n-1] if state=="" & pc!=""
replace state1=state[_n-2] if state=="" & pc=="" & ac!=""


forvalues i=3/4 {
replace state1=state[_n-`i'] if state=="" & pc=="" & ac=="" & candno=="`i"
}

gen stateid=id if state!=""
drop stateid

gen state1=id
replace state1="1" if state1==""

egen state2=max(state1)
drop state1

egen stateid=group(state)
tab id if stateid!=.

replace stateid=id if stateid==.

gen stateid1=stateid[_n-1] if stateid==.
replace stateid1=stateid if stateid!=.

egen pcid=group(pc)
egen acid=group(ac)


drop id 

gen state1=state
gen pc1=pc[_n+1]
gen ac1=ac[_n+2]
gen candno1=candno[_n+3]
gen candname1=candname[_n+3]
gen party1=party[_n+3]
gen votes1=votes[_n+3]

drop state-votes

count if state1=="" & pc1=="" & ac1=="" & candno1=="" & candname1=="" & party1=="" & votes1==""
drop  if state1=="" & pc1=="" & ac1=="" & candno1=="" & candname1=="" & party1=="" & votes1==""

gen id=_n
order id

gen state2=state1
replace state2=state2[_n-1] if state1=="" & state2==""

gen pc2=pc1
replace pc2=pc2[_n-1] if pc1=="" & pc2==""

gen ac2=ac1
replace ac2=ac2[_n-1] if ac1=="" & ac2==""

order state2 pc2 ac2 candno1 candname1 party1 votes1 state1 pc1 ac1
drop state1 pc1 ac1 id

count if state2=="State-UT Code & Name : S09-JAMMU & KASHMIR"
tab pc2 if state2=="State-UT Code & Name : S09-JAMMU & KASHMIR"
drop if state2=="State-UT Code & Name : S09-JAMMU & KASHMIR"
unique pc2 if  state2=="State-UT Code & Name : S01-ANDHRA PRADESH"

unique state2
unique pc2
unique ac2

tab ac2 if state2=="State-UT Code & Name : S01-ANDHRA PRADESH"
unique ac2 if state2=="State-UT Code & Name : S01-ANDHRA PRADESH"

sort state2 pc2 ac2 candno1 candname1 party1 votes1
destring votes1,gen(votes2)
sort state2 pc2
by state2 pc2:egen pcvotes=sum(votes2)
drop pcvotes

save "...\GE\2004-PC-AC temp_2.dta",replace















