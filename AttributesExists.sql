-- Unit test for all atributes in each table

EXEC tSQLt.NewTestClass 'AllAttributesExists';
GO

CREATE PROCEDURE AllAttributesExists.[test FactInvoices]
AS
BEGIN 
	DECLARE @exceptedcout INT = 5000;
	DECLARE @invoiceidcount INT; SELECT @invoiceidcount = COUNT(InvoiceID) FROM FactInvoices;
	DECLARE @quantitysoldcount INT; SELECT @quantitysoldcount = COUNT(QuantitySold) FROM FactInvoices;
	DECLARE @totalamountcount INT; SELECT @totalamountcount = COUNT(TotalAmount) FROM FactInvoices;
	DECLARE @discountamountcount INT; SELECT @discountamountcount = COUNT(DiscountAmount) FROM FactInvoices;
	DECLARE @netamountcount INT; SELECT @netamountcount = COUNT(NetAmount) FROM FactInvoices;

	EXEC tSQLt.AssertEquals @exceptedcout, @invoiceidcount;
	EXEC tSQLt.AssertEquals @exceptedcout, @quantitysoldcount;
	EXEC tSQLt.AssertEquals @exceptedcout, @totalamountcount;
	EXEC tSQLt.AssertEquals @exceptedcout, @discountamountcount;
	EXEC tSQLt.AssertEquals @exceptedcout, @netamountcount;
END;
GO

CREATE PROCEDURE AllAttributesExists.[test FactInventories]
AS
BEGIN
	DECLARE @exceptedcount INT = 5000;
	DECLARE @inventoryid INT; SELECT @inventoryid = COUNT(InventoryID) FROM FactInventories;
	DECLARE @stockreceived INT; SELECT @stockreceived = COUNT(StockReceived) FROM FactInventories;
	DECLARE @stocksold INT; SELECT @stocksold = COUNT(StockSold) FROM FactInventories;
	DECLARE @stockonhand INT; SELECT @stockonhand = COUNT(StockOnHand) FROM FactInventories;

	EXEC tSQLt.AssertEquals @exceptedcount, @inventoryid;
	EXEC tSQLt.AssertEquals @exceptedcount, @stockreceived;
	EXEC tSQLt.AssertEquals @exceptedcount, @stocksold;
	EXEC tSQLt.AssertEquals @exceptedcount, @stockonhand;
END;
GO

CREATE PROCEDURE AllAttributesExists.[test DimDates]
AS
BEGIN
	DECLARE @exceptedcount INT = 871;
	DECLARE @dateid INT; SELECT @dateid = COUNT(DateID) FROM DimDates;
	DECLARE @date INT; SELECT @date = COUNT([Date]) FROM DimDates;
	DECLARE @year INT; SELECT @year = COUNT([Year]) FROM DimDates;
	DECLARE @month INT; SELECT @month = COUNT([Month]) FROM DimDates;
	DECLARE @day INT; SELECT @day = COUNT([DAY]) FROM DimDates;

	EXEC tSQLt.AssertEquals @exceptedcount, @dateid;
	EXEC tSQLt.AssertEquals @exceptedcount, @date;
	EXEC tSQLt.AssertEquals @exceptedcount, @year;
	EXEC tSQLt.AssertEquals @exceptedcount, @month;
	EXEC tSQLt.AssertEquals @exceptedcount, @day;
END;
GO

CREATE PROCEDURE AllAttributesExists.[test DimProducts]
AS
BEGIN
	DECLARE @exceptedcount INT = 264;
	DECLARE @productid INT; SELECT @productid = COUNT(ProductID) FROM DimProducts;
	DECLARE @productname INT; SELECT @productname = COUNT(ProductName) FROM DimProducts;
	DECLARE @productcategory INT; SELECT @productcategory = COUNT(ProductCategory) FROM DimProducts;
	DECLARE @productsubcategory INT; SELECT @productsubcategory = COUNT(ProductSubCategory) FROM DimProducts;
	DECLARE @productprice INT; SELECT @productprice = COUNT(ProductPrice) FROM DimProducts;

	EXEC tSQLt.AssertEquals @exceptedcount, @productid;
	EXEC tSQLt.AssertEquals @exceptedcount, @productname;
	EXEC tSQLt.AssertEquals @exceptedcount, @productcategory;
	EXEC tSQLt.AssertEquals @exceptedcount, @productsubcategory;
	EXEC tSQLt.AssertEquals @exceptedcount, @productprice;
END;
GO

EXEC tSQLt.Run 'AllAttributesExists'
