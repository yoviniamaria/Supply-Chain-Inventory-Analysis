CREATE VIEW vw_inventory_status AS

WITH clean_data AS (
	SELECT
		Date AS order_date, 
        Inventory_Level, 
		Reorder_Point,         
		Demand_Forecast
    FROM supply_chain_inventory
),

monthly_categories AS (
		SELECT
			STR_TO_DATE(
				DATE_FORMAT(order_date, '%Y-%m-01'), 
                '%Y-%m-%d'
			)AS Month,
            
            CASE 
				WHEN Inventory_Level < Reorder_Point
				THEN 'Below Reorder Point'
		
				WHEN Inventory_Level BETWEEN Reorder_Point
				AND Reorder_Point + 50
				THEN 'Near Reorder'
		
				WHEN Inventory_Level > Demand_Forecast * 25
				THEN 'High Inventory'
	
			ELSE 'Healthy Inventory'
			END AS Inventory_Status,
    
			COUNT(*) AS jumlah
        FROM clean_data
        GROUP BY Month, Inventory_Status
)

SELECT 
	Month,
    Inventory_Status AS `Inventory Status`,
    jumlah AS Jumlah
FROM monthly_categories;