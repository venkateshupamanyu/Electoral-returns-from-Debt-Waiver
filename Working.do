
drop if var1=="Election Commission of India - GE-2004 AC Segment Details for PCs"
drop if var1=="General Elections, 2004 - Details for Assembly Segments of Parliamentary Constituencies"
drop if var1=="" & var2=="" & var3=="" & var4=="" & var5==""
drop if var1=="Total Valid Votes for the AC :"
drop if var1=="Total Valid Votes for the PC:"
drop if var1=="Total Valid Votes for the State/UT:"
tab var1 if var2=="" & var3=="" & var4=="" & var5==""
drop if var1!="" & var2=="" & var3=="" & var4=="" & var5==""

count if var1=="Candidate No  & Name"
count if var3=="Party"
count if var4=="Votes"
count if var3=="Party" & var4=="Votes"
drop if var3=="Party" & var4=="Votes"
drop if var1=="Candidate No  & Name"

count if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"
tab var4 if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"
drop if var2=="Election Commission of India - GE-2004 AC Segment Details for PCs"

count if var1=="Valid Postal Ballots for each candidate in the PC"
count if var2=="Valid Postal Ballots for each candidate in the PC"
count if var3=="Valid Postal Ballots for each candidate in the PC"
count if var4=="Valid Postal Ballots for each candidate in the PC"

count if var1=="Total Valid Postal Ballots for the PC"
count if var2=="Total Valid Postal Ballots for the PC"
count if var3=="Total Valid Postal Ballots for the PC"
count if var4=="Total Valid Postal Ballots for the PC"

gen id=_n
sum id
tab id if var5!==""
tab var3 if var5!=""
replace var3==var4 if var5!=""
tab var5
drop var5

count if var2=="Valid Postal Ballots for each candidate in the PC"

count if var5=="Valid Postal Ballots for each candidate in the PC"
count if var1=="Valid Postal Ballots for each candidate in the PC"
count if var2=="Total Valid Postal Ballots for the PC"
count if var1=="Total Valid Postal Ballots for the PC"

count if var1=="PC No. & Name :"
tab var1 if var2=="Valid Postal Ballots for each candidate in the PC"
tab var1 if var2=="Total Valid Postal Ballots for the PC"

replace var1=var2 if var2=="Valid Postal Ballots for each candidate in the PC"
replace var1=var2 if var2=="Total Valid Postal Ballots for the PC"
replace var2="" if var2=="Valid Postal Ballots for each candidate in the PC"
replace var2="" if var2=="Total Valid Postal Ballots for the PC"


count if var2=="Total Valid Votes for the State/UT:"
tab id if var2=="Total Valid Votes for the State/UT:"
tab var1 if var2=="Total Valid Votes for the State/UT:"
tab var3 if var2=="Total Valid Votes for the State/UT:"
tab var4 if var2=="Total Valid Votes for the State/UT:"

drop if var2=="Total Valid Votes for the State/UT:"

gen var5=var3 if var1=="PC No. & Name :"
tab var5




