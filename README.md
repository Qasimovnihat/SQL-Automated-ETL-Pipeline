

https://github.com/user-attachments/assets/002a152c-6fe9-417b-a200-e85c798969da





Avtomatlaşdırılmış E-ticarət Məlumatlarının Təmizlənməsi və ETL (Pipeline)
Layihənin İcmalı
Bu layihə 500.000-dən çox sətirdən ibarət irimiqyaslı e-ticarət məlumat dəstinin təmizlənməsi prosesini tamamilə avtomatlaşdırır. Məqsəd, məlumatların mexaniki (manual) hazırlanması prosesini aradan qaldırmaq, məlumat tipi xətalarını (məsələn, #N/A mətnləri) həll etmək və hər gün yenilənən, analiz üçün hazır təmiz məlumat dəsti təmin etməkdir.

İstifadə Olunan Alətlər və Texnologiyalar
Verilənlər Bazası: SQL Server

Avtomatlaşdırma: SQL Server Agent

Dil: T-SQL (Saxlanılan Prosedurlar - Stored Procedures, CTE-lər)

Gələcək İnteqrasiya: Power BI / Tableau vizuallaşdırması üçün hazır vəziyyətdədir.

Problem
Xam e-ticarət məlumatları ilə işləyərkən bir neçə çətinlik ortaya çıxdı:

item_id və Customer_ID sütunlarında #N/A tipli mətn dəyərlərinin olması məlumat tiplərinin çevrilməsi zamanı xətalara səbəb olurdu.

Kritik kateqoriyal və maliyyə sütunlarında boş (NULL) dəyərlərin olması.

Satış göstəricilərini (metrikalarını) təhrif edən təkrarlanan (dublikat) qeydlər.

Həll Yolu (Mənim Yanaşmam)
Mən "Tam Yeniləmə" (Full Refresh) ETL məntiqi ilə işləyən möhkəm bir Saxlanılan Prosedur (sp_DailySalesCleaning) hazırladım:

Xətaların İdarə Edilməsi: Problemli mətn sütunlarını prosesi dayandırmadan təhlükəsiz şəkildə INT tipinə çevirmək üçün TRY_CAST funksiyasından istifadə etdim.

Məlumatların Tamamlanması (Imputation): Kateqoriyalar, qiymətlər və miqdar sütunlarındakı NULL dəyərləri ISNULL() funksiyası ilə tənzimlədim.

Təkrarların Təmizlənməsi: Dublikat sətirləri müəyyən etmək və silmək üçün ROW_NUMBER() funksiyası ilə Ümumi Cədvəl İfadələri (CTE) tətbiq etdim.

Avtomatlaşdırma
Məlumatların həmişə aktual qalmasını təmin etmək üçün hər gecə saat 02:00-da avtomatik işləyən bir SQL Server Agent Job quraşdırdım. Bu tapşırıq köhnə təmizlənmiş cədvəli silir və ən son xam məlumatlar əsasında yenisini yaradır.
