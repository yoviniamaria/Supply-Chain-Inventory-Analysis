/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Warehouse Summary
Tools		: MySQL

Business Question:
1. Berapa rata-rata Inventory Level pada setiap warehouse?
2. Berapa total Units Sold pada setiap warehouse?
3. Warehouse mana yang memiliki rata-rata Inventory Level tertinggi?
4. Warehouse mana yang memiliki total Units Sold tertinggi?

Business Analytics:
Mengevaluasi distribusi inventory dan aktivitas penjualan pada setiap
warehouse berdasarkan rata-rata Inventory Level dan total Units Sold
untuk mendukung evaluasi operasional gudang.
*/

WITH clean_data AS (
	SELECT
		TRIM(Warehouse_ID) AS warehouse_id, 
		Units_Sold, 
        Inventory_Level
    FROM supply_chain_inventory
),

warehouse_summary AS (
	SELECT
		warehouse_id,
        ROUND(AVG(Inventory_Level), 2) AS Avg_Inventory,
        SUM(Units_Sold) AS Total_Units_Sold
	FROM clean_data
    GROUP BY warehouse_id
)

SELECT
	warehouse_id AS `Warehouse ID`,
    Avg_Inventory AS `AVG Inventory`,
    Total_Units_Sold AS `Units Sold`
FROM warehouse_summary;