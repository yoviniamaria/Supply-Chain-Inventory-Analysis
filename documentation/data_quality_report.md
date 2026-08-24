# Data Quality & Cleaning Report

## Project Information
| Item | Description |
|------|-------------|
| **Project** |	Supply Chain & Inventory Analysis |
| **Dataset**	| High-Dimensional Supply Chain Inventory Dataset |
| **Source** | Kaggle |
| **Period** | January 2024 – December 2024 |
| **Total** | Records	91,250 rows |
| **Total** | Columns	15 columns |
| **Database** | MySQL |

## 1. Data Quality Summary
Sebelum melakukan analisis, dilakukan proses data quality check untuk memastikan data telah berhasil di-import, memiliki struktur yang sesuai, serta tidak memiliki permasalahan kualitas data yang dapat memengaruhi hasil analisis.

### Validation Results
| Validation	| Result |	Conclusion |
|-------------|--------|-------------|
| Dataset Import | 91,250 rows berhasil di-import	| Pass |
| Data Type Validation | Tipe data sesuai dengan struktur tabel yang telah ditentukan	| Pass |
| Missing Values	| Tidak ditemukan |	Pass |
| Empty Strings	| Tidak ditemukan	| Pass |
| Duplicate Data | Tidak ditemukan | Pass |
| Negative Inventory | Tidak ditemukan | Pass |
| Negative Sales | Tidak ditemukan | Pass |
| Unit Price < Unit Cost | Tidak ditemukan | Pass |
| Demand Forecast > Inventory	| Tidak ditemukan |	Pass |
| Lead Time Anomaly	| Tidak ditemukan indikasi anomali signifikan	| Pass |
| Inventory < Reorder Point & Order Quantity = 0 | 4,787 observasi ditemukan | Business Observation |
| Promotion dengan penjualan rendah | Ditemukan pada sebagian observasi	| Business Observation |
| Stockout Flag = 1 |	Tidak ditemukan	| Dataset Characteristic |

### Summary
Secara umum, dataset memiliki kualitas data yang baik dan tidak ditemukan permasalahan utama seperti missing values, empty strings, duplicate records, negative inventory, maupun negative sales.

Beberapa kondisi yang memerlukan investigasi lebih lanjut tidak langsung dikategorikan sebagai kesalahan data. Kondisi tersebut diperlakukan sebagai **business observation** atau **dataset characteristic** setelah dilakukan validasi tambahan.


## 2. Standard Data Validation
Bagian berikut menjelaskan proses validasi dasar yang dilakukan untuk memastikan dataset memiliki struktur dan nilai data yang sesuai sebelum digunakan dalam proses analisis.
- Missing Values
- Empty Strings
- Duplicate Data
- Negative Inventory
- Negative Sales
- Unit Price vs Unit Cost
- Demand Forecast vs Inventory Level

### 2.1 Dataset Import and Structure Validation
Dataset berhasil di-import ke dalam MySQL menggunakan `LOAD DATA LOCAL INFILE`.

Hasil validasi menunjukkan:
- Total records: **91,250**
- Total columns: **15**
- Struktur tabel telah disesuaikan dengan karakteristik masing-masing kolom sebelum proses import.
- Tidak diperlukan konversi tambahan pada kolom tanggal setelah proses import karena tipe data `DATE` telah sesuai dengan struktur tabel yang ditentukan.
Hasil tersebut menunjukkan bahwa dataset berhasil di-import dan memiliki struktur yang sesuai untuk proses analisis.

### 2.2 Missing Values and Empty Strings
Dilakukan pemeriksaan terhadap missing values dan empty strings pada seluruh kolom utama dalam dataset.

Hasil pemeriksaan menunjukkan bahwa:
- Tidak ditemukan missing values.
- Tidak ditemukan empty strings.
  
Dengan demikian, tidak diperlukan proses penghapusan atau imputasi data untuk menangani nilai yang hilang.

### 2.3 Duplicate Records
Pemeriksaan duplicate records dilakukan dengan membandingkan total jumlah baris dengan jumlah kombinasi data unik.

Hasil pemeriksaan:
- Total rows: **91,250**
- Unique rows: **91,250**
- Duplicate records: **0**
Dengan demikian, tidak ditemukan duplicate data pada dataset.


## 3. Detailed Data Validation
Bagian ini berisi investigasi tambahan terhadap beberapa kondisi data untuk memastikan bahwa nilai-nilai yang digunakan dalam analisis tidak menunjukkan indikasi masalah kualitas data atau anomali yang memerlukan penanganan lebih lanjut.

### 3.1 Negative Inventory & Negative Sales
Dilakukan pemeriksaan terhadap nilai `Inventory_Level` dan `Units_Sold` untuk mengidentifikasi kemungkinan adanya nilai negatif atau nilai nol.

