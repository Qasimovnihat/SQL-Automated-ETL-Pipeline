

https://github.com/user-attachments/assets/002a152c-6fe9-417b-a200-e85c798969da



# 🚀 Avtomatlaşdırılmış E-ticarət ETL (Data Cleaning)

![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-red?style=flat-square&logo=microsoft-sql-server)
![T-SQL](https://img.shields.io/badge/Language-T--SQL-blue?style=flat-square)
![Automation](https://img.shields.io/badge/Automation-SQL%20Server%20Agent-green?style=flat-square)

## 📌 Layihənin İcmalı
Bu layihə **500,000+ sətirdən** ibarət böyük həcmli e-ticarət məlumatlarının təmizlənməsi və analize hazırlanması prosesini tamamilə avtomatlaşdırır. Layihənin əsas məqsədi məlumat hazırlığı zamanı yaranan mexaniki işləri sıfıra endirmək və hər gün yenilənən təmiz data bazası yaratmaqdır.

---

## 🛠 Texnologiya Steki
* **Database:** SQL Server
* **Automation:** SQL Server Agent (Job Scheduling)
* **Language:** T-SQL (Stored Procedures, CTEs, Window Functions)
* **Data Quality:** TRY_CAST, ISNULL, Row-level Deduplication

---

## 📉 Problem və Çətinliklər
Xam məlumatlarla işləyərkən qarşıya çıxan əsas texniki maneələr:
* **Məlumat Tipi Xətaları:** `item_id` və `Customer_ID` sütunlarında rast gəlinən `#N/A` mətnləri sistemin çökməsinə səbəb olurdu.
* **Boş Dəyərlər:** Kritik maliyyə və kateqoriya sütunlarında `NULL` dəyərlərin olması analitikanı çətinləşdirirdi.
* **Dublikatlar:** Təkrarlanan sətirlər ümumi satış göstəricilərini yanlış (şişirdilmiş) göstərirdi.

---

## 💡 Həll Yolu: ETL Memarlığı
Layihədə **"Full Refresh"** məntiqi ilə çalışan `sp_DailySalesCleaning` adlı Saxlanılan Prosedur (Stored Procedure) tətbiq olunub:

1.  **Məlumatın Təmizlənməsi (Data Cleaning):**
    * `TRY_CAST` istifadə edilərək xətalı mətnlər (məs: #N/A) təhlükəsiz şəkildə integer tipinə çevrildi.
    * `ISNULL()` vasitəsilə boş xanalar biznes məntiqinə uyğun dolduruldu.
2.  **Deduplikasiya (Deduplication):**
    * `ROW_NUMBER()` və **CTE** istifadə edərək unikal olmayan bütün sətirlər avtomatik silindi.
3.  **Yeniləmə:**
    * Hər icra zamanı köhnə cədvəl `DROP` edilir və ən son xam məlumatlar əsasında "Production-Ready" cədvəl yaradılır.

---

## ⚙️ Avtomatlaşdırma (Automation)
Sistemin insan müdaxiləsi olmadan çalışması üçün:
* **SQL Server Agent Job** yaradılıb.
* Hər gecə saat **02:00-da** avtomatik işə düşür.
* Məlumatlar hər səhər vizuallaşdırma (Power BI/Tableau) üçün tam hazır olur.

---

## 📂 Layihənin Strukturu
```sql
-- Nümunə: Təmizləmə Prosedurunun strukturu
CREATE PROCEDURE sp_DailySalesCleaning
AS
BEGIN
    -- 1. Köhnə datanı təmizlə
    -- 2. CTE ilə dublikatları tap
    -- 3. TRY_CAST ilə tipləri düzəlt
    -- 4. Yeni cədvələ INSERT et
END




