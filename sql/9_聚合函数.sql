-- 单行函数：输入是一行，输出也是一行，输入是多少行，输出就是多少行
-- 聚合函数
-- 需求：查询有多少个雇员
SELECT COUNT(*) FROM emp;

-- COUNT():查询总记录数
-- AVG():求平均值
-- SUM():查询总和
-- MAX():查询最大值
-- MIN():查询最小值

-- COUNT 的时候，函数的参数可以是常量数值，有些时候这种方式比 COUNT(*) 要高效
SELECT COUNT(1) FROM emp;

-- 指定字段进行 COUNT
SELECT COUNT(empno) FROM emp;
-- COUNT 某个字段的时候，会忽略为 null 的值
SELECT COUNT(comm) FROM emp;

-- 需求：查询 emp 表中有多少个工种(工作的种类)
-- COUNT 的时候会计算重复的值
SELECT COUNT(DISTINCT job) FROM emp;

SELECT * from emp;

-- 需求：所有雇员的平均薪资是多少
SELECT AVG(sal) FROM emp;
-- 需求：所有雇员的薪资的总值
SELECT SUM(sal) FROM emp;

-- 查询最高的薪资，最低的薪资是多少
SELECT MAX(sal) FROM emp;

SELECT MIN(sal) FROM emp;