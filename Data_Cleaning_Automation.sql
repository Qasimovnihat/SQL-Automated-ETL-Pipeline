
USE [PortfolioDB];
GO
DROP PROCEDURE IF EXISTS sp_Automated_Cleaning;
DROP TABLE IF EXISTS Cleaned_Sales_Data;


USE [PortfolioDB];
GO

CREATE PROCEDURE sp_Automated_Cleaning
AS
BEGIN
    
    IF OBJECT_ID('Cleaned_Sales_Data', 'U') IS NOT NULL 
        DROP TABLE Cleaned_Sales_Data;

    
    SELECT 
        TRY_CAST(item_id AS INT) AS ItemID, 
        ISNULL(status, 'Unknown') AS OrderStatus,
        TRY_CAST(created_at AS DATE) AS OrderDate,
        sku AS ProductSKU,
        CAST(ISNULL(price, 0) AS DECIMAL(18,2)) AS Price,
        CAST(ISNULL(qty_ordered, 1) AS INT) AS Quantity,
        CAST(ISNULL(grand_total, 0) AS DECIMAL(18,2)) AS TotalAmount,
        ISNULL(category_name_1, 'Others') AS Category,
        ISNULL(payment_method, 'Not Specified') AS PaymentMethod,
        TRY_CAST(Customer_ID AS INT) AS CustomerID 
    INTO Cleaned_Sales_Data
    FROM [Pakistan Largest Ecommerce Dataset] 
    WHERE TRY_CAST(item_id AS INT) IS NOT NULL; 

    
    WITH CTE AS (
        SELECT ItemID, ROW_NUMBER() OVER (PARTITION BY ItemID ORDER BY ItemID) as rn
        FROM Cleaned_Sales_Data
    )
    DELETE FROM CTE WHERE rn > 1;
END;


EXEC sp_Automated_Cleaning;

SELECT * FROM Cleaned_Sales_Data