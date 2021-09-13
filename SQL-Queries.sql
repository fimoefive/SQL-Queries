
--what artists' music do we sell that starts with the letter c?
select *, 
		ArtistId + 1000
	from Artist
where [Name] like 'c%'	-- Stuff based on matching a partial string? use Like operator

-- What states are our customers located in?
select State
from Customer

-- how many customers are in each state?
select State, count (*)
from Customer
-- grouping based by state
group by [State]

Select State as [Customer State], -- sets alias column name
count (*) [Number of Customers], -- second way of declaring an alias name 
CustomerNames = string_agg(firstname, ',') -- third way of declaring an alias with = sign
-- [Customer Names] = string_agg(firstname, ',') with a space has to have []
from Customer c

-- grouping based on state
-- group by FirstName
-- group by [State], Country
group by isnull([State], Country)

--null is a special thing, you have to use is null and is not null to compare it to things
select * 
from Customer
where [state] is not null

-- how many music tracks were purchased by each customer country?

-- number of invoice lines by country
select *
from Invoice i
	join InvoiceLine il
		on i.InvoiceId = il.InvoiceId

select BillingCountry, count(*) 
from Invoice i --customerid, billingcountry
	join InvoiceLine il
		on i.InvoiceId = il.InvoiceId
group by BillingCountry 
order by 1

--number of invoices by country
select BillingCountry, count(*)
from Invoice i
group by BillingCountry
order by 1


select BillingCountry, TrackId 
from Invoice i --customerid, billingcountry
	join InvoiceLine il
		on i.InvoiceId = il.InvoiceId
group by BillingCountry 
order by 1

-- counting with distinct only counts unique instances of a specified field/expression
select count(distinct TrackId), count(*)
from InvoiceLine -- tracks on the invoice

-- when you want only the first x number of rows, us TOP
Select top 5 *
from Invoice
order by Total desc --desc is for decending, asc is for accending orders

----------------- SUBQUERIES ----------------
-------------------------------------------------------------------------------
--nesting one or more queries inside another one
-- subquery, and correlated subquery are the  two main categories


-- artists and their longest track

select *
From Artist a

select *
From Track t join  Album a on a.AlbumId = t.AlbumId


