-- 1. Create 3 users, emp1, emp2, emp3.

-- mariadb -u root College
create user if not exists 'emp1'@'localhost' identified by 'emp1';
create user if not exists 'emp2'@'localhost' identified by 'emp2';
create user if not exists 'emp3'@'localhost' identified by 'emp3';

select user, host from mysql.user where user in ('emp1', 'emp2', 'emp3');

-- 2. Give all privilages on the view created in question 1 (expt7) to emp1.

-- mariadb -u root College
grant all privileges on College.admin_employees to 'emp1'@'localhost';

show grants for 'emp1'@'localhost';

-- 3. Give select and update privilage on name and dno attribute of employee table to grant option.

-- mariadb -u root College
grant select (empname, dept), update (empname, dept) on College.Employee to 'emp2'@'localhost' with grant option;

show grants for 'emp2'@'localhost';

-- 4. Let emp2 grant these privilages to emp1.

-- mariadb -u emp2 -p College
grant select (empname, dept), update (empname, dept) on College.Employee to 'emp1'@'localhost';

show grants for 'emp1'@'localhost';

-- 5. Grant all privilages on all the databases on the mysql server to emp3.

-- mariadb -u root College
grant all privileges on *.* to 'emp3'@'localhost' with grant option;

show grants for 'emp3'@'localhost';

-- 6. Login and check the privilages.

-- mariadb -u emp1 -p College
show grants for 'emp1'@'localhost';

-- mariadb -u emp2 -p College
show grants for 'emp2'@'localhost';

-- mariadb -u emp3 -p College
show grants for 'emp3'@'localhost';

-- 7. Revoke the view privilages from emp1.

-- mariadb -u root College
revoke all privileges on College.admin_employees from 'emp1'@'localhost';

show grants for 'emp1'@'localhost';

-- 8. Provide a list of various privilages available to the user.

-- mariadb -u root College
show privileges;

-- 9. Create an index on empid attribute of employee table.

-- mariadb -u root College
create index if not exists idx_empid on Employee(empno);

show index from Employee where Key_name = 'idx_empid';
