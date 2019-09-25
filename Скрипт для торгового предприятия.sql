USE[TradeCompany]


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region delete
DECLARE @version NVARCHAR(500)= (select @@version)

IF(@version NOT LIKE '%Microsoft SQL Server 2016%')
	BEGIN
	IF object_id('dbo.Dates',							'Table') IS NOT NULL DROP TABLE dbo.Dates
	IF object_id('dbo.Goods_moving',			'Table') IS NOT NULL DROP TABLE dbo.Goods_moving
	IF object_id('dbo.Price',							'Table') IS NOT NULL DROP TABLE dbo.Price
	IF object_id('dbo.Goods_Return_reason','Table') IS NOT NULL DROP TABLE dbo.Goods_Return_reason
	IF object_id('dbo.Goods_Return',			'Table') IS NOT NULL DROP TABLE dbo.Goods_Return
	IF object_id('dbo.Goods_Return_type',	'Table') IS NOT NULL DROP TABLE dbo.Goods_Return_type
	IF object_id('dbo.Remains',						'Table') IS NOT NULL DROP TABLE dbo.Remains
	IF object_id('dbo.Supplies',					'Table') IS NOT NULL DROP TABLE dbo.Supplies
	IF object_id('dbo.Suppliers',					'Table') IS NOT NULL DROP TABLE dbo.Suppliers
	IF object_id('dbo.Credit_Sales_deteils','Table') IS NOT NULL DROP TABLE dbo.Credit_Sales_deteils
	IF object_id('dbo.Sales',							'Table') IS NOT NULL DROP TABLE dbo.Sales
	IF object_id('dbo.Banks',							'Table') IS NOT NULL DROP TABLE dbo.Banks
	IF object_id('dbo.Buyers',						'Table') IS NOT NULL DROP TABLE dbo.Buyers
	IF object_id('dbo.Product',						'Table') IS NOT NULL DROP TABLE dbo.Product
	IF object_id('dbo.Category',					'Table') IS NOT NULL DROP TABLE dbo.Category
	IF object_id('dbo.TM',								'Table') IS NOT NULL DROP TABLE dbo.TM
	IF object_id('dbo.Stock_Expenses',		'Table') IS NOT NULL DROP TABLE dbo.Stock_Expenses
	IF object_id('dbo.Timesheet',					'Table') IS NOT NULL DROP TABLE dbo.Timesheet
	IF object_id('dbo.Salary',						'Table') IS NOT NULL DROP TABLE dbo.Salary
	IF object_id('dbo.Employee_movement',	'Table') IS NOT NULL DROP TABLE dbo.Employee_movement
	IF object_id('dbo.Stocks',						'Table') IS NOT NULL ALTER TABLE dbo.Stocks DROP CONSTRAINT FK_Stocks_Boss_ID 
	IF object_id('dbo.Employees',					'Table') IS NOT NULL DROP TABLE dbo.Employees
	IF object_id('dbo.Employee_Sate',			'Table') IS NOT NULL DROP TABLE dbo.Employee_Sate
	IF object_id('dbo.Positions',					'Table') IS NOT NULL DROP TABLE dbo.Positions
	IF object_id('dbo.Stocks',						'Table') IS NOT NULL DROP TABLE dbo.Stocks
	IF object_id('dbo.Stock_State',				'Table') IS NOT NULL DROP TABLE dbo.Stock_State
	IF object_id('dbo.Stock_Type',				'Table') IS NOT NULL DROP TABLE dbo.Stock_Type
	IF object_id('dbo.Stock_Category',		'Table') IS NOT NULL DROP TABLE dbo.Stock_Category
	IF object_id('dbo.Adress',						'Table') IS NOT NULL DROP TABLE dbo.Adress
	IF object_id('dbo.Sales_type',				'Table') IS NOT NULL DROP TABLE dbo.Sales_type
	IF object_id('dbo.TG_Sale_add',				'Trigger') IS NOT NULL DROP TRIGGER dbo.TG_Sale_add
	IF object_id('dbo.TG_Return_add',			'Trigger') IS NOT NULL DROP TRIGGER dbo.TG_Return_add
	IF object_id('dbo.TG_Goods_moving_add','Trigger') IS NOT NULL DROP TRIGGER dbo.TG_Goods_moving_add
	IF object_id('dbo.TG_Employee_movement_add','Trigger') IS NOT NULL DROP TRIGGER dbo.TG_Employee_movement_add
	IF object_id('dbo.Current_Price',			'VIEW') IS NOT NULL DROP VIEW dbo.Current_Price
	IF object_id('dbo.Current_Remains',		'VIEW') IS NOT NULL DROP VIEW dbo.Current_Remains
	IF object_id('dbo.SalRet_View',				'VIEW') IS NOT NULL DROP VIEW dbo.SalRet_View
	IF object_id('dbo.Get_turnover',				'P') IS NOT NULL DROP PROCEDURE dbo.Get_turnover
	IF object_id('dbo.Get_profitability',		'P') IS NOT NULL DROP PROCEDURE dbo.Get_profitability
	IF object_id('dbo.Get_Info_by_employees','P') IS NOT NULL DROP PROCEDURE dbo.Get_Info_by_employees
	END
ELSE 
BEGIN
		DROP TABLE IF EXISTS dbo.Dates
		DROP TABLE IF EXISTS dbo.Goods_moving
		DROP TABLE IF EXISTS dbo.Price
		DROP TABLE IF EXISTS dbo.Goods_Return_reason
		DROP TABLE IF EXISTS dbo.Goods_Return
		DROP TABLE IF EXISTS dbo.Goods_Return_type
		DROP TABLE IF EXISTS dbo.Remains
		DROP TABLE IF EXISTS dbo.Supplies
		DROP TABLE IF EXISTS dbo.Suppliers
		DROP TABLE IF EXISTS dbo.Credit_Sales_deteils
		DROP TABLE IF EXISTS dbo.Sales
		DROP TABLE IF EXISTS dbo.Banks
		DROP TABLE IF EXISTS dbo.Buyers
		DROP TABLE IF EXISTS dbo.Product
		DROP TABLE IF EXISTS dbo.Category
		DROP TABLE IF EXISTS dbo.TM
		DROP TABLE IF EXISTS dbo.Timesheet
		DROP TABLE IF EXISTS dbo.Stock_Expenses
		DROP TABLE IF EXISTS dbo.Salary 
		DROP TABLE IF EXISTS dbo.Employee_movement
		IF object_id('dbo.Stocks',		'Table') IS NOT NULL  ALTER TABLE dbo.Stocks DROP CONSTRAINT FK_Stocks_Boss_ID 
		DROP TABLE IF EXISTS dbo.Employees
		DROP TABLE IF EXISTS dbo.Employee_Sate
		DROP TABLE IF EXISTS dbo.Positions
		DROP TABLE IF EXISTS dbo.Stocks
		DROP TABLE IF EXISTS dbo.Adress
		DROP TABLE IF EXISTS dbo.Stock_State
		DROP TABLE IF EXISTS dbo.Stock_Type
		DROP TABLE IF EXISTS dbo.Stock_Category
		DROP TABLE IF EXISTS dbo.Sales_type
		DROP TRIGGER IF EXISTS dbo.TG_Sale_add
		DROP TRIGGER IF EXISTS dbo.TG_Return_add
		DROP TRIGGER IF EXISTS dbo.TG_Goods_moving_add
		DROP VIEW IF EXISTS dbo.TG_Employee_movement_add
		DROP VIEW IF EXISTS dbo.Current_Price
		DROP VIEW IF EXISTS dbo.Current_Remains
		DROP VIEW IF EXISTS dbo.SalRet_View
		DROP FUNCTION IF EXISTS dbo.GetStringTable_FromString 
		DROP FUNCTION IF EXISTS dbo.GetIntTable_FromString
		DROP PROCEDURE IF EXISTS dbo.Get_turnover
		DROP PROCEDURE IF EXISTS dbo.Get_profitability
		DROP PROCEDURE IF EXISTS dbo.Get_Info_by_employees
	END

--#endregion


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region table Create


--#region Dates
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Dates
(
	Date_Id					INT IDENTITY PRIMARY KEY,
	[Date]					DATE							NOT NULL,
	Day_num					TINYINT						NOT NULL,
	Week_num				TINYINT						NOT NULL,
	Month_num				TINYINT						NOT NULL,
	Year_num				SMALLINT					NOT NULL,
	Is_Holiday			BIT								NOT NULL
)
----------------------------------------------------------------------------------------------------
--#endregion

--#region table Category of products
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Category
(
	Category_ID			INT IDENTITY PRIMARY KEY,
	Category_Name		NVARCHAR(150)				NOT NULL,
	Parent_ID				INT							NULL,
	Insert_Date			DATE						NOT NULL,
)

