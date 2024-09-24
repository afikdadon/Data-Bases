DROP TABLE CUSTOMIZED_FOR
DROP TABLE CUSTOMIZES
DROP TABLE [CUSTOMIZES TYPES]
DROP TABLE AROMAS
DROP TABLE SHIMMERS
DROP TABLE FORMULAS
DROP TABLE PRODUCTS
DROP TABLE [PROUDUCTS TYPES]
DROP TABLE COLORS
DROP TABLE ORDERS
DROP TABLE [CREDIT CARDS]
DROP TABLE [SHIPPING METHOD]
DROP TABLE SEARCHES
DROP TABLE USERS 
DROP TABLE COUNTRIES
DROP TABLE CUSTOMERS


CREATE	TABLE CUSTOMERS (
	Email			Varchar(50)		NOT NULL,
	[First Name]	Varchar (15)	NOT NULL,
	[Last Name]		Varchar(15)		NOT NULL,
	Phone			Char(10)		NOT NULL

	CONSTRAINT PK_CUSTOMERS
	PRIMARY KEY (Email),

	CONSTRAINT CK_EMAIL CHECK (Email Like '%@%.%'),
	CONSTRAINT CK_PHONE CHECK (Phone Like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)


CREATE	TABLE	[CREDIT CARDS] (
	[Card Number]		Varchar(16)			NOT NULL,
	Email				Varchar(50),
	[Year Expiration]	Int		NOT NULL,
	[Month Expiration]	Int		NOT NULL,
	CVC					Char(3)		NOT NULL

	CONSTRAINT PK_CREDIT_CARDS
	PRIMARY KEY ([Card Number]),

	CONSTRAINT fk_CUSTOMERS_TO_CREDIT_CARDS
	FOREIGN KEY (Email)
	REFERENCES CUSTOMERS(Email),

	CONSTRAINT CK_Card_Number CHECK (Len ([Card Number])=16),
	CONSTRAINT CK_Year_Exp CHECK (year(getdate())<[Year Expiration] OR year(getdate())= [Year Expiration] AND month(getdate())<=[Month Expiration]),
	CONSTRAINT CK_Month_Exp CHECK ([Month Expiration] BETWEEN 1 AND 12),
	CONSTRAINT CK_CVC CHECK (Len (CVC)= 3)
)


CREATE	TABLE	USERS (
	[User Email]	Varchar(50)		NOT NULL,
	[Password]		Varchar(20)		NOT NULL,
	Country			Varchar (30)	NOT NULL,
	City			Varchar (20)	NOT NULL,
	Street			Varchar (20)	NOT NULL,
	Apartment		Varchar (5),
	[Zip Code]		Int				NOT NULL

	CONSTRAINT PK_USERS
	PRIMARY KEY ([User Email])

	CONSTRAINT fk_CUSTOMERS_TO_USERS
	FOREIGN KEY ([User Email])
	REFERENCES CUSTOMERS(Email),

	CONSTRAINT CK_Password CHECK (Len ([Password])>=5),
	CONSTRAINT CK_City_USERES CHECK (City NOT LIKE '%[^A-Z \t]%')
)


CREATE	TABLE	SEARCHES (
	[Search DT]		datetime		NOT NULL,
	[IP Address]	Varchar(30)		NOT NULL,
	Content			Varchar(60),
	Email			Varchar(50)

	CONSTRAINT PK_SEARCHES
	PRIMARY KEY ([Search DT], [IP Address]),

	CONSTRAINT fk_CUSTOMERS_TO_SEARCHES
	FOREIGN KEY (Email)
	REFERENCES CUSTOMERS(Email),

	CONSTRAINT CK_IP_Address CHECK ([IP Address] lIKE '%.%.%.%')
)


CREATE	TABLE	ORDERS (
	[Order ID]		Int				NOT NULL,
	[Order Date]	date,
	[Shipping Method] Varchar(45)	NOT NULL,
	Country			Varchar (30)	NOT NULL,
	City			Varchar (20)	NOT NULL,
	Street			Varchar (20)	NOT NULL,
	Apartment		Varchar (5),
	[Zip Code]		Int				NOT NULL,
	[Card Number]	Varchar(16)		NOT NULL,
	[Search DT]		DateTime		NOT NULL,
	[IP Address]	Varchar(30)		NOT NULL



	CONSTRAINT PK_ORDERS
	PRIMARY KEY ([Order ID]),

	CONSTRAINT fk_CREDIT_CARDS_TO_ORDERS
	FOREIGN KEY ([Card Number])
	REFERENCES [CREDIT CARDS]([Card Number]),

	CONSTRAINT fk_SEARCHES_TO_ORDERS
	FOREIGN KEY ([Search DT], [IP Address])
	REFERENCES SEARCHES([Search DT], [IP Address]),

	CONSTRAINT CK_City_ORDERS CHECK (City NOT LIKE '%[^A-Z \t]%')
)


CREATE	TABLE	PRODUCTS (
	Product			Varchar(24)		NOT NULL,
	Color			Varchar(40)		NOT NULL,
	Price			Money			NOT NULL

	CONSTRAINT PK_PRODUCTS
	PRIMARY KEY (Product,Color)

	CONSTRAINT CK_Price CHECK (Price>0)
)


CREATE TABLE CUSTOMIZES (
	Product Varchar (24) NOT NULL,
	Color Varchar (40) NOT NULL,
	[Serial Number] INT NOT NULL,
	Formula Varchar (5),
	Shimmer Varchar (5),
	Aroma Varchar (10),
	Additives Varchar (7),
	Customize Varchar (24)

	CONSTRAINT PK_CUSTOMIZES
	PRIMARY KEY (Product,Color,[Serial Number]),
	CONSTRAINT fk_PRODUCTS_AND_COLOR_TO_CUSTOMIZES
	FOREIGN KEY (Product,Color)
	REFERENCES PRODUCTS (Product,Color),

	CONSTRAINT CK_Additives CHECK (Additives = 'CBD/CBG')
)

	
CREATE	TABLE	CUSTOMIZED_FOR (
	Product				Varchar(24)		NOT NULL,
	Color				Varchar(40)		NOT NULL,
	[Serial Number]		Int				NOT NULL,
	[Order ID]			Int				NOT NULL

	CONSTRAINT PK_CUSTOMIZED_FOR
	PRIMARY KEY ([Serial Number],Product,Color, [Order ID]),

	CONSTRAINT fk_CUSTOMIZES_TO_CUSTOMIZED_FOR
	FOREIGN KEY (Product, Color, [Serial Number])
	REFERENCES CUSTOMIZES(Product, Color, [Serial Number]),

	CONSTRAINT fk_ORDERS_TO_CUSTOMIZED_FOR
	FOREIGN KEY ([Order ID])
	REFERENCES ORDERS([Order ID])
)
	
CREATE TABLE COUNTRIES(
	[Country Name]		varchar(30)		PRIMARY KEY	 NOT NULL
)	 
	  
INSERT INTO COUNTRIES VALUES
    ('Afghanistan'),('Albania'),('Algeria'),('Argentina'),
    ('Armenia'),('Australia'),('Austria'),('Bangladesh'),('Belarus'),
    ('Belgium'),('Bermuda'),('Bhutan'),('Bolivia'),('Bosnia and Herzegovina'),
    ('Brazil'),('Bulgaria'),('Cambodia'),('Canada'),('Central African Republic'),
    ('Chad'),('Chile'),('China'),('Colombia'),('Costa Rica'),('Croatia'),
    ('Cuba'),('Cyprus'),('Czech Republic'),
    ('Denmark'),('Dominican Republic'),('Ecuador'),('Egypt'),('El Salvador'),('Eritrea'),
    ('Estonia'),('Ethiopia'),('Fiji'),('Finland'),('France'),('French Guiana'),('French Polynesia'),
    ('Georgia'),('Germany'),('Greece'),('Greenland'),('Guatemala'),('Guinea'),('Honduras'),('Hong Kong'),
    ('Hungary'),('Iceland'),('India'),('Indonesia'),('Iran'),('Iraq'),('Ireland'),('Israel'),('Italy'),
    ('Jamaica'),('Japan'),('Jordan'),('Laos'),('Latvia'),('Lebanon'),('Libya'),('Macedonia'),('Madagascar'),
    ('Malawi'),('Malaysia'),('Maldives'),('Mali'),('Malta'),('Mexico'),('Morocco'),('Netherlands'),('New Zealand'),
	('Nicaragua'),('Nigeria'),('North Korea'),('Norway'),('Pakistan'),('Paraguay'),('Peru'),('Philippines'),('Poland'),
	('Portugal'),('Puerto Rico'),('Qatar'),('Romania'),('Russia'),('Saudi Arabia'),('Singapore'),('Slovakia'),('Slovenia'),
	('South Africa'),('South Korea'),('Spain'),('Sri Lanka'),('Swaziland'),('Sweden'),('Switzerland'),('Syria'),('Taiwan'),
	('Thailand'),('Tunisia'),('Turkey'),('Ukraine'),('United Arab Emirates'),('United Kingdom'),('United States'),('Uruguay'),
	('Venezuela'),('Vietnam'),('Yemen')
	 
	 ALTER TABLE USERS 
	 ADD CONSTRAINT FK_USERS_TO_COUNTRIES 
	 FOREIGN KEY (Country) 
	 REFERENCES COUNTRIES([Country Name])

	 ALTER TABLE ORDERS 
	 ADD CONSTRAINT FK_ORDERS_TO_COUNTRIES 
	 FOREIGN KEY (Country) 
	 REFERENCES COUNTRIES([Country Name])

	
CREATE	TABLE [PROUDUCTS TYPES] (
	[Product Type]  Varchar(24)		PRIMARY KEY	 NOT NULL
)

INSERT INTO [PROUDUCTS TYPES] VALUES 
	('GET GLOSSED Lip Gloss'),('Lipstick'),('Liquid Foundation'),('Cream Foundation Compact'),('Concealer')

	ALTER TABLE PRODUCTS
	ADD CONSTRAINT FK_PROUDUCTS_TYPES
	FOREIGN KEY (Product)
	REFERENCES [PROUDUCTS TYPES]([Product Type])
	

CREATE	TABLE [SHIPPING METHOD](
	[Shipping Method]  Varchar(45)	PRIMARY KEY	 NOT NULL
)

INSERT INTO [SHIPPING METHOD] VALUES 
	('Standard Shipping'),('Express Shipping')

	ALTER TABLE ORDERS
	ADD CONSTRAINT FK_SHIPPING_METHOD
	FOREIGN KEY ([Shipping Method])
	REFERENCES [SHIPPING METHOD]([Shipping Method])

	
CREATE	TABLE COLORS(
	Color		Varchar(40)		PRIMARY KEY	 NOT NULL
)

INSERT INTO COLORS VALUES 
	('Love(LG)'),('Tulip(LG)'),('Luscious(LG)'),('Gerber Daisy(LG)'),('Firecracker(LG)'),('Classic Red'),('Dollface'),
	('Naked'),('Flossy'),('Bombshell'),('Rose Quartz'),('Daiquiri'),('Rizzo(LG)'),('Sugar&Spice'),('Soho'),
	('Siret(LG)'),('Feeling it(LG)'),('Blushing Bride(LG)'),('Pinch My Lips'),('Pinkstone(LG)'),('Peachy'),('Foxy'),
	('Amethyst'),('Merlot'),('Besos'),('Allure'),('Cardinal'),('Moon Walk(LG)'),('Champagne Sparkle'),
	('Holiday Rose'),('Christmas Red'),('Sculpture'),('Rocket Red'),('Chianti'),('Katrina'),('Tulip'),('BailonBesos'),
	('Natallia Lipstick'),('Blanco'),('Pinkberry'),('Alison'),('Rose Gold'),('Rose Pop Lipstick'),('Undress'),
	('Patty'),('Erica'),('Lori'),('Spicy Mauve Lipstick'),('Bangs Lipstick'),('Keris Kiss'),('Faye'),
	('Pink Shine Lipstick'),('Mario Pinched My Lips'),('Glum Plum Lipstick'),('African Violet'),('1 Blue (FAIR) LF'),
	('2 Blue (FAIR) LF'),('3 Tan (LIGHT) LF'),('3 Blue (FAIR) LF'),('4 Tan (LIGHT) LF'),('4 Blue (LIGHT) LF'),
	('5 Tan (MEDIUM) LF'),('5 Blue (MEDIUM) LF'),('6 Blue (MEDIUM) LF'),('6 Tan (MEDIUM) LF'),('8 Blue (MEDIUM) LF'),
	('10 Blue (MEDIUM) LF'),('10 Tan (DARK) LF'),('12 Blue (DARK) LF'),('14 Umber (DARK) LF'),('16 Umber (DARK) LF'),
	('18 Umber (DARK) LF'),('1 Blue (FAIR) CF'),('2 Blue (FAIR) CF'),('3 Tan (LIGHT) CF'),('3 Blue (FAIR) CF'),
	('4 Tan (LIGHT) CF'),('4 Blue (LIGHT) CF'),('5 Tan (MEDIUM) CF'),('5 Blue (MEDIUM) CF'),('6 Blue (MEDIUM) CF'),
	('6 Tan (MEDIUM) CF'),('8 Blue (MEDIUM) CF'),('10 Blue (MEDIUM) CF'),('10 Tan (DARK) CF'),('12 Blue (DARK) CF'),
	('14 Umber (DARK) CF'),('16 Umber (DARK) CF'), ('18 Umber (DARK) CF'),('Banana (1-FAIR)'),('Ivory (2-FAIR)'),
	('Ivory Beige (23 2, 13 3 -FAIR)'),('Light Olive (23 – LIGHT)'), ('Peachy (2 Peach – LIGHT)'),
	('Medium Olive (23 3, 13 2 – MEDIUM)'),('Olive (3 – DARK)'),('Mocha (3 Umber – DARK)')

	ALTER TABLE PRODUCTS
	ADD CONSTRAINT FK_COLORS
	FOREIGN KEY (Color)
	REFERENCES COLORS(Color)


CREATE	TABLE FORMULAS(
	Formula		Varchar(5)		PRIMARY KEY	 NOT NULL
)

INSERT INTO FORMULAS VALUES 
	('SHEER'),('FULL'),('MATTE'),('CREAM')

	ALTER TABLE CUSTOMIZES
	ADD CONSTRAINT FK_FORMULAS
	FOREIGN KEY (Formula)
	REFERENCES FORMULAS (Formula)
	


CREATE	TABLE SHIMMERS(
	Shimmer		Varchar(5)		PRIMARY KEY	 NOT NULL
)

INSERT INTO SHIMMERS VALUES 
	('GOLD'),('PINK'),('WHITE'),('NONE')

	ALTER TABLE CUSTOMIZES
	ADD CONSTRAINT FK_SHIMMERS
	FOREIGN KEY (Shimmer)
	REFERENCES SHIMMERS (Shimmer)


	
CREATE	TABLE AROMAS(
	Aroma		Varchar(10)		PRIMARY KEY	 NOT NULL
)

INSERT INTO AROMAS VALUES 
	('STRAWBERRY'),('VANILLA'),('PEPPERMINT'),('GRAPEFRUIT'),('NONE')

	ALTER TABLE CUSTOMIZES
	ADD CONSTRAINT FK_AROMAS
	FOREIGN KEY (Aroma)
	REFERENCES AROMAS (Aroma)
	
	
CREATE	TABLE [CUSTOMIZES TYPES](
	[Customize Types]		Varchar(24)		PRIMARY KEY	 NOT NULL
)

INSERT INTO [CUSTOMIZES TYPES] VALUES 
	('TEA TREE'),('SHEA BUTTER'),('OIL CONTROL'),('OIL CONTROL & TEA TREE'),('ANTI-AGING'),('OIL CONTROL & ANTI-AGING'),('NONE')

	ALTER TABLE CUSTOMIZES
	ADD CONSTRAINT FK_CUSTOMIZES_TYPES
	FOREIGN KEY (Customize)
	REFERENCES [CUSTOMIZES TYPES] ([Customize Types])


-------------------------- PART 1 --------------------------

	
--return the top 2 products that order in 2022 after search
SELECT	 TOP 2		Product,
					Order_Quantity = COUNT (distinct O.[Order ID])
FROM				ORDERS AS O JOIN SEARCHES AS S 
					ON YEAR(O.[Search DT]) = YEAR(S.[Search DT]) AND O.[IP Address]= S.[IP Address] JOIN CUSTOMIZED_FOR AS CF
					ON O.[Order ID] = CF.[Order ID]
WHERE				YEAR (O.[Order Date]) = 2022
GROUP BY			CF.Product
ORDER BY			Order_Quantity DESC

	
-- return the customers that order more than 15 lips products
SELECT				City,
					Order_Quantity = COUNT (O.[City]),
					Lip_Quantity = COUNT (*),
					[First Name],
					C.Email, 
					Phone
FROM				CUSTOMIZED_FOR AS CF JOIN ORDERS AS O
					ON CF.[Order ID] = O.[Order ID] JOIN [CREDIT CARDS]AS CC
					ON O.[Card Number] = CC.[Card Number] JOIN CUSTOMERS AS C
					ON CC.Email = C.Email
WHERE				CF.Product = 'GET GLOSSED Lip Gloss' OR CF.Product = 'Lipstick'
GROUP BY			O.City , C.Email, C.[First Name], C.Phone
HAVING				count (*) >15
ORDER BY			Order_Quantity DESC


-- return the diffrences between the number of sales in 2021(T_O = 2021) and 2022 (T_T = 2022) 
SELECT				T_T.Product,
					Product_QuantityTT,
					Product_QuantityTO,
					GAP = Product_QuantityTT- COALESCE(Product_QuantityTO,0)
FROM(
					SELECT				Product,
										Product_QuantityTT = count (CF.Product) 
					FROM ORDERS AS O JOIN CUSTOMIZED_FOR AS CF
					ON O.[Order ID] = CF.[Order ID]
					WHERE YEAR (O.[Order Date]) = 2022
					GROUP BY CF.Product
					) 
					AS T_T LEFT JOIN
					(
					SELECT				Product,
										Product_QuantityTO = count (CF.Product) 
					FROM ORDERS AS O JOIN CUSTOMIZED_FOR AS CF
					ON O.[Order ID] = CF.[Order ID]
					WHERE YEAR (O.[Order Date]) = 2021
					GROUP BY Product
					)
					AS T_O
					ON T_O.Product = T_T.Product
ORDER BY			GAP DESC


-- return the new users that order in 2022
SELECT	DISTINCT	U.[User Email]
FROM				USERS AS U JOIN [CREDIT CARDS] AS CC
					ON U.[User Email] = CC.Email JOIN ORDERS AS O
					ON CC.[Card Number] = O.[Card Number]
WHERE				YEAR(O.[Order Date]) > 2021 and U.[User Email] NOT IN (	
						SELECT U.[User Email]
						FROM USERS AS U JOIN [CREDIT CARDS] AS CC
						ON U.[User Email] = CC.Email JOIN ORDERS AS O
						ON CC.[Card Number] = O.[Card Number]
						WHERE YEAR(O.[Order Date]) < 2022
						GROUP BY U.[User Email])


-- update the price of top 2 best sellers to be 10% more	 
UPDATE			PRODUCTS
SET				Price = Price*1.1
WHERE			Product IN (
					SELECT	 TOP 2		Product
					FROM				ORDERS AS O JOIN SEARCHES AS S 
										ON YEAR(O.[Search DT]) = YEAR(S.[Search DT]) AND O.[IP Address]= S.[IP Address] JOIN CUSTOMIZED_FOR AS CF
										ON O.[Order ID] = CF.[Order ID]
					WHERE				YEAR (O.[Order Date]) = 2022
					GROUP BY			CF.Product)


-- returns all customers who ordered more than once and are not users that live in United States 
SELECT			C.EMAIL		
FROM			CUSTOMERS AS C JOIN [CREDIT CARDS] AS CC
				ON C.Email = CC.Email JOIN ORDERS AS O
				ON CC.[Card Number] = O.[Card Number]
WHERE			YEAR (O.[Order Date]) = 2022
GROUP BY		C.Email
HAVING			COUNT (DISTINCT O.[Order ID]) >1
	
EXCEPT

SELECT			U.[User Email]
FROM			USERS AS U JOIN [CREDIT CARDS] AS CC
				ON U.[User Email] = CC.Email JOIN ORDERS AS O
				ON CC.[Card Number] = O.[Card Number]
WHERE			YEAR (O.[Order Date]) = 2022 AND U.Country = 'United States'
GROUP BY		U.[User Email]

	 

-------------------------- PART 2 --------------------------

-- VIEW - return list of all the users with `low` password
DROP VIEW Password_Check	 
CREATE VIEW		Password_Check AS 
SELECT			U.[User Email]
FROM			USERS as U
WHERE			LEN(U.[Password]) <=8 OR (U.[Password] NOT LIKE '%[0-9]%' AND  U.[Password] NOT LIKE '%[A-Za-z]%')
	
SELECT *
FROM Password_Check


--FUNCTION - return the top 15 searchers content by selected date
DROP FUNCTION	TOP_15_SEARCHES
CREATE FUNCTION TOP_15_SEARCHES(@searchDT date)
RETURNS TABLE AS 
RETURN
SELECT			TOP 15 S.Content as Content, count(distinct S.[Search DT]) as [Searches]
FROM			SEARCHES as S
WHERE			DATEDIFF(mm,[Search DT] ,@searchDT) < 4
GROUP BY		S.Content
ORDER BY		Searches desc

SELECT   * 
FROM dbo.TOP_15_SEARCHES ('2022-06-23')


--TRIGGER - update the num of products for evrey order
ALTER TABLE ORDERS add numOfProducts int

DROP TRIGGER TRIGGER_UpdateNumOfProducts
CREATE TRIGGER TRIGGER_UpdateNumOfProducts
ON CUSTOMIZED_FOR
FOR INSERT
AS
UPDATE			ORDERS
SET				NumOfProducts = (
							SELECT	COUNT(*)
							FROM CUSTOMIZED_FOR AS CF
							WHERE	ORDERS.[Order ID] = CF.[Order ID])

INSERT INTO CUSTOMIZED_FOR VALUES ('GET GLOSSED Lip Gloss', 'Tulip(LG)',476,539, 25)
SELECT *
FROM ORDERS
ORDER BY 4 DESC



-------------------------- PART 3 --------------------------

-- show the most popular serchers for each country
DROP VIEW VIEW_SEARCHES
CREATE	VIEW	VIEW_SEARCHES AS 
SELECT			O.Country, 
				S.Content,
				[NUMBER OF SEARCHES] = COUNT(*)
FROM			SEARCHES AS S JOIN ORDERS AS O ON S.[Search DT] = O.[Search DT] AND S.[IP Address]=O.[IP Address]
GROUP BY		O.Country, S.Content
HAVING			COUNT(*)>1

SELECT *
FROM VIEW_SEARCHES


-- sales data for each country 
DROP VIEW SALES_BY_COUNTRY
CREATE VIEW SALES_BY_COUNTRY AS
SELECT			O.Country,
				SALES = COUNT(*), 
				TOTAL = SUM(O.PriceOrder)
FROM			CUSTOMERS AS C JOIN [CREDIT CARDS] AS CC
				ON C.Email = CC.Email JOIN ORDERS AS O
				ON CC.[Card Number]= O.[Card Number]
GROUP BY O.Country

SELECT *
FROM SALES_BY_COUNTRY
ORDER BY SALES_BY_COUNTRY.SALES DESC


-- return the total amount for each product
DROP VIEW VIEW_PRODUCT_QUANTITY
CREATE VIEW VIEW_PRODUCT_QUANTITY AS 
SELECT		O.Country, 
			CF.Product, 
			[Total Amount] = COUNT( CF.Product) 
FROM		ORDERS AS O 
LEFT JOIN 	CUSTOMIZED_FOR AS CF 
ON 			O.[Order ID] = CF.[Order ID]
GROUP BY	O.Country, cf.Product

SELECT *
FROM VIEW_PRODUCT_QUANTITY
ORDER BY VIEW_PRODUCT_QUANTITY.Country asc

-- return all customers and all returning customers
DROP VIEW RETURN_CUSTOMERS
CREATE VIEW RETURN_CUSTOMERS AS
SELECT	 T.Country,
		[RETURN CUSTOMER] = T.TOTAL, 
		[NUMBER OF CUSTOMERS] = COUNT(*)
FROM
(	SELECT		O.Country, 
				C.Email,
				TOTAL  = COUNT(*)
	FROM		[CREDIT CARDS] AS CC JOIN ORDERS AS O
				ON CC.[Card Number]= O.[Card Number] JOIN CUSTOMERS AS C
				ON CC.Email= C.Email
	GROUP BY	O.Country, C.Email
	) AS T

GROUP BY t.country, t.total
HAVING COUNT(*) > 1

SELECT *
FROM RETURN_CUSTOMERS

-- add tatget of sales for each country
ALTER TABLE COUNTRIES  ADD [TARGET OF SALES] MONEY 
 
UPDATE COUNTRIES  SET  [TARGET OF SALES] =  abs(checksum(newid())%1000) 

UPDATE COUNTRIES  SET [TARGET OF SALES] = 555
		WHERE [Country Name] = 'Fiji'

--for each country where orders were placed, return the number of orders and the target order
DROP VIEW SALES_DATA_COUNTRY
CREATE VIEW SALES_DATA_COUNTRY as
SELECT		O.Country,
			C.[TARGET OF SALES],
			[Sales Data] =SUM(O.PriceOrder)
FROM		ORDERS AS O JOIN COUNTRIES AS C
			ON C.[Country Name] = O.Country
GROUP BY	O.Country, C.[TARGET OF SALES]

SELECT *
FROM SALES_DATA_COUNTRY
ORDER BY SALES_DATA_COUNTRY.[Sales Data] desc


-- number of searches by month
DROP VIEW SEARCHES_BY_MONTH
CREATE VIEW  SEARCHES_BY_MONTH AS
SELECT		Month = FORMAT ([Search DT],'yyyy-MM'),
			[Number Of Searches] = COUNT(*) 
FROM		SEARCHES
GROUP BY	FORMAT ([Search DT],'yyyy-MM')

SELECT *
FROM SEARCHES_BY_MONTH


--number of sales by month
DROP VIEW SALES_BY_MONTH
CREATE VIEW SALES_BY_MONTH AS
SELECT		[Date] = FORMAT(O.[Order Date],'yyyy-MM'),
			CF.Product,
			[Number of Orders] = COUNT(*),
			[Revenues] = SUM(CF.ProductPrice)
FROM		ORDERS AS O JOIN CUSTOMIZED_FOR AS CF
			ON O.[Order ID] = CF.[Order ID]
GROUP BY	FORMAT(O.[Order Date],'yyyy-MM'), cf.Product

SELECT *
FROM SALES_BY_MONTH




-------------------------- PART 4 --------------------------

--WINDOW FUNCTIONS - NTILE, SUM --> divides the customers into decimals according to their income to the company
SELECT			*,
				Decile = NTILE (10) OVER (ORDER BY [TOTAL_SALES ($)]) 
FROM(
				SELECT	C.Email,
						[TOTAL_SALES ($)] = SUM(DISTINCT P.Price)
				FROM	CUSTOMERS AS C JOIN [CREDIT CARDS] AS CC
						ON C.Email = CC.Email JOIN ORDERS AS O
						ON CC.[Card Number] = O.[Card Number] JOIN CUSTOMIZED_FOR AS CF
						ON O.[Order ID] = CF.[Order ID] JOIN PRODUCTS AS P
						ON CF.Product = P.Product
				GROUP BY C.Email, P.Price
				) AS TOTAL_SALES

 ORDER BY		Decile DESC , [TOTAL_SALES ($)] DESC


 --WINDOW FUNCTIONS - COUNT, MIN --> returns the least sold color in the selected year

 -- return the order quantity by year for any color
DROP FUNCTION	Order_Quantity_By_Year
CREATE FUNCTION Order_Quantity_By_Year(@year Int)
RETURNS TABLE AS 
RETURN
SELECT		P.Color,
			Order_Quantity = COALESCE((SELECT COUNT (CF.COLOR)
										FROM CUSTOMIZED_FOR AS CF JOIN ORDERS AS O
										ON O.[Order ID] = CF.[Order ID]
										WHERE CF.Color = P. COLOR AND YEAR(O.[Order Date]) =@year),0)

FROM		PRODUCTS AS P 


SELECT	TOP 1		[YEAR] = '2022',
					color,					
					Order_Quantity = MIN(Order_Quantity) over( PARTITION  by Order_Quantity)
FROM dbo.Order_Quantity_By_Year ('2022') AS [2022 YEAR]


----A combination of several tools---

								
-- Add the new column to the CUSTOMIZED_FOR table
ALTER TABLE CUSTOMIZED_FOR ADD ProductPrice decimal(18,2)

-- Update the new column with the price from the PRODUCTS table
UPDATE CF
SET CF.ProductPrice = P.Price
FROM CUSTOMIZED_FOR CF
INNER JOIN PRODUCTS P ON CF.Product = P.Product


--TRIGGER - update the price of the order
ALTER TABLE ORDERS add PriceOrder FLOAT

DROP TRIGGER TRIGGER_UpdatePriceOrder
CREATE TRIGGER TRIGGER_UpdatePriceOrder
ON CUSTOMIZED_FOR
FOR INSERT
AS
UPDATE			ORDERS
SET				PriceOrder = (
								SELECT SUM(  CF.ProductPrice)
								FROM CUSTOMIZED_FOR AS CF
								WHERE ORDERS.[Order ID] = CF.[Order ID]
							)

INSERT INTO CUSTOMIZED_FOR VALUES ('Cream Foundation Compact', '12 Blue (DARK) CF',655,233,50)
	
SELECT *
FROM ORDERS
ORDER BY 4 DESC


--united customer to his orders
DROP VIEW	CUSTOMERS_ORDERS
CREATE VIEW CUSTOMERS_ORDERS AS
 SELECT		C.Email,
			O.Country,
			O.[Order ID],
			O.[Order Date],
			O.NumOfProducts,
			O.PriceOrder
FROM		CUSTOMERS AS C JOIN [CREDIT CARDS] AS CC 
		ON C.Email = CC.Email JOIN ORDERS AS O
ON CC.[Card Number] = O.[Card Number]


SELECT  *
FROM CUSTOMERS_ORDERS

--retun the number of orders for any country by selected year
DROP FUNCTION	Orders_Number_Country_ByYear
CREATE FUNCTION Orders_Number_Country_ByYear (@year int)
RETURNS TABLE
AS RETURN
SELECT		O.Country,
			[Numer of Orders] = count(*)
FROM		CUSTOMERS AS C JOIN [CREDIT CARDS] AS CC 
			ON C.Email = CC.Email JOIN ORDERS AS O
			ON CC.[Card Number] = O.[Card Number]
WHERE		YEAR(O.[Order Date]) = @year
GROUP BY	O.Country


SELECT   * 
FROM dbo.Orders_Number_Country_ByYear ('2022')


--Calculation the yearly growth and sales cycle for each country
DROP FUNCTION Yearly_Growth_Sales_Country
CREATE FUNCTION Yearly_Growth_Sales_Country (@year int) 
RETURNS TABLE 
AS
RETURN

SELECT		T.Country,
			[revenue] = T.revenue,
			[growth (%)] = round((T.revenue-R.revenue)/R.revenue,2)*100
FROM(
		SELECT		CO.Country,
					YEAR = YEAR(CO.[Order Date]),
					REVENUE = SUM(CO.PriceOrder)
		FROM		CUSTOMERS_ORDERS AS CO
		WHERE		YEAR(CO.[Order Date]) = @year
		GROUP BY	CO.Country, YEAR (CO.[Order Date]) 
		)
		AS T,
		(
		SELECT		CO.Country,
					YEAR = YEAR(CO.[Order Date]),
					REVENUE = SUM(CO.PriceOrder)
		FROM		CUSTOMERS_ORDERS AS CO
		WHERE		YEAR(CO.[Order Date]) = (@year-1)
		GROUP BY	CO.Country, YEAR (CO.[Order Date])
		) AS R
WHERE T.Country = R.Country

SELECT   * 
FROM dbo.Yearly_Growth_Sales_Country ('2022')


-- print all the data for the conclusion table
DROP FUNCTION Yearly_Report
CREATE FUNCTION Yearly_Report(@year int)
RETURNS TABLE 
AS RETURN
SELECT		G.country,
			[Order Quantity] =O.[Numer of Orders],
			[revenue ($)] =G.[revenue],	
			G.[growth (%)],
			[avarage purches ($)] = round([revenue]/O.[Numer of Orders],2)
FROM		Yearly_Growth_Sales_Country (@year) as G JOIN  Orders_Number_Country_ByYear (@year) AS O
			ON G.Country = O.Country JOIN (
											SELECT CO.Country
											FROM CUSTOMERS_ORDERS AS CO
											WHERE YEAR(CO.[Order Date])= @year and CO.[Order ID] IN(
																									SELECT O.[Order ID]
																									FROM ORDERS AS O)
																									GROUP BY Country
													
											)AS CO ON CO.Country = G.Country 

SELECT   * 
FROM dbo.Yearly_Report ('2022') 