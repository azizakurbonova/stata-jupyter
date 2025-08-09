* Demo using Stata's cancer dataset
sysuse cancer, clear

* COMMENTED OUT: Used to save data in order to load into Jupyter
* save "cancer.dta", replace

* Contains studytime (months to death / censoring), died (1 if dead,0 if censored), treatment type/drug, age
describe
codebook, compact

* If we want to, say, analyze treatment by age group
* First, prepare and transform data (munge)
gen age_group = .
replace age_group = 1 if age < 50
replace age_group = 2 if age >= 50 & age < 60
replace age_group = 3 if age >= 60 & age < 70
replace age_group = 4 if age >= 70 & age != .

label define age_grp 1 "Under 50" 2 "50-59" 3 "60-69" 4 "70+"
label values age_group age_grp

* Create survival time in years
gen survival_years = studytime / 12

* Create treatment labels
label define drug_lbl 1 "Placebo" 2 "Drug A" 3 "Drug B"
label values drug drug_lbl

* Generate a pseudo "time period" variable for trend analysis
* cancer data doesn't have years, use enrollment order instead
gen patient_id = _n
gen enrollment_period = ceil(patient_id/12)  // Group patients into periods

* Summary statistics by treatment group
tabstat survival_years age died, by(drug) stats(mean sum count)

* Collapse data by drug and age group
preserve
collapse (mean) mean_survival=survival_years ///
         (mean) mean_age=age ///
         (sum) n_died=died ///
         (count) n_patients=died, by(drug age_group)

list, sepby(drug)

* Save collapsed results
export delimited using "cancer_summary_results_stata.csv", replace
restore