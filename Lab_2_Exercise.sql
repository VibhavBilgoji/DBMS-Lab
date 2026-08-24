-- sudo /opt/lampp/mysqldump -u root College > College.sql
-- Creates a backup of the entire database, and stored it in a sql file

select empname from Employee where empname like '____';
select empname from Employee where length(empname) = 4;

select empname from Employee where empname like '%R';

select empname from Employee where empname like 'B%' or empname like 'M%';

select * from Employee where empname between 'A' and 'G';

select * from Employee order by salary asc;

select * from Employee order by dept asc, empname asc;

select empname, hiredate from Employee order by hiredate desc;

select empname from Employee where dept = 30 order by salary desc;

select empname, salary, salary * 0.10 as PF from Employee;

select empname from Employee where adddate(hiredate, interval 2 year) < curdate();
select empname from Employee where datediff(curdate(), hiredate) > 730;
select empname from Employee where hiredate < date_sub(curdate(), interval 2 year);

delete from Employee where gender = 'M' and commission > salary;