Hasil pemeriksaan menunjukkan bahwa:
- Tidak ditemukan nilai `Inventory_Level` negatif.
- Tidak ditemukan nilai `Inventory_Level` sebesar 0.
- Tidak ditemukan nilai `Units_Sold` negatif.
Dengan demikian, tidak ditemukan indikasi permasalahan terkait negative inventory maupun negative sales pada dataset.

### 3.2 Unit Price vs Unit Cost
Dilakukan pemeriksaan untuk mengidentifikasi apakah terdapat produk dengan `Unit_Price` yang lebih rendah daripada `Unit_Cost`.

Hasil pemeriksaan menunjukkan bahwa seluruh observasi memiliki `Unit_Price` yang lebih tinggi daripada `Unit_Cost`.

Dengan demikian, tidak ditemukan indikasi penjualan produk di bawah biaya *(loss selling)* berdasarkan data yang tersedia.

### 3.3 Demand Forecast vs Inventory Level
Dilakukan pemeriksaan untuk mengidentifikasi observasi dengan `Demand_Forecast` yang melebihi `Inventory_Level`.

Hasil pemeriksaan menunjukkan bahwa tidak ditemukan observasi dengan `Demand_Forecast` yang lebih tinggi daripada `Inventory_Level`.

Hal ini menunjukkan bahwa, berdasarkan data yang tersedia, `Inventory_Level` secara konsisten berada di atas `Demand_Forecast`.

### 3.4 Supplier Lead Time Investigation
Dilakukan investigasi terhadap `Supplier_Lead_Time_Days` untuk mengidentifikasi kemungkinan adanya supplier dengan lead time yang jauh lebih tinggi dibandingkan supplier lainnya.

Hasil investigasi menunjukkan bahwa:
- Lead time maksimum adalah **14 hari**.
- Nilai lead time maksimum tersebut dimiliki oleh **9 supplier**.
Berdasarkan investigasi awal, tidak ditemukan indikasi anomali lead time yang signifikan atau satu supplier tertentu yang memiliki lead time jauh lebih tinggi dibandingkan supplier lainnya.

### 3.5 Inventory Below Reorder Point with No Order Quantity
Sebanyak **4,787 observasi** menunjukkan kondisi `Inventory_Level` berada di bawah `Reorder_Point` dengan `Order_Quantity = 0`.

Kondisi ini memerlukan investigasi lebih lanjut untuk memahami apakah observasi tersebut menunjukkan potensi masalah dalam proses replenishment atau merupakan karakteristik dari dataset.

Analisis lanjutan terhadap kondisi ini dibahas pada bagian **Business Observation Investigation.**


## 4. Business Observation Investigation
Bagian ini berisi investigasi lebih detail terhadap beberapa kondisi data untuk memastikan bahwa nilai-nilai yang digunakan dalam analisis tidak menunjukkan indikasi masalah pada kualitas data.

### 4.1 Inventory Below Reorder Point with Order Quantity = 0
Sebanyak **4,787 observasi** menunjukkan kondisi `Inventory_Level` berada di bawah `Reorder_Point` dengan `Order_Quantity = 0`.

Hasil investigasi lanjutan menunjukkan:
| Metric | Result |
|--------|--------|
| Total Observations | 4,787 |
| Order Quantity = 0	| 4,787 |
| Minimum Gap |	1 unit |
| Maximum Gap |	49 units |
| Average Gap	| 12.30 units |

Seluruh observasi tersebut memiliki `Order_Quantity` sebesar 0. Selain itu, selisih antara `Inventory_Level` dan `Reorder_Point` relatif kecil, dengan rata-rata selisih sebesar **12.30 unit**, minimum **1 unit**, dan maksimum **49 unit**.

Berdasarkan hasil investigasi tersebut, kondisi `Inventory_Level < Reorder_Point` dengan `Order_Quantity = 0` tidak dapat langsung dikategorikan sebagai data error atau keterlambatan proses replenishment. Kondisi ini lebih tepat diperlakukan sebagai **business observation** yang kemungkinan berkaitan dengan kebijakan replenishment atau karakteristik dataset.

Oleh karena itu, observasi tersebut tetap dipertahankan dalam dataset dan tidak dilakukan penghapusan data selama proses cleaning.

### 4.2 Stockout Flag Investigation
Dilakukan pemeriksaan terhadap kolom `Stockout_Flag` untuk mengidentifikasi observasi yang menunjukkan kondisi kehabisan stok selama periode analisis.

Hasil pemeriksaan menunjukkan bahwa tidak ditemukan observasi dengan `Stockout_Flag = 1` selama periode observasi.

Oleh karena itu, analisis terkait frekuensi, pola, maupun dampak stockout tidak dapat dilakukan berdasarkan dataset yang tersedia.

Kondisi ini tidak dikategorikan sebagai data error, melainkan sebagai **dataset characteristic**, karena seluruh observasi dalam dataset menunjukkan tidak adanya kondisi stockout selama periode analisis.

