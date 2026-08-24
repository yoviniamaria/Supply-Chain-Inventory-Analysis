# Supply-Chain-Inventory-Analysis
End-to-end supply chain and inventory analysis using SQL and Power BI to evaluate inventory performance, product contribution, and supplier replenishment efficiency.

## Project Overview
Proyek ini bertujuan menganalisis performa inventory dan supply chain menggunakan **High-Dimensional Supply Chain Inventory Dataset (Kaggle)**.

Analisis dilakukan dari tiga prespektif bisnis utama yaitu:
-	**Inventory Overview**
-	**Product Inventory Analysis**
-	**Supply Chain & Replenisment Analysis**

Proyek ini menggunakan SQL untuk data cleaning dan analisis data, serta PowerBI untuk membangun dashboard interaktif. Analisis dilakukan untuk mengidentifikasi faktor-faktor yang mempengaruhi performa inventory dan supply chain dan menghasikan rekomendasi bisnis berbasis data.

## Business Problem
Perusahaan perlu menjaga keseimbangan antara ketersediaan stok dan biaya inventory agar dapat mengambil keputusan bisnis yang lebih efektif. 
Inventory yang terlalu tinggi dapat meningkatkan biaya penyimpanan dan operasional, sedangkan stok yang terlalu rendah dapat menyebabkan kehilangan peluang penjualan *(stockout)*. Oleh karena itu, perusahaan perlu melakukan analisis inventory untuk mengidentifikasi produk prioritas, mengevaluasi efisiensi pengelolaan stok, serta mendukung proses replenishment. 
Hasil analisis diharapkan dapat memberikan insight dan rekomendasi berbasis data guna mendukung strategi pengelolaan inventory perusahaan.

## Business Objective
Menganalisis performa inventory dan supply chain melalui analisis pergerakan stok, kontribusi produk, klasifikasi inventory, serta evaluasi persediaan untuk mengidentifikasi faktor-faktor yang memengaruhi keseimbangan antara ketersediaan stok dan biaya inventory. Hasil analisis diharapkan dapat memberikan rekomendasi bisnis berbasis data guna meningkatkan efektivitas pengelolaan inventory perusahaan.

