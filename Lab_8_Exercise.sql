-- 1. Create a view containing the information about all employees belonging to admin department check if view is updatable.
create or replace view Admin_Employees as
select e.empno, e.empname, e.gender, e.job, e.managerno, e.hiredate, e.salary, e.commission, e.dept
from Employee e
join Dept d on e.dept = d.deptno
where d.dname = 'Admin';

select * from Admin_Employees;

select table_name, is_updatable
from information_schema.views
where table_schema = 'College' and table_name = 'Admin_Employees';

-- 2. Create a view for every project containing project no, pname, pbudget, status, plocation, duration and the name, department name, salary of employees working on that project and the no. of hours employee works on the project and check if the view is updatable
create or replace view Project_Employee_Details as
select 
    p.proj_num,
    p.pname,
    p.pbudget,
    p.status,
    p.location as plocation,
    p.duration,
    e.empname,
    d.dname,
    e.salary,
    w.hours_per_week
from Project p
join Emp_WorksOn_Project w on p.proj_num = w.pno
join Employee e on w.eno = e.empno
join Dept d on e.dept = d.deptno;

select * from Project_Employee_Details;

select table_name, is_updatable
from information_schema.views
where table_schema = 'College' and table_name = 'Project_Employee_Details';

-- 3. Create a view to store the number of employees belonging to every department ,their average salary and name of the department and check if the view is updatable
create or replace view Dept_Employee_Stats as
select 
    d.dname,
    count(e.empno) as emp_count,
    round(avg(e.salary), 2) as avg_salary
from Dept d
left join Employee e on d.deptno = e.dept
group by d.deptno, d.dname;

select * from Dept_Employee_Stats;

select table_name, is_updatable
from information_schema.views
where table_schema = 'College' and table_name = 'Dept_Employee_Stats';

-- 4. Create a view to store name, empid, salary and also the details of project he works on like pno, pname, hours and status
create or replace view Emp_Project_Details as
select 
    e.empname,
    e.empno as empid,
    e.salary,
    p.proj_num as pno,
    p.pname,
    w.hours_per_week as hours,
    p.status
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num;

select * from Emp_Project_Details;

-- 5. Using the view created above create another view to store the no. of employees working on every project and total hours spent on that project
create or replace view Project_Emp_Hours as
select 
    pno,
    pname,
    count(distinct empid) as emp_count,
    sum(hours) as total_hours
from Emp_Project_Details
group by pno, pname;

select * from Project_Emp_Hours;

-- 6. Using the view created in question 4 create another view to store the no. of projects each employee works on and the total hours
create or replace view Emp_Project_Count_Hours as
select 
    empid,
    empname,
    count(pno) as no_of_projects,
    sum(hours) as total_hours
from Emp_Project_Details
group by empid, empname;

select * from Emp_Project_Count_Hours;

-- 7. Create a temporary table to store the details of project located at banglore along with employees details working on it.
create temporary table if not exists Bangalore_Project_Employees as
select 
    p.proj_num,
    p.pname,
    p.location as plocation,
    p.pbudget,
    p.status,
    p.duration,
    e.empno,
    e.empname,
    e.job,
    e.salary,
    w.hours_per_week
from Project p
join Emp_WorksOn_Project w on p.proj_num = w.pno
join Employee e on w.eno = e.empno
where p.location in ('Bangalore', 'Bengalore');

select * from Bangalore_Project_Employees;

-- 8. Using the temporary table above find the employees working all projects located at banglore.
create temporary table if not exists Bangalore_Project_Employees as
select 
    p.proj_num,
    p.pname,
    p.location as plocation,
    p.pbudget,
    p.status,
    p.duration,
    e.empno,
    e.empname,
    e.job,
    e.salary,
    w.hours_per_week
from Project p
join Emp_WorksOn_Project w on p.proj_num = w.pno
join Employee e on w.eno = e.empno
where p.location in ('Bangalore', 'Bengalore');

select empno, empname
from Bangalore_Project_Employees
group by empno, empname
having count(distinct proj_num) = (
    select count(distinct proj_num)
    from Bangalore_Project_Employees
);

-- 9. Using the views created above: 1. Find the project with a minimum no. of employees working on it.
select pno, pname, emp_count
from Project_Emp_Hours
where emp_count = (
    select min(emp_count)
    from Project_Emp_Hours
);

-- 10. Using the views created above: 2. Find the employees who works on the maximum projects
select empid, empname, no_of_projects
from Emp_Project_Count_Hours
where no_of_projects = (
    select max(no_of_projects)
    from Emp_Project_Count_Hours
);

-- 11. Using the views created above: 3. Find the department with average salary greater than average offered by company
select dname, avg_salary
from Dept_Employee_Stats
where avg_salary > (
    select avg(salary)
    from Employee
);
