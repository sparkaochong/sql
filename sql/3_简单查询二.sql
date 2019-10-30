-- 在 SQL 中也支持四则运算(+-*/)

-- 需求：查询出所有雇员的编号、雇员姓名、每个雇员的年基本工资(年薪)、日薪
-- empno、ename、sal --> emp
-- 年薪：月薪 * 12
-- 日薪：月薪 / 30
SELECT empno, ename, (sal * 12) 年薪, (sal / 30) 日薪
FROM emp;

-- 假设：每一个员工每年有 5000 元奖励，每个月有 200 补贴
SELECT empno,
       ename,
       (sal + 200) * 12 + 5000 year_sal,
       (sal + 200) / 30        day_sal
FROM emp;

-- 别名：AS ，给 SELECT 子句中的查询字段进行别名，AS 可以省略
SELECT empno,
       ename,
       (sal + 200) * 12 + 5000 AS year_sal,
       (sal + 200) / 30        AS day_sal
FROM emp;

SELECT empno,
       ename,
       (sal + 200) * 12 + 5000 year_sal,
       (sal + 200) / 30        day_sal
FROM emp;

-- 表名也可以设置别名
SELECT e.empno,
       e.ename,
       (e.sal + 200) * 12 + 5000 year_sal,
       (e.sal + 200) / 30        day_sal
FROM emp e;