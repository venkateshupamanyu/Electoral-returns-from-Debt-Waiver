
tab v6
drop v6
tab v5

gen id=_n
order id

count if v1=="" & v2=="" & v3=="" & v4=="" & v5==.
count if v1=="" & v2=="" & v3=="" & v4=="" & v5==.
drop if v1=="" & v2=="" & v3=="" & v4=="" & v5==.


drop id
gen id=_n
order id


tab v5
tab id if v5!=.

tab v4 if v5!=.


tab v2 if v1=="State-UT Code & Name :"
gen state=v2 if v1=="State-UT Code & Name :"
tab id if state!=""
tab state

tab v2 if v1=="PC No. & Name :"
gen pc=v2 if v1=="PC No. & Name :"

tab v2 if v1=="AC Number and AC Name :"
gen ac=v2 if v1=="AC Number and AC Name :"

















drop v9
count if v1=="" & v2=="" & v3=="" & v4=="" & v5=="" & v6=="" & v7=="" & v8==.
drop if v1=="" & v2=="" & v3=="" & v4=="" & v5=="" & v6=="" & v7=="" & v8==.
gen id=_n
order id
tab id if v8!=.
tab v7 if v8!=.
tab v6 if v8!=.
tab v5 if v8!=.
tab v4 if v8!=.

count if v4!="" & v1=="" & v2=="" & v3=="" & v5=="" & v6=="" & v7==""
tab v4 if v4!="" & v1=="" & v2=="" & v3=="" & v5=="" & v6=="" & v7==""
drop if v4!="" & v1=="" & v2=="" & v3=="" & v5=="" & v6=="" & v7==""

replace v5=v7 if v8!=.
replace v6=v8 if v8!=""
tostring v8,replace
count if v8!="."
replace v6=v8 if v8!="."
drop v8

tab v7
tab id if v7!=""
count if v5==v7
replace v7="" if v5==v7
ta v7
tab id if v7!=""

count if v1=="" & v2=="" & v3=="" & v4=="" & v5=="" & v6=="" & v7=="" 
tab id if v1=="" & v2=="" & v3=="" & v4=="" & v5=="" & v6=="" & v7==""
