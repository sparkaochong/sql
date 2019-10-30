-- 关键字：ORDER BY 来进行排序查询
-- 需求：查询雇员的所有信息，并且按照基本工资由高到低进行排序
SELECT *
FROM emp
ORDER BY sal DESC;
-- 需求：查询雇员的所有信息，并且按照基本工资由低到高进行排序
SELECT *
FROM emp
ORDER BY sal ASC;
-- 需求：查询出所有业务员(CLERK)的详细信息，并且按照基本工资由低到高排序
SELECT *
FROM emp
WHERE job = 'CLERK'
ORDER BY sal;
-- 需求：查询所有雇员的姓名、工作、雇佣日期、基本薪资、并且先按照基本薪资升序排，再按照雇佣日期降序排
SELECT ename, job, hiredate, sal
FROM emp
ORDER BY sal ASC, hiredate DESC;

-- 查询的 SQL 语法
SELECT [DISTINCT] * | 字段名 [[AS] 别名], 字段名 [[AS] 别名], ...
    FROM 表名 [别名]
    [
WHERE 条件]
    [
ORDER BY 字段 [ASC | DESC]], 字段 [ASC | DESC]], ...]

SELECT *, ename, job, hiredate, sal
FROM emp
WHERE job = 'CLERK'
ORDER BY sal;

-- 四个子句的执行顺序
-- 1. FROM 子句：先确定需要查询的表
-- 2. WHERE 子句：针对表中的记录按照条件进行过滤
-- 3. SELECT 子句：查询指定字段的值
-- 4. ORDER BY 子句：对查询出来的字段的值进行排序

