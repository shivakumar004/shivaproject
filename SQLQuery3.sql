select * from HumanResources.Employee

-----------------------string functions---------------------------------------

select ASCII('A')

select ascii('Apple')

select ascii('banana')

select ascii('SQL')
select ascii('123abc')
select ascii('@symbol')

select ascii('shiva') , char(83)
select ascii('Shiva') where 'Shiva' between char(65) and char(90)

SELECT 'shiva' AS Name
WHERE ASCII(LEFT('shiva', 1)) BETWEEN 65 AND 90;

'A' vs 'a'

'Z' vs 'z'

'0' vs 'A'

select
case
	when ascii('A') > ascii('a') then 'A is greater'
	else 'a is greater'
end



select * from EMPLOYEE

select empname
from EMPLOYEE
where ascii(left(empname,1)) between 65 and 90

select char(65)+char(55)
select char(77)+char(10)+char(88)
select 'shiva'+char(10)+'kumar'

select * from EMPLOYEE

SELECT EmpName, CHAR(ASCII(LEFT(EmpName, 1))) AS FirstChar
FROM Employee;

select CHARINDEX('h','shiva')

select charindex ('d','ihsdihsosdnfiwesd',(select CHARINDEX('d','ihsdihsosdnfiwesd')+2))

select CHARINDEX('s','ishdisidhsidhii',11)

select CHARINDEX('@','hello123@example.com')
select CHARINDEX('sql','Learn SQL at W3Schools')

select empname,CHARINDEX('a',empname,3) as p from EMPLOYEE 

-- Find domain of an email
SELECT SUBSTRING('shivakumar@gmail.com', CHARINDEX('@', 'shivakumar@gmail.com') + 1, LEN('shivakumar@gmail.com'));
-- Output: gmail.com
SELECT SUBSTRING('shivakumar@gmail.com',5,10)


select CONCAT('sss','hsss')
select concat(44,44)

select CONCAT('sss',null)

select concat('mr.','shiva','kumar')
select * from HumanResources.Employee
select top 12 concat(firstname,' ',lastname) from person.person

select top 12 * from person.person
select firstname,concat('id',':',businessentityid) as id from person.person

select concat(FirstName,'(id:',businessentityid,')') from person.person

select concat(FirstName,lastname,'@gmail.com') from person.person

SELECT 
  'Test' + NULL AS PlusResult,
  CONCAT('Test', NULL) AS ConcatResult;

  select 'shiva'+' '+'kumar'

select CONCAT_WS('-','shiva','kumar')

select DATALENGTH('shiva  kumar')

select DATALENGTH('odcfoijadoijqoidhowefovkjn,cnkawie0q9uwq0i1	n     ')

select DIFFERENCE('shiva','sai')

DECLARE @d DATETIME = '12/01/2018';
SELECT FORMAT (@d, 'd', 'en-US') AS 'US English Result',
               FORMAT (@d, 'd', 'no') AS 'Norwegian Result',
               FORMAT (@d, 'd', 'zu') AS 'Zulu Result';



select format(getdate(),'t','en-US')as 'Norwegian Result'

SELECT FORMAT(1000000, 'N0') AS CommaNumber;

CREATE TABLE Salaries (Amount DECIMAL(10,2));
INSERT INTO Salaries VALUES (52000), (73450.25), (9999.9);

SELECT FORMAT(Amount, 'C', 'en-IN') AS FormattedSalary FROM Salaries;

select left('shiva',1)

select left('database',4)

select left(firstname,2) as c from Person.Person

declare @no bigint =154994994494


select left(cast(@no as varchar),4)+'****************' as ssss

select left(154994994494,4)+'****************' as ssss


select len('   shiva    ')

select datalength('   shiva    ')

select len('SQL Interview')

select firstname  from Person.Person where len(firstname)>6 

declare @no1 int=49494949;
select len(@no1)

select lower ('SIJDOAD')

select upper ('SIJDOAD')

select ltrim('      sojdoajd')

select rtrim('      sojdoajd         ')

select NCHAR(65)

select NCHAR(65)
select UNICODE('Ahiva')

SELECT NCHAR(number) AS Letter
FROM GENERATE_SERIES(65, 90) AS number; -- OR use numbers manually if no generate_series

select PATINDEX('%shi%','sandojieshi')
SELECT PATINDEX('%@%', 'shiva@gmail.com');   -- Output: 6
SELECT PATINDEX('%com%', 'shiva@gmail.com'); -- Output: 11
SELECT PATINDEX('%z%', 'shiva');             -- Output: 0 (not found)


select replace('shivaosijdkjwdec ojawspadd','s','a')


select REPLICATE('shiva',88)

select REVERSE('shiva')

select right('shiva',2)

select RTRIM('shiva      ')

select SUBSTRING('shivakumar@gamil.com',2,10)

select SUBSTRING('shivakumar@gamil.com',CHARINDEX('@','shivakumar@gamil.com')+1,10)

select trim('#%^;' from '#sdnka3osd#isa%kcn^;')
-----------Numeric Functions:-------------------------
select ABS(-45448)

SELECT AVG(salary) FROM Employees;

SELECT department, AVG(salary) AS avg_salary
FROM HumanResources.Employee
GROUP BY department;

select * from [Person].[Person]
 
select ListPrice
from [Production].[ProductListPriceHistory]
where ListPrice>(select avg(ListPrice)from [Production].[ProductListPriceHistory] )

select CEILING(45.00000002)

select floor(45.92)

select count(additionalcontactinfo) 
from [Person].[Person]

create table school(
class int,
id int,
marks int)

insert into school values(1,101,98)

insert into school values(1,102,96)

insert into school values(1,103,97)


insert into school values(1,104,99)
insert into school values(1,105,95)
insert into school values(1,106,80)
insert into school values(1,107,85)
insert into school values(1,108,98)
insert into school values(1,109,98)
insert into school values(1,110,98)


create database ipl


select max(marks) from school

select min(marks) from school
select avg(marks) from school

select marks from school where marks>(select avg(marks) from school)

select * from HumanResources.Employee

select jobtitle, min(vacationhours)
from HumanResources.Employee
group by JobTitle

select pi()

select POWER(5,2)
select RAND(7)

select sum(businessentityid) from HumanResources.Employee

select CURRENT_TIMESTAMP

SELECT DATEADD(year, 1, getdate()) AS DateAdd;

select DATEDIFF(year,'1996/10/13',getdate())

select DATENAME(year,getdate())

select datepart(month,getdate())

select day(getdate())


select cast(88.021 as int)

select cast('1996/10/8' as datetime)

SELECT CAST(25.65 AS varchar);

select cast('shiva' as int)

SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com');

SELECT CONVERT(int, 25.65);

select CURRENT_USER
SELECT ISNULL('Hello', 'W3Schools.com');
SELECT ISNULL(NULL, 500);

select isnull(null,null)

select * from tblCompany 


























