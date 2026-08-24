CREATE VIEW vw_region_summary AS

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