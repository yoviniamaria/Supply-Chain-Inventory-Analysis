/*
Project		: Supply Chain Performance Analyst
Author		: Maria Yovinia
Analysis	: Data Quality Check
Tools		: MySQL

Description:
SQL queries untuk Dataset Imported, Data Quality Check dan Businness Validation

*/

/*======================================================================================================================
1. STRUCTURE TABLE
========================================================================================================================*/
CREATE TABLE supply_chain_inventory (Date DATE, 
									SKU_ID VARCHAR(8), 
                                    Warehouse_ID VARCHAR(8), 
                                    Supplier_ID VARCHAR(8), 
                                    Region VARCHAR(8), 
                                    Units_Sold INTEGER, 
                                    Inventory_Level INTEGER, 
                                    Supplier_Lead_Time_Days INTEGER, 
                                    Reorder_Point INTEGER, 
                                    Order_Quantity INTEGER, 
                                    Unit_Cost DECIMAL(10,2), 
                                    Unit_Price DECIMAL(10,2), 
                                    Promotion_Flag TINYINT(1), 
                                    Stockout_Flag TINYINT(1), 
                                    Demand_Forecast DECIMAL(10,2));

/*======================================================================================================================
2. IMPORT DATA
========================================================================================================================*/
-- Import database menggunakan load data local infile
LOAD DATA LOCAL INFILE 'D:/Desktop/New folder (2)/supply_chain_dataset1.csv'
INTO TABLE supply_chain_inventory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE 'local_infile';

SELECT * FROM supply_chain_inventory LIMIT 10;

/*======================================================================================================================
3. DATASET OVERVIEW
========================================================================================================================*/
SELECT 
	COUNT(*) AS total_rows
FROM supply_chain_inventory;

-- Jumlah kolom
SELECT
	COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_schema = 'retail_sales'
AND table_name = 'supply_chain_inventory';

/* Investigation Result
	- Rows: 91250
    - Columns: 15
*/

/*======================================================================================================================
4. DATA TYPE CHECK 
========================================================================================================================*/
DESCRIBE supply_chain_inventory;

/* Investigation Result
	- semua tipe data sudah sesuai dengan sruktur tabel yang dibuat sebelum proses LOAD DATA LOCAL INFILE
*/

/*======================================================================================================================
5. MISSING VALUE CHECK 
========================================================================================================================*/
SELECT
	SUM(Date IS NULL) AS Date_Null,
    SUM(SKU_ID IS NULL) AS SKU_Null,
    SUM(Warehouse_ID IS NULL) AS Warehouse_Null,
    SUM(Supplier_ID IS NULL) AS Supplier_Null,
    SUM(Region IS NULL) AS Region_Null,
    SUM(Units_Sold IS NULL) AS Units_Sold_Null,
    SUM(Inventory_Level IS NULL) AS Inventory_Level_Null,
    SUM(Supplier_Lead_Time_Days IS NULL) AS Lead_Time_Null,
    SUM(Reorder_Point IS NULL) AS Reorder_Point_Null,
    SUM(Order_Quantity IS NULL) AS Order_Qty_Null,
    SUM(Unit_Cost IS NULL) AS Unit_Cost_Null,
    SUM(Unit_Price IS NULL) AS Unit_Price_Null,
	SUM(Promotion_Flag IS NULL) AS Promotion_Flag_Null,
    SUM(Stockout_Flag IS NULL) AS Stockout_Flag_Null,
    SUM(Demand_Forecast IS NULL) AS Demand_Forecast_Null
FROM supply_chain_inventory;

-- Empty String Check 
SELECT
	SUM(SKU_ID = '') AS Empty_SKU,
    SUM(Warehouse_ID = '') AS Empty_Warehouse,
    SUM(Supplier_ID = '') AS Empty_Supplier,
    SUM(Region = '') AS Empty_Region
FROM supply_chain_inventory;

/* Investigation Result
	- Tidak ditemukan missing value
    - tidak ditemukan Empty string
*/

/*======================================================================================================================
6. DUPLICATE CHECK 
========================================================================================================================*/
SELECT
	COUNT(*) AS Total_Row,
    COUNT(DISTINCT CONCAT_WS('|',
	Date,
    SKU_ID,
    Warehouse_ID,
    Supplier_ID,
    Region,
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
    )) AS Unique_Row
FROM supply_chain_inventory;

/* Investigation Result
	Total_Row = 91250 Unique_Row = 91250
	- Tidak ditemukan duplikat data
*/


/*======================================================================================================================
6. BUSINESS VALIDATION
========================================================================================================================*/
-- Investigate Inventory < Reorder Point tetapi Order Quantity = 0
SELECT
	Inventory_Level,
    Reorder_Point,
    order_quantity
FROM supply_chain_inventory
WHERE Inventory_Level < Reorder_Point 
	AND Order_Quantity = 0;

-- Stockout Flag
SELECT
	Stockout_Flag,
    Inventory_Level
