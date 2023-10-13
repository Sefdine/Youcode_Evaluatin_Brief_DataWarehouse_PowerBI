use EvaluationBriefEcommerce



CREATE PARTITION FUNCTION InvoicesDatePartitionFunction (VARCHAR(50))
AS RANGE LEFT FOR VALUES ('2021-01-01', '2022-01-01', '2023-01-01');

ALTER DATABASE EvaluationBriefEcommerce ADD FILEGROUP [FG_sales_Archive]
GO
ALTER DATABASE EvaluationBriefEcommerce ADD FILEGROUP [FG_sales_2021]
GO
ALTER DATABASE EvaluationBriefEcommerce ADD FILEGROUP [FG_sales_2022]
GO
ALTER DATABASE EvaluationBriefEcommerce ADD FILEGROUP [FG_sales_2023]
GO

-----------------------------------

ALTER DATABASE EvaluationBriefEcommerce ADD FILE
(NAME = N'Invoices_Archive',
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Invoices_Archive.ndf', SIZE = 2048KB) TO FILEGROUP [FG_sales_Archive];

ALTER DATABASE EvaluationBriefEcommerce ADD FILE
(NAME = N'Invoices_2021',
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Invoices_2021.ndf', SIZE = 2048KB) TO FILEGROUP [FG_sales_2021];

ALTER DATABASE EvaluationBriefEcommerce ADD FILE
(NAME = N'Invoices_2022',
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Invoices_2022.ndf', SIZE = 2048KB) TO FILEGROUP [FG_sales_2022];

ALTER DATABASE EvaluationBriefEcommerce ADD FILE
(NAME = N'Invoices_2023',
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Invoices_2023.ndf', SIZE = 2048KB) TO FILEGROUP [FG_sales_2023];


CREATE PARTITION SCHEME InvoicesPartitionScheme
AS PARTITION InvoicesDatePartitionFunction
TO ([Primary], [FG_sales_2021], [FG_sales_2022], [FG_sales_2023]);

-----------------------------

CREATE VIEW FactInvoicesWithDateBase
AS
SELECT
    InvoiceID,
    fi.DateID,
    ProductID,
    CustomerID,
    ShipperID,
    QuantitySold,
    TotalAmount,
    DiscountAmount,
	NetAmount,
    dd.Date AS InvoiceDate
FROM
    FactInvoices fi
JOIN
    DimDates dd ON fi.DateID = dd.DateID;

DROP TABLE FactInvoicesPartitioned 

-- Create a new partitioned fact table
CREATE TABLE FactInvoicesPartitioned
(
    InvoiceID INT,
    DateID INT,
    ProductID INT,
    CustomerID INT,
    ShipperID INT,
    QuantitySold INT,
    TotalAmount DECIMAL(10, 2),
    DiscountAmount DECIMAL(10, 2),
	NetAmount DECIMAL(10, 2),
    InvoiceDate VARCHAR(50),
    PRIMARY KEY (InvoiceID, InvoiceDate)
)
ON InvoicesPartitionScheme (InvoiceDate);



INSERT INTO FactInvoicesPartitioned (InvoiceID, DateID, ProductID, CustomerID, ShipperID, QuantitySold, NetAmount, TotalAmount, DiscountAmount, InvoiceDate)
SELECT InvoiceID, DateID, ProductID, CustomerID, ShipperID, QuantitySold, NetAmount, TotalAmount, DiscountAmount, InvoiceDate
FROM FactInvoicesWithDateBase;


SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'FactInvoicestPartitioned'
order by partition_number;


----------------------------------------
-- Select data from the SalesFactPartitioned table
SELECT 
    InvoiceID,
    InvoiceDate,
    ProductID,
    CustomerID,
    QuantitySold,
    TotalAmount,
    DiscountAmount,
	NetAmount
FROM 
    FactInvoicesPartitioned
WHERE 
    InvoiceDate >= '2022-01-01' AND InvoiceDate < '2023-01-01';
------------------------------
-- Select aggregated data from the SalesFactPartitioned table
SELECT 
    dd.Year,
    dp.ProductCategory,
    SUM(fi.QuantitySold) AS TotalQuantitySold,
    SUM(fi.TotalAmount) AS TotalSalesAmount
FROM 
    FactInvoicesPartitioned fi
JOIN 
    DimDates dd ON fi.DateID = dd.DateID
JOIN 
    DimProducts dp ON fi.ProductID = dp.ProductID
WHERE 
    dd.Year IN (2022, 2023)
    AND dp.ProductCategory = 'Electronics'
GROUP BY 
    dd.Year, dp.ProductCategory;
