
import excel using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE\2004-2009 dist output new_Agricultural census data 2005-06 GE cleaned_new.xlsx",sheet(Sheet1) firstrow

cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and electoral performance\GE"
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
outreg2 [r1 r2 r3 r4 r5 r6 r7 r8 r9] using "Baseline vote share_no empty votshr.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Baseline vote share_no empty votshr.txt"

areg dist_inc_votshr 	 				post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c1
areg dist_incally20042009_votshr 		post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c2
areg dist_incallyconst20042009_votshr 	post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c3
areg dist_incallyconst2004_votshr 		post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c4
areg dist_incallyconst2009_votshr 		post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c5
areg dist_upa20042009_votshr 		post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c6
areg dist_upaconst20042009_votshr 	post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c7
areg dist_upaconst2004_votshr 		post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c8
areg dist_upaconst2009_votshr 		post_range1 post_range2 post_range3 post_range4 post_range5 post_range6 i.year,absorb(state_district_code)
est store c9
outreg2 [c1 c2 c3 c4 c5 c6 c7 c8 c9] using "Range vote share_no empty votshr.xls", drop(2009.year) label nocons addtext(District FE, Yes,Year FE, Yes) dec(3) excel replace
erase "Range vote share_no empty votshr.txt"
