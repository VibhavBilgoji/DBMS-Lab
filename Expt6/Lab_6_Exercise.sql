-- 1. Find out the number of employees in every dept. display the dept name and the count. Also display the maximum, minimum and the average salary offered by each dept.
select d.dname,
       count(e.empno) as emp_count,
       max(e.salary) as max_salary,
       min(e.salary) as min_salary,
       round(avg(e.salary), 2) as avg_salary
from Dept d
join Employee e on d.deptno = e.dept
group by d.deptno, d.dname;

-- 2. List the total salary payable to each dept. display the dept name and the total salary.
select d.dname,
       sum(e.salary) as total_salary
from Dept d
join Employee e on d.deptno = e.dept
group by d.deptno, d.dname;

-- 3. List the jobs and the number of employees in each job. The result should be in the descending order of the number of jobs.
select job,
       count(*) as emp_count
from Employee
group by job
order by emp_count desc;

-- 4. List the jobwise total salary, average salary and minimum salary of employees.
select job,
       sum(salary) as total_salary,
       round(avg(salary), 2) as avg_salary,
       min(salary) as min_salary
from Employee
group by job;

-- 5. List the total salary of employees jobwise for research dept.
select e.job,
       sum(e.salary) as total_salary
from Employee e
join Dept d on e.dept = d.deptno
where d.dname = 'Research'
group by e.job;

-- 6. List the job wise total salary, average salary of employees of 'admin' dept. Display only those jobs having average salary, average salary greater than 50000.
select e.job,
       sum(e.salary) as total_salary,
       round(avg(e.salary), 2) as avg_salary
from Employee e
join Dept d on e.dept = d.deptno
where d.dname = 'Admin'
group by e.job
having avg(e.salary) > 50000;

-- 7. Retrieve the total number of projects controlled by every dept. Display the dept name, and the count.
select d.dname,
       count(p.proj_num) as project_count
from Dept d
join Project p on d.deptno = p.dnum
group by d.deptno, d.dname;

-- 8. Retrieve the total number of employees working on every project. Display the project no, name and the count.
select p.proj_num,
       p.pname,
       count(w.eno) as emp_count
from Project p
join Emp_WorksOn_Project w on p.proj_num = w.pno
group by p.proj_num, p.pname;

-- 9. Retrieve the total time (in hours) spent on every project.
select p.proj_num,
       p.pname,
       sum(w.hours_per_week) as total_hours
from Project p
join Emp_WorksOn_Project w on p.proj_num = w.pno
group by p.proj_num, p.pname;

-- 10. Retrieve the details of project with more than three employees working on it. Also display the average salary offered for that project.
select p.proj_num,
       p.pname,
       p.location,
       p.dnum,
       count(distinct w.eno) as emp_count,
       round(avg(e.salary), 2) as avg_salary
from Project p
join Emp_WorksOn_Project w on p.proj_num = w.pno
join Employee e on w.eno = e.empno
group by p.proj_num, p.pname, p.location, p.dnum
having count(distinct w.eno) > 3;

-- 11. For each dept having more than two female employees retrieve the maximum and minimum salary paid to the female employee.
select d.dname,
       max(e.salary) as max_female_salary,
       min(e.salary) as min_female_salary
from Dept d
join Employee e on d.deptno = e.dept
where e.gender = 'F'
group by d.deptno, d.dname
having count(*) > 2;

-- 12. For each employee display the total number of projects he is working on, and also display the total time (hours per week) he spends on all projects.
select e.empno,
       e.empname,
       count(w.pno) as total_projects,
       sum(w.hours_per_week) as total_hours
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
group by e.empno, e.empname;
