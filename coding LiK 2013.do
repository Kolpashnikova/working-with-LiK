use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh0.dta", clear 
keep  hhid10 hhid11 hhid12 hhid psu residence oblast
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh0new.dta", replace

*this one has pid
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh1a.dta", clear
keep hhid pid h102 h103_m h103_y h103a h104 h105 h108 h108a 
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh1anew.dta", replace

*assets
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh2b.dta", clear
keep  hhid n2b h223
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh2bnew.dta", replace
forvalues i = 1(1)40 {
    by hhid: gen n2b`i' = 1 if n2b==`i'
	by hhid: egen new`i' = max(n2b`i')
	replace new`i'=0 if new`i'==.
	drop n2b`i'
}


rename new1 main_dwelling
rename new2 another_house
rename new3   garage
rename new4   bicycle
rename new5   motorcycle
rename new6   car
rename new7   tractor
rename new8   refrigerator
rename new9   gas_stove
rename new10   electric_stove
rename new11   microwave
rename new12   air_conditioner
rename new13   sewing_machine
rename new14   washing_machine_regular
rename new15   washing_machine_automated
rename new16   vacuum_cleaner
rename new17   sofa
rename new18   wardrobe
rename new19   bed
rename new20   kitchen_furniture
rename new21   radio
rename new22   music_system
rename new23   television
rename new24   dvd_player
rename new25   video_camera
rename new26   photo_camera
rename new27   digital_camera
rename new28   pc
rename new29   satellite_dish
rename new30   mobile_phone
rename new31   landline_phone
rename new32   internet_connection
rename new33   cows
rename new34   sheep
rename new35   horses
rename new36   donkeys
rename new37   pigs
rename new38   rabbits
rename new39   chicken
rename new40   bees

drop n2b h223
duplicates drop
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh2bnew.dta", replace


*saving and loans
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh2d.dta", clear
keep hhid h247 h249 h250
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh2dnew.dta", replace

*household income
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh5a.dta", clear
keep  hhid source h502
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh5anew.dta", replace
by hhid: egen HhldInc = total(h502)
forvalues i = 1(1)18 {
    by hhid: gen source`i' = 1 if source==`i'
	by hhid: egen new`i' = max(source`i')
	replace new`i'=0 if new`i'==.
	drop source`i'
}

rename new1 farming
rename new2 agricultural
rename new3 enterpreneurship
rename new4 non_agricultural_enterprises
rename new5 rents
rename new6 rents_from_land
rename new7 interests
rename new8 dividends
rename new9 money_transfers_from_abroad
rename new10 aid_from_persons_kyrgyz
rename new11 NGOs
rename new12 wage
rename new13 bonuses
rename new14 irregular_work
rename new15 inheritance
rename new16 alimony
rename new17 scholarships
rename new18 other_income

drop source h502
duplicates drop
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh5anew.dta", replace

*migrants
*h602 is pid
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh6a.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh6anew.dta", replace
rename h602 pid
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh6anew.dta", replace

*migrants additional
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh6b.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh6bnew.dta", replace

*events negative
use "C:\Users\user\Documents\2018\LIK_stata\data2013\household\hh7.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh7new.dta", replace

**************** merging the above ********************************
use "C:\Users\user\Documents\2018\LIK_stata\data2013\hh0new.dta", clear
merge 1:1 hhid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh2bnew.dta", update nogen
merge 1:1 hhid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh2dnew.dta", update nogen
merge 1:1 hhid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh5anew.dta", update nogen
merge 1:1 hhid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh6bnew.dta", update nogen
merge 1:1 hhid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh7new.dta", update nogen
save "C:\Users\user\Documents\2018\LIK_stata\data2013\hh_merge_beforepid_2013.dta", replace

/********************************
* BELOW ARE INDIVIDUAL VARIABLES
*********************************/




*life satisfaction
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id1.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id1new.dta", replace

*education (some of the data is in the previous years b/c nothing changed since then
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id2a.dta", clear
keep hhid pid i200 i206 i211
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id2anew.dta", replace

*health
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id2b.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id2bnew.dta", replace

*employment
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id3a.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id3anew.dta", replace

*employment details
*  i319c i319s if not empty - it means this is a self-employed person (how much profit)
* i325 this is for those who work for someone else
* contains information whether the work is full time or temp
* i332 contains information how much money they earn on this job
*  i337 contains information about the main breadwinner
*  i357 this is a profit from a side business
* i363 wage on the side job
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id3b.dta", clear
keep hhid pid i305_1 i305_2 i306_1 i306_2 i319c i319s i325 i332 i337 i357 i363
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id3bnew.dta", replace

* migration within last year
* 
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id4.dta", clear
keep  hhid pid i415 i416 i417_oct12 i417_nov12 i417_dec12 i417_jan13 i417_feb13 i417_mar13 i417_apr13 i417_may13 i417_jun13 i417_jul13 i417_aug13 i417_sep13 i417_oct13 i418
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id4new.dta", replace

*decision making in different aspects of life but not housework
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id5b.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id5bnew.dta", replace


* time use - needs to be transformed before merge
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id5c.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id5cnew.dta", replace
gen Weekday=1
replace Weekday=0 if i502==6|i502==7
egen total_time=rowtotal(t0400- t0330)
sum total_time
gen total_time_min=total_time*30
sum total_time_min

drop  i501 i502 t0400 t0430 t0500 t0530 t0600 t0630 t0700 t0730 t0800 t0830 t0900 t0930 t1000 t1030 t1100 t1130 t1200 t1230 t1300 t1330 t1400 t1430 t1500 t1530 t1600 t1630 t1700 t1730 t1800 t1830 t1900 t1930 t2000 t2030 t2100 t2130 t2200 t2230 t2300 t2330 t0000 t0030 t0100 t0130 t0200 t0230 t0300 t0330 total_time

reshape wide total_time_min , i(hhid pid) j(activity)
forval i= 1(1)34 {
	replace total_time_min`i'=0 if total_time_min`i'==.
}

