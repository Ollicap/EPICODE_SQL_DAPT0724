use AdventureWorksDW;
-- punto 01
select * from dimproduct;
describe dimproduct;

-- punto 02
select ProductKey,
ProductAlternateKey,
EnglishProductName,
Color,
StandardCost,
FinishedGoodsFlag as Completed
from dimproduct;

-- punto 03 + 04
select ProductKey,
ProductAlternateKey,
EnglishProductName,
Color,
StandardCost,
FinishedGoodsFlag as Completed
from dimproduct
where FinishedGoodsFlag = 1;

-- punto 05
select ProductKey,
ModelName as model_name,
EnglishProductName as product_name,
StandardCost as standard_cost
from dimproduct
where ProductAlternateKey like 'FR%' 
or
ProductAlternateKey like 'BK%';

-- punto 06
select ProductKey,
ProductAlternateKey,
ModelName as model_name,
EnglishProductName as product_name,
StandardCost as standard_cost,
ListPrice as list_price,
ListPrice - StandardCost as markup
from dimproduct
where ProductAlternateKey like 'FR%' 
or
ProductAlternateKey like 'BK%';

-- punto 07
select ProductKey,
ProductAlternateKey,
ModelName as model_name,
EnglishProductName as product_name,
StandardCost as standard_cost,
ListPrice as list_price,
ListPrice - StandardCost as markup
from dimproduct
where ListPrice between 1000 and 2000
and FinishedGoodsFlag = 1;
