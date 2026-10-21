Select *
From online_retail
LIMIT 10;

-- Quantity of rows --

Select COunt(*) as total_rows,
SUM(InvoiceNo is null) as null_invoice,
SUM(InvoiceNo is not null) as not_null_invoice
From online_retail
;

-- Dataset period --

SELECT MAX(InvoiceDate) as last_date, MIN(InvoiceDate) as first_date
From online_retail;

-- Countries --

Select Distinct Country as country
From online_retail ;

-- Monthly revenue --

Select date_format(InvoiceDate, '%Y-%m') as month_sales, SUM(Quantity*UnitPrice) as revenue
From online_retail
Group by month_sales
Order by month_sales;


-- TOP 5 month by revenue--

SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
    SUM(Quantity * UnitPrice) AS revenue
FROM online_retail
GROUP BY sales_month
ORDER BY revenue desc
LIMIT 5;

-- TOP 10 countries by revenue --

Select Country,SUM(Quantity*UnitPrice) as revenue
From online_retail 
Group by Country
Order by revenue DESC
Limit 10;

-- TOP 20 Customers by revenue --

SELECT TRIM(CustomerID) as customer_ID,
ROUND(SUM(Quantity*UnitPrice),2) as revenue
FROM online_retail
WHERE TRIM(CustomerID)<>''
AND CustomerID is not null
Group by customer_ID
order by revenue DESC
LIMIT 20;


-- Negative transactions --
 
Select count(Distinct InvoiceNo) as cancelled
From online_retail
Where InvoiceNo LIKE 'C%' ;
 
Select SUM(Quantity*UnitPrice) as negative_revenue
From online_retail
Where Quantity<0;

Select SUM(CASE 
When Quantity<0 Then Quantity*UnitPrice
Else 0
END)*100/SUM(Quantity*UnitPrice) as negative_transaction_percent From online_retail;

-- Product Analysis: TOP 10 by revenue(excluding postage) --

Select StockCode, `Description`,SUM(Quantity*UnitPrice) as revenue
From online_retail
Where StockCode NOT IN ('DOT', 'POST')
group by StockCode, `Description`
order by revenue DESC
LIMIT 10;