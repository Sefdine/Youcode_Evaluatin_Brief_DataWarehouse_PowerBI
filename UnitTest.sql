
EXEC tSQLt.NewTestClass 'DataIntegrity';
GO
CREATE PROCEDURE DataIntegrity.[test FactInvoices]
AS
BEGIN
	DECLARE @actualcount INT; 
	SELECT @actualcount = COUNT(InvoiceID) FROM FactInvoices;
	DECLARE @exceptedcount INT = 5000;

	EXEC tSQLt.AssertEquals @actualcount, @exceptedcount;
END;
GO
EXEC tSQLt.Run DataIntegrity

