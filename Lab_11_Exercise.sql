-- 1. Create 4 tables with attributes mentioned in the brackets: table1(a1), table2(a2), table3(a3), table4(a4,b4). Create a trigger on table1 to insert,delete,update tables table2,table3,table4 respectively. Whenever we insert a value in table1(a1) the same value should be inserted in table2; if the number is present in table3, it should be deleted from table3 and if the number is present in table4(a4) then b4 should be updated(incremented by 1).
drop table if exists table1, table2, table3, table4;

create table table1(
    a1 int
);

create table table2(
    a2 int
);

create table table3(
    a3 int
);

create table table4(
    a4 int,
    b4 int default 0
);

delimiter //
create or replace trigger trg_table1_after_insert
after insert on table1
for each row
begin
    insert into table2 (a2) values (new.a1);
    delete from table3 where a3 = new.a1;
    update table4 set b4 = b4 + 1 where a4 = new.a1;
end //
delimiter ;

insert into table3 (a3) values (10), (20), (30);
insert into table4 (a4, b4) values (10, 5), (40, 2);

insert into table1 (a1) values (10);

select * from table1;
select * from table2;
select * from table3;
select * from table4;

-- 2. Create a table emp_proj with empid,number of projects he is working on, total number of hrs. Create another table proj_info with project number,number of employees working on that project,total number of hrs spent on that project. Whenever we delete an entry from the works_on table respective changes must be done to emp_proj and proj_info tables.
drop table if exists works_on, emp_proj, proj_info;

create table works_on (
    empid int,
    proj_num int,
    hrs float,
    primary key (empid, proj_num)
);

create table emp_proj (
    empid int primary key,
    no_of_projects int default 0,
    total_hrs float default 0
);

create table proj_info (
    proj_num int primary key,
    no_of_employees int default 0,
    total_hrs float default 0
);

insert into works_on (empid, proj_num, hrs)
select eno, pno, hours_per_week
from Emp_WorksOn_Project;

insert into emp_proj (empid, no_of_projects, total_hrs)
select empid, count(proj_num), sum(hrs)
from works_on
group by empid;

insert into proj_info (proj_num, no_of_employees, total_hrs)
select proj_num, count(empid), sum(hrs)
from works_on
group by proj_num;

delimiter //
create or replace trigger trg_works_on_after_delete
after delete on works_on
for each row
begin
    update emp_proj
    set no_of_projects = no_of_projects - 1,
        total_hrs = total_hrs - old.hrs
    where empid = old.empid;

    update proj_info
    set no_of_employees = no_of_employees - 1,
        total_hrs = total_hrs - old.hrs
    where proj_num = old.proj_num;
end //
delimiter ;

select * from works_on where empid = 2;
select * from emp_proj where empid = 2;
select * from proj_info where proj_num = 1;

delete from works_on where empid = 2 and proj_num = 1;

select * from works_on where empid = 2;
select * from emp_proj where empid = 2;
select * from proj_info where proj_num = 1;