## Dataset
**Source:**  
[High-Dimensional Supply Chain Inventory Dataset (Kaggle)](https://www.kaggle.com/datasets/ziya07/high-dimensional-supply-chain-inventory-dataset/data)

**Period:**  
January 2024 – December 2024

**Records:**  
91.250 rows

**Columns Used:**  
Dataset ini memiliki 15 kolom utama, yaitu
| Column | Business Interpretation |
|--------|-------------------------|
| Date | Tanggal pencatatan data inventory yang digunakan sebagai acuan analisis trend dan aktivitas inventory. |
| SKU_ID	| Kode unik setiap produk (Stock Keeping Unit) yang digunakan untuk mengidentifikasi dan membedakan setiap produk dalam inventory. |
| Warehouse_ID |	Kode unik yang diberikan untuk setiap gudang penyimpanan inventory. |
| Supplier_ID	| Kode unik yang diberikan untuk membedakan setiap supplier |
| Region | Wilayah operasional tempat warehouse atau aktivitas supply chain berlangsung |
| Units_Sold | Jumlah unit yang terjual pada saat pencatatan |
| Inventory_Level |	Jumlah stok yang tersedia pada saat pencataan |
| Supplier_Lead_Time_Days |	Estimasi jumlah hari yang dibutuhkan supplier untuk memenuhi pesanan sejak dilakukan pemesanan hingga barang diterima. |
| Reorder_Point	| Batas minimum stock yang harus tersedia sebelum dilakukan pemesanan ulang. |
| Order_Quantity | Jumlah unit yang dipesan ke supplier |
| Unit_Cost	Harga | beli per unit saat di beli ke supplier |
| Unit_Price | Harga yang dijual per unit |
| Promotion_Flag | Indikator yang menunjukkan apakah produk sedang mengikuti program promosi pada periode tersebut. |
| Stockout_Flag | Indikator apakah produk mengalami kehabisan stok pada periode tersebut |
| Demand_Forecast | Estimasi jumlah permintaan produk pada periode tertentu yang digunakan sebagai dasar dalam perencanaan inventory dan pengambilan keputusan replenishment pada periode berikutnya. |

Dataset asli tidak disertakan dalam repository ini karena batasan ukuran file.
Silakan mengunduh dataset melalui tautan resmi High-Dimensional Supply Chain Inventory Dataset (Kaggle) di atas.

## Tools Used
-	SQL (MySQL) digunakan untuk data cleaning, data validation, dan exploratory analysis,
-	Power BI digunakan untuk membangun dashboard interaktif.
-	GitHub digunakan untuk memaparkan seluruh proses analisis sampai dengan recommendation

## Data Quality and Cleaning
Sebelum melakukan analisis, dilakukan proses **Data Quality Check** dan **Data Cleaning** untuk memastikan konsistensi dan keandalan data.

Proses validasi mencakup:
-	Missing Values 
-	Empty Strings 
-	Duplicate Records 
-	Negative Values 
-	Unit Price vs Unit Cost 
-	Demand Forecast vs Inventory Level 
-	Supplier Lead Time 
-	Inventory Level vs Reorder Point 
-	Promotion dan Stockout Indicators 

Tidak ditemukan **missing values, empty strings, duplicate records**, maupun **negative values** yang memerlukan penghapusan data.

Beberapa **business observations** kemudian dilakukan investigasi lebih lanjut, termasuk **4.787 observasi** dengan kondisi *Inventory Level* berada di bawah *Reorder Point* dan *Order Quantity* = 0. Observasi tersebut tetap dipertahankan karena dikategorikan sebagai **business observations**, bukan **data errors**.

Proses **Data Cleaning** difokuskan pada standarisasi identifier menggunakan `TRIM()` tanpa menghapus observasi yang valid.

Untuk melihat proses validasi dan hasil investigasi secara lebih detail, lihat 
[Data Quality & Cleaning Report](https://github.com/yoviniamaria/Supply-Chain-Inventory-Analysis/blob/main/documentation/data_quality_report.md)


## Key Analysis Areas
### Inventory Analytics
Analisis inventory dilakukan untuk memahami pola persediaan dan aktivitas penjualan selama periode **Januari–Desember 2024**.

***Key Insights***
- **Average Inventory secara konsisten berada di atas Average Reorder Point**. Average Inventory berada pada kisaran **454–527 unit**, sedangkan Average Reorder Point relatif stabil di sekitar **300 unit**. Hal ini menunjukkan bahwa secara agregat, inventory masih berada di atas batas Reorder Point. 
- **Total Units Sold tertinggi terjadi pada Maret 2024**, yaitu sebesar **231,596 unit**, kemudian menurun hingga mencapai titik terendah pada **September 2024** sebesar **76,304 unit**. 
- Meskipun terjadi penurunan aktivitas penjualan setelah Maret, **Average Inventory tidak menunjukkan pola penurunan yang serupa** dan tetap berada pada kisaran sekitar **454–477 unit** selama sebagian besar periode setelah Maret. 

Secara keseluruhan, **inventory cenderung tetap dipertahankan meskipun aktivitas penjualan mengalami penurunan**. Kondisi ini dapat menjadi area untuk mengevaluasi keseimbangan antara ketersediaan stok dan potensi kelebihan inventory.

### Product Inventory Analysis
Analisis dilakukan untuk mengevaluasi kondisi inventory setiap produk berdasarkan **Average Inventory, Total Units Sold, Demand Forecast,** dan **Inventory Coverage**. Analisis ini bertujuan untuk mengidentifikasi produk dengan tingkat persediaan tinggi serta melihat keterkaitannya dengan tingkat demand.

***Key Insights***
- **SKU_41 memiliki Average Inventory tertinggi**, yaitu sebesar **523.97 unit**. Perbedaan Average Inventory antara produk dengan nilai tertinggi dan terendah secara keseluruhan mencapai sekitar **115.45 unit**. 
- **Total Units Sold dan Average Demand Forecast antar produk relatif serupa**. SKU_41 memiliki Average Demand Forecast sebesar **20.06 unit**, yang tidak menunjukkan perbedaan besar dibandingkan produk lainnya. 
- Tingginya **Average Inventory pada SKU_41 tidak diikuti oleh Demand Forecast yang lebih tinggi**. Hal ini menunjukkan bahwa tingkat persediaan antar produk tidak sepenuhnya sejalan dengan tingkat forecast demand. 
- **SKU_41 juga memiliki Inventory Coverage tertinggi sebesar 26.12**, menunjukkan bahwa persediaannya relatif tinggi dibandingkan estimasi demand. 

Secara keseluruhan, **SKU_41 memiliki tingkat inventory dan Inventory Coverage tertinggi, sementara Demand Forecast relatif serupa dengan produk lainnya**. Kondisi ini dapat menjadi area perhatian untuk mengevaluasi apakah tingkat persediaan SKU tersebut sudah sesuai dengan kebutuhan demand.

### Inventory Health Analysis
Analisis dilakukan untuk mengevaluasi kondisi inventory secara keseluruhan dan mengidentifikasi potensi **understock** maupun **high inventory** melalui klasifikasi berdasarkan `Inventory_Level`, `Reorder_Point`, dan `Demand_Forecast`.

Kondisi inventory diklasifikasikan ke dalam empat kategori:
- **High Inventory**
- **Healthy Inventory**
- **Near Reorder**
- **Below Reorder Point**

***Key Insights***
- **42% observasi berada dalam kategori High Inventory**, menjadikannya kategori dengan proporsi terbesar.
- **38% observasi berada dalam kategori Healthy Inventory**, sedangkan sekitar **14% Near Reorder** dan **5% Below Reorder Point**.
- Kondisi **Below Reorder Point** perlu tetap dipantau karena menunjukkan inventory telah berada di bawah batas yang digunakan sebagai acuan replenishment.
- Secara keseluruhan, proporsi **High Inventory** lebih besar dibandingkan **Healthy Inventory**. Berdasarkan rule-based classification yang digunakan, hal ini menunjukkan bahwa sebagian besar observasi memiliki tingkat inventory yang relatif tinggi. 

Temuan ini dapat menjadi area perhatian untuk mengevaluasi keseimbangan antara ketersediaan stok dan potensi **inventory berlebih**, terutama pada produk atau periode dengan konsentrasi **High Inventory** yang lebih tinggi.

*Kategori Inventory Health menggunakan rule-based classification yang dirancang untuk tujuan analisis dan visualisasi portfolio, bukan sebagai standar operasional universal.*

### Product Analysis
Analisis dilakukan untuk mengevaluasi kondisi inventory pada tingkat produk melalui **Inventory Value**, frekuensi SKU berada pada atau di bawah **Reorder Point**, serta **Average Inventory Gap.**

***Key Insights***    
**1. Inventory Value**  
**SKU_38 memiliki Inventory Value tertinggi sebesar 16,354,739.83**. Perbedaan nilai inventory antar SKU juga cukup besar, menunjukkan bahwa nilai persediaan tidak tersebar secara merata dan beberapa produk memiliki modal yang lebih besar terikat dalam inventory.

**2. At-or-Below Reorder Point Frequency**  
Frekuensi SKU berada pada atau di bawah **Reorder Point** relatif serupa, dengan rentang **94–107 observasi** dan selisih hanya **13 observasi**. Dengan total **50 SKU**, kondisi ini menunjukkan bahwa inventory yang mencapai Reorder Point cukup merata di seluruh produk.

**3. Average Inventory Gap**  
Sebagian besar SKU memiliki rata-rata gap sekitar **10–13 unit di bawah Reorder Point. SKU_48 (-13.17)** dan **SKU_38 (-13.09)** memiliki rata-rata kekurangan yang lebih besar, sedangkan **SKU_34 (-9.89)** memiliki gap yang relatif lebih kecil.

### Region Analysis
Analisis dilakukan untuk mengevaluasi kondisi inventory dan aktivitas penjualan pada setiap region berdasarkan rata-rata `Inventory_Level` dan total `Units_Sold`.

***Key Insights***
-	East memiliki rata-rata inventory tertinggi sebesar **473.05 unit** dan **total 459,961 Units Sold**. 
-	**West** memiliki rata-rata inventory terendah sebesar **470.09 unit** dan **total 453,215 Units Sold**. 
-	Selisih rata-rata inventory antara region tertinggi dan terendah hanya **2.96 unit**, menunjukkan bahwa tingkat persediaan antar-region relatif serupa. 
-	Distribusi `Units_Sold` juga relatif merata, dengan East memiliki penjualan tertinggi dan West terendah. 

Secara keseluruhan, **tidak terdapat perbedaan yang signifikan dalam rata-rata inventory maupun aktivitas penjualan antar-region**, sehingga distribusi inventory dan aktivitas penjualan dalam dataset dapat dikatakan relatif seimbang.

### Warehouse Analysis
Analisis dilakukan untuk mengevaluasi distribusi inventory dan aktivitas penjualan pada setiap warehouse berdasarkan rata-rata `Inventory_Level` dan total `Units_Sold`.

***Key Insights***
-	**WH_2** memiliki rata-rata inventory tertinggi sebesar **491.49 unit**, sedangkan **WH_3** memiliki rata-rata inventory terendah sebesar **455.56 unit**, dengan selisih **35.93 unit**. 
-	Total Units_Sold antarwarehouse relatif merata, berada pada kisaran **365,114–366,902 unit**. 
-	**WH_1** memiliki total *Units Sold* tertinggi sebesar **366,902 unit**, sedangkan **WH_5** memiliki total terendah sebesar **365,114 unit**. 
-	Perbedaan rata-rata inventory antarwarehouse tidak diikuti oleh perbedaan yang signifikan pada total *Units Sold*. 

Secara keseluruhan, aktivitas penjualan antarwarehouse relatif seimbang, meskipun terdapat perbedaan pada rata-rata `Inventory_Level`. Hal ini menunjukkan bahwa **warehouse dengan tingkat inventory lebih tinggi tidak selalu memiliki total penjualan yang lebih tinggi.**

### Supplier Analysis
Analisis dilakukan untuk mengevaluasi performa supplier dan kondisi inventory berdasarkan `Supplier Lead Time`, `Order Quantity`, `Inventory Level`, dan `Reorder Point`. Analisis ini bertujuan untuk mengidentifikasi perbedaan performa replenishment antar supplier serta mengevaluasi kondisi inventory yang terkait dengan masing-masing supplier.

***Key Insights***  
**1. Average Lead Time by Supplier**  
- Perbedaan rata-rata Lead Time antar supplier relatif kecil. `SUP_4` memiliki rata-rata Lead Time tertinggi sebesar **8.64 hari**, sedangkan `SUP_5` memiliki rata-rata Lead Time terendah sebesar **6.96 hari**.
- Selisih antara supplier dengan Lead Time tertinggi dan terendah hanya sekitar **1.68 hari**, menunjukkan bahwa Lead Time antar supplier dalam dataset relatif serupa.

**2. Total Order Quantity by Supplier**  
- `SUP_7` memiliki Total Order Quantity tertinggi sebesar **239,283 unit**, sedangkan `SUP_9` memiliki Total Order Quantity terendah sebesar **112,062 unit**.
- Meskipun terdapat perbedaan Total Order Quantity antar supplier, rata-rata Order Quantity per observasi relatif serupa, yaitu sekitar **19 unit**. Hal ini menunjukkan bahwa perbedaan Total Order Quantity kemungkinan lebih dipengaruhi oleh jumlah atau frekuensi observasi dibandingkan ukuran pesanan rata-rata.

**3. Supplier Lead Time vs Order Quantity**
- Perbandingan antara Supplier Lead Time dan Total Order Quantity tidak menunjukkan pola hubungan yang konsisten.
- `SUP_7`, yang memiliki Total Order Quantity tertinggi, memiliki rata-rata Lead Time sebesar **7.56 hari**, masih di bawah rata-rata keseluruhan sekitar **8 hari**.  
Sementara itu, `SUP_4` memiliki rata-rata Lead Time tertinggi sebesar **8.64 hari**, tetapi bukan supplier dengan Total Order Quantity tertinggi.
- Berdasarkan pola tersebut, supplier dengan volume pesanan yang lebih tinggi **tidak selalu memiliki Lead Time yang lebih lama**.

**4. Average Inventory vs Average Reorder Point by Supplier**
- Secara keseluruhan, rata-rata Inventory Level setiap supplier berada di atas rata-rata Reorder Point.
- `SUP_7` memiliki rata-rata Inventory tertinggi sebesar **494.26 unit**, dengan rata-rata Reorder Point sebesar **322.35 unit**. Supplier lainnya juga menunjukkan pola yang sama, yaitu rata-rata Inventory berada di atas rata-rata Reorder Point.
- Hal ini menunjukkan bahwa secara agregat, kondisi Inventory yang terkait dengan setiap supplier berada di atas Reorder Point. Namun, nilai rata-rata tidak menggambarkan seluruh observasi, sehingga tetap terdapat kondisi tertentu di mana Inventory Level berada di bawah Reorder Point.

Secara keseluruhan, performa supplier dalam dataset menunjukkan pola yang relatif stabil. Lead Time antar supplier relatif serupa dan tidak terlihat pola bahwa supplier dengan Total Order Quantity lebih tinggi selalu memiliki Lead Time yang lebih lama.

Selain itu, rata-rata Inventory Level yang terkait dengan setiap supplier berada di atas rata-rata Reorder Point. Berdasarkan hasil analisis ini, **tidak terdapat supplier yang secara jelas menunjukkan perbedaan performa atau kondisi inventory yang jauh lebih buruk dibandingkan supplier lainnya.**

## Project Structure
```
Supply-Chain-Inventory-Analysis/
│
├── README.md
│
├── data/
│   └── README.md
│
├── sql/
│   ├── 01_Data_Quality_Check.sql
│   ├── 02_Data_Cleaning.sql
│   ├── 03_Inventory_Analytics.sql
│   ├── 04_Product_Inventory_Analytics.sql
│   ├── 05_Inventory_Health_Analysis.sql
│   ├── 06_Product_Analytics.sql
│   ├── 07_Region_Summary.sql
│   ├── 08_Warehouse_Summary.sql
│   ├── 09_Supplier_Summary.sql
│   └── views/
│	       ├── vw_inventory_summary.sql
│	       ├── vw_inventory_status.sql
│	       ├── vw_product_inventory.sql
│	       ├── vw_region_summary.sql
│	       ├── vw_warehouse_summary.sql
│     	 └── vw_warehouse_summary.sql
│
├── documentation/
│   ├── data_quality_report.md
│   └── analysis_notes.md
│
├── power_bi/
│   ├── Supply Chain Inventory.pbix
│   └── images/
│   	 ├── Inventory_Overview.png
│   	 ├── Product_Inventory_Analysis.png
│  	   ├── Supply_Chain_Replenishment.png
│  	   └── Executive_Summary.png
│
├── images/
│   └── dashboard_preview.png
│
└── LICENSE
```

## Dashboard Preview
### Inventory Overview
![Sales Dashboard](images/Inventory_Overview.png)
### Product Inventory Analysis
![Sales Dashboard](images/Product_Inventory_Analysis.png)
### Supply Chain Replenishment
![Sales Dashboard](images/Supply_Chain_Replenishment.png)

## Key Business Findings
### Inventory Health
**High Inventory** mencakup **42.25%** dari total observasi, menjadikannya kategori inventory dengan proporsi terbesar.

**Healthy Inventory** mencakup **38.38%** dari total observasi.

Tidak ditemukan observasi dengan `Stockout_Flag = 1` selama periode analisis. Namun, observasi dengan Inventory Level yang berada di bawah Reorder Point tetap perlu dipantau untuk mendukung proses replenishment yang tepat waktu.

### Product Inventory
**SKU_38** memiliki Inventory Value tertinggi sebesar **16.35M**, sehingga menjadi salah satu produk dengan nilai persediaan yang perlu mendapat perhatian lebih dalam pengelolaan inventory.

**SKU_20** dan **SKU_14** memiliki frekuensi tertinggi berada pada atau di bawah Reorder Point, masing-masing sebanyak **107 observasi**.

**SKU_11** memiliki rata-rata selisih Inventory Level terhadap Reorder Point tertinggi, yaitu sekitar **182 unit**, yang menunjukkan rata-rata inventory SKU tersebut berada cukup jauh di atas Reorder Point.

### Supplier Performance
Average Supplier Lead Time berada di sekitar **8 hari**, dengan rentang antara **6.96–8.64 hari**, sehingga perbedaan Lead Time antar supplier relatif kecil.

**SUP_7** memiliki Total Order Quantity tertinggi sebesar **239K unit**, dengan Average Lead Time sebesar **7.56 hari**.

Rata-rata Inventory Level yang terkait dengan setiap supplier berada di atas rata-rata Reorder Point. Namun, hasil agregasi ini tidak berarti seluruh observasi berada di atas Reorder Point, sehingga kondisi inventory pada tingkat observasi tetap perlu dipantau.

## Business Recommendations
1. Optimize High Inventory
Tinjau SKU dengan tingkat persediaan tinggi untuk mengidentifikasi potensi overstock dan mengevaluasi apakah tingkat inventory masih sesuai dengan kebutuhan permintaan. Penyesuaian replenishment dan alokasi inventory dapat dilakukan untuk mengurangi potensi persediaan berlebih.

3. Prioritize High-Value Inventory
Fokuskan pemantauan pada SKU dengan Inventory Value tinggi karena produk tersebut memiliki nilai modal yang lebih besar dalam persediaan. Evaluasi secara berkala dapat membantu mengidentifikasi potensi inventory yang tidak digunakan secara optimal dan mengurangi risiko modal yang terlalu banyak terikat dalam stok.

5. Strengthen Reorder Point Monitoring
Pantau SKU yang sering berada pada atau di bawah Reorder Point serta produk yang mendekati batas Reorder Point. Monitoring ini dapat membantu memastikan proses replenishment dilakukan pada waktu yang tepat dan mengurangi potensi risiko kekurangan persediaan.

7. Maintain Supplier Performance Monitoring
Lakukan pemantauan secara rutin terhadap Supplier Lead Time dan aktivitas pemesanan untuk memastikan proses replenishment tetap berjalan secara konsisten. Meskipun perbedaan Lead Time antar supplier dalam dataset relatif kecil, monitoring tetap diperlukan untuk mengidentifikasi perubahan performa supplier dari waktu ke waktu.


## Author
**Maria Yovinia**  
Information Systems Graduate  
[Google Data Analytics Professional Certificate](https://coursera.org/verify/professional-cert/X0A778W6LDOY)  
LinkedIn: [Maria Yovinia](www.linkedin.com/in/mariayovinia)  
GitHub: [yoviniamaria](https://github.com/yoviniamaria)
