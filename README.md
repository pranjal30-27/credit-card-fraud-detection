# Credit Card Fraud Detection & Risk Dashboard

## Problem Statement
Credit card fraud costs the global economy over $30 billion annually.
This project builds an end-to-end fraud detection system using machine
learning, statistical analysis, and an interactive Power BI dashboard
to identify fraudulent transactions in real time.

## Dataset
- Source: Kaggle — ULB Machine Learning Group
- 284,807 transactions | 31 features | 492 fraud cases (0.17%)
- Zero missing values

## Project Structure
fraud_detection/
├── notebooks/       # Python EDA, ML modeling, R analysis
├── reports/         # Charts, dashboard PDF, model results
├── data/            # Raw dataset (not uploaded to GitHub)
└── README.md

## Tools & Technologies
| Tool                     | Purpose                                   |
|--------------------------|-------------------------------------------|
| Python (Pandas, Sklearn) | Data cleaning, EDA, ML modeling           |
| XGBoost                  | Primary fraud detection model             |
| SMOTE (imbalanced-learn) | Handling class imbalance                  |
| R (ggplot2)              | Statistical analysis & hypothesis testing |
| Power BI                 | Interactive fraud risk dashboard          |

## Methodology
1. **EDA** — Explored 284,807 transactions, identified severe
   class imbalance (0.17% fraud)
2. **SMOTE** — Generated synthetic fraud samples to balance
   training data from 394 to 227,648 fraud cases
3. **Modeling** — Trained Logistic Regression, Random Forest,
   and XGBoost; evaluated using Precision-Recall AUC
4. **Statistical Analysis** — Hypothesis testing confirmed fraud
   transactions are statistically different (p < 0.001)
5. **Dashboard** — Built 3-page Power BI dashboard with KPIs,
   model scorecard, and drill-through risk view

## Results

| Model               | Precision | Recall | F1   | PR-AUC |
|---------------------|-----------|--------|------|--------|
| Logistic Regression | 0.06      | 0.91   | 0.11 | 0.70   |
| Random Forest       | 0.87      | 0.78   | 0.82 | 0.86   |
| XGBoost             | 0.88      | 0.81   | 0.84 | 0.88   |

**Best Model: XGBoost — PR-AUC 0.88**

## Key Findings
1. Fraud transactions cluster at very low amounts (<€10) —
   fraudsters test stolen cards with small purchases first
2. Fraud spikes between midnight and 4am when monitoring is low
3. Features V14, V17, V12 are the strongest fraud predictors
4. Accuracy is misleading for imbalanced data — PR-AUC is
   the correct metric (99.8% accuracy means nothing here)

## How to Run
```bash
# Clone the repo
git clone https://github.com/pranjal30-27/fraud-detection

# Install dependencies
pip install -r requirements.txt

# Run notebooks in order
jupyter notebook notebooks/01_eda.ipynb
jupyter notebook notebooks/02_modeling.ipynb
```

## Dashboard
Open reports/fraud_dashboard.pbix in Power BI Desktop
or view the static PDF at reports/fraud_dashboard.pdf

## Author
Pranjal | May 2026
[LinkedIn](www.linkedin.com/in/pranjal-khaire-12447b273) | 
[GitHub](https://github.com/pranjal30-27)
