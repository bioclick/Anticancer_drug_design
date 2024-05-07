# Anticancer_drug_design

### Data Gathering

The drug combination data used in this study were sourced from DrugComb, DrugCombDB, and SYNERGxDB. The dataset covers 19 tissue types, with the majority of data concentrated in seven types: skin, lung, breast, ovarian, brain, kidney, and colon.

### About the Data

To evaluate the synergy scores of drug combinations, four different metrics were used:
The drug combination data used in this study were sourced from DrugComb, DrugCombDB, and SYNERGxDB. The dataset covers 19 tissue types, with the majority of data concentrated in seven types: skin, lung, breast, ovarian, brain, kidney, and colon.

### About the Data

To evaluate the synergy scores of drug combinations, four different metrics were used:

- **ZIP**
- **Loewe**
- **Bliss**
- **HSA**

These scores follow a near-normal distribution, mostly falling between -10 and 10, indicating that most drug combinations exhibit additive effects.

**Labeling Synergistic Effects:**
Fisher's exact test was used to identify drug pairs with synergistic effects. Odds ratios were calculated for pairs of mechanisms of action (MoA) to identify pathway combinations that are more likely to exhibit synergistic effects across different metrics (ZIP, Bliss, HSA, and Loewe). Drug pairs were classified into two groups:

- **Synergistic:** Synergy metric > 10
- **Non-Synergistic:** Synergy metric ≤ 10

### Preprocessing

**Feature Extraction:**
A comprehensive set of 12,221 pharmaceutical and genomic features was calculated to capture information from both drug chemical structures and cell lines:

**Feature Extraction:**
A comprehensive set of 12,221 pharmaceutical and genomic features was calculated to capture information from both drug chemical structures and cell lines:

- **Drug Chemical Descriptors:** RDKit, Mordred
- **Chemical Fingerprints:** MACCS, E-state
- **Deep Learning Fingerprint:** Infomax
- **Genomic Features:** Gene expression, mutation, copy number variation

**Feature Removal:**

- **Zero-Variance Features:** Eliminated
- **Highly Correlated Features:** Features with an absolute Pearson R > 0.9 were removed to prevent model instability and overfitting.

**Feature Selection:**
Features were selected based on their F-value via ANOVA. The selected feature sets consist of 2,000, 3,000, 4,000, or all features.

### Data Splitting

To evaluate model performance, the dataset was randomly partitioned into training and testing sets:

To evaluate model performance, the dataset was randomly partitioned into training and testing sets:

- **Training Set:** 80% (292,206 pairs)
- **Testing Set:** 20% (72,952 pairs)

### Hyperparameter Tuning

Optimal hyperparameter combinations were selected using grid search with 5-fold cross-validation.

### Model Construction

After preprocessing and tuning, three tree-based models were trained on the training set:

Optimal hyperparameter combinations were selected using grid search with 5-fold cross-validation.

### Model Construction

After preprocessing and tuning, three tree-based models were trained on the training set:

- **Random Forest**
- **XGBoost**
- **CatBoost**

### Model Evaluation

Three metrics were used to evaluate model performance:

1. **Normalized Mean Squared Error (NMSE)**

2. **Pearson Correlation Coefficient (PCC)**

3. **Accuracy:**

# Workflow

![Alt Text](https://github.com/bioclick/Anticancer_drug_design/blob/main/drug_workflow.png)

### The output is the synergy level determined using drug names and cell line names as input, based on the ZIP and Bliss metrics.

| Drug_1                        | Drug_2                  | Cell_line_name | Drug_1_cid | Drug_2_cid | DepMap_ID  | ZIP    | Bliss  |
| ----------------------------- | ----------------------- | -------------- | ---------- | ---------- | ---------- | ------ | ------ |
| Lapatinib Ditosylate (Tykerb) | Pazopanib hydrochloride | SUM-102PT      | 9941095    | 11525740   | ACH-001388 | 32.899 | 60.42  |
| Venetoclax (ABT-199)          | Vincristine             | SUM-102PT      | 49846579   | 5978       | ACH-001388 | 31.121 | 30.944 |
| Lapatinib Ditosylate (Tykerb) | Pazopanib hydrochloride | HCC1395        | 9941095    | 11525740   | ACH-000699 | 4.687  | 0.704  |
| Venetoclax (ABT-199)          | Vincristine             | HCC1395        | 49846579   | 5978       | ACH-000699 | 9.282  | 5.284  |
| Lapatinib Ditosylate (Tykerb) | Pazopanib hydrochloride | UACC-893       | 9941095    | 11525740   | ACH-000554 | 13.59  | 30.787 |
| Venetoclax (ABT-199)          | Vincristine             | UACC-893       | 49846579   | 5978       | ACH-000554 | 7.393  | 10.184 |
| Lapatinib Ditosylate (Tykerb) | Pazopanib hydrochloride | Du4475         | 9941095    | 11525740   | ACH-000258 | 8.056  | 11.08  |
| Venetoclax (ABT-199)          | Vincristine             | Du4475         | 49846579   | 5978       | ACH-000258 | 5.27   | 4.266  |
| Lapatinib Ditosylate (Tykerb) | Pazopanib hydrochloride | HCC1143        | 9941095    | 11525740   | ACH-000374 | -2.979 | 12.168 |
| Venetoclax (ABT-199)          | Vincristine             | HCC1143        | 49846579   | 5978       | ACH-000374 | -2.481 | -0.592 |
