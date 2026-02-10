Subscription Churn & Revenue Recovery Analysis 📊

📌 Project Overview

In this project, I acted as a Lead Data Analyst for a mid-sized SaaS company to address Revenue Leakage. I developed an end-to-end pipeline to analyze fragmented transaction logs, identifying that ~25% of monthly revenue was at risk due to "Involuntary Churn" (payment failures).

🛠️ Technical Stack

Python: Pandas (Cleaning), NumPy (Synthetic Data), Seaborn/Matplotlib (Visualization)

SQL: MySQL Workbench (Window Functions, CTEs, Aggregations)

Domain: SaaS Analytics, Revenue Operations (RevOps)

🔍 Key Implementation & Challenges

1. Data Engineering (Python)
Currency Normalization: Built a Regex pipeline to reconcile inconsistent formats ($19.99 vs 18.50 EUR), converting all records to a base USD value.

- Duplicate Logic: Identified and removed "System Glitch" duplicates using subset validation, preventing a 5% overestimation of MRR.

- Inference: Handled missing last_login timestamps to segment "Zombie Users" from active subscribers.

2. Advanced Analytics (SQL)
3. 
MRR Tracking: Utilized CTEs and DATE_FORMAT to aggregate fragmented logs into a clean monthly subscription view.

- Revenue Dynamics: Employed Window Functions (LAG) to track Month-over-Month (MoM) revenue changes, identifying specific months with high expansion vs. contraction.

📈 Insights & Recommendations

The "So What?":

-Analysis revealed that while behavioral churn is stable, technical payment failures account for $2,000 - $3,000 in lost revenue per month.

Proposed Action: 

- Implementing a Dunning Sequence (automated retries) could recover approximately $25k+ in Annual Recurring Revenue (ARR) with zero acquisition cost.

Silent Churn Risk:

- Established that the "Danger Zone" begins after 14 days of inactivity, where the probability of churn increases significantly.


🎓  Project Reflection

This project demonstrated the reality of "Messy Data." I learned that a Data Analyst's value isn't just in writing code, but in translating technical errors into business dollar amounts.
