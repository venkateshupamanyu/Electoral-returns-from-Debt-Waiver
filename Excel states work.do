
clear
import excel using "...\AE\State election details.xlsx",sheet("Excel states") firstrow

ren *,lower
egen state_code=group(st_name)
order state_code st_name
sort year state_code dist_name ac_name partyabbre

by year state_code dist_name: egen dist_votes=sum(totvotpoll)
by year state_code dist_name: egen dist_incvotes1=sum(totvotpoll) if partyabbre=="INC"
by year state_code dist_name: egen dist_incvotes=mean(dist_incvotes1)
drop dist_incvotes1

gen dist_incvotshr=dist_incvotes/dist_votes
sort year st_name dist_name ac_name partyabbre

*** Party won ***
ren partyabbre party
ren ac_name ac
ren totvotpoll votes
drop state_code

sort year st_name dist_name ac party
by year st_name dist_name ac: egen maxvotes_1=max(votes)
gen partywon=party if votes==maxvotes_1

drop cand party votes dist_incvotes
duplicates drop

by year st_name dist_name ac:gen ac_count=_N
tab ac_count
tab st_name if ac_count==1
tab ac if ac_count==1

*** We expect ac_count to be 2 for all AC's, but for few in Arunachal Pradesh and Sikkim we get 1 as they are uncontested seats ***

drop if partywon==""
drop ac_count
duplicates drop

sort year st_name dist_name
by year st_name dist_name: gen inc_distseat_1=1 if partywon=="INC"
by year st_name dist_name: gen inc_distseat_2=sum(inc_distseat_1)
by year st_name dist_name: egen inc_distseat=max(inc_distseat_2)
drop inc_distseat_1 inc_distseat_2

by year st_name dist_name: gen incally_distseat_1=1 if inlist(partywon,"NCP") & year==2009
by year st_name dist_name: gen incally_distseat_2=sum(incally_distseat_1)
by year st_name dist_name: egen incally_distseat=max(incally_distseat_2)
drop incally_distseat_1 incally_distseat_2

sort year st_name dist_name
by year st_name dist_name: gen upa_distseat_1=1 if inlist(partywon,"INC","NCP") & year==2009
by year st_name dist_name: gen upa_distseat_2=sum(upa_distseat_1)
by year st_name dist_name: egen upa_distseat=max(upa_distseat_2)
drop upa_distseat_1 upa_distseat_2

drop ac
drop maxvotes_1
drop partywon
duplicates drop

export excel using "...\AE\Excel states work_stata new.xlsx", firstrow(variables) replace

save "...\AE\Excel states work_stata new.dta",replace
 


