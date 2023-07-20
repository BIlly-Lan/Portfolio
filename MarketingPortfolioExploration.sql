USE Portfolio_Project;

SELECT * 
FROM customer_table cus;

-- What was the response rate for all 5 of the campaign efforts? 

SELECT SUM(AcceptedCmpOverall)/COUNT(id)*100 AS OverallCmpSucsessRate
FROM campaign_table;


-- Next: What was the best to lowest performing campaign

SELECT 
	SUM(AcceptedCmp1) AS Cmp1Total,
    SUM(AcceptedCmp2) AS Cmp2Total,
    SUM(AcceptedCmp3) AS Cmp3Total,
    SUM(AcceptedCmp4) AS Cmp4Total,
    SUM(AcceptedCmp5) AS Cmp5Total
FROM campaign_table;

-- *Highest performing = Cmp 4 = 164 accepted
-- *Lowest performing = Cmp 2 =  30 accepted


-- Next:  What was the total response rate out of all customers asked across all campaigns 

SELECT 
    AVG(AcceptedCmpOverall)/COUNT(id)*100 AS TotalResponseRate
FROM campaign_table;


-- Total Response rate is Total Customers asked 2205/ Average number of Acceptions = 0.013%


SELECT
    COUNT(id) AS TotalCustomersAsked,
    SUM(AcceptedCmp1) AS Cmp1Total,
    (SUM(AcceptedCmp1) / COUNT(id)) * 100 AS Cmp1SuccessRate,
    SUM(AcceptedCmp2) AS Cmp2Total,
    (SUM(AcceptedCmp2) / COUNT(id)) * 100 AS Cmp2SuccessRate,
    SUM(AcceptedCmp3) AS Cmp3Total,
    (SUM(AcceptedCmp3) / COUNT(id)) * 100 AS Cmp3SuccessRate,
    SUM(AcceptedCmp4) AS Cmp4Total,
    (SUM(AcceptedCmp4) / COUNT(id)) * 100 AS Cmp4SuccessRate,
    SUM(AcceptedCmp5) AS Cmp5Total,
    (SUM(AcceptedCmp5) / COUNT(id)) * 100 AS Cmp5SuccessRate
FROM campaign_table;

-- cmp1 SR = 6.43%
-- Cmp2 SR = 1.36%
-- Cmp3 SR = 7.39%
-- Cmp4 SR = 7.43%
-- Cmp5 SR = 7.30%
-- avg SR 5.98%

-- What is the best-performing platform to sell products from ;

SELECT 
	AVG(NumWebPurchases) AS avgwebpurchases,
    AVG(NumStorePurchases) AS avgstorepurchases,
    AVG(NumCatalogPurchases) AS avgcatalogpurchases
FROM product_orders_table;

-- *Web = 4.1007, Store= 5.8236 Catalog = 2.6454



-- What are the characteristics of customers who responded positively to the pilot campaign? Is there any typical pattern among them?

SELECT 
	income, 
    Age, 
    CASE 
		WHEN Education_Graduation = 1 THEN "YES"
        WHEN Education_Master = 1 THEN "YES"
        WHEN Education_PhD = 1 THEN "YES"
		ELSE "NO" 
    END AS Above_Higher_Education,
	CASE
		WHEN Marital_Together = 1 THEN "YES"
        WHEN Marital_Married = 1 THEN "YES"
        ELSE "NO"
	END AS Partnered,
    CASE
		WHEN (kidhome + teenhome) > 2 THEN '>2'
        WHEN (kidhome + teenhome) <= 2 THEN '<=2'
	END AS Combined_Home_Count,
	mnttotal
FROM customer_table cust
JOIN Product_orders_table pot
	ON cust.id = pot.id
ORDER BY mnttotal DESC
LIMIT 10;

-- * Found correlation between having an extended education & total products purchased


-- NEXT: is there a correlation between the top 10 customers that used accepted the most campaigns?


SELECT * 
FROM campaign_table camt
JOIN customer_table cust
	ON cust.id = camt.id
ORDER BY AcceptedCmpOverall DESC
LIMIT 10;

-- AGE 45 - 60
-- Income > 80,000

-- NEXT: is there a corraltion between the BOTTOM 10 customers that used accepted the most campaigns ?
 

SELECT 
	AVG(age) AS AvgAge,
    cust.id,
    camt.AcceptedCmpOverall 
FROM campaign_table camt
JOIN customer_table cust
	ON cust.id = camt.id
LIMIT 10;

-- Relationship between campaign acceptance and purchasing behavior

SELECT 
	pot.NumWebVisitsMonth,
    camt.AcceptedCmpOverall 
FROM campaign_table camt
JOIN product_orders_table pot
	ON pot.id = camt.id
ORDER BY NumWebVisitsMonth DESC
lIMIT 10;

-- No strong corralation bettween web visit frequency and campaign acceptance

SELECT 
	acceptedcmpoverall,
	MntWines,
    MntFruits,
    MntMeatProducts,
    MntFishProducts,
    MntSweetProducts,
	MntGoldProds,
    NumDealsPurchases    
FROM campaign_table camt
JOIN product_orders_table pot
    ON pot.id = camt.id
ORDER BY acceptedcmpoverall DESC;

-- The customers who accepted more campaigns order a little more wine than average but nothing too extreme. 

-- totalmnt vs acceptedcmpoverall


SELECT 
	pot.NumWebVisitsMonth,
    camt.AcceptedCmpOverall 
FROM campaign_table camt
JOIN product_orders_table pot
	ON pot.id = camt.id
ORDER BY NumWebVisitsMonth DESC
lIMIT 10;

-- No strong corralation bettween web visit frequency and campaign acceptance

SELECT 
	acceptedcmpoverall,
	mnttotal
FROM campaign_table camt
JOIN product_orders_table pot
    ON pot.id = camt.id
ORDER BY mnttotal DESC;



