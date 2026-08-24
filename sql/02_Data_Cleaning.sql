/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Clean Data
Tools		: MySQL

Business Questions:
1. Apakah dataset sudah memiliki format dan struktur data yang sesuai untuk analisis?
2. Apakah terdapat data yang tidak konsisten pada kolom ID (SKU, Warehouse, Supplier, Region)?
3. Berapa jumlah data yang tersedia setelah proses cleaning?
4. Apakah dataset hasil cleaning sudah siap digunakan untuk analisis inventory dan supply chain?

Business Analytics:
Melakukan proses data cleaning dan validasi awal untuk memastikan kualitas, konsistensi, dan kesiapan dataset 
sebelum digunakan dalam analisis inventory dan supply chain performance. 
*/


/*======================================================================================================================
1. CLEAN DATA DAN VALIDASI
========================================================================================================================*/
WITH clean_data AS (
	SELECT
		Date, 
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

SELECT * FROM clean_data LIMIT 10;


/*======================================================================================================================
2. CLEAN DATA DAN VALIDASI JUMLAH DATA
========================================================================================================================*/
WITH clean_data AS (
	SELECT
		Date, 
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

SELECT COUNT(*)
FROM clean_data;