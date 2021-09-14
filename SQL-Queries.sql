
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
-- joining to a subquery
select *
From Artist a
left outer join
	(select ArtistId, max(Milliseconds) LongestSongLength
From Track t 
	join  Album a 
		on a.AlbumId = t.AlbumId
group by ArtistId
) maxSong
on a.ArtistId = maxSong.ArtistId

-- finds ArtistId in assending order by the longest song length in milliseconds
select ArtistId, max(Milliseconds) LongestSongLength
From Track t 
	join  Album a 
		on a.AlbumId = t.AlbumId
group by ArtistId 
	order by 1 Asc

------ correlated Subquery in the select statement
select a.ArtistId,
	a.name,
		(select max(Milliseconds) LongestSongLenght
			From track t
				join Album al
					on al.AlbumId = t.AlbumId
			where al.ArtistId = a.ArtistId -- = 3
			group by ArtistId
		)
From Artist a



-- which artists have no tracks
-- Correlated Subquery in the where clause

select *
from Artist a
where not exists (
		select 'anything'
		From track t
			join Album al
					on al.AlbumId = t.AlbumId
		where al.ArtistId = a.ArtistId
)

-- regular subquery for artist with no tracks
-- where ArtistId is not AlbumId table
select *
from Artist a
where ArtistId not in (
	select ArtistId
	From track t
			join Album al
					on al.AlbumId = t.AlbumId
)


----------- UNION, EXCEPT, UNION ALL, INTERSECT ----------------
----------------------------------------------------------------

-- combining/comparing two or more resultsets that may or may not have anything in common

-- Union
-- 1,2,3,4,5,6,7,8,9,10
-- union
-- 8,9,10,11,12,13,14,15
-- results =
-- 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 union
-- 1,2,3,4,5,6,7,8,9,10,8,9,10,11,12,13,14,15 union all

-- Execpt
-- 1,2,3,4,5,6,7,8,9,10
-- except
-- 8,9,10,11,12,13,14,15
-- result =
-- 1,2,3,4,5,6,7

-- union of two select queries
select left (Name, 1)
from Artist
union --all
select left(FirstName, 1)
from Customer



-- must have the same number of columns, aliases only matter on the first set
-- all of Customer and Employee email addresses
select Email, 'Employee' as [type]
from Employee
union all
select Email, 'Customer'
from Customer

-- except operator
-- number of artist that ArtistId is not in the Album table
select ArtistId
from Artist a
except
select ArtistId
from Album 

-- intersect, gives the middle portion of the Venn Diagram
select ArtistId
from Artist a
intersect
select ArtistId
from Album 

-- intersect, show me the overlap of these two data sets

-- union, give me the combination of these two intersects that are unique
-- with no duplication

-- union all, give me all of the results from both of data sets
-- give me the combinations both tables with duplication


-- except, give me all the results of the top unless 
-- there is a match from the bottom
select left(FirstName,1)
from Employee
except
select left(FirstName,1)
from Customer

select left(FirstName,1)
from Customer
except
select left(FirstName,1)
from Employee