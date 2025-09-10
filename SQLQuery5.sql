SELECT AND WHERE
Show all columns from matches.

select * from matches


--Show only id, season, winner from matches.

select id,season,winner from matches

Show all deliveries where batsman = 'V Kohli'.

select * from deliveries where batter ='V kohli'

Show all matches played in the city 'Mumbai'.

select * from matches where city ='Mumbai'

Show all deliveries where wide_runs > 0.

select * from deliveries where extra_runs >0 and extras_type='wides'

ORDER BY
List top 10 matches by season descending.
select top 10 * from matches order by season desc

Show first 20 deliveries ordered by total_runs descending.

select top 20 * from deliveries order by total_runs desc


DISTINCT
List all unique cities where matches were played.

select distinct city  from matches
List all unique teams from batting_team in deliveries.
select * from deliveries

select distinct batting_team  from deliveries
--------AGGREGATE FUNCTIONS
Count how many matches are there in total.
select count(distinct id) from matches

select * from matches

select * from [dbo].[matches]

select count(match_type) from [dbo].[matches]

Count how many distinct seasons are there.


select count(distinct(season)) from [dbo].[matches]

Find total runs scored in deliveries.

select sum(total_runs) from deliveries


Find average total_runs per ball.

select avg(cast(total_runs as float)) from deliveries

Find maximum batsman_runs in a single ball.

select max(batsman_runs) from deliveries

GROUP BY AND HAVING
Find number of matches played each season.

select * from matches

select season,count(id) as no_matches
from matches
group by season
ORDER BY season;
Find total runs scored by each batting_team.

select * from deliveries
select batting_team,sum(total_runs) as tr
from deliveries
group by batting_team

Find total runs scored by each batsman.

select * from deliveries

select batter,sum(total_runs) as tt
from deliveries
group by batter
order by tt desc

select * from matches
Find bowlers who have bowled more than 100 balls.

select * from deliveries

select bowler,count(*) as bb
from deliveries
WHERE extras_type IS NULL
group by bowler
having count(*)>100
order by bb desc


Find teams that have won more than 50 matches.
select * from matches

select winner,count(*) as tt
from matches
group by winner
having count(*)>50



JOINS
For each delivery, show season from matches.
select * from matches
select * from deliveries

select d.*,m.season
from deliveries d join
matches m on m.id=d.match_id

List all deliveries with winner column from matches.
select * from matches
select * from deliveries

select d.*,m.winner from deliveries d
join matches m on d.match_id = m.id



Find total runs per season.

select m.season,sum(total_runs) as tt from deliveries d
join matches m on m.id=d.match_id
group by m.season
order by m.season


Find the batsman with highest runs in 2016 season.
select * from matches
select * from deliveries

select top 1 d.batter,sum(total_runs) as tt from deliveries d
join matches m on m.id=d.match_id
where m.season ='2016'
group by d.batter
order by tt desc

SUBQUERIES
Find batsman with maximum total_runs in deliveries.
select top 1 d.batter,sum(total_runs) as tt from deliveries d
join matches m on m.id=d.match_id
group by d.batter
order by tt desc


Find matches where the winning team scored more than 200 runs.

select * from matches
select * from deliveries

select * from matches where target_runs>'200'
SELECT m.id, m.season, m.winner, SUM(d.total_runs) AS total_score
FROM matches m
JOIN deliveries d ON m.id = d.match_id
WHERE d.batting_team = m.winner
GROUP BY m.id, m.season, m.winner
HAVING SUM(d.total_runs) > 200;


Find matches where a player scored a century in a single match.

select * from matches
select * from deliveries

SELECT d.match_id, d.batter, SUM(d.batsman_runs) AS runs
FROM deliveries d
GROUP BY d.match_id, d.batter
HAVING SUM(d.batsman_runs) >= 100;


CTE
Using CTE, list each employee along with their manager’s name.


Using CTE, show top 5 employees with highest pay rate.

Using CTE, show products with a running total of StandardCost.

Create a recursive CTE to display organization hierarchy.

STRING FUNCTIONS
Get uppercased names of all unique cities.

Show batsman names and their length of name.

Show match dates formatted as YYYY-MM.

Show all distinct venue names trimmed of spaces.

Show all bowlers whose names start with letter M.

Show matches where city name contains ‘pur’.

Show first 3 letters of each batsman name.

Show last 4 letters of each bowler name.

DATE FUNCTIONS
Extract year from date and count matches played in each year.

select * from matches

select year(date) as year,count(*) as ty from matches
group by year(date)
order by year desc

Extract month and count matches played in each month.
select month(date) as month,count(*) as ty from matches
group by month(date)
order by month desc

SELECT 
    DATENAME(MONTH, date) AS MonthName,
    COUNT(*) AS Total_Matches
FROM matches
GROUP BY DATENAME(MONTH, date), MONTH(date)
ORDER BY MONTH(date); 




USER-DEFINED FUNCTIONS
Create a scalar function fn_TotalRunsByBatsman(@BatsmanName) that returns total runs.
select * from matches
select * from deliveries

