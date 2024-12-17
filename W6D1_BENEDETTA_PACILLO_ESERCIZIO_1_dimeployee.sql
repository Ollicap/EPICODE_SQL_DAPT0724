-- punto 01
use AdventureWorksDW;
select * from dimemployee;
describe dimemployee;

-- punto 02
select * from dimemployee
where SalesPersonFlag = 1;

