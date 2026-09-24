-- 1. List Employee number, name, department no, and the department name
select e.empno, e.empname, e.dept, d.dname
from Employee e
join Dept d on e.dept = d.deptno;

-- 2. list employee name, department name, and department location
select e.empname, d.dname, d.location
from Employee e
join Dept d on e.dept = d.deptno;

-- 3. list employee name, department name, for all clerks in the company
select e.empname, d.dname
from Employee e
join Dept d on e.dept = d.deptno
where e.job = 'Clerk';

-- 4. list employee name, job, his manager's name, and manager's job
select e.empname as employee_name, e.job as employee_job, m.empname as manager_name, m.job as manager_job
from Employee e
join Employee m on e.managerno = m.empno;

-- 5. display the names of the employeees who are working in sales or research dept.
select e.empname
from Employee e
join Dept d on e.dept = d.deptno
where d.dname in ('Sales', 'Research');

-- 6. display name and salary, of the employee who is working in bengalore
select e.empname, e.salary
from Employee e
join Dept d on e.dept = d.deptno
where d.location = 'Bengalore';

-- 7. display name and commission of the female employees working for the admin dept.
select e.empname, e.commission
from Employee e
join Dept d on e.dept = d.deptno
where e.gender = 'F' and d.dname = 'Admin';

-- 8. display the names of the employees working on 'Cloud Computing' project
select e.empname
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where p.pname = 'Cloud Computing';

-- 9. display all the projects controlled by admin dept.
select p.proj_num, p.pname, p.location, p.dnum
from Project p
join Dept d on p.dnum = d.deptno
where d.dname = 'Admin';

-- 10. display the names of all employees working on 'DBMS' project for more than 20 hours per week.
select e.empname
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where p.pname = 'DBMS' and w.hours_per_week > 20;

-- 11. display the names of the employees working on atleast one project controlled by the same dept to which they belong
select distinct e.empname
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where e.dept = p.dnum;

-- 12. List the names of the projects having the same location as the department controlling it
select p.pname
from Project p
join Dept d on p.dnum = d.deptno
where p.location = d.location;

-- 13. list the names of the managers with the projects they are working on
select distinct e.empname as manager_name, p.pname as project_name
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where e.job = 'Manager';

-- 14. list the name and the salary of the managers who are working on the 'Computerization' project for more than 15 hours per week.
select distinct e.empname, e.salary
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where e.job = 'Manager' and p.pname = 'Computerization' and w.hours_per_week > 15;

-- 15. display the names of the employees working on the project located at 'Mumbai'.
select distinct e.empname
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where p.location = 'Mumbai';
