
clear
import excel using "...\AE\State election details.xlsx",sheet("Non-Excel states") firstrow

ren *,lower
egen state_code=group(state)
order state_code state
sort year state_code district ac

by year state_code district: egen dist_votes=sum(votes)
by year state_code district: egen dist_incvotes1=sum(votes) if party=="INC"
by year state_code district: egen dist_incvotes=mean(dist_incvotes1)
drop dist_incvotes1

gen dist_incvotshr=dist_incvotes/dist_votes

ren state st_name 
ren district dist_name

*** Party won ***
sort year st_name dist_name ac party
by year st_name dist_name ac: egen maxvotes_1=max(votes)
gen partywon=party if votes==maxvotes_1

drop cand party votes dist_incvotes
duplicates drop

by year st_name dist_name ac:gen ac_count=_N
tab ac_count
tab st_name if ac_count==1
*** We expect ac_count to be 2 for all AC's, but for few in Arunachal Pradesh and Sikkim we get 1 as they are uncontested seats ***

drop ac_count maxvotes_1
duplicates drop

drop if partywon==""

sort year st_name dist_name ac
by year st_name dist_name: gen inc_distseat_1=1 if partywon=="INC"
by year st_name dist_name: gen inc_distseat_2=sum(inc_distseat_1)
by year st_name dist_name: egen inc_distseat=max(inc_distseat_2)
drop inc_distseat_1 inc_distseat_2

by year st_name dist_name: gen incally_distseat_1=1 if inlist(partywon,"AC","TRS","CPI","CPM","NCP") & year==2004
by year st_name dist_name: gen incally_distseat_2=sum(incally_distseat_1)
by year st_name dist_name: egen incally_distseat=max(incally_distseat_2)
drop incally_distseat_1 incally_distseat_2

sort year st_name dist_name
by year st_name dist_name: gen upa_distseat_1=1 if inlist(partywon,"INC","AC","TRS","CPI","CPM","NCP") & year==2004
by year st_name dist_name: gen upa_distseat_2=sum(upa_distseat_1)
by year st_name dist_name: egen upa_distseat=max(upa_distseat_2)
drop upa_distseat_1 upa_distseat_2

drop ac partywon dist_votes
duplicates drop

export excel using "...\AE\Non-Excel states work_stata _new.xlsx", firstrow(variables) replace

save "...\AE\Non-Excel states work_stata new.dta",replace
 


