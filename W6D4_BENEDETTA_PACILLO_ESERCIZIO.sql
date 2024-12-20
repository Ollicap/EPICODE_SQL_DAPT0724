USE AdventureWorksDW;
/*Interrogare e filtrare le tabelle Esercizio Schema concettuale Dove possibile svolgi gli esercizi utilizzando sia JOIN che SUBQUERY*/

/*1. Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory)*/
-- Join

SELECT 
	ProductKey,
    EnglishProductName,
    EnglishProductSubcategoryName,
    cat.EnglishProductCategoryName
FROM dimproduct p
JOIN
	dimproductsubcategory sub
ON 
	p.ProductSubcategoryKey = sub.ProductSubcategoryKey
join
	dimproductcategory cat
ON
	sub.productcategorykey = cat.productcategorykey;

/* 2 */
SELECT distinct 
	p.ProductKey,
    EnglishProductName
FROM dimproduct p
JOIN 
	factresellersales sale
ON 
	p.ProductKey = sale.ProductKey;

/* 4 */

SELECT distinct 
	p.ProductKey,
    EnglishProductName
FROM dimproduct p
LEFT JOIN 
	factresellersales sale
ON 
	p.ProductKey = sale.ProductKey
WHERE p.finishedgoodSflag = 1
and sale.productkey IS NULL;

-- 5

SELECT 
	sale.ProductKey,
    p.EnglishProductName,
    sale.SalesOrderNumber,
    sale.SalesOrderLineNumber,
    sale.SalesAmount,
    sale.OrderDate,
    sale.UnitPrice,
    sale.TotalProductCost
FROM factresellersales sale
LEFT JOIN	
	dimproduct p
ON
	sale.ProductKey = p.ProductKey;
    
-- 1
SELECT 
	sale.ProductKey,
    p.EnglishProductName,
    sale.SalesOrderNumber,
    sale.SalesOrderLineNumber,
    sale.SalesAmount,
    sale.OrderDate,
    sale.UnitPrice,
    sale.TotalProductCost
FROM factresellersales sale
LEFT JOIN	
	dimproduct p
ON
	sale.ProductKey = p.ProductKey
JOIN
	dimproductsubcategory sub
ON 
	p.ProductSubcategoryKey = sub.ProductSubcategoryKey
join
	dimproductcategory cat
ON
	sub.productcategorykey = cat.productcategorykey;

-- 2

SELECT *
FROM dimreseller;

SELECT 
	r.ResellerKey,
    r.ResellerName,
    g.City,
    g.StateProvinceCode,
    g.StateProvinceName,
    g.EnglishCountryRegionName
FROM dimreseller r
JOIN 
	dimgeography g
ON 
	r.GeographyKey = g.GeographyKey
JOIN 
	dimsalesterritory st
ON
	g.SalesTerritoryKey = st.SalesTerritoryKey
ORDER BY 1;

-- 4
SELECT 
	sale.ProductKey,
    p.EnglishProductName,
    sale.SalesOrderNumber,
    sale.SalesOrderLineNumber,
    sale.SalesAmount,
    sale.OrderDate,
    sale.UnitPrice,
    sale.TotalProductCost,
    sale.OrderQuantity,
    r.ResellerName,
    g.City,
    g.StateProvinceCode,
    g.StateProvinceName,
    g.EnglishCountryRegionName
FROM factresellersales sale
LEFT JOIN	
	dimproduct p
ON
	sale.ProductKey = p.ProductKey
JOIN
	dimproductsubcategory sub
ON 
	p.ProductSubcategoryKey = sub.ProductSubcategoryKey
join
	dimproductcategory cat
ON
	sub.productcategorykey = cat.productcategorykey
JOIN
	dimreseller r
ON 
	r.ResellerKey = sale.ResellerKey
JOIN
	dimgeography g
ON 
	r.GeographyKey = g.GeographyKey
JOIN 
	dimsalesterritory st
ON
	g.SalesTerritoryKey = st.SalesTerritoryKey;


	


	




    
	

