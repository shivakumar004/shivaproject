CREATE TABLE EMP (
  EMPID INT,
  EMPNAME VARCHAR(50),
  SALARY INT
);
CREATE TABLE EMP_LOG (
  LOGID INT IDENTITY,
  EMPID INT,
  EMPNAME VARCHAR(50),
  SALARY INT,
  STATUS VARCHAR(50),
  LOGDATE DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER TRG_INSERT_EMP
ON EMP
AFTER INSERT
AS
BEGIN
  INSERT INTO EMP_LOG (EMPID, EMPNAME, SALARY, STATUS)
  SELECT EMPID, EMPNAME, SALARY, 'INSERTED'
  FROM INSERTED;
END;

INSERT INTO EMP VALUES (1, 'Shiva', 50000);

select * from emp
select * from EMP_LOG
-------------------hi-----------

CREATE TRIGGER TRG_DELETE_EMP
ON EMP
AFTER DELETE
AS
BEGIN
  INSERT INTO EMP_LOG (EMPID, EMPNAME, SALARY, STATUS)
  SELECT EMPID, EMPNAME, SALARY, 'DELETED'
  FROM DELETED;
END;
DELETE FROM EMP WHERE EMPID = 1;

CREATE TRIGGER TRG_UPDATE_EMP
ON EMP
AFTER UPDATE
AS
BEGIN
  INSERT INTO EMP_LOG (EMPID, EMPNAME, SALARY, STATUS)
  SELECT EMPID, EMPNAME, SALARY, 'UPDATED'
  FROM INSERTED;
END;
-- Only runs if salary is actually changing
UPDATE EMP SET SALARY = 61000 WHERE EMPID = 1;

UPDATE EMP SET SALARY = 60000 WHERE EMPID = 2;


CREATE TRIGGER FOR_IN_UPD
ON EMPP
FOR UPDATE 
AS
BEGIN
	-- New data (after update)
	INSERT INTO EMPP_LOG(EMPID, EMPANAME, EMPDOB, EMPDEPT, USERID, EFFECT_DATE, STATUS)
	SELECT EMPID, EMPANAME, EMPDOB, EMPDEPT, 'KFIN-12', GETDATE(), 'NEW DATA UPDATED'
	FROM INSERTED;

	-- Old data (before update)
	INSERT INTO EMPP_LOG(EMPID, EMPANAME, EMPDOB, EMPDEPT, USERID, EFFECT_DATE, STATUS)
	SELECT EMPID, EMPANAME, EMPDOB, EMPDEPT, 'KFIN-12', GETDATE(), 'OLD DATA BEFORE UPDATE'
	FROM DELETED;
END;

create table student22(
sno int,
sname varchar(30),
marks int)

select * from student22
insert student22 values(3,'sunil',18)

create table student22_log(
logid int identity,
sno int,
sname varchar(30),
marks int,
status varchar(30),
logdate datetime default getdate())

select * from student22_log

create trigger trig_insert_stu
on student22
after insert
as 
begin
		insert into student22_log(sno,sname,marks,status)
		select sno,sname,marks,'inserted'
		from inserted
end

delete student22 where sno=1

create trigger trig_delete_stu
on student22
after delete
as
begin	
		insert into student22_log(sno,sname,marks,status)
		select sno,sname,marks,'deleted'
		from deleted
end
delete from student22 where sno=2

create trigger trig_update_stu
on student22
for update
as
begin 
		insert into student22_log(sno,sname,marks,status)
		select sno,sname,marks,'newdatainserted'
		from inserted
		insert into student22_log(sno,sname,marks,status)
		select sno,sname,marks,'olddatadeleted'
		from deleted
end		

update student22 set marks =555 where sno=2


declare @num int=1
if @num<10
begin
 print('less than 10')
end
else 
begin
	print('great than 10')
end




CREATE TRIGGER TRG_EMP_LOG
ON EMP
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT action
    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO EMP_LOG (EMPID, EMPNAME, SALARY, STATUS)
        SELECT EMPID, EMPNAME, SALARY, 'INSERT'
        FROM INSERTED;
    END

    -- UPDATE action
    IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO EMP_LOG (EMPID, EMPNAME, SALARY, STATUS)
        SELECT EMPID, EMPNAME, SALARY, 'UPDATE'
        FROM INSERTED;
    END

    -- DELETE action
    IF EXISTS (SELECT 1 FROM DELETED) AND NOT EXISTS (SELECT 1 FROM INSERTED)
    BEGIN
        INSERT INTO EMP_LOG (EMPID, EMPNAME, SALARY, STATUS)
        SELECT EMPID, EMPNAME, SALARY, 'DELETE'
        FROM DELETED;
    END
END;


select * from emp
insert into emp values (1,'shiva',8888)
select  * from EMP_LOG

select * from person.EmailAddress

select businessentityid,emailaddress,count(*)
from Person.EmailAddress
group by businessentityid,emailaddress
having count(*)>1

CREATE TABLE Employees (
  EmpID INT,
  EmpName VARCHAR(50),
  Gender VARCHAR(10),
  Department VARCHAR(20),
  Salary INT
);
INSERT INTO Employees VALUES (1, 'Rahul', 'Male', 'HR', 30000);
INSERT INTO Employees VALUES (2, 'Priya', 'Female', 'IT', 50000);
INSERT INTO Employees VALUES (3, 'Amit', 'Male', 'IT', 60000);
INSERT INTO Employees VALUES (4, 'Anjali', 'Female', 'Finance', 45000);
INSERT INTO Employees VALUES (5, 'Ravi', 'Male', 'HR', 30000);
INSERT INTO Employees VALUES (6, 'Sneha', 'Female', 'Finance', 70000);
INSERT INTO Employees VALUES (7, 'Vikram', 'Male', 'IT', 55000);
INSERT INTO Employees VALUES (8, 'Pooja', 'Female', 'HR', 32000);
INSERT INTO Employees VALUES (9, 'Suresh', 'Male', 'Sales', 40000);
INSERT INTO Employees VALUES (10, 'Divya', 'Female', 'Sales', 42000);

select * from Employees where Salary>50000

select * from Employees where department in ('it','finance')

select * from Employees where Salary  between 40000 and 60000

select department ,count(*) as totalcont
from Employees
group by Department
having count(*)>2


select department,count(*) as malecount
from Employees
where gender='male'
group by Department
having count(*)>=2
order by malecount desc
---where---------
select * from Employees where gender ='female'

select * from Employees where EmpName ='vikram'

select * from Employees where Department ='hr'

select * from Employees where gender ='male' and Salary<=35000

-------in-------------------------
select * from Employees where Department in('it','finance')

select * from Employees where Salary in('30000','55000','60000')

select * from Employees where Empname in('rahul','ravi','pooja')
select * from Employees where Department in('it','sales','hr')

select * from Employees where gender='male' and salary in('30000','55000','60000')
--------between--------------------------

select * from Employees where salary between 40000 and 60000

select * from Employees where EmpID between 2 and 4
select * from Employees where salary between 30000 and 50000

select * from Employees where gender ='female' and salary between 35000 and 70000

select * from Employees where Department ='hr' and salary between 30000 and 35000
---------------------group by--------------------
select department,count(*) as cd
from Employees
group by department

select gender,count(*) as total
from Employees
group by Gender
having count(*)>6

select department,avg(Salary) as avgsalary
from Employees
group by Department


select gender,count(gender) as gender
from Employees
where Department='it'
group by gender

select department,sum(salary) as salary
from Employees
group by department

-----------having---------------------

Show departments with more than 2 employees.

select department,count(*) as cd
from Employees
group by Department
having count(*)>2

Show gender groups with count more than 3.

select Gender,count(gender) as total
from Employees
group by Gender
having count(*)>3


Show departments where average salary is 100000

select department,avg(Salary) as avs
from Employees
group by department
having avg(Salary)=100000

Show salary groups that occur more than once.

SELECT Salary, COUNT(*) AS count_of_salary
FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1
ORDER BY Salary DESC;


-- Q5. Show departments with average salary above 40000.

select department,avg(Salary) as avs
from Employees
group by department
having avg(Salary)>40000

-------------------------------------------------------------
SELECT PHONENUMBER FROM PERSON.PERSONPHONE WHERE BUSINESSENTITYID IN
( SELECT BUSINESSENTITYID FROM  HumanResources.Employee  )



SELECT  * FROM   Person.PersonPhone --19972
SELECT * FROM   HumanResources.Employee --290

select empname,salary from Employees
where Salary >(select avg(salary) from Employees)
-----------------------------------------------------------------

with highsalary as(
	select * from Employees where salary>50000
	),
	lowsalary as(
	select * from Employees where salary<=50000
	)
	select * from highsalary
	union
	select * from lowsalary


	WITH ZORO AS (
	SELECT FIRSTNAME+' '+LASTNAME AS [FULL NAME] FROM PERSON.PERSON )
	SELECT * FROM ZORO WHERE [FULL NAME]  NOT LIKE '%N/A%'

-------------------------------------------------------------------------

select empname,salary from Employees
where Salary > (select avg(salary) from Employees)

select empname,salary,(select avg(salary) from Employees) as avgsal
from Employees

select * from (
select department,avg(salary) as avgsal 
from Employees
group by Department
)as avgdep
where avgsal >40000

select empname,salary,department
from Employees e
where Salary > (select avg(salary) from Employees
where Department=e.Department)




Create a table to log employee deletions
Table: EmployeeDeleteLog
Columns: EmployeeID, DeletedDate

create table EmployeeDeleteLog(
EmployeeID int,
DeletedDate datetime default getdate()
)
create trigger tri_delete
on [HumanResources].[Employee]
after delete
as
begin
	insert into EmployeeDeleteLog(EmployeeID)
	select BusinessEntityID
	from deleted
end
select top 10 * from [HumanResources].[Employee]
select * from EmployeeDeleteLog
delete from [HumanResources].[Employee] where BusinessEntityID=1

UPDATE HumanResources.Employee
SET CurrentFlag = 0
WHERE BusinessEntityID = 1;


Create an AFTER DELETE trigger on HumanResources.Employee to log deleted employees
Table: HumanResources.Employee
Columns: BusinessEntityID, NationalIDNumber, JobTitle, BirthDate


alter table EmployeeDeleteLog(
logid int identity,
BusinessEntityID int,
NationalIDNumber int,
JobTitle varchar(30),
BirthDate datetime
)






Create an AFTER INSERT trigger on Sales.SalesOrderHeader to log new orders
Table: Sales.SalesOrderHeader
Columns: SalesOrderID, OrderDate, CustomerID, TotalDue

Create an AFTER UPDATE trigger on Person.PersonPhone to log phone number changes
Table: Person.PersonPhone
Columns: BusinessEntityID, PhoneNumber, PhoneNumberTypeID, ModifiedDate




create table employee2(
employeeid int,
empname varchar(30),
)
select * from employee2
create table employee_log(
logid int identity,
employeeid int,
empname varchar(30),
status varchar(30),
actionchange datetime default getdate()
)

select * from employee_log

create trigger trig_employee
on employee2
after insert,update,delete
as
begin	
		if exsit





select * from Employees


alter function ranksal(@salary int)
returns varchar(33)
as
begin	
	declare @rsal varchar(33)
	if @salary>=60000
	set @rsal='highsalry'

	else	if @salary>=50000
	set @rsal='midsalry'
	else
	set @rsal='highsalry'
	return @rsal
	end

select empname,department,salary,dbo.ranksal(salary) as grade
from Employees

sp_help'employees'

sp_helptext 'dbo.ranksal';

select * from Employees

create function gettaxamount(@salary int)
returns int
as
begin
	declare @tax int
	if @salary >=40000
	set @tax = @salary*10/100
	if @salary >=50000
	set @tax = @salary*20/100
	if @salary >=60000
	set @tax = @salary*30/100
		
	return @tax
end

select empname,department,salary,dbo.gettaxamount(salary) as taxamount
from Employees



alter table Employees add bod date 

select * from Employees

exec sp_rename 'Employees.bod','dob','column'


UPDATE Employees SET dob = '1996-01-15' WHERE empid = 1;
UPDATE Employees SET dob = '1992-06-23' WHERE empid = 210;
UPDATE Employees SET dob = '1994-03-12' WHERE empid = 211;
UPDATE Employees SET dob = '1995-11-30' WHERE empid = 212;
UPDATE Employees SET dob = '1993-07-08' WHERE empid = 213;
UPDATE Employees SET dob = '1991-09-18' WHERE empid = 214;
UPDATE Employees SET dob = '1997-04-25' WHERE empid = 215;
UPDATE Employees SET dob = '1990-12-05' WHERE empid = 216;
UPDATE Employees SET dob = '1996-02-14' WHERE empid = 217;
UPDATE Employees SET dob = '1992-10-19' WHERE empid = 218;
UPDATE Employees SET dob = '1995-06-21' WHERE empid = 219;
UPDATE Employees SET dob = '1993-03-03' WHERE empid = 220;
UPDATE Employees SET dob = '1991-05-10' WHERE empid = 221;
UPDATE Employees SET dob = '1990-08-16' WHERE empid = 201;
UPDATE Employees SET dob = '1997-09-09' WHERE empid = 202;
UPDATE Employees SET dob = '1992-11-11' WHERE empid = 203;
UPDATE Employees SET dob = '1994-04-04' WHERE empid = 204;
UPDATE Employees SET dob = '1995-01-17' WHERE empid = 205;
UPDATE Employees SET dob = '1993-10-10' WHERE empid = 206;
UPDATE Employees SET dob = '1996-12-12' WHERE empid = 207;
UPDATE Employees SET dob = '1994-07-07' WHERE empid = 209;

alter function getage(@dob date)
returns int
as 
begin 
	declare @age int
	set @age= DATEDIFF(year,@dob,getdate())

	IF (MONTH(GETDATE()) < MONTH(@dob)) 
	   OR (MONTH(GETDATE()) = MONTH(@dob) AND DAY(GETDATE()) < DAY(@dob))
		SET @age = @age - 1

	return @age
end

select * from Employees


select empname,gender,dob,dbo.getage(dob) as age from Employees

	CREATE TABLE BANK(ID		INT,USERNAME		VARCHAR(30),PRINCIPLE			FLOAT,TENURE			FLOAT,RATE FLOAT)

			INSERT INTO BANK 
			VALUES 
			(1	,'PRIYA',					100000	,				1.5		,			16		),
			(2	,'VAISHNAV',			250000	,				3			,			18		),
			(3	,'SKY',					1000000		,			5				,		12				)
			SELECT * FROM BANK

create function getemiamt(@userid int)
returns float
as
begin
		declare @intamt float
		select @intamt=PRINCIPLE*RATE*TENURE/100 FROM BANK
					WHERE ID = @userid
		DECLARE @EMI FLOAT 
					SELECT @EMI = @intamt+PRINCIPLE/(TENURE*12)
					FROM BANK 
					WHERE ID = @userid 
					RETURN @EMI 
				END 
		SELECT DBO.getemiamt(1)
				--@EMI = PRINCIPLE*RATE*TENURE/100+PRINCIPLE/(TENURE*12)


create function alld(@userid int)
returns table
as
	return select * from bank where id=@userid 

select * from alld(3)
		

B. MULTISTATEMENT TABLE VALUES FUNCTION 
	--- RETURN TABLE AS RESULT
	--MULTI0PLE T-S QL QUERIES 
	--USES A TABLE VARIABLE 


create function multi(@userid int,@username varchar(22))
returns @tbl table(USERID INT, USERNAME VARCHAR(30), PRINCIPLE FLOAT, TENURE FLOAT, RATE FLOAT, EMI FLOAT)
as
begin
		INSERT INTO @TBL	(USERID , USERNAME , PRINCIPLE , TENURE , RATE , EMI )
		SELECT ID, USERNAME, PRINCIPLE, TENURE, RATE , PRINCIPLE*RATE*TENURE/100+PRINCIPLE/(TENURE*12) AS EMI  FROM BANK 
			WHERE ID = @USERID 
			RETURN
		END 
		SELECT * FROM BANK 
		SELECT * FROM multi(1, 'PRIYA')


 alter function getage1(@indate date)
 returns int
 as
 begin
	declare @age int
	set @age=DATEDIFF(year,@indate,getdate())

	if(month(getdate()) <month(@indate))
	or (month(getdate()) =month(@indate) and day(getdate()) < day(@indate))
	set @age= @age-1

	return @age

	end

	select dbo.getage1('1998-12-22')

 select datediff(year,'1998-02-22',getdate())	

alter FUNCTION getAgeDetails(@dob DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
  declare @agedetails varchar(80),@year int,@months int,@totalmonths int
  --set @totalmonths=DATEDIFF(year,@dob,getdate())
  set @totalmonths=DATEDIFF(MONTH,@dob,getdate())

  set @year=@totalmonths/12
   SET @months = @totalmonths % 12
  set @agedetails=cast(@year as varchar) +'years'+
					cast(@months as varchar) +'months'


  RETURN @agedetails
END


select dbo.getAgeDetails('1998-02-22')

select dbo.getAgeDetails111('1998-02-22')
	

	CREATE FUNCTION getAgeDetails111(@dob DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @years INT, @months INT, @weeks INT, @days INT
    DECLARE @hours BIGINT, @minutes BIGINT, @seconds BIGINT
    DECLARE @totalMonths INT, @totalDays INT
    DECLARE @ageDetail VARCHAR(MAX)

    -- Total values
    SET @totalMonths = DATEDIFF(MONTH, @dob, GETDATE())
    SET @totalDays = DATEDIFF(DAY, @dob, GETDATE())
    SET @weeks = @totalDays / 7
    SET @days = @totalDays % 7

    SET @hours = DATEDIFF(HOUR, @dob, GETDATE())
    SET @minutes = DATEDIFF(MINUTE, @dob, GETDATE())
    SET @seconds = DATEDIFF(SECOND, @dob, GETDATE())

    -- Breakdown years and months
    SET @years = @totalMonths / 12
    SET @months = @totalMonths % 12

    -- Final formatted string
    SET @ageDetail = 
        CAST(@years AS VARCHAR) + ' years ' +
        CAST(@months AS VARCHAR) + ' months ' +
        CAST(@days AS VARCHAR) + ' days' + CHAR(13) +
        'or ' + CAST(@totalMonths AS VARCHAR) + ' months' + CHAR(13) +
        'or ' + CAST(@weeks AS VARCHAR) + ' weeks ' + CAST(@days AS VARCHAR) + ' days' + CHAR(13) +
        'or ' + CAST(@totalDays AS VARCHAR) + ' days' + CHAR(13) +
        'or ' + CAST(@hours AS VARCHAR) + ' hours' + CHAR(13) +
        'or ' + CAST(@minutes AS VARCHAR) + ' minutes' + CHAR(13) +
        'or ' + CAST(@seconds AS VARCHAR) + ' seconds'

    RETURN @ageDetail
END

select * from bank

alter PROCEDURE get_age(@iage date)
as
select datediff(year,@iage,getdate())

exec get_age '1994-02-22'


select distinct(season) from matches
select * from matches
select * from deliveries

CREATE PROCEDURE GetMaxSeasonScores
AS
BEGIN
    SELECT 
        season AS [Year], 
        MAX(team_total) AS [Highest_Total]
    FROM (
        SELECT 
            d.match_id, 
            m.season, 
            d.batting_team, 
            SUM(d.total_runs) AS team_total
        FROM deliveries d
        JOIN matches m ON d.match_id = m.id
        GROUP BY d.match_id, m.season, d.batting_team
    ) AS match_scores
    GROUP BY season
    ORDER BY season
END

	exec GetMaxSeasonScores

select * from matches
select * from deliveries
insert into deliveries(inning) values(1)

alter procedure getmaxruns
	@year NVARCHAR(10)
	as
	 begin 
			
			select top 1 m.season as [year],
					d.batting_team,
					d.match_id,
					m.date,
					sum(d.total_runs) as tr from deliveries d
					join matches m on d.match_id=m.id
					where m.season=@year
					group by m.season,d.batting_team,d.match_id,m.date
					order by sum(d.total_runs) desc
end

exec getmaxruns '2018'



select repeat(

delete matches

select * from matches




select * from Employees
insert into Employees(empid) values(333)






