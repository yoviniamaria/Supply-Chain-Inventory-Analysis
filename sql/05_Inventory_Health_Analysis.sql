/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Product Inventory Analytics
Tools		: MySQL

Business Question:
- Berapa banyak observasi yang berada pada masing-masing kondisi Inventory Health?
- Berapa banyak observasi yang berada di bawah atau mendekati Reorder Point?
- Apakah mayoritas observasi berada dalam kondisi Healthy Inventory?
- Seberapa besar proporsi observasi yang berpotensi menunjukkan High Inventory atau risiko kekurangan inventory?

Business Analytics:
Mengklasifikasikan kondisi Inventory Health berdasarkan Inventory Level, Reorder Point, dan Demand Forecast 
untuk mengidentifikasi potensi kelebihan atau kekurangan persediaan, 
serta mengevaluasi kesehatan inventory secara keseluruhan.

Note:
Kategori Inventory Health pada project ini menggunakan rule-based classification yang dirancang untuk tujuan analisis 
dan visualisasi portfolio, bukan merupakan standar operasional yang berlaku secara universal.
Setiap observasi diklasifikasikan ke dalam satu kategori berdasarkan urutan prioritas kondisi yang telah ditentukan.
*/

WITH clean_data AS (
	SELECT
        Inventory_Level, 
		Reorder_Point, 
		Demand_Forecast
    FROM supply_chain_inventory
)

SELECT
	
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
GROUP BY Inventory_Status;
