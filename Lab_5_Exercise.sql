-- 1. Retrieve the number of employees working in the company
select count(*) as total_employees
from Employee;

-- 2. List the number of jobs available in the company
select count(distinct job) as total_jobs
from Employee;

-- 3. list the total salaries payable to employees
select sum(salary) as total_salary
from Employee;

-- 4. list the maximum and minumum salary offered by the company
select max(salary) as max_salary, min(salary) as min_salary
from Employee;

-- 5. list the average salary paid to a 'salesperson'
select avg(salary) as avg_salary
from Employee
where job = 'Salesperson';

-- 6. list the total number of 'clerks' in the company
select count(*) as total_clerks
from Employee
where job = 'Clerk';

-- 7. list the number of employees working for the 'admin' dept and minimum salary offerred by the dept.
select count(*) as total_employees, min(e.salary) as min_salary
from Employee e
join Dept d on e.dept = d.deptno
where d.dname = 'Admin';

-- 8. list the earliest date and the latest date someone was hired
select min(hiredate) as earliest_hiredate, max(hiredate) as latest_hiredate
from Employee;

-- 9. count the number of employees whose commission is more than salary
select count(*) as count_commission_gt_salary
from Employee
where commission > salary;

-- 10. count the number of employees working on 'research' project for more than 10 hours per week.
select count(distinct w.eno) as total_employees
from Emp_WorksOn_Project w
join Project p on w.pno = p.proj_num
where p.pname = 'Research' and w.hours_per_week > 10;

-- 11. count the number of projects controlled by admin dept.
select count(*) as total_projects
from Project p
join Dept d on p.dnum = d.deptno
where d.dname = 'Admin';
