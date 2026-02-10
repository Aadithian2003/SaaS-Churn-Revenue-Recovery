use saas_churn ;

WITH MonthlySummary AS (
    SELECT 
        customer_id,
        DATE_FORMAT(event_date, '%Y-%m-01') AS activity_month,
        amount_usd,
        status,
        -- Check if they had a success at any point this month
        MAX(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) OVER(PARTITION BY customer_id, DATE_FORMAT(event_date, '%Y-%m-01')) as had_success
    FROM transactions
)
SELECT * FROM MonthlySummary;




SELECT 
    customer_id,
    activity_month,
    current_month_mrr,
    prev_month_mrr,
    (current_month_mrr - IFNULL(prev_month_mrr, 0)) AS revenue_diff
FROM (
    SELECT 
        customer_id, 
        -- We define activity_month here so the outer query can see it
        DATE_FORMAT(event_date, '%Y-%m-01') AS activity_month, 
        SUM(amount_usd) AS current_month_mrr,
        -- Look at the previous month's revenue for this specific customer
        LAG(SUM(amount_usd)) OVER (PARTITION BY customer_id ORDER BY DATE_FORMAT(event_date, '%Y-%m-01')) AS prev_month_mrr
    FROM transactions 
    WHERE status = 'Success'
    GROUP BY customer_id, DATE_FORMAT(event_date, '%Y-%m-01')
) AS clean_mrr;



SELECT 
    DATE_FORMAT(event_date, '%Y-%m') AS month,
    SUM(CASE WHEN status = 'Failed' THEN amount_usd ELSE 0 END) AS revenue_at_risk,
    SUM(CASE WHEN status = 'Success' THEN amount_usd ELSE 0 END) AS recovered_revenue,
    -- Recovery Rate Calculation
    ROUND(
        SUM(CASE WHEN status = 'Success' THEN amount_usd ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN status = 'Failed' THEN amount_usd ELSE 0 END) + SUM(CASE WHEN status = 'Success' THEN amount_usd ELSE 0 END), 0) * 100, 2
    ) AS recovery_rate_pct
FROM transactions
GROUP BY 1
ORDER BY 1;
