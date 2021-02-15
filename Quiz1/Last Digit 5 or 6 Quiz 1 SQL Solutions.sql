
-- S2 Last Digit 5 or 6 Quiz 1

-- Question 3

with temp as
(select sh.CustomerID, count(sd.ProductID) ProductCount
 from Sales.SalesOrderHeader sh
 join Sales.SalesOrderDetail sd
      on sh.SalesOrderID = sd.SalesOrderID
 group by sh.CustomerID, sh.SalesOrderID)

 select CustomerID, max(ProductCount) HighestProductCount, 
        count(CustomerID) HowManyOrder
 from temp
 group by CustomerID
 having max(ProductCount) = 1 and count(CustomerID) > 1
 order by CustomerID;


-- Question 4

with temp as
(select month(OrderDate) Month, sh.SalesOrderID, TotalDue,  sum(OrderQty) total,
rank() over (partition by month(OrderDate) order by TotalDue desc) as ranking
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
on sh.SalesOrderID = sd.SalesOrderID
where year(OrderDate) = 2007
group by month(OrderDate), sh.SalesOrderID, TotalDue)

select t.Month, t.SalesOrderID, t.TotalDue, t.total
from temp t
where ranking = 1
order by Month;

