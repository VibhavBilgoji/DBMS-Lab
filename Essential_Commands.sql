-- Start lampp server: sudo /opt/lampp/lampp start
-- start MariaDB: sudo /opt/lampp/bin/mysql -u root -p

-- MariaDB Commands:
show databases;
create database db_name;
use db_name;

-- Example:
create table Student (rollno int, name varchar(20) not null, dob date, dept varchar(25), primary key (rollno));

show tables;

desc Student;

insert into Student values (76, "Vibhav Bilgoji", '2006-02-20', 'Computer');

select * from Student;

select * from Student where dept = 'Computer';

select * from Student where dept = 'Computer' and rollno > 70;

select current_date;

select rollno, name, year(dob) from Student;

-- instead of year, we can use day, month as well
select year(current_date);

update Student set dept='ETC' where rollno = 76;

-- relative update, updates for each row
update Student set rollno = rollno + 5;

update Student set rollno = rollno - 5 where rollno = 69;

delete from Student where rollno = 76;

select * from Student order by dept, rollno;

select * from Student where name like 'vib%';

--# % - any number of any characters
--# _ - any single char
