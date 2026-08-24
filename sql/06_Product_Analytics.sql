/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Product Inventory Analytics
Tools		: MySQL

Business Question:
1. Berapa Invetory Value setiap produk?
2. Produk mana yang paling sering berada pada atau di bawah Reorder Point?
3. Berapa rata-rata selisih Inventory level terhadap Reorder Point pada setiap SKU?

Business Analytics:
Mengevaluasi kondisi persediaan dengan menghitung Inventory Value,
mengidentifikasi SKU yang paling sering mencapai Reorder Point,
serta menganalisis rata-rata selisih Inventory Level terhadap Reorder Point untuk mendukung keputusan replenishment.
*/

WITH clean_data AS (
	SELECT
		TRIM(SKU_ID) AS sku_id, 
        Units_Sold, 
        Inventory_Level, 
        Reorder_Point,
        Unit_Cost        
    FROM supply_chain_inventory
),

product_metrics AS (
    SELECT
        sku_id,

        -- Total Inventory Value
        ROUND(
            SUM(Inventory_Level * Unit_Cost),
            2
        ) AS Inventory_Value,

        -- Frequency of Inventory at/below Reorder Point
        SUM(
            CASE
                WHEN Inventory_Level <= Reorder_Point THEN 1
                ELSE 0
            END
        ) AS Reorder_Point_Frequency,

        -- Average Gap only when Inventory is at/below ROP
        ROUND(
            AVG(
                CASE
                    WHEN Inventory_Level <= Reorder_Point
                    THEN Inventory_Level - Reorder_Point
                END
            ), 2 ) AS Avg_Gap

    FROM clean_data
    GROUP BY sku_id
)

SELECT
	sku_id AS `SKU ID`,
    Inventory_Value AS `Inventory Value`,
    Reorder_Point_Frequency AS `Reorder Point Frequency`,
    Avg_Gap AS `AVG Gap`
FROM product_metrics
ORDER BY `Reorder Point Frequency` DESC;