-- Rename Table
alter table oldtbname to newtbname;

-- add primary key
alter table tbname add primary key(keyname);

-- drop primary key
alter table tbname drop primary key;

-- add column
alter table tbname add column colname datatype;

-- drop column
alter table tbname drop column colname;

-- add column with default values
alter table tbname add colname datatype default defaultval;

-- add constraints
-- Example:
alter table tbname add constraint fk1 foreign key (deptno) references dept(deptno);
-- in desc, MUL means foreign key

-- change column datatype
alter table tbname modify column colname datatype;

-- change column name as well as datatype
alter table tbname change column oldcolname newcolname datatype;

-- create table with foreign key constraint
-- Example:
create table try(
    a int primary key,
    b int,
    constraint fk2 foreign key (b) references student(rollno)
);

-- create new table with same structure, including constraints
create table newtbname like oldtbname;

-- copy all data from old table to new table
insert into newtbname select * from oldtbname;

-- create new table with same structure and data, but constraints are not copied
create table newtbname as select * from oldtbname;
