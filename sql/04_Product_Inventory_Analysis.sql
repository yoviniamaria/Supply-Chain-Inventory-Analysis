/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Product Inventory Analytics
Tools		: MySQL

Business Question:
1. Produk mana yang memiliki rata-rata Inventory Level tertinggi?
2. Produk mana yang memiliki Inventory Coverage tertinggi?
3. Produk mana yang memiliki Inventory Level relatif tinggi dibandingkan dengan Demand Forecast?

Business Analytics:
Mengevaluasi kondisi inventory setiap produk berdasarkan
Inventory Level, Units Sold, Demand Forecast, dan Inventory Coverage
untuk mengidentifikasi produk dengan tingkat persediaan tinggi
dan potensi overstock.
*/

WITH clean_data AS (
	SELECT
		Date AS order_date, 
		TRIM(SKU_ID) AS sku_id, 
		TRIM(Warehouse_ID) AS warehouse_id, 
        TRIM(Supplier_ID) AS supplier_id, 
		TRIM(Region) AS region, 
		Units_Sold, 
        Inventory_Level, 
        Supplier_Lead_Time_Days, 
		Reorder_Point, 
		Order_Quantity, 
		Unit_Cost, 
		Unit_Price, 
		Promotion_Flag, 
		Stockout_Flag, 
		Demand_Forecast
    FROM supply_chain_inventory
)

SELECT
	sku_id,
	ROUND( AVG(Inventory_Level), 2) AS Avg_Inventory,
    SUM(Units_Sold) AS Total_Units_Sold,
    ROUND( AVG(Demand_Forecast), 2) AS Avg_Demand_Forecast,
    ROUND( 
		AVG(Inventory_Level) / 
        AVG(Demand_Forecast), 2
	) AS Inventory_Coverage
FROM clean_data
GROUP BY sku_id
ORDER BY Inventory_Coverage DESC
LIMIT 10;