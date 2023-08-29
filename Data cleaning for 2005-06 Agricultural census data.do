********************************************************************************
********************************************************************************
********************************************************************************
*** Using Agricultural census data 2005-05 excel and getting eligible population ratio ***
clear
import excel using "...\Agricultural census data 2005-06.xlsx",sheet(clean data with pop ratio) firstrow

*** Following renaming of states and districts are done to match with 2004-2009 dist output.dta file ***
replace state=upper(state)
replace dist_name=proper(dist_name)

replace dist_name="Anantapur" if dist_name=="Ananthapur" & state=="ANDHRA PRADESH"
replace dist_name="Cuddapah" if dist_name=="Kadapa" & state=="ANDHRA PRADESH"
replace dist_name="Mahbubnagar" if dist_name=="Mahabubnagar" & state=="ANDHRA PRADESH"
replace dist_name="Vishakapatnam" if dist_name=="Visakhapatnam" & state=="ANDHRA PRADESH"
replace dist_name="Prakasam " if dist_name=="Prakasam" & state=="ANDHRA PRADESH"

replace dist_name=upper(dist_name) if state=="ARUNACHAL PRADESH"
replace dist_name="PAPUM PARE" if dist_name=="PAPUMPARE" & state=="ARUNACHAL PRADESH"
*replace dist_name="WEST SIANG(MECHUKA)" if dist_name=="WEST SIANG" & state=="ARUNACHAL PRADESH"

replace dist_name="Dhemji" if dist_name=="Dhemaji" & state=="ASSAM"
replace dist_name="Karbi Anglong" if dist_name=="Karbi-Anglong" & state=="ASSAM"

replace dist_name="Buxor" if dist_name=="Buxar" & state=="BIHAR"
replace dist_name="Kaimur (Bhabhua)" if dist_name=="Kaimur" & state=="BIHAR"
replace dist_name="Nawada" if dist_name=="Nawadah" & state=="BIHAR"
replace dist_name="Nawada" if dist_name=="Nawadah" & state=="BIHAR"
replace dist_name="Sheikhpura" if dist_name=="Shekhpura" & state=="BIHAR"
replace dist_name="Sheohar" if dist_name=="Shivhar" & state=="BIHAR"

replace state="CHHATTISGARH" if state=="CHATTISGARH"
replace dist_name="Dakshin Bastar Dantewada" if dist_name=="Dantewara" & state=="CHHATTISGARH"
replace dist_name="Janjgir-Champa" if dist_name=="Janjgir" & state=="CHHATTISGARH"
replace dist_name="Kabirdham" if dist_name=="Kawardha" & state=="CHHATTISGARH"
replace dist_name="Koriya" if dist_name=="Korea" & state=="CHHATTISGARH"
replace dist_name="Mahasamund" if dist_name=="Mahasamudh" & state=="CHHATTISGARH"
replace dist_name="Uttar Bastar Kanker" if dist_name=="Kanker" & state=="CHHATTISGARH"
replace dist_name="Surguja" if dist_name=="Sarguja" & state=="CHHATTISGARH"

replace dist_name="Banaskantha" if dist_name=="Palanpur/Banaskantha" & state=="GUJARAT"
replace dist_name="Baroda" if dist_name=="Vadodara" & state=="GUJARAT"
replace dist_name="Bulsar" if dist_name=="Valsad" & state=="GUJARAT"
replace dist_name="Dangs" if dist_name=="Ahwa/Dangs" & state=="GUJARAT"
replace dist_name="Dohad" if dist_name=="Dahod" & state=="GUJARAT"
replace dist_name="Gandhinagar" if dist_name=="Gandhinag" & state=="GUJARAT"
replace dist_name="Kaira" if dist_name=="Nadiyad/Kheda" & state=="GUJARAT"
replace dist_name="Kutch" if dist_name=="Bhuj/Kutch" & state=="GUJARAT"
replace dist_name="Narmada" if dist_name=="Rajpipala/Narmada" & state=="GUJARAT"
replace dist_name="Panchmahal" if dist_name=="Godhara/Panchmahals" & state=="GUJARAT"
replace dist_name="Sabarkantha" if dist_name=="Himatnaga/Sabarkantha" & state=="GUJARAT"

