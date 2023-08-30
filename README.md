# Electoral-returns-from-debt-waiver
Welfare programs are often scrutinized for resource redistribution for political gains. We investigate the Agricultural Debt Waiver and Debt Relief Scheme of 2008 in India which is one of the largest debt waiver programs in the world. Using a novel dataset created to compare constituencies before and after the 2008 redistricting exercise, we find that the 2008 waiver led to higher number of seats for the incumbent in subsequent general elections though its effect on vote share remained muted. We find that the incumbent party performed better in large states ruled by neutral parties. Along with the announcement effect that was present in initial elections, an analysis of subsequent state elections shows that implementation quality also fetched more seats. Our findings provide more evidence on the political capture of public resources for electoral gains through programmatic design of the scheme and insights into temporal nature of voter preferences.


Stata codes for Electoral returns from debt waiver project

1 - Data cleaning for 2004 general elections.do
This .do file extracts and cleans the 2004 general elections results from the .pdf file showing the 2004 general elections report.

2 - Data cleaning for 2009 general elections.do
This .do file extracts and cleans the 2004 general elections results from the .pdf file showing the 2009 general elections report.

3 - Data cleaning for 2005-06 Agricultural census data.do
This .do file cleans the 2005-06 Agricultural census excel file and obtains the required variables for computing the district-level eligibility proportion.


4 - 2004_dist_inc_votshr.do
This .do file cleans and extracts the 2004 general election outcomes in terms of party vote shares and seats won at the district-level.


5 - 2009_dist_inc_votshr.do
This .do file cleans and extracts the 2009 general election outcomes in terms of party vote shares and seats won at the district-level.
This .do file also geenrates the regression results showing the impact of district eligibility proportion on 2009 general election results vis-a-vis 2004 general election results.

6 - Excel states work.do
This .do file cleans and extracts the state assembly elections results from the election commission excel files.

7 - Non-Excel states work.do
This .do file cleans and extracts the state assembly elections results from the election commission .pdf reports.

8 - State elections analysis.do
This .do file does the analysis of the state assembly election results and finds the impact of the district eligibility proportion on them.