FROM supply_chain_inventory
WHERE Stockout_Flag = 1;

-- Investigate Promotion Flag
SELECT
	Promotion_Flag,
    Units_Sold,
    Inventory_Level
FROM supply_chain_inventory
WHERE Promotion_Flag = 1
	AND Units_Sold <= 5;
    
SELECT
	Promotion_Flag,
    AVG(Units_Sold) AS Avg_Units_Sold,
    AVG(Demand_Forecast) AS Avg_Forecast
FROM supply_chain_inventory 
GROUP BY Promotion_Flag;

/* Investigation Result
	- Total Inventoy < ROP dan Quantity_Order = 0 sebanyak 4787 data
    - Sebagian besar produk yang berada di bawah Reorder Point memiliki selisih inventory yang relatif kecil, 
	  sehingga kondisi ini belum tentu menunjukkan keterlambatan replenishment dan masih memerlukan investigasi 
      lebih lanjut.
      
	- Tidak ditemukan data dengan Stockout_Flag = 1 selama periode observasi. Oleh karena itu 
      analisis stockout tidak dapat dilakukan pada dataset ini.
    
    - Produk yang mengikuti program promosi memiliki rata-rata penjualan lebih tinggi 
      dibandingkan produk tanpa promosi.
*/

-- Investigate Unit Price < Unit Cost
SELECT
	Unit_Price,
    Unit_Cost
FROM supply_chain_inventory
WHERE Unit_Price < Unit_Cost;

-- Investigate: Inventory Level Negatif
SELECT
	Inventory_Level
FROM supply_chain_inventory
WHERE Inventory_Level < 0;

-- Investigate Demand Forecast > Inventory Level
SELECT
	Inventory_Level,
    Demand_Forecast
FROM supply_chain_inventory
WHERE Demand_Forecast > Inventory_Level;

-- Investigate Supplier Lead Time
SELECT
	COUNT(DISTINCT Supplier_ID) AS Total_Supplier,
    MAX(Supplier_Lead_Time_Days) 
FROM supply_chain_inventory
WHERE Supplier_Lead_Time_Days = (
	SELECT
		MAX(Supplier_Lead_Time_Days)
	FROM supply_chain_inventory);

-- Investigate Order Quantity > Reorder Point
SELECT
	Inventory_Level,
	Reorder_Point,
	Order_Quantity,
	(Inventory_Level + Order_Quantity) AS Inventory_After_Order
FROM supply_chain_inventory
WHERE Inventory_Level < Reorder_Point
	AND (Inventory_Level + Order_Quantity) < Reorder_Point;

/*
Query diatas mencari kondisi:
- Inventory masih di bawah Reorder Point
- Setelah ditambah Order Quantity, stok tetap belum mencapai Reorder Point.
*/


/* Investigation Result:
	- Seluruh produk memiliki harga jual lebih tinggi daripada harga beli sehingga 
      tidak ditemukan indikasi penjualan di bawah biaya (loss selling).
    
    - Tidak ditemukan stok negatif dan tidak ada stok nol
    
    - Tidak ditemukan inventory berada di bawah forecast. 
	  Menunjukkan perusahaan menjaga inventory selalu berada diatas forecast. 
    
    - Lead time maksimum pada dataset adalah 14 hari dan dimiliki oleh 9 supplier. 
      Tidak ditemukan supplier yang secara signifikan memiliki lead time lebih tinggi dibanding supplier lainnya.
    
    - Ditemukan 4.787 data hasil Investigate Order Quantity > Reorder Point dengan adanya indikasi 
      semua transaksi ini Order_Quantity = 0.
      Dilakukan analisis lanjutan untuk memastikan Order Quantity kondisi inventory yang berada di bawah Reorder Point. 
*/

-- Investigate Order Quantity = 0 dengan kondisi inventory yang berada di bawah Reorder Point
SELECT
    COUNT(*) AS Total,
    SUM(Order_Quantity = 0) AS Order_Zero,
    SUM(Order_Quantity > 0) AS Order_Positive
FROM supply_chain_inventory
WHERE Inventory_Level < Reorder_Point;

-- Identifikasi Gap antara Inventory dan Reorder Point
SELECT
    MIN(Reorder_Point - Inventory_Level) AS Min_Gap,
    MAX(Reorder_Point - Inventory_Level) AS Max_Gap,
    AVG(Reorder_Point - Inventory_Level) AS Avg_Gap
FROM supply_chain_inventory
WHERE Inventory_Level < Reorder_Point
AND Order_Quantity = 0;


/* Investigation Result
	- Sebanyak 4.787 observasi menunjukkan Inventory Level berada di bawah Reorder Point tanpa adanya Order Quantity.
	
    - Seluruh observasi tersebut memiliki Order Quantity sebesar 0, 
      dengan rata-rata selisih Inventory terhadap Reorder Point hanya sebesar 12.30 unit 
      (minimum 1 unit dan maksimum 49 unit)
*/