ALTER TABLE dbo.Category ADD  CONSTRAINT [DF_Category_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
----------------------------------------------------------------------------------------------------
--#endregion

--#region table Trade mark 
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.TM
(
	TM_ID						SMALLINT IDENTITY PRIMARY KEY,
	TM_Name					NVARCHAR(500)			NOT NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.TM ADD  CONSTRAINT [DF_TM_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
----------------------------------------------------------------------------------------------------
--#endregion

--#region table Product - with identification of Products
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Product
(
	Product_ID			BIGINT IDENTITY PRIMARY KEY,
	BarCode					NVARCHAR(20)			NULL,
	Product_Name		NVARCHAR(250)			NOT NULL,
	Category_ID			INT								NULL,
	TM_ID						SMALLINT					NULL,
	Is_return				BIT								NOT NULL,
	Parent_Product	BIGINT						NULL,
	Insert_Date			DATE							NOT NULL
)
/*
CREATE NONCLUSTERED INDEX NCLIX_Product_Category_ID ON dbo.Product(Category_ID)
CREATE NONCLUSTERED INDEX NCLIX_Product_TM_ID ON dbo.Product(TM_ID)
CREATE NONCLUSTERED INDEX NCLIX_Product_Parent_Product ON dbo.Product(Parent_Product)
*/
ALTER TABLE dbo.Product ADD  CONSTRAINT [DF_Product_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Product ADD  CONSTRAINT FK_Product_TM FOREIGN KEY (TM_ID) REFERENCES dbo.TM (TM_ID) ON DELETE SET NULL
ALTER TABLE dbo.Product ADD  CONSTRAINT FK_Product_Category FOREIGN KEY (Category_ID) REFERENCES dbo.Category (Category_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Employee Sate 
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Employee_Sate
(
	Employee_Sate_ID TINYINT IDENTITY PRIMARY KEY,
	Employee_Sate_Name NVARCHAR(50)	NOT NULL
)
----------------------------------------------------------------------------------------------------
--#endregion

--#region Positions
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Positions
(
	Position_ID			SMALLINT IDENTITY PRIMARY KEY,
	Position_Name		NVARCHAR(150)			NOT NULL,
	Divisions				NVARCHAR(150)			NULL,
	Insert_Date			DATE							NOT NULL
)
ALTER TABLE dbo.Positions ADD  CONSTRAINT [DF_Positions_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
----------------------------------------------------------------------------------------------------
--#endregion

--#region Employees 
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Employees
(
	Employee_ID			INT IDENTITY PRIMARY KEY,
	[Name]					NVARCHAR(100)			NOT NULL,
	Surname					NVARCHAR(100)			NOT NULL,
	SecondName			NVARCHAR(100)			NOT NULL,
	INN							NVARCHAR(10)			NOT NULL,
	Sex							VARCHAR(6)				NOT NULL,
	BirthDay				DATE							NOT NULL,
	Stock_ID				SMALLINT					NULL,
	Tab_Num					NVARCHAR(10)			NOT NULL,
	Employee_Sate_ID TINYINT					NOT NULL,
	Position_ID			SMALLINT					NOT NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Employees ADD  CONSTRAINT [DF_Employees_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Employees ADD  CONSTRAINT FK_Employees_Position_ID FOREIGN KEY (Position_ID) REFERENCES dbo.Positions (Position_ID) 
ALTER TABLE dbo.Employees ADD  CONSTRAINT FK_Employees_Employee_Sate_ID FOREIGN KEY (Employee_Sate_ID) REFERENCES dbo.Employee_Sate (Employee_Sate_ID) 
----------------------------------------------------------------------------------------------------
--#endregion

--#region Employees movement
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Employee_movement
(
	Movement_ID			BIGINT IDENTITY PRIMARY KEY,
	Employee_ID			INT								NOT NULL,
	Stock_ID				SMALLINT					NULL,
	Position_ID			SMALLINT					NULL,
	Employee_Sate_ID TINYINT					NULL,
	Date_Move				DATE							NOT NULL,
	
	[Description]		NVARCHAR(500)			NOT NULL
)

ALTER TABLE dbo.Employee_movement ADD  CONSTRAINT [DF_Employee_movement_DateInsert]  DEFAULT (getdate()) FOR Date_Move

ALTER TABLE dbo.Employee_movement ADD  CONSTRAINT FK_Employee_movement_Position_ID FOREIGN KEY (Position_ID) REFERENCES dbo.Positions (Position_ID) 
ALTER TABLE dbo.Employee_movement ADD  CONSTRAINT FK_Employee_movement_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES dbo.Employees (Employee_ID) 
ALTER TABLE dbo.Employee_movement ADD  CONSTRAINT FK_Employee_movement_Employee_Sate_ID FOREIGN KEY (Employee_Sate_ID) REFERENCES dbo.Employee_Sate (Employee_Sate_ID)

----------------------------------------------------------------------------------------------------
--#endregion

--#region States of Shops/Stocks
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Stock_State
(
	Stock_State_ID	TINYINT IDENTITY PRIMARY KEY,
	State_Name			NVARCHAR(150)			NOT NULL
)
----------------------------------------------------------------------------------------------------
--#endregion

--#region Type of Shops/Stocks
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Stock_Type
(
	Stock_Type_ID		TINYINT IDENTITY PRIMARY KEY,
	[Type_Name]			NVARCHAR(150)			NOT NULL
)
----------------------------------------------------------------------------------------------------
--#endregion

--#region Category of Shops/Stocks
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Stock_Category
(
	Stock_Category_ID	TINYINT IDENTITY PRIMARY KEY,
	[Category_Name]	NVARCHAR(150)			NOT NULL
)
----------------------------------------------------------------------------------------------------
--#endregion

--#region Adress 
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Adress
(
	Adress_ID				INT IDENTITY PRIMARY KEY,
	Country					VARCHAR(150)			NOT NULL,
	City						VARCHAR(150)			NOT NULL,
	Post						VARCHAR(25)				NULL,
	Street					VARCHAR(150)			NOT NULL,
	Build						VARCHAR(15)				NOT NULL,
	Office					VARCHAR(15)				NULL,
	Latitude				VARCHAR(25)				NULL,
	Longitude				VARCHAR(25)				NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Adress ADD  CONSTRAINT [DF_Adress_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
----------------------------------------------------------------------------------------------------
--#endregion

--#region Stocks/Shops/Retilers 
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Stocks
(
	Stock_ID				SMALLINT IDENTITY PRIMARY KEY,
	Stock_Name			NVARCHAR(150)			NOT NULL,
	Adress_ID				INT								NULL,
	Stock_Type_ID		TINYINT						NULL,
	Stock_Category_ID	TINYINT					NULL,
	Stock_State_ID	TINYINT						NOT NULL,
	Boss_ID					INT								NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Stocks ADD  CONSTRAINT [DF_Stocks_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Stocks ADD  CONSTRAINT FK_Stocks_Adress_ID FOREIGN KEY (Adress_ID) REFERENCES dbo.Adress (Adress_ID) ON DELETE SET NULL
ALTER TABLE dbo.Stocks ADD  CONSTRAINT FK_Stocks_Stock_Type_ID FOREIGN KEY (Stock_Type_ID) REFERENCES dbo.Stock_Type (Stock_Type_ID) ON DELETE SET NULL
ALTER TABLE dbo.Stocks ADD  CONSTRAINT FK_Stocks_Stock_Category_ID FOREIGN KEY (Stock_Category_ID) REFERENCES dbo.Stock_Category (Stock_Category_ID) ON DELETE SET NULL
ALTER TABLE dbo.Stocks ADD  CONSTRAINT FK_Stocks_Stock_State_ID FOREIGN KEY (Stock_State_ID) REFERENCES dbo.Stock_State (Stock_State_ID)
ALTER TABLE dbo.Stocks ADD  CONSTRAINT FK_Stocks_Boss_ID FOREIGN KEY (Boss_ID) REFERENCES dbo.Employees (Employee_ID) ON DELETE SET NULL

ALTER TABLE dbo.Employees ADD  CONSTRAINT FK_Employees_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL

ALTER TABLE dbo.Employee_movement ADD  CONSTRAINT FK_Employee_movement_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Salary for Employees
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Salary
(
	Salary_ID				INT IDENTITY PRIMARY KEY,
	Employee_ID			INT								NOT NULL,
	DateStart				DATE							NOT NULL,
	DateEnd					DATE							NULL,
	Sum_Salary_month MONEY						NOT NULL,
	Tax							NUMERIC(9,2)			NOT NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Salary ADD  CONSTRAINT [DF_Salary_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Salary ADD  CONSTRAINT FK_Salary_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES dbo.Employees (Employee_ID) ON DELETE CASCADE
----------------------------------------------------------------------------------------------------
--#endregion

--#region expenses,outlay,cost For stock keeping
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Stock_Expenses
(
	Expense_ID			INT IDENTITY PRIMARY KEY,
	Stock_ID				SMALLINT					NULL,
	COST_Month			MONEY							NOT NULL,
	DateFrom				DATE							NOT NULL,
	DateTo					DATE							NOT NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Stock_Expenses ADD  CONSTRAINT [DF_Stock_Expenses_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Stock_Expenses ADD  CONSTRAINT FK_Stock_Expenses_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region timesheet
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Timesheet
(
	Timetable_ID		BIGINT IDENTITY PRIMARY KEY,
	Employee_ID			INT								NOT NULL,
	Date_Report			DATE							NOT NULL,
	Hours_work			FLOAT(23)					NOT NULL,
	Hours_need			FLOAT(23)					NOT NULL,
	Stock_ID				SMALLINT					NULL,
	Is_Wacation			BIT								NOT NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Timesheet ADD  CONSTRAINT [DF_Timesheet_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Timesheet ADD  CONSTRAINT FK_Timesheet_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
ALTER TABLE dbo.Timesheet ADD  CONSTRAINT FK_Timesheet_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES dbo.Employees (Employee_ID) ON DELETE CASCADE
----------------------------------------------------------------------------------------------------
--#endregion

--#region Buyers
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Buyers
(
	Buyer_ID				BIGINT  IDENTITY PRIMARY KEY,
	[Name]					NVARCHAR(100)			NOT NULL,
	SurName					NVARCHAR(100)			NULL,
	SecondName			NVARCHAR(100)			NULL,
	INN							NVARCHAR(10)			NULL,
	Sex							VARCHAR(6)				NULL,
	BirthDay				DATE							NULL,
	Adress_ID				INT								NULL,
	type_Buyer			NVARCHAR(100)			NULL,
	Insert_Date			DATE							NOT NULL
)

ALTER TABLE dbo.Buyers ADD  CONSTRAINT [DF_Buyers_DateInsert]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Buyers ADD  CONSTRAINT FK_Buyers_Adress_ID FOREIGN KEY (Adress_ID) REFERENCES dbo.Adress (Adress_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Sales_type
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Sales_type
(
	Sale_type				SMALLINT IDENTITY PRIMARY KEY,
	Name_Sale_type	NVARCHAR(100)			NOT NULL,
	Insert_Date			DATE							NOT NULL
)
ALTER TABLE dbo.Sales_type ADD  CONSTRAINT [DF_Sales_type_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
----------------------------------------------------------------------------------------------------
--#endregion

--#region Sales
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Sales
(
	Sale_ID					BIGINT  IDENTITY PRIMARY KEY,
	Product_ID			BIGINT						NOT NULL,
	Qty							NUMERIC(9,2)			NOT NULL,
	Check_Num				NVARCHAR(50)			NOT NULL,
	Employee_ID			INT								NULL,	
	Stock_ID				SMALLINT					NULL,
	Sale_type				SMALLINT					NULL,
	Sum_Sale				NUMERIC(9,2)			NOT NULL,
	Insert_Date			SMALLDATETIME			NOT NULL,
	Tax							NUMERIC(9,2)			NOT NULL,
	Buyer_ID				BIGINT						NULL,
	Is_credit				BIT								NOT NULL,
	Date_Sale				SMALLDATETIME			NOT NULL
)


ALTER TABLE dbo.Sales ADD  CONSTRAINT [DF_Sales_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
ALTER TABLE dbo.Sales ADD  CONSTRAINT FK_Sales_Product_ID FOREIGN KEY (Product_ID) REFERENCES dbo.Product (Product_ID) ON DELETE CASCADE
ALTER TABLE dbo.Sales ADD  CONSTRAINT FK_Sales_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES dbo.Employees (Employee_ID) ON DELETE SET NULL
ALTER TABLE dbo.Sales ADD  CONSTRAINT FK_Sales_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
ALTER TABLE dbo.Sales ADD  CONSTRAINT FK_Sales_Buyer_ID FOREIGN KEY (Buyer_ID) REFERENCES dbo.Buyers (Buyer_ID) ON DELETE SET NULL
ALTER TABLE dbo.Sales ADD  CONSTRAINT FK_Sales_Sale_type FOREIGN KEY (Sale_type) REFERENCES dbo.Sales_type (Sale_type) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Credit banks
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Banks
(
	Bank_ID SMALLINT IDENTITY PRIMARY KEY,
	Bank_Name				NVARCHAR(250)			NOT NULL,
	Bank_OKPO				VARCHAR(12)				NOT NULL,
	Adress_ID				INT								NULL,
	Insert_Date			DATE							NOT NULL
)
ALTER TABLE dbo.Banks ADD  CONSTRAINT [DF_Banks_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
ALTER TABLE dbo.Banks ADD  CONSTRAINT FK_Banks_Adress_ID FOREIGN KEY (Adress_ID) REFERENCES dbo.Adress (Adress_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Credit sale
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Credit_Sales_deteils
(
	Credit_ID				BIGINT  IDENTITY PRIMARY KEY,
	Sale_ID					BIGINT						NOT NULL,
	Credit_type			VARCHAR(100)			NOT NULL,
	Bank_ID					SMALLINT					NULL,
	Sum_credit			NUMERIC(9,2)			NOT NULL,
	Sum_first_pay		NUMERIC(9,2)			NOT NULL,
	Month_count			TINYINT						NOT NULL,
	Insert_Date			SMALLDATETIME			NOT NULL
)

ALTER TABLE dbo.Credit_Sales_deteils ADD  CONSTRAINT [DF_Credit_Sales_deteils_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
ALTER TABLE dbo.Credit_Sales_deteils ADD  CONSTRAINT FK_CS_Sale_ID FOREIGN KEY (Sale_ID) REFERENCES dbo.Sales (Sale_ID) ON DELETE CASCADE
ALTER TABLE dbo.Credit_Sales_deteils ADD  CONSTRAINT FK_Credit_Sales_deteils_Bank_ID FOREIGN KEY (Bank_ID) REFERENCES dbo.Banks (Bank_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Suppliers --Поставщики
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Suppliers
(
	Purveyor_ID			INT  IDENTITY PRIMARY KEY,
	Purveyor_Name		NVARCHAR(500)			NOT NULL,
	Adress_ID				INT								NULL,
	INN							VARCHAR(15)				NULL,
	Insert_Date			SMALLDATETIME			NOT NULL
)
ALTER TABLE dbo.Suppliers ADD  CONSTRAINT [DF_Suppliers_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
ALTER TABLE dbo.Suppliers ADD  CONSTRAINT FK_Suppliers_Adress_ID FOREIGN KEY (Adress_ID) REFERENCES dbo.Adress (Adress_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Supplys --поставки
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Supplies
(
	Supplie_ID			BIGINT  IDENTITY PRIMARY KEY,
	Product_ID			BIGINT						NOT NULL,
	Qty							NUMERIC(9,2)			NOT NULL,
	Check_Num				NVARCHAR(50)			NOT NULL,
	Stock_ID				SMALLINT					NULL,
	Purveyor_ID			INT								NULL,
	Sum_Supplie			NUMERIC(9,2)			NOT NULL,
	Date_Supplie		SMALLDATETIME			NOT NULL,
	Insert_Date			SMALLDATETIME			NOT NULL
)

ALTER TABLE dbo.Supplies ADD  CONSTRAINT [DF_Supplies_DateInsert]  DEFAULT (getdate()) FOR Insert_Date
ALTER TABLE dbo.Supplies ADD  CONSTRAINT FK_Suppliess_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
ALTER TABLE dbo.Supplies ADD  CONSTRAINT FK_Suppliess_Product_ID FOREIGN KEY (Product_ID) REFERENCES dbo.Product (Product_ID) ON DELETE CASCADE
ALTER TABLE dbo.Supplies ADD  CONSTRAINT FK_Suppliess_Purveyor_ID FOREIGN KEY (Purveyor_ID) REFERENCES dbo.Suppliers (Purveyor_ID) ON DELETE CASCADE
----------------------------------------------------------------------------------------------------
--#endregion

--#region remains of goods --Остатки
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Remains
(
	Remain_ID				BIGINT IDENTITY PRIMARY KEY,
	Product_ID			BIGINT						NOT NULL,
	Qty							NUMERIC(9,2)			NOT NULL,
	Stock_ID				SMALLINT					NULL,
	DateTime_Remain	DATETIME					NOT NULL
)

ALTER TABLE dbo.Remains ADD  CONSTRAINT [DF_Remains_DateTime_Remain]  DEFAULT (getdate()) FOR DateTime_Remain
ALTER TABLE dbo.Remains ADD  CONSTRAINT FK_Remains_Product_ID FOREIGN KEY (Product_ID) REFERENCES dbo.Product (Product_ID) ON DELETE CASCADE
ALTER TABLE dbo.Remains ADD  CONSTRAINT FK_Remains_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region Types of goods return
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Goods_Return_type
(
	Return_type_ID	TINYINT IDENTITY PRIMARY KEY,
	TYPE_NAME				NVARCHAR(300)			NOT NULL,
	Insert_Date			DATE							NOT NULL
)	

ALTER TABLE dbo.Goods_Return_type ADD  CONSTRAINT [DF_Goods_Return_type_InsDate]  DEFAULT (getdate()) FOR Insert_Date
----------------------------------------------------------------------------------------------------
--#endregion

--#region Goods return
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Goods_Return
(
	Return_ID				BIGINT IDENTITY PRIMARY KEY,
	Doc_return			NVARCHAR(50)			NOT NULL,
	Date_return			SMALLDATETIME			NOT NULL,
	Stock_ID				SMALLINT					NULL,
	Product_ID			BIGINT						NOT NULL,
	Qty							NUMERIC(9,2)			NOT NULL,
	Return_type_ID	TINYINT						NULL,
	Sum_return			NUMERIC(9,2)			NOT NULL,
	Doc_sale				NVARCHAR(50)			NOT NULL,	
	Sale_date				DATE							NOT NULL,
	Stock_sale			SMALLINT					NULL,
	Return_type			SMALLINT					NULL,
	Is_credit				BIT								NULL,
	Insert_Date			SMALLDATETIME			NOT NULL
)	

ALTER TABLE dbo.Goods_Return ADD  CONSTRAINT [DF_Goods_Return_Insert_Date]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Goods_Return ADD  CONSTRAINT FK_Goods_Return_Product_ID FOREIGN KEY (Product_ID) REFERENCES dbo.Product (Product_ID) ON DELETE CASCADE
ALTER TABLE dbo.Goods_Return ADD  CONSTRAINT FK_Goods_Return_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
ALTER TABLE dbo.Goods_Return ADD  CONSTRAINT FK_Goods_Return_Return_type_ID FOREIGN KEY (Return_type_ID) REFERENCES dbo.Goods_Return_type (Return_type_ID) ON DELETE SET NULL
ALTER TABLE dbo.Goods_Return ADD  CONSTRAINT FK_Goods_Return_Return_type FOREIGN KEY (Return_type) REFERENCES dbo.Sales_type (Sale_type) ON DELETE SET NULL
----------------------------------------------------------------------------------------------------
--#endregion

--#region reason of Goods return
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Goods_Return_reason
(
	Return_ID				BIGINT						NOT NULL,
	Return_reason		VARCHAR(MAX)			NOT NULL,
	Insert_Date			DATETIME					NOT NULL
)	

ALTER TABLE dbo.Goods_Return_reason ADD  CONSTRAINT [DF_Goods_Return_reason_InsDate]  DEFAULT (getdate()) FOR Insert_Date
ALTER TABLE dbo.Goods_Return_reason ADD  CONSTRAINT FK_Goods_Return_reason_ID FOREIGN KEY (Return_ID) REFERENCES dbo.Goods_Return (Return_ID) 
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Moving goods
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Goods_moving
(
	Move_ID					INT	IDENTITY PRIMARY KEY,
	Product_start		BIGINT						NULL,
	QTY							NUMERIC(9,2)			NOT NULL,
	Product_end			BIGINT						NULL,
	Stock_start			SMALLINT					NULL,
	Stock_end				SMALLINT					NULL,
	Reason					NVARCHAR(500)			NOT NULL,
	DateMove				SMALLDATETIME			NOT NULL,
	Insert_Date			SMALLDATETIME			NOT NULL
)	

ALTER TABLE dbo.Goods_moving ADD  CONSTRAINT [DF_Goods_moving_InsDate]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Goods_moving ADD  CONSTRAINT FK_Goods_moving_Stock_start FOREIGN KEY (Stock_start) REFERENCES dbo.Stocks (Stock_ID) ON DELETE SET NULL
ALTER TABLE dbo.Goods_moving ADD  CONSTRAINT FK_Goods_moving_Product_start FOREIGN KEY (Product_start) REFERENCES dbo.Product (Product_ID) ON DELETE SET NULL
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Prices of goods
----------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Price
(
	Price_ID				BIGINT IDENTITY PRIMARY KEY,
	Product_ID			BIGINT						NOT NULL,
	Stock_ID				SMALLINT					NOT NULL,
	Cur_price				NUMERIC(9,2)			NOT NULL,
	DatePrice				SMALLDATETIME			NOT NULL,
	Insert_Date			SMALLDATETIME			NOT NULL
)	

ALTER TABLE dbo.Price ADD  CONSTRAINT [DF_Price_InsDate]  DEFAULT (getdate()) FOR Insert_Date

ALTER TABLE dbo.Price ADD  CONSTRAINT FK_Price_Stock_ID FOREIGN KEY (Stock_ID) REFERENCES dbo.Stocks (Stock_ID) ON DELETE CASCADE
ALTER TABLE dbo.Price ADD  CONSTRAINT FK_Price_Product_ID FOREIGN KEY (Product_ID) REFERENCES dbo.Product (Product_ID) ON DELETE CASCADE
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#endregion table Create

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region Tables insert test data
GO

--#region Add data into table dbo.Dates
----------------------------------------------------------------------------------------------------
DECLARE @ST_DAY DATE ='20000101'
DECLARE @TODAY DATE = '20300101'

WHILE (@ST_DAY<=@TODAY)
BEGIN 

INSERT INTO dbo.Dates
(
	[Date],
	Day_num,
	Week_num,
	Month_num,
	Year_num,
	Is_Holiday
)

SELECT @ST_DAY								AS [Date], 
			DATEPART(DAY,@ST_DAY)		AS Day_num,
			DATEPART(WEEK,@ST_DAY)	AS Week_num,
			DATEPART(MONTH,@ST_DAY) AS Month_num,
			DATEPART(YEAR,@ST_DAY)	AS Year_num,
			CASE WHEN  DATEPART(WEEKDAY,@ST_DAY) 
			IN (6,7) THEN 1 ELSE 0 END AS Is_Holiday


			SET @ST_DAY = DATEADD(DAY,+1,@ST_DAY)

END

GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Category
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Category
(
	Category_Name,
	Parent_ID
)
VALUES
('Great technique', null), ('Small technique', null), ('TV', 1), ('Smartphone', 2)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.TM
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.TM
(
	TM_Name
)
VALUES
('Samsung'), ('Philips'), ('Sony'), ('Apple')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Product
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Product
(
	BarCode,
	Product_Name,
	Category_ID,
	TM_ID,
	Is_return,
	Parent_Product
)
VALUES
('80042973911735597250', 'UE32J4500AKXUA', 3, 1, 0, Null ), 
('80042954657951632178', 'J510H/DS Galaxy J5 (2016) Black', 4, 1, 0, Null ),
('91065479789419874621', 'KD43XD8099BR2', 3, 3, 0, Null ),
('6206546798732141357', 'Apple iPod shuffle 2Gb MKMG2RP/A Silver 5Gen', 2, 4, 0, Null ),
('6206565465479846977', 'Router Apple Airport Express MC414RS/A(MB321)', 2, 4, 0, Null ),
('6206565465479846978', 'Router Apple Airport Express MC414RS/A(MB321)', 2, 4, 1, 5 )
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Employee_Sate
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Employee_Sate
(
	Employee_Sate_Name
)
VALUES
('work'), ('be ill'), ('maternity leave'), ('vacation paid'), ('vacation NO paid'), ('fire')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Positions
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Positions
(
	Position_Name,
	Divisions
)
VALUES
('Seller', 'Stock'), ('Chief of stock', 'Stock'), ('Cashier','Stock'),('BI Developer','IT'),('DBA','IT'),('C# developer','IT')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Employees
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Employees
(
	[Name],
	Surname,
	SecondName,
	INN,
	Sex,
	BirthDay,
	Stock_ID,
	Tab_Num,
	Employee_Sate_ID,
	Position_ID
)
VALUES
('NameTest1', 'SurnameTest1', 'SecondNameTest1','1234567890','Male',	'19850125',	NULL,'00001',1, 1), 
('NameTest2', 'SurnameTest2', 'SecondNameTest2','1234567891','Female','19880510', NULL,'00002',2, 2), 
('NameTest3', 'SurnameTest3', 'SecondNameTest3','1234567892','Male',	'19911004',	NULL,'00003',4, 3), 
('NameTest4', 'SurnameTest4', 'SecondNameTest4','1234567893','Female','19940617', NULL,'00004',3, 5)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Employee_movement
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Employee_movement
(
	Employee_ID,
	Stock_ID,
	Position_ID,
	Date_Move,
	[Description]
)
VALUES
(1,NULL,1,'20170105','Recruited'), 
(2,NULL,2,'20170212','Change of position'),
(4,NULL,5,'20170401','Care of the decree')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Stock_State
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Stock_State
(
	State_Name
)
VALUES ('Working'),( 'Building'), ('Reformating'), ('Closed')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Stock_Type
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Stock_Type
(
	[Type_Name]
)
VALUES ('Shop'),( 'Storage'), ('Headoffice'), ('Distribution center')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Stock_Category
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Stock_Category
(
	[Category_Name]
)
VALUES ('Very big'),( 'Big'), ('Medium'), ('Small'), ('Main'), ('Additional')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Adress
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Adress
(
	Country,
	City,
	Post,
	Street,
	Build,
	Office,
	Latitude,
	Longitude
)
VALUES
('Ukraine', 'Dnipro', '49000','Mandrikivska',	'51 M','221/4',	NULL,NULL), 
('Ukraine', 'Kyiev', '52000','Dniprovska',	'24','4',	NULL,NULL), 
('Ukraine', 'Lviv', '64000','Tolstogo',	'315','634',	NULL,NULL), 
('Ukraine', 'Kharkiv', '97000','Mailonvskogo',	'23/1', NULL,	NULL,NULL) 
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Stocks
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Stocks
(
	Stock_Name,
	Adress_ID,
	Stock_Type_ID,
	Stock_Category_ID,
	Stock_State_ID,
	Boss_ID
)
VALUES
('Dnipro-1s', 1, 1, 3, 1,	2), 
('Kiyev-RC1', 2, 4, 1, 2, NULL),
('HO LV1',		3, 3, 6, 3, 3)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Salary
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Salary
(
	Employee_ID,
	DateStart,
	DateEnd,
	Sum_Salary_month,
	Tax
)
VALUES
(1,'20160501', NULL,				9000.00,	0.22), 
(2,'20170101', NULL,				12000.00, 0.22), 
(3,'20160301','20170101',		18000.00, 0.05), 
(3,'20170101', NULL,				20000.00, 0.05),
(4,'20170401', '20200401',	1000.00,	0.05)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Stock_Expenses
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Stock_Expenses
(
	Stock_ID,
	COST_Month,
	DateFrom,
	DateTo
)
VALUES
(1,25000.00,'20160201', '20180201'), 
(2,250000.00,'20170201', '20170601'), 
(3,200000.00,'20160201', '20180201'),
(3,75000.00,'20170101', '20170301')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Timesheet
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Timesheet
(
	Employee_ID,
	Date_Report,
	Hours_work,
	Hours_need,
	Stock_ID,
	Is_Wacation
)
VALUES
(1,'20170401',12,12,1,0),(1,'20170402',12,12,1,0),(1,'20170403',0,0,1,0),(1,'20170404',0,0,1,0),(1,'20170405',6,0,1,0),
(2,'20170401',12,12,1,0),(2,'20170402',12,12,1,0),(2,'20170403',0,0,1,0),(2,'20170404',0,0,1,0),(2,'20170405',0,12,1,0),
(3,'20170401',0,8,3,1),(3,'20170402',0,8,3,1),(3,'20170403',0,8,3,1),(3,'20170404',0,8,3,1),(3,'20170405',0,8,3,1),
(4,'20170401',0,8,3,1),(4,'20170402',0,8,3,1),(4,'20170403',0,8,3,1),(4,'20170404',0,8,3,1),(4,'20170405',0,8,3,1)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Buyers
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Buyers
(
	[Name],
	SurName,
	SecondName,
	INN,
	Sex,
	BirthDay,
	Adress_ID,
	type_Buyer
)
VALUES
('BuyerName1', NULL, NULL,'12345678',NULL,'20100304',NULL, 'legal entity'),
('BuyerName2', 'BuyerSurName2', 'BuyerSecondName2','1234567890',NULL,'19940530',NULL,'phizik'),
('BuyerName3', NULL, NULL,'12345677',NULL,'20040920',NULL, 'legal entity'),
('BuyerName4', 'BuyerSurName4', 'BuyerSecondName4','1234567891',NULL,'19940530',NULL,'phizik')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Sales_type
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Sales_type
(
	Name_Sale_type
)
VALUES
('Internet'), ('Retail'), ('Wholesale'), ('Call-Center')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Sales
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Sales
(
	Product_ID,
	Qty,
	Check_Num,
	Employee_ID,
	Stock_ID,
	Sale_type,
	Sum_Sale,
	Date_Sale,
	Tax,
	Buyer_ID,
	Is_credit
)
VALUES
(1,1,'Check1', 1, 1, 2, 12899.99, '20170102', 0.2, NULL, 0),
(5,2,'Check2', 1, 1, 2, 14259.99, '20170112', 0.2, NULL, 1),
(6,1,'Check3', 3, 2, 1, 13099.99, '20170121', 0.2, NULL, 0)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Banks
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Banks
(
	Bank_Name,
	Bank_OKPO,
	Adress_ID
)
VALUES
('PlevatBank','12345768',NULL), ('GosBank','10000008',NULL)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Credit_Sales_deteils
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Credit_Sales_deteils
(
	Sale_ID,
	Credit_type,
	Bank_ID,
	Sum_credit,
	Sum_first_pay,
	Month_count
)
VALUES
(2,'Credit Pament free #1',1,14259.99, 1426, 10)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Suppliers
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Suppliers
(
	Purveyor_Name,
	Adress_ID,
	INN
)
VALUES
('Samsung-Ukraine',4,'37482596'), ('Apple USA', NULL,'65465478'), ('Sony-Poland', NULL,'84865421')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Supplies
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Supplies
(
	Product_ID,
	Qty,
	Check_Num,
	Stock_ID,
	Purveyor_ID,
	Sum_Supplie,
	Date_Supplie
)
VALUES
(1,10,'NDOC-2016120810547',1,1,8500,'20161208' ), 
(1,15,'NDOC-2016120810547',2,1,8500,'20161208' ), 
(2,25,'NDOC-2017022110547',1,1,3100,'20170221' ),  
(4,20,'NDOC-2017012310547',2,1,12500,'20170123' ), 
(5,20,'NDOC-2017012465790',1,1,8100,'20170124' ), 
(6,20,'NDOC-2017012710000',2,1,7800,'20170127' )
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Remains
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Remains
(
	Product_ID,
	Qty,
	Stock_ID,
	DateTime_Remain
)
VALUES
(1,10,1,'20170401 09:00'),
(1,15,2,'20170401 09:00'),
(2,25,1,'20170401 09:00'),
(4,20,2,'20170401 09:00'),
(5,20,1,'20170401 09:00'),
(6,20,2,'20170401 09:00'),
(1,9,1,'20170402 15:30'),
(1,14,2,'20170402 18:00'),
(2,23,1,'20170402 17:00'),
(4,18,2,'20170402 12:00'),
(5,19,1,'20170402 20:00'),
(6,17,2,'20170402 10:45')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Goods_Return_type
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Goods_Return_type
(
	TYPE_NAME
)
VALUES('In 14 days'), ('Damaged'), ('Garanty')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Goods_Return
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Goods_Return
(
	Doc_return,
	Date_return,
	Stock_ID,
	Product_ID,
	Qty,
	Return_type_ID,
	Sum_return,
	Doc_sale,
	Sale_date,
	Stock_sale
)
VALUES	('RET-DOC20170105','20170105',1,1,1,1,12899.99,'Check1','20170102',1),
				('RET-DOC20170304','20170304',1,6,1,2,13099.99,'Check3','20170121',2)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Goods_Return_reason
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Goods_Return_reason
(
	Return_ID,
	Return_reason
)
VALUES	(1,'take another device'), (2,'Crush when was tranporting')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Goods_moving
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Goods_moving
(
	Product_start,
	QTY, 
	Product_end, 
	Stock_start, 
	Stock_end, 
	Reason, 
	DateMove
)
VALUES(1,2,1,3,1,'Remove from base','20161215'),(6,2,6,3,1,'Remove from base','20161220'),(3,10,NULL,3,NULL,'Demaged products','20161225')
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add data into table dbo.Price
----------------------------------------------------------------------------------------------------
INSERT INTO dbo.Price
(
	Product_ID,
	Stock_ID, 
	Cur_price,
	DatePrice
)
SELECT p.Product_ID, 
				s.Stock_ID, 
				CASE 
					WHEN p.Product_ID= 1 THEN 14599.99
					WHEN p.Product_ID= 2 THEN 10999.99
					WHEN p.Product_ID= 3 THEN 12599.99
					WHEN p.Product_ID= 4 THEN 13000.00
					WHEN p.Product_ID= 5 THEN 15687.25
					WHEN p.Product_ID= 6 THEN 8999.99
					ELSE 0 END AS Cur_price,
					GETDATE() AS DatePrice
FROM dbo.Product AS p
CROSS JOIN dbo.Stocks AS s
UNION ALL
SELECT p.Product_ID, 
				s.Stock_ID, 
				CASE 
					WHEN p.Product_ID= 1 THEN 10.99
					WHEN p.Product_ID= 2 THEN 20.99
					WHEN p.Product_ID= 3 THEN 30.99
					WHEN p.Product_ID= 4 THEN 40.00
					WHEN p.Product_ID= 5 THEN 50.25
					WHEN p.Product_ID= 6 THEN 60.99
					ELSE 0 END AS Cur_price,
					DATEADD(DAY,-(p.Product_ID+s.Stock_ID),GETDATE()) AS DatePrice
FROM dbo.Product AS p
CROSS JOIN dbo.Stocks AS s

GO
----------------------------------------------------------------------------------------------------
--#endregion

--#endregion Tables insert test data

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region Triggers Create

--#region Add Sale
----------------------------------------------------------------------------------------------------
CREATE TRIGGER dbo.TG_Sale_add ON dbo.Sales
FOR INSERT  
AS  
IF NOT EXISTS(SELECT *
           FROM INSERTED i 
           WHERE i.Qty<=(SELECT TOP 1 r.qty FROM dbo.Remains r 
                            WHERE r.Product_ID = i.Product_ID
														AND r.Stock_ID = i.Stock_ID
                            ORDER BY r.DateTime_Remain DESC))
    BEGIN
       ROLLBACK TRAN
         PRINT 'There is no such goods in stock'
    END
    ELSE
    BEGIN
    	BEGIN TRY 
			BEGIN TRANSACTION
    	    	
    		INSERT INTO dbo.Remains(Product_ID, Qty, Stock_ID, DateTime_Remain)
    		SELECT	i.Product_ID, 
				(rem.Qty-i.Qty) AS QTY,
				i.Stock_ID,
				GETDATE() AS DateTime_Remain
				FROM INSERTED i 
				JOIN(
							SELECT DISTINCT d.Product_ID, d.Qty, d.Stock_ID
							FROM dbo.Remains d
							WHERE d.DateTime_Remain IN (SELECT MAX(r.DateTime_Remain) FROM dbo.Remains AS r GROUP BY Product_ID,Stock_ID )
						) rem ON rem.Product_ID = i.Product_ID
						AND rem.Stock_ID = i.Stock_ID 
						
    	 COMMIT TRANSACTION
    	 END TRY  
    	 
			 BEGIN CATCH 
    	    ROLLBACK TRANSACTION 
    	     PRINT 'Something going wrong'
    	 END CATCH
    	END
GO

/*INSERT INTO dbo.Sales(Product_ID, Qty, Check_Num, Employee_ID, Stock_ID, Sale_type, Sum_Sale, Date_Sale, Tax, Buyer_ID, Is_credit)
VALUES(3,1,'2 test',1,1,1,12500.52,GETDATE(),0.20,1,0)*/
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add Return
----------------------------------------------------------------------------------------------------
CREATE TRIGGER dbo.TG_Return_add ON dbo.Goods_Return
FOR INSERT  
AS 
	
	
DECLARE @c INT = (	SELECT COUNT(*) FROM dbo.Goods_Return AS gr
    								JOIN INSERTED i ON i.Product_ID = gr.Product_ID
    															AND CAST(i.Sale_date AS DATE) = Cast(gr.Sale_date AS DATE)
																	AND i.[Doc_sale] = gr.Doc_sale
																	AND i.[Stock_sale] = gr.[Stock_sale]
																	)															

	IF (@c<2)
		BEGIN
					
					 IF NOT EXISTS(SELECT * FROM dbo.Sales s
									JOIN INSERTED i 
									ON Cast(s.Date_Sale AS DATE) = CAST(i.Sale_date AS DATE)
									AND s.Product_ID = i.Product_ID
									AND s.Check_Num = i.[Doc_sale]
									AND s.Stock_ID = i.[Stock_sale]
									AND i.Qty<=s.Qty)
					BEGIN
					 ROLLBACK TRAN
						 PRINT 'There is no such sales'
					END
			ELSE 
					BEGIN
						BEGIN TRY 
							BEGIN TRANSACTION
    	    	
    						INSERT INTO dbo.Remains(Product_ID, Qty, Stock_ID, DateTime_Remain)
    						SELECT	i.Product_ID, 
								(rem.Qty+i.Qty) AS QTY,
								i.Stock_ID,
								GETDATE() AS DateTime_Remain
								FROM INSERTED i 
								JOIN(
											SELECT DISTINCT d.Product_ID, d.Qty, d.Stock_ID
											FROM dbo.Remains d
											WHERE d.DateTime_Remain IN (SELECT MAX(r.DateTime_Remain) FROM dbo.Remains AS r GROUP BY Product_ID,Stock_ID )
										) rem ON rem.Product_ID = i.Product_ID
										AND rem.Stock_ID = i.Stock_ID 
						
    					 COMMIT TRANSACTION
    					 END TRY  
    	 
							 BEGIN CATCH 
    							ROLLBACK TRANSACTION 
    							 PRINT 'Something going wrong'
    					 END CATCH
					END
			
		END
		
ELSE
		BEGIN
					 ROLLBACK TRAN
					 PRINT 'There is already one return by this information'
		END
 

GO
/*
SELECT * FROM dbo.Sales AS s
SELECT * FROM dbo.Goods_Return AS gr


INSERT INTO dbo.Goods_Return (Doc_return, Date_return, Stock_ID, Product_ID, Qty, Return_type_ID, Sum_return, Doc_sale, Sale_date, Stock_sale)
VALUES('Test trigger2', GETDATE(),1,6,1,1,12899.99,'Check3','20170121',2)

INSERT INTO dbo.Goods_Return (Doc_return, Date_return, Stock_ID, Product_ID, Qty, Return_type_ID, Sum_return, Doc_sale, Sale_date, Stock_sale)
VALUES('Test trigger2', GETDATE(),1,5,1,1,12899.99,'Check2','20170112',1)
*/
/*INSERT INTO dbo.Sales(Product_ID, Qty, Check_Num, Employee_ID, Stock_ID, Sale_type, Sum_Sale, Date_Sale, Tax, Buyer_ID, Is_credit)
VALUES(3,1,'2 test',1,1,1,12500.52,GETDATE(),0.20,1,0)*/
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add Goods_moving
----------------------------------------------------------------------------------------------------
CREATE TRIGGER dbo.TG_Goods_moving_add ON dbo.Goods_moving
FOR INSERT  
AS  
IF NOT EXISTS(SELECT *
           FROM INSERTED i 
           WHERE i.Qty<=(SELECT TOP 1 r.qty FROM dbo.Remains r 
                            WHERE r.Product_ID = i.Product_start
														AND r.Stock_ID = i.Stock_start
                            ORDER BY r.DateTime_Remain DESC))
    BEGIN
       ROLLBACK TRAN
         PRINT 'There is no such goods in stock'
    END
    ELSE
    BEGIN
    	BEGIN TRY 
			BEGIN TRANSACTION
    	    	
    		INSERT INTO dbo.Remains(Product_ID, Qty, Stock_ID, DateTime_Remain)
    		SELECT	i.Product_start, 
				(rem.Qty-i.Qty) AS QTY,
				i.Stock_start,
				GETDATE() AS DateTime_Remain
				FROM INSERTED i 
				JOIN(
							SELECT DISTINCT d.Product_ID, d.Qty, d.Stock_ID
							FROM dbo.Remains d
							WHERE d.DateTime_Remain IN (SELECT MAX(r.DateTime_Remain) FROM dbo.Remains AS r GROUP BY Product_ID,Stock_ID )
						) rem ON rem.Product_ID = i.Product_start
						AND rem.Stock_ID = i.Stock_start 
				
						
DECLARE @Rez_stock SMALLINT, @rez_product BIGINT
SET @Rez_stock = (SELECT Stock_end FROM INSERTED)
SET @rez_product = (SELECT Product_end FROM INSERTED)
					
					IF(@Rez_stock IS NOT NULL AND @rez_product IS NOT NULL)
						BEGIN
							INSERT INTO dbo.Remains(Product_ID, Qty, Stock_ID, DateTime_Remain)
    		SELECT	i.Product_end, 
				(rem.Qty+i.Qty) AS QTY,
				i.Stock_end,
				GETDATE() AS DateTime_Remain
				FROM INSERTED i 
				JOIN(
							SELECT DISTINCT d.Product_ID, d.Qty, d.Stock_ID
							FROM dbo.Remains d
							WHERE d.DateTime_Remain IN (SELECT MAX(r.DateTime_Remain) FROM dbo.Remains AS r GROUP BY Product_ID,Stock_ID )
						) rem ON rem.Product_ID = i.Product_end
						AND rem.Stock_ID = i.Stock_end
							
						END
						
    	 COMMIT TRANSACTION
    	 END TRY  
    	 
			 BEGIN CATCH 
    	    ROLLBACK TRANSACTION 
    	     PRINT 'Something going wrong'
    	 END CATCH
    	END
GO

/*INSERT INTO dbo.Goods_moving(Product_start, QTY, Product_end, Stock_start, Stock_end, Reason, DateMove)
	VALUES() -- NOT good
	INSERT INTO dbo.Goods_moving(Product_start, QTY, Product_end, Stock_start, Stock_end, Reason, DateMove)
	VALUES() -- good
	*/
----------------------------------------------------------------------------------------------------
--#endregion

--#region Add Employees/Employee movement
----------------------------------------------------------------------------------------------------
CREATE TRIGGER dbo.TG_Employee_movement_add ON dbo.Employee_movement
FOR INSERT  
AS  

IF EXISTS(SELECT * 
            FROM dbo.Employees  e
            JOIN INSERTED i ON i.Employee_ID = e.Employee_ID)
	BEGIN
		
		BEGIN TRY
			
			BEGIN TRANSACTION
					UPDATE e
					SET e.Stock_ID = i.Stock_ID, 
							e.Position_ID = i.Position_ID, 
							e.Insert_Date = i.Date_Move,
							e.Employee_Sate_ID = i.Employee_Sate_ID
					FROM dbo.Employees e
					JOIN INSERTED i ON e.Employee_ID = i.Employee_ID
			COMMIT TRANSACTION
			
			END TRY
			BEGIN CATCH
			
				ROLLBACK TRANSACTION
				PRINT 'Something going wrong'
		
			END CATCH
	
	END        
ELSE
	BEGIN
		PRINT('There is no such data in position/employee or Stocks')
	END          


/*INSERT INTO dbo.Employee_movement(Employee_ID, Stock_ID, Position_ID, Employee_Sate_ID, Date_Move, DESCRIPTION)
VALUES(1,1,1,1,'20170413','Test2')*/
----------------------------------------------------------------------------------------------------
--#endregion

--#endregion Triggers Create

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region Indexes Create

CREATE NONCLUSTERED INDEX NLCIX_Dates_Date ON dbo.Dates([Date])
CREATE NONCLUSTERED INDEX NCLIX_Dates_numbers ON dbo.Dates(Year_num,Month_num,Week_num,Day_num) INCLUDE (Is_Holiday)

CREATE NONCLUSTERED INDEX NCLIX_Category_parent ON dbo.Category(Parent_ID)

CREATE NONCLUSTERED INDEX NCLIX_Employees_INN_Tab ON dbo.Employees (INN,Tab_Num)
CREATE NONCLUSTERED INDEX NCLIX_Employees_Stock ON dbo.Employees (Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Employees_Employee_Sate_ID ON dbo.Employees (Employee_Sate_ID)
CREATE NONCLUSTERED INDEX NCLIX_Employees_Position_ID ON dbo.Employees (Position_ID)

CREATE NONCLUSTERED INDEX NCLIX_Employee_movement_Date ON dbo.Employee_movement(Date_Move)
CREATE NONCLUSTERED INDEX NCLIX_Employee_movement_Emp_St_Posit ON  dbo.Employee_movement(Employee_ID, Stock_ID,Position_ID)

CREATE NONCLUSTERED INDEX NCLIX_Adress_text ON dbo.Adress (Country,City,Post,Street,Build,Office)

CREATE NONCLUSTERED INDEX NCLIX_Stocks_Adress_ID ON dbo.Stocks (Adress_ID)
CREATE NONCLUSTERED INDEX NCLIX_Stocks_Stock_Type_ID ON dbo.Stocks (Stock_Type_ID)
CREATE NONCLUSTERED INDEX NCLIX_Stocks_Stock_Category_ID ON dbo.Stocks (Stock_Category_ID)
CREATE NONCLUSTERED INDEX NCLIX_Stocks_Stock_State_ID ON dbo.Stocks (Stock_State_ID)
CREATE NONCLUSTERED INDEX NCLIX_Stocks_Stock_Boss_ID ON dbo.Stocks (Boss_ID)

CREATE NONCLUSTERED INDEX NCLIX_Salary_DD_Emp ON dbo.Salary(DateStart,DateEnd,Employee_ID)
CREATE NONCLUSTERED INDEX NCLIX_Salary_Emp ON dbo.Salary(Employee_ID)

CREATE NONCLUSTERED INDEX NCLIX_Stock_Expenses_Stock_ID ON dbo.Stock_Expenses (Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Stock_Expenses_DD_S ON dbo.Stock_Expenses (DateFrom,DateTo,Stock_ID)

CREATE NONCLUSTERED INDEX NCLIX_Timesheet_Find ON dbo.Timesheet (Date_Report,Employee_ID,Stock_ID)

CREATE NONCLUSTERED INDEX NCLIX_Buyers_Adress_ID ON dbo.Buyers (Adress_ID)
CREATE NONCLUSTERED INDEX NCLIX_Buyers_Find ON dbo.Buyers (type_Buyer,INN,[Name])

CREATE NONCLUSTERED INDEX NCLIX_Sales_Find ON dbo.Sales (Date_Sale,Stock_ID,[Check_Num],Sale_type,Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Sales_Product ON dbo.Sales (Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Sales_Stock_ID ON dbo.Sales (Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Sales_Employee_ID ON dbo.Sales (Employee_ID)
CREATE NONCLUSTERED INDEX NCLIX_Sales_Buyer_ID ON dbo.Sales (Buyer_ID)
	
CREATE NONCLUSTERED INDEX NCLIX_Banks_Adress_ID ON dbo.Banks (Adress_ID)
CREATE NONCLUSTERED INDEX NCLIX_Banks_Bank_OKPO ON dbo.Banks (Bank_OKPO)

CREATE NONCLUSTERED INDEX NCLIX_Credit_Sales_deteils_Sale_ID ON dbo.Credit_Sales_deteils(Sale_ID)
CREATE NONCLUSTERED INDEX NCLIX_Credit_Sales_deteils_Bank_ID ON dbo.Credit_Sales_deteils(Bank_ID)

CREATE NONCLUSTERED INDEX NCLIX_Suppliers_Adress_ID ON dbo.Suppliers(Adress_ID)
CREATE NONCLUSTERED INDEX NCLIX_Suppliers_INN ON dbo.Suppliers(INN)

CREATE NONCLUSTERED INDEX NCLIX_Supplies_Find ON dbo.Supplies(Date_Supplie, Stock_ID, Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Supplies_Stock_ID ON dbo.Supplies(Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Supplies_Product_ID ON dbo.Supplies(Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Supplies_Purveyor_ID ON dbo.Supplies(Purveyor_ID)

CREATE NONCLUSTERED INDEX NCLIX_Remains_Find ON dbo.Remains(DateTime_Remain, Stock_ID, Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Remains_Stock_ID ON dbo.Remains(Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Remains_Product_ID ON dbo.Remains(Product_ID)

CREATE NONCLUSTERED INDEX NCLIX_Goods_Return_Find ON dbo.Goods_Return(Date_return, Stock_ID, Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Goods_Return_Sale ON dbo.Goods_Return(Sale_date,Stock_sale,Doc_sale)
CREATE NONCLUSTERED INDEX NCLIX_Goods_Return_Stock_ID ON dbo.Goods_Return(Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Goods_Return_Product_ID ON dbo.Goods_Return(Product_ID)

CREATE CLUSTERED INDEX CLIX_Goods_Return_reason_Return_ID ON dbo.Goods_Return_reason(Return_ID)

CREATE NONCLUSTERED INDEX NCLIX_Goods_moving_Find ON dbo.Goods_moving(DateMove,Stock_start,Product_start)
CREATE NONCLUSTERED INDEX NCLIX_Goods_moving_End ON dbo.Goods_moving(Stock_end,Product_end)
CREATE NONCLUSTERED INDEX NCLIX_Goods_moving_Stock ON dbo.Goods_moving(Stock_start,Stock_end)
CREATE NONCLUSTERED INDEX NCLIX_Goods_moving_Product ON dbo.Goods_moving(Product_start,Product_end)

CREATE NONCLUSTERED INDEX NCLIX_Price_Find ON dbo.Price (DatePrice,Stock_ID,Product_ID)
CREATE NONCLUSTERED INDEX NCLIX_Price_Stock_ID ON dbo.Price (Stock_ID)
CREATE NONCLUSTERED INDEX NCLIX_Price_Product_ID ON dbo.Price (Product_ID)


--#endregion Indexes Create


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region View Create
GO
--#region Current price
----------------------------------------------------------------------------------------------------
CREATE VIEW dbo.Current_Price
AS 
SELECT	p.Price_ID, 
				p.Product_ID, 
				p.Stock_ID, 
				p.Cur_price, 
				p.DatePrice
FROM dbo.Price AS p
WHERE p.DatePrice IN (SELECT MAX(pp.DatePrice) 
                      FROM dbo.Price pp 
					  WHERE pp.Product_ID = p.Product_ID
						AND pp.Stock_ID = p.Stock_ID)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region Current Remains
----------------------------------------------------------------------------------------------------
CREATE VIEW dbo.Current_Remains
AS
SELECT	r.Remain_ID, 
				r.Product_ID, 
				r.Qty, 
				r.Stock_ID, 
				r.DateTime_Remain 
FROM dbo.Remains r
WHERE DateTime_Remain IN(SELECT MAX(rr.DateTime_Remain) 
                         FROM dbo.Remains rr
						 WHERE rr.Product_ID = r.Product_ID
							AND rr.Stock_ID = r.Stock_ID)
GO
----------------------------------------------------------------------------------------------------
--#endregion

--#region All sales and returns
----------------------------------------------------------------------------------------------------
CREATE VIEW dbo.SalRet_View
AS
SELECT	1											AS [Type],
				s.Check_Num						AS [document_num],
				s.Date_Sale						AS [Date],
				s.Product_ID,
				s.Stock_ID,
				ISNULL(s.Is_credit,0)	AS Is_credit,
				ISNULL(s.Sale_type,0)	AS [kind],
				s.Qty,
				s.Sum_Sale						AS Sum_all
FROM dbo.Sales AS s
Union 
SELECT	2 as [Type], 
				gr.Doc_return					AS [document_num],
				gr.Date_return				AS [Date],
				gr.Product_ID, 
				gr.Stock_ID, 
				ISNULL(gr.Is_credit,0) AS Is_credit,
				ISNULL(gr.Return_type,0) AS [kind],
				gr.Qty,
				gr.Sum_return					AS Sum_all
FROM dbo.Goods_Return AS gr 

GO
----------------------------------------------------------------------------------------------------
--#endregion

--#endregion View Create

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region Function Create

--#region Get One-column Table String From String
/*
* needs only for version of server lower then 2016 sp 1. In 2016 sp 1 or higher - use STRING_SPLIT ( string , separator )
 * This function is necessary when you need to parse array of strings with fixed separator
 * You send array of strings and tell what is separator and get table with data - all elements from array in table
 * Work with varchar on out
 */
CREATE FUNCTION dbo.GetStringTable_FromString (@Text VARCHAR(MAX), @Separator VARCHAR(5))

RETURNS @rtnTable TABLE  ([value] varchar(max))

AS  
BEGIN


DECLARE @i1 INT,
          @i2 INT,
          @s VARCHAR(255)
          
  SET @i2=1
  
  WHILE @i2>0 
		BEGIN
			SET @i1=CHARINDEX(@Separator,@Text,@i2)
			IF @i1>0 
				BEGIN  
					SET @s=SUBSTRING(@Text,@i2,@i1-@i2)
					insert into @rtnTable
					Select @s
					SET @i2=@i1+1
				END
			ELSE 
				BEGIN 
					SET @s=SUBSTRING(@Text,@i2,LEN(@Text)-@i2+1)
					insert into @rtnTable
					Select @s
					SET @i2=0
				END

			END
Return 
END;  
GO

--Select * from  dbo.GetStringTable_FromString ('1 2/ 3.4.5 6/7, sdfsdfg,oiuoiu. dcvzxd cv, ddsd.  dsfsdf ', '/')
--#endregion


--#region Get One-column Table INT From String
/*needs only for version of server lower then 2016 sp 1. In 2016 sp 1 or higher - use STRING_SPLIT ( string , separator )
 * This function is necessary when you need to parse array of INTs with fixed separator
 * You send array of Ints and tell what is separator and get table with data - all elements from array in table
 * Work with INT on out
 */
CREATE FUNCTION dbo.GetIntTable_FromString (@Text varchar(MAX), @Separator varchar(5))

RETURNS @rtnTable TABLE  ([value] int)

AS  
BEGIN

DECLARE @i1 INT,
          @i2 INT,
          @s VARCHAR(255)
 
  SET @i2=1
  
  WHILE @i2>0 
		BEGIN
			SET @i1=CHARINDEX(@Separator,@Text,@i2) 
    
			IF @i1>0 
				BEGIN
					SET @s=SUBSTRING(@Text,@i2,@i1-@i2)
					insert into @rtnTable
					Select convert(int,@s)
					SET @i2=@i1+1
				END
			ELSE 
				BEGIN
					SET @s=SUBSTRING(@Text,@i2,LEN(@Text)-@i2+1)
					insert into @rtnTable
					Select convert(int,@s)
					SET @i2=0
				END
  END
Return 
END;  
GO
--Select * from dbo.GetIntTable_FromString ('1,2,3,4,5,8,01,14,1444,658',',')
--#endregion
--#endregion function Create

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--#region Procedures Create

--#region Product turnover 
/*
 One of the main indicators of the efficiency of a trading enterprise is the turnover of commodity stocks. 
 The turnover ratio of a commodity (or stocks) is the ratio of the company's sales to its assets. 
 This indicator shows how quickly the stock in the warehouse is sold. By the ratio of inventory turnover, 
 you can understand how effectively and successfully the company uses its assets to generate revenue.
 To calculate the turnover of goods in natural units it is necessary:
 1) Choose a period
 2) Calculate the average commodity stock for the selected period (you can calculate for a single product or for a commodity group)
 3) Calculate sales of goods (product group) for a period (in natural units)
 --------------
 ALSO: parametrs @date_start/@date_end - it is parametrs by period to calculate turnover
 @depart - this idicator can show 4 different results
if depart = 0 then turnover will be calculating over stocks and products
if depart = 1 then turnover will be calculating over only by stocks - so products will be grouped
if depart = 2 then turnover will be calculating over only by products - so stocks will be grouped
if depart = 3 then turnover will be calculating all turnover by all products and all stocks
---------
@separ - in trial version only can be 0 - by dates
In future version will be chosing, for period< and can be checked by days/Weeks/month/quarters/years
 */

 CREATE PROCEDURE dbo.Get_turnover
					@date_start DATE = '20170401',
					@date_end DATE = '20170414',
					@separ TINYINT = 0,
					@depart TINYINT = 0
AS 
BEGIN
		
SET NOCOUNT ON
SET XACT_ABORT ON
SET ANSI_NULLS ON

IF OBJECT_ID('tempdb..#turnover_remain') IS NOT NULL DROP TABLE #turnover_remain

SELECT	d.Date, 
				d.Day_num, 
				d.Week_num, 
				d.Month_num, 
				d.Year_num ,
				d.Product_ID,
				d.Stock_ID,
				Case WHEN d.[Date] IN (@date_start,@date_end) 
				THEN ISNULL(z.QTY,0)/2.00
				ELSE ISNULL(z.QTY,0) end AS Qty_remain
INTO #turnover_remain
FROM (SELECT d.* , p.Product_ID, s.Stock_ID
			FROM dbo.Dates AS d
			CROSS JOIN dbo.Product AS p
			CROSS JOIN dbo.Stocks AS s
			WHERE d.[Date] BETWEEN @date_start AND @date_end
			) AS d
OUTER APPLY (
							SELECT TOP 1 r.QTY 
							FROM dbo.Remains r 
							WHERE d.Product_ID = r.Product_ID 
							AND d.Stock_ID = r.Stock_ID
							AND CAST(r.DateTime_Remain AS DATE)<=d.Date 
							ORDER BY r.DateTime_Remain desc) z
WHERE d.Date BETWEEN @date_start AND @date_end
ORDER BY d.Date
 
CREATE CLUSTERED INDEX NCLIX_Remain_Find ON #turnover_remain (Date,Stock_ID,Product_ID)
 

IF OBJECT_ID('tempdb..#turnover_Sale') IS NOT NULL DROP TABLE #turnover_Sale
 CREATE TABLE #turnover_Sale 
 (
 	Sale_ID BIGINT NOT NULL,
 	Date_Sale SMALLDATETIME NOT NULL,
 	Stock_ID SMALLINT NOT NULL,
 	Product_ID BIGINT NOT NULL,
 	QTY NUMERIC(9,2)
 	)
 CREATE CLUSTERED INDEX NCLIX_Sale_Find ON #turnover_Sale (Date_Sale,Stock_ID,Product_ID)
 
 INSERT INTO #turnover_Sale (Sale_ID,Date_Sale,Stock_ID,Product_ID,QTY)
 SELECT s.Sale_ID,
				s.Date_Sale,
				s.Stock_ID,
				s.Product_ID,
				SUM(s.Qty) AS QTY
FROM dbo.Sales AS s
 GROUP BY s.Sale_ID,
				s.Date_Sale,
				s.Stock_ID,
				s.Product_ID

IF OBJECT_ID('tempdb..#turnover_rezult') IS NOT NULL DROP TABLE #rezult
 SELECT r.Date, 
				r.Day_num, 
				r.Week_num, 
				r.Month_num, 
				r.Year_num, 
				r.Product_ID, 
				r.Stock_ID, 
				r.Qty_remain,
				Sum(ISNULL(s.Qty,0.00)) AS QTY_sale
INTO #turnover_rezult
 FROM #turnover_remain r 
 LEFT JOIN #turnover_Sale AS s 
													ON s.Date_Sale = r.Date
													AND s.Stock_ID = r.Stock_ID
													AND s.Product_ID = r.Product_ID

 GROUP BY  r.Date, 
				r.Day_num, 
				r.Week_num, 
				r.Month_num, 
				r.Year_num, 
				r.Product_ID, 
				r.Stock_ID, 
				r.Qty_remain
 ORDER BY  r.Date
 
 
 
 IF(@separ=0)
 BEGIN
 	
IF OBJECT_ID('tempdb..#turnover_t') IS NOT NULL DROP TABLE #t

SELECT CASE WHEN @depart IN (0,2) THEN r.Product_ID
						WHEN @depart IN (1,3) THEN 0
						ELSE 0 
       END								AS Product_ID,
			 CASE WHEN @depart IN (0,1) THEN r.Stock_ID
						WHEN @depart IN(2,3) THEN 0
						ELSE 0 
       END								AS Stock_ID,	
       SUM(Qty_remain)		AS Qty_remain,
       SUM(QTY_sale)			AS QTY_sale,
       COUNT(r.Date)			AS Count_period
INTO #turnover_t
FROM #turnover_rezult r
GROUP BY 	 CASE WHEN @depart IN (0,2) THEN r.Product_ID
						WHEN @depart IN (1,3) THEN 0
						ELSE 0 
       END,
			CASE WHEN @depart IN (0,1) THEN r.Stock_ID
						WHEN @depart IN(2,3) THEN 0
						ELSE 0 
       END
 	
 END
 
 IF(@depart = 0)
 BEGIN
 	 SELECT Product_ID, Stock_ID, QTY_sale/(Qty_remain/(Count_period-1)) AS Turnover
 	 FROM #turnover_t
 	 WHERE Qty_remain > 0
 END
 
 IF(@depart = 1)
 BEGIN
 	 SELECT Stock_ID, QTY_sale/(Qty_remain/(Count_period-1)) AS Turnover
 	 FROM #turnover_t
 	 WHERE Qty_remain > 0
 END
 
  IF(@depart = 2)
 BEGIN
 	 SELECT Product_ID, QTY_sale/(Qty_remain/(Count_period-1)) AS Turnover
 	 FROM #turnover_t
 	 WHERE Qty_remain > 0
 END
 
   IF(@depart = 3)
 BEGIN
 	 SELECT QTY_sale/(Qty_remain/(Count_period-1)) AS Turnover
 	 FROM #turnover_t
 	 WHERE Qty_remain > 0
 END
 
 
 DROP TABLE #turnover_t
 DROP TABLE #turnover_rezult
 DROP TABLE #turnover_remain
 DROP TABLE #turnover_sale
END
GO
--#endregion

--#region Product profitability 
/*
Here you can check  profitability of company at all or by each stock
parametrs you send - is = date from and date to and all stoock or some of them - you can send 0 = all, array with "," separate  = for some
 */

 CREATE PROCEDURE dbo.Get_profitability
 @date_start DATE = '20161201',
				@date_end DATE = '20170421',
				@Stocks VARCHAR(MAX) = '0',
				@Separator varchar(5) = ','
AS 
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON
SET ANSI_NULLS ON

--#region Cheking stocks 
IF OBJECT_ID('tempdb..#profitability_stocks') IS NOT NULL DROP TABLE #profitability_stocks

CREATE TABLE #profitability_stocks
(
	[Stock_ID] SMALLINT PRIMARY KEY
)

IF(@Stocks='0')
	BEGIN
	INSERT INTO #profitability_stocks([Stock_ID])
	SELECT Stock_ID FROM dbo.Stocks AS s
	END
ELSE
	BEGIN
		INSERT INTO #profitability_stocks([Stock_ID])
		Select value AS Stock_ID from dbo.GetIntTable_FromString (@Stocks,@Separator)
	END
--#endregion

	
--#region Salary for all employees
IF OBJECT_ID('tempdb..#profitability_Salary') IS NOT NULL DROP TABLE #profitability_Salary

SELECT	r.Employee_ID,
				r.Year_num,
				r.Month_num,
				e.Stock_ID,
				r.Sum_Salary_month*(count(DISTINCT r.Date)*1.00/COUNT(DISTINCT d.Date)*1.00) as Salary
INTO #profitability_Salary
FROM(
	SELECT	d.Date, 
					d.Month_num, 
					d.Year_num, 
					s.Employee_ID, 
					s.Sum_Salary_month
	FROM dbo.Dates AS d
	JOIN dbo.Salary AS s ON d.[Date] BETWEEN s.DateStart AND ISNULL(s.DateEnd, Dateadd(Year,1,GETDATE()))
	WHERE d.[Date] BETWEEN @date_start AND @date_end
) r
join dbo.Dates AS d ON d.Month_num = r.Month_num
											AND d.Year_num = r.Year_num
JOIN dbo.Employees AS e ON e.Employee_ID = r.Employee_ID
WHERE e.Stock_ID IN (SELECT ps.[Stock_ID] FROM #profitability_stocks AS ps ) 
	Group by r.Employee_ID,  
					Sum_Salary_month,
					r.Year_num,
					r.Month_num,
					e.Stock_ID
	Order by r.Employee_ID	
--#endregion

--#region Expences by stoks
IF OBJECT_ID('tempdb..#profitability_Expence') IS NOT NULL DROP TABLE #profitability_Expence

SELECT	r.Month_num, 
				r.Year_num, 
				r.Stock_ID, 
				r.COST_Month*(count(DISTINCT r.Date)*1.00/COUNT(DISTINCT d.Date)*1.00) as Expence
INTO #profitability_Expence
FROM 
(SELECT		d.Date, 
					d.Month_num, 
					d.Year_num, 
					s.Stock_ID,
					s.COST_Month
	FROM dbo.Dates AS d
	JOIN dbo.Stock_Expenses AS s ON d.[Date] BETWEEN s.DateFrom AND ISNULL(s.DateTo, Dateadd(Year,1,GETDATE()))
	WHERE d.[Date] BETWEEN @date_start AND @date_end
	AND s.Stock_ID IN (SELECT ps.[Stock_ID] FROM #profitability_stocks AS ps )
) r
join dbo.Dates AS d ON d.Month_num = r.Month_num
											AND d.Year_num = r.Year_num
GROUP BY r.Month_num, 
				r.Year_num, 
				r.Stock_ID, 
				r.COST_Month
ORDER BY r.Stock_ID
--#endregion
		
--#region Sales
IF OBJECT_ID('tempdb..#profitability_Sales') IS NOT NULL DROP TABLE #profitability_Sales


SELECT dat.Stock_ID, 
				ISNULL(SUM(dat.Qty),0)										AS Qty,
				ISNULL(SUM(dat.Sum_sale_with_tax),0)			AS Sum_sale_with_tax,
				ISNULL(SUM(dat.Sum_sale_without_tax),0)		AS Sum_sale_without_tax,
				ISNULL(SUM(pr.Cur_price),0)								AS Cur_price,
				ISNULL(SUM(dat.Sum_sale_without_tax),0) - 
				ISNULL(SUM(pr.Cur_price),0)								AS Profit
			
INTO #profitability_Sales		 
FROM (
SELECT	s.Employee_ID, 
				s.Date_Sale,
				s.Product_ID,
				s.Stock_ID,
				SUM(s.Qty) AS Qty, 
				SUM(s.Sum_Sale) AS Sum_sale_with_tax,
				SUM(s.Sum_Sale)-SUM(s.Tax*s.Sum_Sale) AS Sum_sale_without_tax
	FROM dbo.Sales AS s
	WHERE s.Date_Sale BETWEEN @date_start AND @date_end
	AND s.Employee_ID IN (SELECT [Employee_ID] FROM #profitability_stocks)
	GROUP BY s.Employee_ID, 
				s.Date_Sale,
				s.Product_ID,
				s.Stock_ID
)dat
OUTER APPLY (SELECT TOP 1 p.Cur_price
             FROM dbo.Price AS p
             WHERE p.DatePrice <= dat.Date_Sale
             AND p.Stock_ID = dat.Stock_ID
             AND p.Product_ID = dat.Product_ID
             ORDER BY p.DatePrice DESC
						) pr
GROUP BY dat.Stock_ID			

--#endregion


--#region result
SELECT	s.Stock_ID, 
				s.Stock_Name, 
				ISNULL(sale.Sum_sale_with_tax,0.00)						AS Sum_sale, 
				ISNULL(sale.Sum_sale_without_tax,0.00)				AS Sum_sale_withot_Tax,
				ISNULL(Salary.Salary,0.00)										AS Salary,
				ISNULL(Expence.Expence,0.00)									AS Expence,
				ISNULL(sale.Cur_price,0)										AS Cur_price,
				ISNULL(sale.Sum_sale_with_tax,0.00) - (ISNULL(Expence.Expence,0.00) + ISNULL(Salary.Salary,0.00) +ISNULL(sale.Cur_price,0) ) AS Total_until_tax,
				ISNULL(sale.Sum_sale_without_tax,0.00) - (ISNULL(Expence.Expence,0.00) + ISNULL(Salary.Salary,0.00)+ISNULL(sale.Cur_price,0)) AS Total_withot_Tax
FROM dbo.Stocks AS s
JOIN #profitability_stocks AS ps ON ps.Stock_ID = s.Stock_ID
LEFT JOIN #profitability_Sales sale ON sale.Stock_ID = s.Stock_ID
LEFT JOIN (SELECT			d.Stock_ID, 
											SUM(d.Salary) AS Salary
						FROM #profitability_Salary d
						GROUP BY d.Stock_ID
	) Salary ON  Salary.Stock_ID = s.Stock_ID
LEFT JOIN (SELECT	d.Stock_ID,
				SUM(d.Expence) AS Expence
				FROM #profitability_Expence d
				GROUP BY d.Stock_ID
) Expence ON Expence.Stock_ID =  s.Stock_ID
--#endregion

END
GO
--#endregion

--#region Sales by your employees

 CREATE PROCEDURE dbo.Get_Info_by_employees
   @date_start SMALLDATETIME = '20170101',
				@date_end SMALLDATETIME = '20170421',
				@Stocks VARCHAR(MAX) = '0',
				@Employees VARCHAR(MAX) = '1,2',
				@Separator VARCHAR(5) = ','

AS 
BEGIN	

SET NOCOUNT ON
SET XACT_ABORT ON
SET ANSI_NULLS ON



--#region Cheking stocks 
IF OBJECT_ID('tempdb..#Empl_info_stocks') IS NOT NULL DROP TABLE #Empl_info_stocks

CREATE TABLE #Empl_info_stocks
(
	[Stock_ID] SMALLINT PRIMARY KEY
)

IF(@Stocks='0')
	BEGIN
	INSERT INTO #Empl_info_stocks([Stock_ID])
	SELECT Stock_ID FROM dbo.Stocks AS s
	END
ELSE
	BEGIN
		INSERT INTO #Empl_info_stocks([Stock_ID])
		Select value AS Stock_ID from dbo.GetIntTable_FromString (@Stocks,@Separator)
	END
--#endregion


--#region Cheking Employees 
IF OBJECT_ID('tempdb..#Empl_info_empl') IS NOT NULL DROP TABLE #Empl_info_empl

CREATE TABLE #Empl_info_empl
(
	[Employee_ID] INT PRIMARY KEY
)

IF(@Employees='0')
	BEGIN
	INSERT INTO #Empl_info_empl([Employee_ID])
	SELECT [Employee_ID] FROM [dbo].[Employees] AS e
	END
ELSE
	BEGIN
		INSERT INTO #Empl_info_empl([Employee_ID])
		Select value AS [Employee_ID] from dbo.GetIntTable_FromString (@Employees,@Separator)
	END
--#endregion

--#region Sales by employees
IF OBJECT_ID('tempdb..#Empl_info_Sales') IS NOT NULL DROP TABLE #Empl_info_Sales
SELECT dat.Employee_ID, 
				SUM(dat.Qty)										AS Qty,
				SUM(dat.Sum_sale_with_tax)			AS Sum_sale_with_tax,
				SUM(dat.Sum_sale_without_tax)		AS Sum_sale_without_tax,
				SUM(pr.Cur_price)								AS Cur_price,
				SUM(dat.Sum_sale_without_tax) - 
				SUM(pr.Cur_price)								AS Profit
			
INTO #Empl_info_Sales		 
FROM (
SELECT	s.Employee_ID, 
				s.Date_Sale,
				s.Product_ID,
				s.Stock_ID,
				SUM(s.Qty) AS Qty, 
				SUM(s.Sum_Sale) AS Sum_sale_with_tax,
				SUM(s.Sum_Sale)-SUM(s.Tax*s.Sum_Sale) AS Sum_sale_without_tax
	FROM dbo.Sales AS s
	WHERE s.Date_Sale BETWEEN @date_start AND @date_end
	AND s.Employee_ID IN (SELECT [Employee_ID] FROM #Empl_info_empl)
	GROUP BY s.Employee_ID, 
				s.Date_Sale,
				s.Product_ID,
				s.Stock_ID
)dat
OUTER APPLY (SELECT TOP 1 p.Cur_price
             FROM dbo.Price AS p
             WHERE p.DatePrice <= dat.Date_Sale
             AND p.Stock_ID = dat.Stock_ID
             AND p.Product_ID = dat.Product_ID
             ORDER BY p.DatePrice DESC
						) pr
GROUP BY dat.Employee_ID						
	

CREATE CLUSTERED INDEX CLIX_Empl_info_Sales_ID ON #Empl_info_Sales (Employee_ID)
--#endregion


--#region Salary for all employees
IF OBJECT_ID('tempdb..#Empl_info_Salary') IS NOT NULL DROP TABLE #Empl_info_Salary

SELECT	r.Employee_ID,
				r.Year_num,
				r.Month_num,
				e.Stock_ID,
				r.Sum_Salary_month*(count(DISTINCT r.Date)*1.00/COUNT(DISTINCT d.Date)*1.00) as Salary
INTO #Empl_info_Salary
FROM(
	SELECT	d.Date, 
					d.Month_num, 
					d.Year_num, 
					s.Employee_ID, 
					s.Sum_Salary_month
	FROM dbo.Dates AS d
	JOIN dbo.Salary AS s ON d.[Date] BETWEEN s.DateStart AND ISNULL(s.DateEnd, Dateadd(Year,1,GETDATE()))
	WHERE d.[Date] BETWEEN @date_start AND @date_end
) r
join dbo.Dates AS d ON d.Month_num = r.Month_num
											AND d.Year_num = r.Year_num
JOIN dbo.Employees AS e ON e.Employee_ID = r.Employee_ID
WHERE e.Stock_ID IN (SELECT ps.[Stock_ID] FROM #Empl_info_stocks AS ps ) 
	Group by r.Employee_ID,  
					Sum_Salary_month,
					r.Year_num,
					r.Month_num,
					e.Stock_ID
	Order by r.Employee_ID	
--#endregion


--#region TimeSheet of employees
IF OBJECT_ID('tempdb..#Empl_info_TimeSheet') IS NOT NULL DROP TABLE #Empl_info_TimeSheet

SELECT	t.Employee_ID, 
				iSNULL(SUM(t.Hours_work),0) AS Sum_Hour_Work,
				iSNULL(SUM(CASE WHEN Is_Wacation = 0 then t.Hours_need END),0)	AS Sum_Hour_need,
				COUNT(Distinct (CASE WHEN t.Hours_work*1.00/
				(CASE WHEN isnull(t.Hours_need,0) = 0 THEN 1 ELSE t.Hours_need END)*1.00>=0.8 
				AND t.Is_Wacation = 0 THEN t.Date_Report END)) AS Count_dates_work,
				COUNT(DISTINCT (case when Hours_need >0 and Is_Wacation = 0 then t.Date_Report END)) AS  Count_dates_Needs
INTO #Empl_info_TimeSheet
FROM dbo.Timesheet AS t
WHERE t. Date_Report BETWEEN @date_start AND @date_end
AND t.Employee_ID IN (SELECT ps.[Stock_ID] FROM #Empl_info_stocks AS ps)
GROUP BY t.Employee_ID
--#endregion 

--#region Rezult
SELECT	s.Stock_ID,
				s2.Stock_Name,
				e.Employee_ID,
				e.Name + ' ' + e.Surname									AS FullName,
				p.Position_Name,
				p.Divisions,
				es.Employee_Sate_Name,
				ISNULL(sale.Qty,0)												AS Qty, 
				ISNULL(sale.Sum_sale_with_tax,0)					AS Sum_sale_with_tax, 
				ISNULL(sale.Sum_sale_without_tax,0)				AS Sum_sale_without_tax,
				ISNULL(sale.Cur_price,0)									AS Cur_price, 
				ISNULL(sale.Profit,0)											AS Profit,
				ISNULL(salar.Salary,0)										AS Salary,
				ISNULL(sale.Profit,0) -
				  ISNULL(salar.Salary,0)									AS Rezult_without_salary,
				ISNULL(ts.Sum_Hour_Work,0)								AS Sum_Hour_Work,
				ISNULL(ts.Sum_Hour_need, 0)								AS Sum_Hour_need,
				ISNULL(ts.Count_dates_work, 0)						AS Count_dates_work,
				ISNULL(ts.Count_dates_Needs,0)						AS Count_dates_Needs
FROM dbo.Employees AS e 
JOIN #Empl_info_empl ee ON ee.Employee_ID = e.Employee_ID
JOIN #Empl_info_stocks s ON s.Stock_ID = e.Stock_ID
JOIN dbo.Stocks AS s2 ON s2.Stock_ID = s.Stock_ID
JOIN dbo.Positions AS p ON p.Position_ID = e.Position_ID
JOIN dbo.Employee_Sate AS es ON e.Employee_Sate_ID = es.Employee_Sate_ID
LEFT JOIN #Empl_info_Sales sale ON sale.Employee_ID = e.Employee_ID 
LEFT JOIN	(SELECT		
						d.Employee_ID,
											SUM(d.Salary) AS Salary
						FROM #Empl_info_Salary d
						GROUP BY d.Employee_ID
					) AS salar ON salar.Employee_ID = e.Employee_ID
LEFT JOIN #Empl_info_TimeSheet ts ON ts.Employee_ID = e.Employee_ID
--#endtrgion 
END

--#endregion
--#endregion

--#endregion Procedures Create



