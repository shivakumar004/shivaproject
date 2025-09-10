CREATE TABLE Student11 (
    StudentID INT,
    Name VARCHAR(50),
    Age INT
);

CREATE TABLE Employee1 (
    EmpID INT,
    Name VARCHAR(50),
    Salary INT
);

CREATE TABLE Marks1 (
    MarkID INT,
    StudentID INT,
    Score INT
);

alter table student11 add status varchar(77)

select * from Student11

alter table student11 alter column status char(1)
 

exec sp_rename 'student11.status','studentstatus','column';

alter table student11 add constraint ck_age check (age<=18)

alter table Employee1 add constraint ck_salary check (salary>0)

sp_help 'employee1'

insert Employee1 values(1,'shiva',10)
Add a new column CreatedDate (DATETIME) in Orders with default as GETDATE().
CREATE TABLE Orders (
    OrderID INT,
    CustomerName VARCHAR(50)
);

alter table orders add CreatedDate DATETIME default  GETDATE()
sp_help 'orders'

insert  into orders( orderid,customername ) values(1,'shiva')
select * from orders

alter table student11 add constraint pk_si primary key(studentid)

ALTER TABLE student11 
ALTER COLUMN studentid INT NOT NULL;

alter table marks1 add constraint fk_marks FOREIGN key (studentid) references student11(studentid)
sp_help 'marks1'
sp_help 'student11'
sp_help 'orders'

alter table student11 drop constraint ck_age

alter table orders drop constraint DF__Orders__CreatedD__7C4F7684

SELECT * FROM sys.check_constraints WHERE parent_object_id = OBJECT_ID('Employee');

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;





select ('this is ram''s name')



