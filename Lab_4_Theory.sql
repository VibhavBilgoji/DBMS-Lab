-- cartesian product
select * from tb1, tb2;

select * from try, tr2 where b = x;

select * from student, dept where student.deptno = dept.deptno;
-- whole hierarchy: dbname.tbname.colname

--using join command
select * from tb1 join tb2 where condition;

-- cartesian product: big intermediate product
-- join (inner join): checks condition beforehand

--using natual join command
select * from tb1 natural join tb2;
--this works like cartesian product

-- when both tables have same colnmae, it takes equijoin (col1=col2 condition), it takes col only once

select * from try join try1 on try.b = try1.n;
-- similar results but in this case, b column will appear twice

--outer join
select * from try left outer join try1 on try.b = try1.b
-- this is an outer join, in this case, the tb on left (try) will be printed entired, and the rows in try1 that satisfy the condition will be printed, but the rows that don't match will show NULL in the rows;
-- full outer join is not there in mysql, instead we use union

-- union
select * from try union select * from try1;

-- intersect
select * from try intersect select * from try1;

-- minus: not there in mysql

-- full outer join using union
select * from try left outer join try1 on try.b = try1.b union select * from try right outer join try1 on try.b = try1.b

-- for union, same number of columns and same datatypes
select * from try union select * from try1;

-- intersect, same number of columns and same datatypes
select * from try intersect select * from try1;

-- minus, same number of columns and same datatypes
select * from try minus select * from try1;

-- outer joins
-- left outer join using union
select * from try
left outer join try1 on try.b = try1.b;

-- right outer join using union
select * from try
right outer join try1 on try.b = try1.b;

-- full outer join using union
select * from try
left outer join try1 on try.b = try1.b
union
select * from try
right outer join try1 on try.b = try1.b;