create function fn_TotalRunsByBatsman(@BatsmanName varchar(33))
returns int
as
begin 
        declare @total int
       select @total =sum(total_runs) from deliveries
       where batter =@BatsmanName
        return @total   
         end

select dbo.fn_TotalRunsByBatsman('SC Ganguly') as ts


CREATE OR ALTER FUNCTION fn_MatchesBySeason(@Season VARCHAR(22))
RETURNS TABLE
AS
RETURN
(
    SELECT d.*, m.season, m.city, m.date  -- choose columns as needed
    FROM deliveries d
    JOIN matches m ON m.id = d.match_id
    WHERE m.season = @Season
);

select counT(*) from dbo.fn_MatchesBySeason('2018')

Create a scalar function fn_BowlerEconomy(@BowlerName) that returns economy rate.

STORED PROCEDURES
Create a stored procedure sp_GetMatchesByCity(@CityName) that returns matches in that city.

alter procedure sp_GetMatchesByCity (@CityName varchar(30))
as

    select * from matches where city = @CityName

   exec sp_GetMatchesByCity 'Bangalore'



Create a stored procedure sp_GetTopBatsmanBySeason(@Season) that returns top 5 batsmen by runs.

select * from matches
select * from [dbo].[deliveries]

Create or alter  procedure sp_GetTopBatsmanBySeason(@Season int)
as
select top 5 m.season,d.batter,sum(total_runs) as tr from [deliveries] d
join matches m on d.match_id=m.id 
where left(m.season,4) = @Season
group by m.season,d.batter
order by sum(total_runs) desc

exec sp_GetTopBatsmanBySeason 2017


Create a stored procedure sp_GetTeamWins(@TeamName) that returns number of matches won.
select * from matches
select * from deliveries
create proc sp_GetTeamWins(@TeamName varchar(33))
as begin
        select winner,count(*) as tm from matches where winner=@TeamName
        group by winner
    end

    exec sp_GetTeamWins 'Chennai Super Kings';



Create a stored procedure sp_GetBowlerStats(@BowlerName) that returns balls bowled, runs conceded, and wickets.











STORED PROCEDURE WITH OUTPUT PARAMETERS
Create a stored procedure sp_GetMatchSummary(@MatchID, @TotalRuns OUT, @Wickets OUT).

STORED PROCEDURE WITH TRANSACTIONS
Create a stored procedure sp_InsertMatchAndLog that inserts into matches and logs the action.

WINDOW FUNCTIONS
Show each batsman with cumulative runs across balls.

Rank batsmen by total_runs in descending order.
SELECT batter, total_runs,
       RANK() OVER (ORDER BY total_runs DESC) AS rank_column
FROM (
    SELECT batter, SUM(total_runs) AS total_runs
    FROM deliveries
    GROUP BY batter
) AS bat_stats;

select * from deliveries

Show each bowler with average runs per ball and their rank.

SELECT bowler,
       CAST(SUM(total_runs) AS FLOAT) / COUNT(*) AS avg_runs_per_ball,
       RANK() OVER (ORDER BY CAST(SUM(total_runs) AS FLOAT) / COUNT(*) DESC) AS rank
FROM deliveries
GROUP BY bowler;
 
CASE WHEN
Show a column match_result_type with value Tie if result = 'tie' else Normal.
select * from matches
select result,
case
    when result ='tie' then 'tie'
    else 'normal'
end as match_result_type
from matches



Show a column run_type: Wide if wide_runs > 0, Six if batsman_runs = 6, else Other.

select * from deliveries

SELECT *,
       CASE
           WHEN extras_type = 'wide' THEN 'Wide'
           WHEN batsman_runs = 6 THEN 'Six'
           ELSE 'Other'
       END AS run_type
FROM deliveries;

 

TRIGGERS
Create a trigger on matches that logs every insert, update, and delete into a log table.


Create a trigger on deliveries that logs every update to total_runs.

ADVANCED
Find the match with the highest total runs.

Find the batsman with the highest strike rate (minimum 200 balls faced).

Find the team with best win percentage.

Find the over in which most runs were scored in a particular match.

Find matches where the chasing team won with 10 or more balls remaining.

CREATE TABLE Students_2023 (
    student_id INT,
    student_name VARCHAR(50)
);

CREATE TABLE Students_2024 (
    student_id INT,
    student_name VARCHAR(50)
);

-- Students in 2023
INSERT INTO Students_2023 VALUES
(1, 'Ravi'),
(2, 'Priya'),
(3, 'Amit'),
(4, 'John');

-- Students in 2024
INSERT INTO Students_2024 VALUES
(3, 'Amit'),
(4, 'John'),
(5, 'Sneha'),
(6, 'David');

select * from Students_2024
except

select * from Students_2023

--------index-------------
create database pratices

CREATE TABLE Employees (
    empid INT PRIMARY KEY,
    empname VARCHAR(100),
    department VARCHAR(50),
    salary INT
);

