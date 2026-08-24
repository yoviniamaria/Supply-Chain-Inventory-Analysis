CREATE VIEW vw_product_inventory AS 

WITH clean_data AS (
	SELECT
		TRIM(SKU_ID) AS sku_id, 
		Units_Sold, 
        Inventory_Level,
        Reorder_Point,
		Order_Quantity,
		Unit_Cost, 
		Stockout_Flag
    FROM supply_chain_inventory
),

product_inventory AS (
	SELECT
		sku_id,
        ROUND(AVG(Inventory_Level),2) AS Avg_Inventory,
        ROUND(AVG(Reorder_Point), 2) AS Avg_Reorder_Point,
		ROUND(SUM(Inventory_Level * Unit_Cost), 2) AS Inventory_Value,
		SUM(Units_Sold) AS Total_Units_Sold,
		SUM(Order_Quantity) AS Total_Order_Quantity,
		SUM(Stockout_Flag) AS Total_Stockout_Flag
	FROM clean_data
	GROUP BY sku_id
)

SELECT
	sku_id AS SKU,
    Avg_Inventory AS `AVG Inventory`,
	Avg_Reorder_Point AS `AVG Reorder Point`,
    Inventory_Value AS `Inventory Value`,
    Total_Units_Sold AS `Units Sold`,
    Total_Order_Quantity AS `Order Quantity`,
    Total_Stockout_Flag AS `Stockout Flag`
FROM product_inventory;