/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Region Summary
Tools		: MySQL

Business Question:
1. Berapa rata-rata Inventory Level pada setiap region?
2. Berapa total Units Sold pada setiap region?
3. Region mana yang memiliki rata-rata Inventory Level tertinggi?
4. Region mana yang memiliki total Units Sold tertinggi?

Business Analytics:
Mengevaluasi performa inventory dan aktivitas penjualan pada setiap region
berdasarkan rata-rata Inventory Level dan total Units Sold untuk
mengidentifikasi wilayah dengan kebutuhan pengelolaan inventory yang berbeda.
*/

WITH clean_data AS (
	SELECT
		TRIM(Region) AS region, 
		Units_Sold, 
        Inventory_Level
    FROM supply_chain_inventory
),

region_summary AS (
	SELECT
		region,
        ROUND(AVG(Inventory_Level), 2) AS Avg_Inventory,
        SUM(Units_Sold) AS Total_Units_Sold
	FROM clean_data
    GROUP BY region
)

SELECT
	region AS Region,
    Avg_Inventory AS `AVG Inventory`,
    Total_Units_Sold AS `Units Sold`
FROM region_summary;