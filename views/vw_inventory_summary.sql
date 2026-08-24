CREATE VIEW vw_inventory_summary AS 

WITH clean_data AS (
	SELECT
		Date AS order_date, 
        Units_Sold, 
        Inventory_Level,
		Reorder_Point, 
		Unit_Cost
    FROM supply_chain_inventory
),

monthly_inventory AS (
	SELECT
		STR_TO_DATE(
			DATE_FORMAT(order_date, '%Y-%m-01'),
			'%Y-%m-%d'
        ) AS Month,
    
		ROUND( AVG(Inventory_Level), 2) AS Avg_Inventory,
    
		SUM(Units_Sold) AS Total_Units_Sold,
    
		ROUND( AVG(Reorder_Point), 2) AS Avg_Reorder_Point,
    
		ROUND(SUM(Inventory_Level * Unit_Cost), 2) AS Inventory_Value
        
	FROM clean_data
    GROUP BY Month
)

SELECT
	Month, 
    Avg_Inventory AS `AVG Inventory`,
    Total_Units_Sold AS `Total Units Sold`,
    Avg_Reorder_Point AS `AVG Reorder Points`,
    Inventory_Value AS `Inventory Value`
FROM monthly_inventory;
    
    