-- Insert some test data (add 1000 rows if you want big test)
INSERT INTO Employees VALUES
(1, 'Ravi', 'HR', 50000
(2, 'Priya', 'IT', 60000),
(3, 'Amit', 'Sales', 45000),
(4, 'John', 'HR', 52000);


select * from employees where empname='priya'

create index idx_empname 
on employees (empname)

sp_helpindex 'employees'

create index idx_dept_saly 
on employees(department,salary)

drop index idx_empname on employees

create Clustered index empid 
on employees (empid)

drop index idx_gender on employess

create nonClustered index idx_empname 
on employees (empname)

CREATE TABLE Articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(200),
    content TEXT
);
INSERT INTO Articles VALUES
(1, 'AI News', 'ChatGPT is a powerful language model.'),
(2, 'SQL Tips', 'Full-text search is better than like operator.'),
(3, 'Tech Update', 'OpenAI is leading in AI research.');

select * from articles

CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;

ALTER INDEX idx_empname ON Employees
rebuild;


ALTER INDEX idx_empname ON Employees
REORGANIZE;

CREATE TABLE Employees11 (
    empid INT PRIMARY KEY,
    empname VARCHAR(50),
    salary INT
);

-- Insert 10000 rows
DECLARE @i INT = 1;
WHILE @i <= 10000
BEGIN
    INSERT INTO Employees11 VALUES (
        @i, 
        'Emp' + CAST(@i AS VARCHAR),
        FLOOR(RAND() * 100000)
    );
    SET @i += 1;
END;

select * from employees11


create index idx_empname on employees11(empname)

DELETE FROM Employees11 WHERE empid % 2 = 0;

SELECT 
    i.name AS IndexName,
    ips.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(
        DB_ID(), OBJECT_ID('Employees'), NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i 
    ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE i.name = 'idx_empname';

ALTER INDEX idx_empname ON Employees REORGANIZE;

ALTER INDEX idx_empname ON Employees rebuild;


SET STATISTICS IO ON;
SELECT * FROM Employees WHERE empname = 'Emp500';

DELETE FROM Employees11 WHERE empid % 2 = 0;



DECLARE @i INT = 2;
WHILE @i <= 10000
BEGIN
    INSERT INTO Employees11 VALUES (
        @i,
        'Emp' + CAST(@i AS VARCHAR),
        FLOOR(RAND() * 100000)
    );
    SET @i += 2;
END;

SELECT 
    i.name AS IndexName,
    ips.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(
        DB_ID(), OBJECT_ID('Employees'), NULL, NULL, 'DETAILED') ips
JOIN sys.indexes i 
    ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE i.name = 'idx_empname';

TRUNCATE TABLE employees11;
drop table employees11

CREATE TABLE Employees (
    empid INT PRIMARY KEY,
    empname VARCHAR(50),
    salary INT
);

INSERT INTO Employees VALUES 
(1, 'Alice', 30000),
(2, 'Bob', 40000),
(3, 'Charlie', 50000);

CREATE TABLE NewEmployees (
    empid INT,
    empname VARCHAR(50),
    salary INT
);

INSERT INTO NewEmployees VALUES 
(2, 'Bob', 42000),         -- Update
(3, 'Charlie', 50000),     -- Same (no change)
(4, 'David', 35000);       -- New (insert)

select * from Employees
select * from NewEmployees

update  NewEmployees set salary =10000 where empid=4

merge employees as t
using newemployees as s
on t.empid=s.empid
when matched then 
update set
  T.empname = S.empname,
        T.salary = S.salary
when not matched then
insert (empid,empname,salary)
values(s.empid,s.empname,s.salary);

merge employees as t
using newemployees as s
on t.empid=s.empid
when matched then
update set 
t.salary=s.salary
when not matched by t then
insert (empid,empname,salary)
values(s.empid,s.empname,s.salary);

MERGE INTO Employees AS target
USING NewEmployees AS source
ON target.EmpID = source.EmpID

WHEN MATCHED THEN
    UPDATE SET target.Salary = source.Salary

WHEN NOT MATCHED BY TARGET THEN
    INSERT (EmpID, EmpName, Salary)
    VALUES (source.EmpID, source.EmpName, source.Salary)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

    ----------pivot----------
    CREATE TABLE SalesData (
    Region VARCHAR(50),
    Product VARCHAR(10),
    Sales INT
);
INSERT INTO SalesData (Region, Product, Sales) VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200),
('West', 'B', 250),
('North', 'A', 130),
('North', 'B', 170);

select * from SalesData

select * from (
select region,product,sales
from SalesData 
) as src
pivot(
sum(sales)
for product in([a],[b])
)as pvt;

select * from(
select region,product,sales
from salesdata
) as pp
pivot(
 sum(sales)
     for   product in([a],[b])
        )as nn


        select * from employees

        select * from (
        select empid,empname,salary from employees
        )as pp
        pivot(
        sum(salary)
        for empname in([bob],[charlie],[david])
        )as mm;


        CREATE TABLE PivotedSales (
    Region VARCHAR(50),
    A INT,
    B INT
);

INSERT INTO PivotedSales VALUES
('East', 100, 150),
('West', 200, 250),
('North', 130, 170);


select region,product,sales from (
select region,[a],[b] from PivotedSales) as sc
unpivot( sales for product in ([a],[b])
)as unp









