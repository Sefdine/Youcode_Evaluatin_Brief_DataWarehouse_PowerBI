EXEC tSQLt.NewTestClass 'TableCreatedSuccessfully';
GO

CREATE PROCEDURE TableCreatedSuccessfully.[test TableExists]
AS
BEGIN
	EXEC tSQLt.AssertObjectExists @ObjectName = N'FactInvoices'
								 ,@Message = N'Failed'
	EXEC tSQLt.AssertObjectExists @ObjectName = N'FactInventories'
								 ,@Message = N'Failed'
	EXEC tSQLt.AssertObjectExists @ObjectName = N'DimDates'
								 ,@Message = N'Failed'
	EXEC tSQLt.AssertObjectExists @ObjectName = N'DimProducts'
								 ,@Message = N'Failed'
	EXEC tSQLt.AssertObjectExists @ObjectName = N'DimCustomers'
								 ,@Message = N'Failed'
	EXEC tSQLt.AssertObjectExists @ObjectName = N'DimShippers'
								 ,@Message = N'Failed'
	EXEC tSQLt.AssertObjectExists @ObjectName = N'DimSuppliers'
								 ,@Message = N'Failed'
END;
GO