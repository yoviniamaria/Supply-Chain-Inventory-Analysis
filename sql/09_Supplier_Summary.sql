/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Supplier Performances & Inventory Analytics
Tools		: MySQL

Business Question:
1. Bagaimana performa supplier berdasarkan rata-rata lead time dan order quantity?
2. Supplier mana yang memiliki total order quantity tertinggi?
3. Bagaimana hubungan antara supplier lead time dan order quantity?
4. Bagaimana kondisi rata-rata inventory dibandingkan dengan reorder point pada setiap supplier?

Business Analytics:
Mengevaluasi performa supplier dan kondisi inventory untuk mengidentifikasi efisiensi replenishment 
serta potensi risiko persediaan.
*/

WITH clean_data AS (
	SELECT
        TRIM(Supplier_ID) AS supplier_id,
		Units_Sold, 
        Inventory_Level,
        Supplier_Lead_Time_Days,
        Reorder_Point,
		Order_Quantity
    FROM supply_chain_inventory
),

supplier_summary AS (
	SELECT
		supplier_id,
    
		ROUND(AVG(Supplier_Lead_Time_Days), 2 ) AS AVG_Lead_Time,
    
		SUM(Order_Quantity) AS Total_Order_Qty,
    
		ROUND(AVG(Order_Quantity), 2 ) AS AVG_Order_Qty,
    
		ROUND(AVG(Inventory_Level), 2 ) AS AVG_Inventory,
    
		ROUND(AVG(Reorder_Point), 2 ) AS AVG_Reorder_Point,
    
		SUM(Units_Sold) AS Total_Units_Sold

	FROM clean_data
	GROUP BY supplier_id
)

SELECT
    supplier_id AS `Supplier ID`,
	AVG_Lead_Time AS `Avg Lead Time`,
    Total_Order_Qty AS `Total Order Quantity`,
    AVG_Order_Qty AS `Avg Order Quantity`,
    AVG_Inventory AS `Avg Inventory`,
    AVG_Reorder_Point AS `Avg Reorder Point`,
    Total_Units_Sold AS `Total Units Sold`
FROM supplier_summary;