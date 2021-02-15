
-- S2 Last Digit 1, 2 or 3 Quiz 1

-- Question 3

select distinct sh.TerritoryID, Name, round(min(TotalDue), 2) LowestOrderValue
from Sales.SalesTerritory t
join Sales.SalesOrderHeader sh
on t.TerritoryID = sh.TerritoryID
where sh.TerritoryID not in
(select TerritoryID
from Sales.SalesOrderHeader
where TotalDue <4)
group by sh.TerritoryID, Name
order by sh.TerritoryID;



-- Question 4

with temp1 as
     (select CustomerID, max(TotalDue) as HighestOrderValue
      from Sales.SalesOrderHeader
      group by CustomerID),

     temp2 as
	 (select CustomerID, sum(OrderQty) as HighestOrderQuantity,
      rank() over (partition by customerid order by sum(OrderQty) desc) as OrderQtyPosition
      from Sales.SalesOrderHeader sh
      join Sales.SalesOrderDetail sd
      on sh.SalesOrderID = sd.SalesOrderID
      group by CustomerID, sh.SalesOrderID)

select t1.CustomerID, t1.HighestOrderValue, t2.HighestOrderQuantity
from temp1 as t1
join temp2 as t2
on t1.CustomerID = t2.CustomerID
where OrderQtyPosition = 1
order by t1.CustomerID desc;

-- OR

select soh.CustomerID, MAX(soh.TotalDue) as [MAX TotalDue], MAX(sod.OrderQty) AS [MAX OrderQty] 
from  Sales.SalesOrderHeader soh 
join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID 
group by soh.CustomerID
order by soh.CustomerID desc;