rename total_time_min1 sleep
rename total_time_min2 per_care
rename total_time_min3 eating 
rename total_time_min4 health_care
rename total_time_min5 cooking
rename total_time_min6 laundry
rename total_time_min7 shoping
rename total_time_min8 h_cleaning
rename total_time_min9 h_repairs
rename total_time_min10 h_work
rename total_time_min11 childcare
rename total_time_min12 elderly_care
rename total_time_min13 travel
rename total_time_min14 animal_care
rename total_time_min15 garden_work
rename total_time_min16 food_processing
rename total_time_min17 h_production
rename total_time_min18 leisure
rename total_time_min19 internet
rename total_time_min20 cinema
rename total_time_min21 sport
rename total_time_min22 t_fam_friends
rename total_time_min23 phone_conver
rename total_time_min24 social_reunion
rename total_time_min25 religious_act
rename total_time_min26 community_work
rename total_time_min27 other
rename total_time_min28 education
rename total_time_min29 self_educ
rename total_time_min30 paid_employment
rename total_time_min31 onetime_job
rename total_time_min32 self_employment
rename total_time_min33 unpaid_fam_work
rename total_time_min34 job_looking

gen year = 2013

save "C:\Users\user\Documents\2018\LIK_stata\data2013\id5cnew.dta", replace

*number of children their age and gender
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id5dch.dta", clear
keep  hhid pid i528 i530 i531_yy
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id5dchnew.dta", replace

by hhid pid: egen numchild=max(i528)

sort hhid pid i530
by hhid pid: gen malechild=1 if i530==1
by hhid pid: gen femalechild=1 if i530==2

by hhid pid: egen malech = max(malechild)
replace malech = 0 if malech ==.
by hhid pid: egen femalech = max(femalechild)
replace femalech = 0 if femalech ==.

drop malechild femalechild

gen underand5=1 if i531_yy>=2008
gen underand6=1 if i531_yy>=2007
gen underand2=1 if i531_yy>=2011
gen underand18=1 if i531_yy>=1995
replace underand5=0 if underand5==.
replace underand6=0 if underand6==.
replace underand2=0 if underand2==.
replace underand18=0 if underand18==.

by hhid pid: egen numchildunderand5=total(underand5)
by hhid pid: egen numchildunderand6=total(underand6)
by hhid pid: egen numchildunderand2=total(underand2)
by hhid pid: egen numchildunderand18=total(underand18)

drop  i528 i530 i531_yy underand5 underand6 underand2 underand18

duplicates drop
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id5dchnew.dta", replace

*gender attitudes
use "C:\Users\user\Documents\2018\LIK_stata\data2013\individual\id5e.dta", clear
save "C:\Users\user\Documents\2018\LIK_stata\data2013\id5enew.dta", replace

use "C:\Users\user\Documents\2018\LIK_stata\data2013\id1new.dta", clear
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id2anew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id2bnew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id3anew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id3bnew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id4new.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id5bnew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id5cnew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id5dchnew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\id5enew.dta", update nogen

save "C:\Users\user\Documents\2018\LIK_stata\data2013\indmergednew2013.dta", replace

use "C:\Users\user\Documents\2018\LIK_stata\data2013\indmergednew2013.dta", clear
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh1anew.dta", update nogen
merge 1:1 hhid pid using "C:\Users\user\Documents\2018\LIK_stata\data2013\hh6anew.dta", update nogen

save "C:\Users\user\Documents\2018\LIK_stata\data2013\indmergednew2013.dta", replace

/*****************************************
**** MERGING HHID AND PID
*****************************************/

use "C:\Users\user\Documents\2018\LIK_stata\data2013\hh_merge_beforepid_2013.dta", clear
merge 1:m hhid using "C:\Users\user\Documents\2018\LIK_stata\data2013\indmergednew2013.dta", update nogen
save "C:\Users\user\Documents\2018\LIK_stata\data2013\merged_LiK_2013.dta", replace