replace dist_name="Hisar" if dist_name=="Hissar" & state=="HARYANA"
replace dist_name="Kurukshetra" if dist_name=="Kurushetra" & state=="HARYANA"
replace dist_name="Mahendragarh" if dist_name=="Mohindargarh" & state=="HARYANA"
replace dist_name="Yamuna-Nagar" if dist_name=="Yamunanagar" & state=="HARYANA"

replace dist_name="Sirmour" if dist_name=="Sirmaur" & state=="HIMACHAL PRADESH"

replace dist_name="East Singhbhum" if dist_name=="East Singhbhum(Purba Sing" & state=="JHARKHAND"
replace dist_name="Garhwa" if dist_name=="Garwah" & state=="JHARKHAND"
replace dist_name="Palamu" if dist_name=="Daltanganj(Palamu)" & state=="JHARKHAND"
replace dist_name="West Singhbhum" if dist_name=="Chaibasa(West Singbhum)" & state=="JHARKHAND"

replace dist_name="Bagalkot" if dist_name=="Bagalkote" & state=="KARNATAKA"
replace dist_name="Bangalore" if dist_name=="Bangalore Urban" & state=="KARNATAKA"
replace dist_name="Coorg" if dist_name=="Kodagu" & state=="KARNATAKA"
replace dist_name="Dharwar" if dist_name=="Dharwad" & state=="KARNATAKA"
replace dist_name="North Kanara" if dist_name=="Uttara Kannada" & state=="KARNATAKA"
replace dist_name="South Kanara" if dist_name=="Dakshina Kannada" & state=="KARNATAKA"

replace dist_name="Wayanad" if dist_name=="Wynad" & state=="KERALA"

replace dist_name="Atia" if dist_name=="Datia" & state=="MADHYA PRADESH"
replace dist_name="Chhindwara" if dist_name=="Chindwara" & state=="MADHYA PRADESH"
replace dist_name="East Nimar (Khandwa)" if dist_name=="Khandwa" & state=="MADHYA PRADESH"
replace dist_name="Narsimhapur" if dist_name=="Narsinghpur" & state=="MADHYA PRADESH"
replace dist_name="Neemuch" if dist_name=="Neemach" & state=="MADHYA PRADESH"
replace dist_name="Sheopur" if dist_name=="Sheopurkalan" & state=="MADHYA PRADESH"
replace dist_name="West Nimar (Khargone)" if dist_name=="Khargone" & state=="MADHYA PRADESH"

replace dist_name="Ahmednagar" if dist_name=="Ahamad Nagar" & state=="MAHARASHTRA"
replace dist_name="Aurangabad" if dist_name=="Auragabad" & state=="MAHARASHTRA"
replace dist_name="Gondia" if dist_name=="Gondiya" & state=="MAHARASHTRA"
replace dist_name="Kolhapur" if dist_name=="Kholapur" & state=="MAHARASHTRA"
replace dist_name="Ahamednagar" if dist_name=="Ahamad Nagar" & state=="MAHARASHTRA"
replace dist_name="Osmanabad" if dist_name=="Usmanabad" & state=="MAHARASHTRA"
replace dist_name="Raigad" if dist_name=="Raygad" & state=="MAHARASHTRA"
replace dist_name="Ratnagiri" if dist_name=="Rathnagiri" & state=="MAHARASHTRA"
replace dist_name="Sangli" if dist_name=="Sangali" & state=="MAHARASHTRA"
replace dist_name="Sindhudurg" if dist_name=="Shindhudurga" & state=="MAHARASHTRA"
replace dist_name="Wardha" if dist_name=="Vardha" & state=="MAHARASHTRA"
replace dist_name="Washim" if dist_name=="Vashim" & state=="MAHARASHTRA"
replace dist_name="Yavatmal" if dist_name=="Yawatmai" & state=="MAHARASHTRA"

