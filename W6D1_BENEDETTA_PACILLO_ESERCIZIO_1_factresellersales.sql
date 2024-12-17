use AdventureWorksDW;
select * from factresellersales;

select 
	SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate,
    ProductKey,
    ResellerKey,
    OrderQuantity,
    UnitPrice,
	SalesAmount - TotalProductCost as profit
from factresellersales
where 
	OrderDate >= '2020-01-01'
and 
	ProductKey in (597, 598, 477, 214);

select b.listprice
, b.StandardCost
, SalesAmount - TotalProductCost as Markup
, case 
	when TotalProductCost is null then a.SalesAmount - a.OrderQuantity * b.StandardCost
	else SalesAmount - TotalProductCost end as Markup_corretto
from factresellersales as a
inner join dimproduct as b on a.ProductKey=b.ProductKey
where TotalProductCost is null;
