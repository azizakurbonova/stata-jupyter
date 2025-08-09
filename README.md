# STATA to Jupyter Notebook Pipeline Conversion

## Overview
Quick demo that converts a statistical analysis pipeline from STATA to Python/Jupyter notebook using STATA's built-in cancer dataset (48 patients, 3 drug treatments). The goal is to perfectly replicate STATA's data transformation and aggregation operations in pandas, ensuring numerical equivalence in the summary statistics

## Pipeline Components
**Assemble → Munge → Analyze** workflow:

Cancer survival dataset is transformed by creating age groups, converting survival time to years, and labeling treatments. 

The analysis phase generates summary statistics by treatment and age group using groupby operations (replicating STATA's `collapse` command)

## Notes
Emphasis on handling categorical variables correctly when doing the STATA to Jupyter conversion (mapping "Other" → "Drug A"), data type conversions (Yes/No → 1/0), maintaining consistency in aggregation operations, etc.

The exercise includes validation code that performs numerical comparison between STATA and Python outputs. You can also compare the CSV summary output directly.