replace dist_name="WILLIAMNAGAR, DC" if dist_name=="East Garo Hills" & state=="MEGHALAYA"
replace dist_name="SHILLONG, DC" if dist_name=="East Khasi Hill" & state=="MEGHALAYA"
replace dist_name="NONGPOH, DC" if dist_name=="Ribhoi" & state=="MEGHALAYA"
replace dist_name="BAGHMARA, DC" if dist_name=="South Garo Hill" & state=="MEGHALAYA"
replace dist_name="AMPATIGIRI,  SDO(C )" if dist_name=="West Garo Hills" & state=="MEGHALAYA"
replace dist_name="NONGSTOIN, DC" if dist_name=="West Khasi Hill" & state=="MEGHALAYA"

replace dist_name=upper(dist_name) if state=="MIZORAM"

replace dist_name="Pughoboto" if dist_name=="Zunheboto" & state=="NAGALAND"

replace dist_name="Bargarh" if dist_name=="Baragarh" & state=="ORISSA"
replace dist_name="Boudh-Khondmals" if dist_name=="Boudh" & state=="ORISSA"
replace dist_name="Jagatsinghpur" if dist_name=="Jagatsingpur" & state=="ORISSA"
replace dist_name="Kendrapara" if dist_name=="Kendrapada" & state=="ORISSA"
replace dist_name="Koraput " if dist_name=="Koraput" & state=="ORISSA"
replace dist_name="Malkangiri" if dist_name=="Malkanagiri" & state=="ORISSA"
replace dist_name="Subarnapur" if dist_name=="Sonepur" & state=="ORISSA"

replace dist_name="Fatehgarh Sahib" if dist_name=="F.G. Sahib" & state=="PUNJAB"
replace dist_name="Ferozepur" if dist_name=="Ferozpur" & state=="PUNJAB"
replace dist_name="Gurdaspur" if dist_name=="Gurdashpur" & state=="PUNJAB"
replace dist_name="Jullundur" if dist_name=="Jalandhar" & state=="PUNJAB"
replace dist_name="Ludhiana" if dist_name=="Ludhina" & state=="PUNJAB"
replace dist_name="Nawan Shahr" if dist_name=="Shahed Bhagat Singh Nagar" & state=="PUNJAB"

replace dist_name="Banswara" if dist_name=="Banswar" & state=="RAJASTHAN"
replace dist_name="Chittorgarh" if dist_name=="Chittoregarh" & state=="RAJASTHAN"
replace dist_name="Dungarpur" if dist_name=="Dungerpur" & state=="RAJASTHAN"
replace dist_name="Jhalawar" if dist_name=="Jalaware" & state=="RAJASTHAN"
replace dist_name="Jhunjhunu" if dist_name=="Junjun" & state=="RAJASTHAN"
replace dist_name="Karauli" if dist_name=="Karoli" & state=="RAJASTHAN"
replace dist_name="Nagaur" if dist_name=="Nagore" & state=="RAJASTHAN"
replace dist_name="Rajsamand" if dist_name=="Rajasmand" & state=="RAJASTHAN"
replace dist_name="Sawaimadhopur" if dist_name=="Sawai_Madhopur" & state=="RAJASTHAN"
replace dist_name="Sirohi" if dist_name=="Shirohi" & state=="RAJASTHAN"

replace dist_name="Sikkim East" if dist_name=="East" & state=="SIKKIM"
replace dist_name="Sikkim North" if dist_name=="North" & state=="SIKKIM"
replace dist_name="Sikkim South" if dist_name=="South" & state=="SIKKIM"
replace dist_name="Sikkim West" if dist_name=="West" & state=="SIKKIM"

