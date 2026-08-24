-- 1
create table Project(
    pno int primary key,
    pname varchar(25) not null unique,
    location varchar(25),
    dnum tinyint,
    foreign key (dnum) references Dept(deptno)
);

create table Works_on(
    eno int,
    pno int,
    hours_per_week float,
    primary key (eno, pno),
    foreign key (eno) references Employee(empno),
    foreign key (pno) references Project(pno)
);

-- 2
alter table Employee add constraint fk1 foreign key (depno) references Dept(deptno);

-- 3
alter table Employee add column bdate date;

-- 4
alter table Dept add constraint uk1 unique (dname);

-- 5
alter table Works_on alter column hours_per_week set default 20;

-- 6
alter table Project change column pno proj_num tinyint;

-- 7
rename table Works_on to Emp_WorksOn_Project;

-- 8
alter table Dept modify column deptno tinyint;

-- 9
alter table Employee drop column bdate;

-- 10
-- sudo /opt/lampp/mysqldump -u root College > College.sql

-- 11
create database DummyEmp;
-- sudo /opt/lampp/mysql -u root -p DummyEmp < dumpfile.sql

-- 12
drop DummyEmp;

-- 13
-- create table DummyProject like Project;
create table DummyProject as select * from Project;
-- insert into DummyProject select * from Project;
-- desc DummyProject;
select * from DummyProject;

-- 14
truncate from DummyProject;

-- 15
insert into DummyProject select * from Project;
