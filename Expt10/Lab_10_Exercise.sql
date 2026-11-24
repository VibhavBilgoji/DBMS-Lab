-- SET 1: Expt No. 9: Stored procedures

-- 1. Write a procedure to get details of all projects.
delimiter //
create or replace procedure GetAllProjects()
begin
    select * from Project;
end //
delimiter ;

call GetAllProjects();

-- 2. Write a procedure which accepts 'empid' as parameter and display his details.
delimiter //
create or replace procedure GetEmployeeDetails(in in_empid int)
begin
    select * from Employee where empno = in_empid;
end //
delimiter ;

call GetEmployeeDetails(1);

-- 3. Write a procedure which accepts 'project_no' as parameter and display the controlling dept_no and no. of employees working on that project.
delimiter //
create or replace procedure GetProjectDeptAndEmpCount(in in_proj_num int)
begin
    select 
        p.proj_num,
        p.pname,
        p.dnum as controlling_dept_no,
        count(distinct w.eno) as no_of_employees
    from Project p
    left join Emp_WorksOn_Project w on p.proj_num = w.pno
    where p.proj_num = in_proj_num
    group by p.proj_num, p.pname, p.dnum;
end //
delimiter ;

call GetProjectDeptAndEmpCount(3);

-- 4. Write procedure which accepts empid as an input and finds the salary and no. of projects he is working on if sal>50000 and no of projects his working on is >2 increase the salary by 5% if salary is between 50000>=60000 and no. of projects >2 increase salary by 2%, if sal>100000 and no of projects >=1 increase salary by 1%. Display empid,sal,no. of projects,increased salary.
delimiter //
create or replace procedure CalculateEmployeeSalaryIncrease(in in_empid int)
begin
    declare v_sal float;
    declare v_proj int default 0;
    declare v_inc_sal float;
    
    select salary into v_sal
    from Employee
    where empno = in_empid;
    
    select count(pno) into v_proj
    from Emp_WorksOn_Project
    where eno = in_empid;
    
    if v_sal > 100000 and v_proj >= 1 then
        set v_inc_sal = round(v_sal * 1.01, 2);
    elseif v_sal > 60000 and v_proj > 2 then
        set v_inc_sal = round(v_sal * 1.05, 2);
    elseif v_sal >= 50000 and v_sal <= 60000 and v_proj > 2 then
        set v_inc_sal = round(v_sal * 1.02, 2);
    else
        set v_inc_sal = v_sal;
    end if;
    
    select 
        in_empid as empid,
        v_sal as sal,
        v_proj as no_of_projects,
        v_inc_sal as increased_salary;
end //
delimiter ;

call CalculateEmployeeSalaryIncrease(13);

-- 5. Write a procedure which executes the same task as in procedure 4 but for all the employees in the database.
delimiter //
create or replace procedure CalculateAllEmployeesSalaryIncrease()
begin
    declare done int default false;
    declare v_empid int;
    declare v_empname varchar(25);
    declare v_sal float;
    declare v_proj int;
    declare v_inc_sal float;
    
    declare cur cursor for 
        select e.empno, e.empname, e.salary, count(w.pno) as proj_count
        from Employee e
        left join Emp_WorksOn_Project w on e.empno = w.eno
        group by e.empno, e.empname, e.salary
        order by e.empno;
        
    declare continue handler for not found set done = true;
    
    drop temporary table if exists Temp_Salary_Increase;
    create temporary table Temp_Salary_Increase (
        empid int,
        empname varchar(25),
        sal float,
        no_of_projects int,
        increased_salary float
    );
    
    open cur;
    
    read_loop: loop
        fetch cur into v_empid, v_empname, v_sal, v_proj;
        if done then
            leave read_loop;
        end if;
        
        if v_sal > 100000 and v_proj >= 1 then
            set v_inc_sal = round(v_sal * 1.01, 2);
        elseif v_sal > 60000 and v_proj > 2 then
            set v_inc_sal = round(v_sal * 1.05, 2);
        elseif v_sal >= 50000 and v_sal <= 60000 and v_proj > 2 then
            set v_inc_sal = round(v_sal * 1.02, 2);
        else
            set v_inc_sal = v_sal;
        end if;
        
        insert into Temp_Salary_Increase values (v_empid, v_empname, v_sal, v_proj, v_inc_sal);
    end loop;
    
    close cur;
    
    select empid, empname, sal, no_of_projects, increased_salary from Temp_Salary_Increase;
    drop temporary table if exists Temp_Salary_Increase;
end //
delimiter ;

call CalculateAllEmployeesSalaryIncrease();