replace state="TAMIL NADU" if state=="TAMILNADU"
replace dist_name="Tiruvallur" if dist_name=="Thiruvallur" & state=="TAMIL NADU"
replace dist_name="Tiruvannamalai" if dist_name=="Thiruvannamalai" & state=="TAMIL NADU"
replace dist_name="Tiruchirappalli" if dist_name=="Tirchirappalli" & state=="TAMIL NADU"
replace dist_name="Kanniyakumari" if dist_name=="Kanyakumari" & state=="TAMIL NADU"

replace dist_name="Dhalai  " if dist_name=="Dhalai" & state=="TRIPURA"

replace dist_name="Baghpat" if dist_name=="Bagpat" & state=="UTTAR PRADESH"
replace dist_name="Bareilly" if dist_name=="Bareley" & state=="UTTAR PRADESH"
replace dist_name="Basti" if dist_name=="Vasti" & state=="UTTAR PRADESH"
replace dist_name="Bijnor" if dist_name=="Bijnore" & state=="UTTAR PRADESH"
replace dist_name="Budaun" if dist_name=="Badaun" & state=="UTTAR PRADESH"
replace dist_name="Ballia" if dist_name=="Balia" & state=="UTTAR PRADESH"
replace dist_name="Buland Shahr" if dist_name=="Bulandshahar" & state=="UTTAR PRADESH"
replace dist_name="Chandauli" if dist_name=="Chandoli" & state=="UTTAR PRADESH"
replace dist_name="Chitrakut" if dist_name=="Chitrakoot" & state=="UTTAR PRADESH"
replace dist_name="Deoria" if dist_name=="Devariya" & state=="UTTAR PRADESH"
replace dist_name="Etawah" if dist_name=="Itawah" & state=="UTTAR PRADESH"
replace dist_name="Firozabad" if dist_name=="Firojabad" & state=="UTTAR PRADESH"
replace dist_name="Gauttam Budh Nagar" if dist_name=="Gautam Budha Nagar" & state=="UTTAR PRADESH"
replace dist_name="Hathras" if dist_name=="Mahamayanagar" & state=="UTTAR PRADESH"
replace dist_name="Jyotiba Pholey Nagar" if dist_name=="Jyotiba Phulenagar" & state=="UTTAR PRADESH"
replace dist_name="Kushi Nagar" if dist_name=="Kushinagar" & state=="UTTAR PRADESH"
replace dist_name="Moradabad" if dist_name=="Muradabad" & state=="UTTAR PRADESH"
replace dist_name="Muzaffar Nagar" if dist_name=="Muzaffarnagar" & state=="UTTAR PRADESH"
replace dist_name="Rae Bareli" if dist_name=="Raibareily" & state=="UTTAR PRADESH"
replace dist_name="Shrawasti" if dist_name=="Shravasti" & state=="UTTAR PRADESH"
replace dist_name="Siddharth Nagar" if dist_name=="Sidharthanagar" & state=="UTTAR PRADESH"

replace state="UTTARAKHAND" if state=="UTTARANCHAL"
replace dist_name="Rudraprayag" if dist_name=="Rudryapryaag" & state=="UTTARAKHAND"
replace dist_name="Udhamsingh Nagar" if dist_name=="Udham Singh Nagar" & state=="UTTARAKHAND"

replace dist_name="Dakshin Dinajpur" if dist_name=="Dinajpur (South)" & state=="WEST BENGAL"
replace dist_name="North 24-Parganas" if dist_name=="24 Parganas (North)" & state=="WEST BENGAL"
replace dist_name="South 24-Parganas" if dist_name=="24 Parganas (South)" & state=="WEST BENGAL"
replace dist_name="Uttar Dinajpur" if dist_name=="Dinajpur (North)" & state=="WEST BENGAL"

save "...\GE\Agricultural census data 2005-06 GE cleaned.dta",replace
********************************************************************************
********************************************************************************
********************************************************************************
