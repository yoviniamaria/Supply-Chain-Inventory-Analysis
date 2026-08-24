/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Inventory Analytics
Tools		: MySQL

Business Question:
1. Bagaimana tren rata-rata Inventory Level setiap bulan?
2. Berapa total Units Sold setiap bulan?
3. Bagaimana perbandingan rata-rata Inventory Level dengan Reorder Point setiap bulan?

Business Analytics:
Menganalisis tren inventory bulanan untuk mengevaluasi keseimbangan antara 
Inventory Level, Units Sold, dan Reorder Point selama periode 2024.
*/

WITH clean_data AS (
	SELECT
		Date AS order_date, 
        Inventory_Level,
        Units_Sold, 
        Reorder_Point
    FROM supply_chain_inventory
)

SELECT
	DATE_FORMAT(order_date, '%Y-%m-01') AS Month,
    
    ROUND( AVG(Inventory_Level), 2) AS Avg_Inventory,
    
    SUM(Units_Sold) AS Total_Units_Sold,
    
    ROUND( AVG(Reorder_Point), 2) AS Avg_Reorder_Point
FROM clean_data
GROUP BY Month
ORDER BY Month;