### 4.3 Promotion Flag Investigation
Dilakukan investigasi terhadap `Promotion_Flag` untuk melihat perbedaan rata-rata `Units_Sold` dan `Demand_Forecast` antara produk yang mengikuti program promosi dan produk tanpa promosi.
| Promotion Flag | Avg Units Sold	| Avg Demand Forecast |
|----------------|----------------|---------------------|
| 0 | 19.51 |	19.53 |
| 1	| 24.91	| 24.93|

Hasil investigasi menunjukkan bahwa terdapat beberapa observasi dengan `Promotion_Flag = 1` yang memiliki tingkat penjualan rendah. Namun, jika dilihat secara agregat, rata-rata `Units_Sold` pada kondisi promosi lebih tinggi dibandingkan kondisi tanpa promosi.

Produk yang mengikuti promosi memiliki rata-rata penjualan sebesar **24.91 unit**, sedangkan produk tanpa promosi memiliki rata-rata penjualan sebesar **19.51 unit**.

Hal yang sama juga terlihat pada `Demand_Forecast`, di mana rata-rata forecast pada kondisi promosi sebesar **24.93**, lebih tinggi dibandingkan kondisi tanpa promosi sebesar **19.53**.

Berdasarkan hasil investigasi tersebut, beberapa observasi promosi dengan penjualan rendah tidak dikategorikan sebagai masalah kualitas data. Kondisi ini lebih tepat dikategorikan sebagai **business observation** dan dapat menjadi area untuk analisis lebih lanjut terkait efektivitas promosi terhadap permintaan dan penjualan produk.


## 5. Data Cleaning Process
Setelah proses data quality check dan investigasi terhadap beberapa kondisi data, dilakukan proses data cleaning dan validasi awal untuk memastikan kualitas, konsistensi, dan kesiapan dataset sebelum digunakan dalam proses analisis.

### 5.1 Text Standardization
Kolom yang digunakan sebagai identifier dan kategori distandardisasi menggunakan fungsi `TRIM()` untuk menghapus spasi yang tidak diperlukan.

Kolom yang dilakukan standardisasi meliputi:
- `SKU_ID`
- `Warehouse_ID`
- `Supplier_ID`
- `Region`

Standardisasi dilakukan untuk menghindari potensi perbedaan nilai yang disebabkan oleh adanya spasi tambahan pada data.

### 5.2 Data Retention
Tidak ditemukan missing values, empty strings, duplicate records, maupun nilai negatif yang memerlukan penghapusan atau perbaikan data.

Beberapa kondisi yang memerlukan investigasi lebih lanjut, seperti `Inventory_Level < Reorder_Point` dengan `Order_Quantity = 0`, tidak dikategorikan sebagai data error. Oleh karena itu, observasi tersebut tetap dipertahankan dalam dataset.

Setelah proses cleaning, jumlah data tetap sebanyak:
| Metric |	Result |
|--------|---------|
| Total Rows | 91,250 |
| Total Columns |	15 |

Hal ini menunjukkan bahwa proses cleaning berfokus pada standardisasi dan validasi data tanpa menghapus observasi dari dataset.

### 5.3 Clean Dataset
Dataset hasil cleaning digunakan sebagai dasar untuk seluruh proses analisis selanjutnya, meliputi:
- Inventory Analysis
- Product Inventory Analysis
- Inventory Health Analysis
- Product Analysis
- Region Analysis
- Warehouse Analysis
- Supplier Analysis
Dataset yang telah melalui proses cleaning dan validasi kemudian digunakan sebagai sumber data utama untuk proses analisis dan visualisasi pada dashboard Power BI.


## 6. Final Conclusion
Secara keseluruhan, dataset memiliki kualitas yang baik dan siap digunakan untuk proses analisis.

Proses data cleaning yang dilakukan berfokus pada standardisasi dan validasi data tanpa menghapus observasi dari dataset. Setelah proses cleaning, dataset tetap memiliki **91,250 rows** dan **15 columns**.

Tidak ditemukan permasalahan utama seperti missing values, empty strings, duplicate records, negative inventory, maupun negative sales yang memerlukan penghapusan atau perbaikan data.

Beberapa kondisi memerlukan investigasi lebih lanjut, terutama `Inventory_Level < Reorder_Point` **dengan** `Order_Quantity = 0`. Sebanyak **4,787 observasi** ditemukan dalam kondisi tersebut. Namun, berdasarkan hasil investigasi, kondisi tersebut tidak dapat langsung dikategorikan sebagai data error dan lebih tepat diperlakukan sebagai **business observation**.

Selain itu, tidak ditemukannya observasi dengan `Stockout_Flag = 1` dikategorikan sebagai **dataset characteristic**, sehingga analisis terkait stockout tidak dapat dilakukan menggunakan dataset ini.

Berdasarkan hasil data quality check, detailed data validation, dan business observation investigation, dataset dinilai **valid, konsisten, dan siap digunakan sebagai dasar untuk proses analisis inventory dan supply chain selanjutnya.**
