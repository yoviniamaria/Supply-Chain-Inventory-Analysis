CREATE VIEW vw_warehouse_summary AS

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