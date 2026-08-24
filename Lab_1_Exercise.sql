create table Employee(empno int primary key, empname varchar(25) not null, gender varchar(1), job varchar(25), managerno int, hiredate date, salary float(12), commission float(10), dept tinyint);

create table Dept(deptno int primary key, dname varchar(25) not null, location varchar(20));

insert into Employee values(1, "Vibhav", "M", "Developer", 42, '2026-08-15', 45000.00, 12000.00, 1);

select * from Employee;

select * from Dept;

select empno, empname, job, hiredate from Employee;

select empno, empname, job, salary, from Employee where deptno = 10;

INSERT INTO Employee VALUES
(1, 'Vibhav', 'M', 'President', NULL, '2024-01-15', 95000.00, NULL, 10),
(2, 'Walsh', 'M', 'Analyst', 1, '2025-03-10', 45000.00, 5000.00, 10),
(3, 'Faiz', 'M', 'Clerk', 2, '2025-07-22', 18000.00, NULL, 20),
(4, 'Shubham', 'M', 'Salesman', 1, '2026-02-01', 22000.00, 30000.00, 10),
(5, 'Sparsh', 'M', 'Clerk', 2, '2026-04-11', 21000.00, NULL, 15),
(6, 'Siya', 'F', 'Manager', 1, '2024-11-05', 60000.00, 12000.00, 30);

INSERT INTO Dept VALUES
(10, 'Executive', 'Mapusa'),
(15, 'Engineering', 'Panaji'),
(20, 'Research', 'Vasco'),
(30, 'Sales', 'Porvorim');

select empno, empname, job, salary from Employee where dept = 10;

select empname, salary from Employee where job = 'Clerk';

select deptno, dname from Dept where deptno <= 20;

select empname from Employee where Salary < 25000;

select empname from Employee where gender = 'F' and deptno = 30 and salary > 30000;

select empname from Employee, salary, commission from Employee where commission > salary;

select empname, empno from Employee where job = "President";

select * from Employee where commission is NULL;

select empname, empno from Employee where job = "Clerk" or job = "Analyst";

select distinct job from Employee;
