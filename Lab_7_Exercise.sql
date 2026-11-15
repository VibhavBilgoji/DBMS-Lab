-- 1. List all the employees who have a same job as 'Smith'.
select empno, empname, job
from Employee
where job = (
    select job
    from Employee
    where empname = 'Smith'
)
and empname <> 'Smith';

-- 2. Display the names of the employees who are working in sales or research dept.
select empname
from Employee
where dept in (
    select deptno
    from Dept
    where dname in ('Sales', 'Research')
);

-- 3. Display the name and salary of the employee who is working in bangalore.
select empname, salary
from Employee
where dept in (
    select deptno
    from Dept
    where location in ('Bengalore', 'Bangalore')
);

-- 4. List the employee names whose salary is greater than the lowest salary of the employees of 'research' dept.
select empname, salary
from Employee
where salary > (
    select min(salary)
    from Employee
    where dept = (
        select deptno
        from Dept
        where dname = 'Research'
    )
);

-- 5. List the employee names whose salary is greater than the highest salary of the employees of 'admin' dept.
select empname, salary
from Employee
where salary > (
    select max(salary)
    from Employee
    where dept = (
        select deptno
        from Dept
        where dname = 'Admin'
    )
);

-- 6. List the name of the employee earning the highest salary.
select empname, salary
from Employee
where salary = (
    select max(salary)
    from Employee
);

-- 7. List the names of the employees earning highest salary in every dept.
select e.empname, d.dname, e.salary
from Employee e
join Dept d on e.dept = d.deptno
where (e.dept, e.salary) in (
    select dept, max(salary)
    from Employee
    group by dept
);

-- 8. List the details about employees whose salary is second highest in the company.
select *
from Employee
where salary = (
    select max(salary)
    from Employee
    where salary < (
        select max(salary)
        from Employee
    )
);

-- 9. List the details about employees who have maximum number of people reporting to them.
select *
from Employee
where empno in (
    select managerno
    from Employee
    where managerno is not null
    group by managerno
    having count(*) = (
        select max(report_count)
        from (
            select count(*) as report_count
            from Employee
            where managerno is not null
            group by managerno
        ) as counts
    )
);

-- 10. List the employees who earn more than the average salary in their own department.
select e.empno, e.empname, e.dept, e.salary
from Employee e
where e.salary > (
    select avg(e2.salary)
    from Employee e2
    where e2.dept = e.dept
);

-- 11. List the employee and his manager details, where the employee's salary is greater than the manager's salary.
select e.empno as emp_no,
       e.empname as emp_name,
       e.salary as emp_salary,
       m.empno as manager_no,
       m.empname as manager_name,
       m.salary as manager_salary
from Employee e
join Employee m on e.managerno = m.empno
where e.salary > m.salary;

-- 12. Retrieve the name of the department which is offering avg salary less than the avg salary offered by the company.
select d.dname,
       round(avg(e.salary), 2) as avg_dept_salary
from Dept d
join Employee e on d.deptno = e.dept
group by d.deptno, d.dname
having avg(e.salary) < (
    select avg(salary)
    from Employee
);

-- 13. For each department that has more than 2 employees retrieve the department number and number of its employees earning salary above 40k, also retrieve the name of the dept.
select d.deptno,
       d.dname,
       count(e.empno) as emp_count_above_40k
from Dept d
join Employee e on d.deptno = e.dept
where e.salary > 40000
  and d.deptno in (
      select dept
      from Employee
      group by dept
      having count(*) > 2
  )
group by d.deptno, d.dname;

-- 14. Find the employee who spends maximum no of hrs on projects.
select e.empno,
       e.empname,
       sum(w.hours_per_week) as total_hours
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
group by e.empno, e.empname
having sum(w.hours_per_week) = (
    select max(total_hrs)
    from (
        select sum(hours_per_week) as total_hrs
        from Emp_WorksOn_Project
        group by eno
    ) as sub
);

-- 15. Find an employee who works on all the projects controlled by department number = 2.
select e.empno, e.empname
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where p.dnum in (2, 20)
group by e.empno, e.empname
having count(distinct p.proj_num) = (
    select count(*)
    from Project
    where dnum in (2, 20)
);

-- 16. Find the employee who works for maximum hours on a single project.
select e.empno,
       e.empname,
       p.pname as project_name,
       w.hours_per_week
from Employee e
join Emp_WorksOn_Project w on e.empno = w.eno
join Project p on w.pno = p.proj_num
where w.hours_per_week = (
    select max(hours_per_week)
    from Emp_WorksOn_Project
);

-- 17. Find the employee who earns the maximum salary in every dept.
select e.empname, d.dname, e.salary
from Employee e
join Dept d on e.dept = d.deptno
where e.salary = (
    select max(e2.salary)
    from Employee e2
    where e2.dept = e.dept
);