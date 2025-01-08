USE  AdventureWorksDW;
/*1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?*/
SELECT ProductKey
FROM dimproduct p
GROUP BY ProductKey
HAVING COUNT(*) > 1;
-- Soluzione alternativa
DESCRIBE dimproduct;

/*2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.*/
-- factresellersales
SELECT SalesOrderNumber, SalesOrderLineNumber
FROM factresellersales
GROUP BY 1,2
HAVING COUNT(*) > 1;
-- factinternetsales
SELECT SalesOrderNumber, SalesOrderLineNumber
FROM factinternetsales
GROUP BY 1,2
HAVING COUNT(*) > 1;

/*3. Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.*/
WITH total_sales AS (
SELECT 'frs' as channel,
frs.SalesOrderNumber,
frs.SalesOrderLineNumber,
frs.OrderDate,
frs.ProductKey,
frs.OrderQuantity,
frs.UnitPrice,
frs.TotalProductCost,
frs.SalesAmount
FROM factresellersales frs
UNION
SELECT 'fis' as channel,
fis.SalesOrderNumber,
fis.SalesOrderLineNumber,
fis.OrderDate,
fis.ProductKey,
fis.OrderQuantity,
fis.UnitPrice,
fis.TotalProductCost,
fis.SalesAmount
FROM factinternetsales fis
ORDER BY OrderDate)
SELECT COUNT(total_sales.SalesOrderLineNumber) as tot_sales, total_sales.OrderDate, channel
FROM total_sales
GROUP BY total_sales.OrderDate, channel
HAVING total_sales.OrderDate >= '2020-01-01';

/* 4. Calcola il fatturato totale FactResellerSales.SalesAmount), la quantità totale venduta FactResellerSales.OrderQuantity) e il prezzo medio di vendita FactResellerSales.UnitPrice) per prodotto DimProduct) 
a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!*/

SELECT p.EnglishProductName,
concat(SUM(frs.SalesAmount), ' $') as Total_Sales,
SUM(frs.OrderQuantity) as Total_Qt,
concat(SUM(frs.SalesAmount)/SUM(frs.OrderQuantity), ' $') as Average_price_1,
concat(AVG(frs.UnitPrice), ' $') as Average_price_2
FROM factresellersales frs
LEFT JOIN dimproduct p
ON frs.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName;

-- leggibilità migliorata

SELECT p.EnglishProductName,
concat(SUM(frs.SalesAmount), ' $') as Total_Sales,
SUM(frs.OrderQuantity) as Total_Qt,
concat(ROUND(SUM(frs.SalesAmount)/SUM(frs.OrderQuantity), 2), ' $') as Average_price_1,
concat(ROUND(AVG(frs.UnitPrice), 2), ' $') as Average_price_2
FROM factresellersales frs
LEFT JOIN dimproduct p
ON frs.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName;





/* 1. Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta
FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory). 
Il result set deve esporre pertanto il nome della categoria prodotto, 
il fatturato totale e la quantità totale venduta.
I campi in output devono essere parlanti!*/

SELECT EnglishProductCategoryName as Category,
SUM(SalesAmount) as Total_sales,
SUM(OrderQuantity) as Total_Qt
FROM factresellersales as rsales
JOIN dimproduct as p
ON p.ProductKey = rsales.ProductKey
JOIN dimproductsubcategory as subc
ON p.ProductSubcategoryKey = subc.ProductSubcategoryKey
JOIN dimproductcategory as c
ON  subc.ProductCategoryKey = c.ProductCategoryKey
GROUP BY c.ProductCategoryKey
ORDER BY 2 DESC;

/* 2. Calcola il fatturato totale per area città DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.*/

SELECT g.City,
concat(SUM(SalesAmount), ' $') as Total_sales
FROM factresellersales frs
LEFT JOIN dimreseller dr
ON frs.ResellerKey = dr.ResellerKey
LEFT JOIN dimgeography g
ON dr.geographyKey = g.GeographyKey
WHERE frs.OrderDate >= '2020-01-01'
GROUP BY g.City
HAVING SUM(SalesAmount) > 60000
ORDER BY Total_sales;
 