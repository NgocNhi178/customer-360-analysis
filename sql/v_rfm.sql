WITH RFM AS (
    SELECT
        ct.CustomerID,

        MAX(ct.Purchase_Date) AS Last_Purchase,

        DATE_DIFF(
            DATE '2022-09-01',
            MAX(ct.Purchase_Date),
            DAY
        ) AS Recency,

        SAFE_DIVIDE(
            COUNT(ct.Transaction_ID),
            GREATEST(
                DATE_DIFF(
                    DATE '2022-09-01',
                    cr.created_date,
                    MONTH
                ),
                1
            )
        ) AS Frequency,

        SUM(ct.GMV) AS Monetary

    FROM customer360.customer_transaction ct
    JOIN customer360.customer_registered cr
        ON ct.CustomerID = cr.ID

    GROUP BY
        ct.CustomerID,
        cr.created_date
),

N AS (
    SELECT
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.25) THEN Recency END) AS Q1,
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.50) THEN Recency END) AS Q2,
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.75) THEN Recency END) AS Q3
    FROM (
        SELECT
            Recency,
            ROW_NUMBER() OVER (ORDER BY Recency) AS stt,
            COUNT(*) OVER() AS tongsodong
        FROM RFM
    )
),

F AS (
    SELECT
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.25) THEN Frequency END) AS Q1,
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.50) THEN Frequency END) AS Q2,
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.75) THEN Frequency END) AS Q3
    FROM (
        SELECT
            Frequency,
            ROW_NUMBER() OVER (ORDER BY Frequency) AS stt,
            COUNT(*) OVER() AS tongsodong
        FROM RFM
    )
),

M AS (
    SELECT
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.25) THEN Monetary END) AS Q1,
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.50) THEN Monetary END) AS Q2,
        MAX(CASE WHEN stt = FLOOR(tongsodong * 0.75) THEN Monetary END) AS Q3
    FROM (
        SELECT
            Monetary,
            ROW_NUMBER() OVER (ORDER BY Monetary) AS stt,
            COUNT(*) OVER() AS tongsodong
        FROM RFM
    )
),

RFMscore AS (
    SELECT
        r.CustomerID,
        r.Recency,
        r.Frequency,
        r.Monetary,

        CASE
            WHEN r.Recency <= n.Q1 THEN 4
            WHEN r.Recency <= n.Q2 THEN 3
            WHEN r.Recency <= n.Q3 THEN 2
            ELSE 1
        END AS R_score,

        CASE
            WHEN r.Frequency <= f.Q1 THEN 1
            WHEN r.Frequency <= f.Q2 THEN 2
            WHEN r.Frequency <= f.Q3 THEN 3
            ELSE 4
        END AS F_score,

        CASE
            WHEN r.Monetary <= m.Q1 THEN 1
            WHEN r.Monetary <= m.Q2 THEN 2
            WHEN r.Monetary <= m.Q3 THEN 3
            ELSE 4
        END AS M_score

    FROM RFM r
    CROSS JOIN N n
    CROSS JOIN F f
    CROSS JOIN M m
)

SELECT
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    R_score,
    F_score,
    M_score,

    CONCAT(
        CAST(R_score AS STRING),
        CAST(F_score AS STRING),
        CAST(M_score AS STRING)
    ) AS RFM_score,

    CASE
        WHEN R_score >= 3 AND F_score >= 3 AND M_score >= 3
            THEN 'VIP'

        WHEN R_score <= 2 AND F_score >= 3 AND M_score >= 3
            THEN 'KHONG THE MAT'

        WHEN R_score = 4 AND F_score <= 2 AND M_score <= 2
            THEN 'KHACH MOI'

        WHEN R_score >= 3 AND (F_score >= 3 OR M_score >= 3)
            THEN 'THAN THIET'

        WHEN R_score <= 2 AND (F_score >= 3 OR M_score >= 3)
            THEN 'NGUY CO MAT'

        WHEN R_score >= 3 AND F_score <= 2 AND M_score <= 2
            THEN 'TIEM NANG'

        WHEN R_score <= 2 AND F_score <= 2 AND M_score <= 2
            THEN 'NGU DONG'

        ELSE 'KHAC'
    END AS Segment

FROM RFMscore