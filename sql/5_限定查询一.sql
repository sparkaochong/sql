----------------------------------------------限定查询一-------------------------------
-- 限定查询就是指定条件过滤
-- 需求：查询出基本月薪大于 2000 元的所有的雇员信息
-- 查询的表是：emp
-- 过滤条件： sal > 2000
SELECT *
FROM emp
WHERE sal > 2000;

-- 查询 SQL 的语法
SELECT [DISTINCT] *|字段名 [[AS] 别名], 字段名 [[AS] 别名], ...
    FROM 表名
    [
WHERE 条件]

-- 三个子句的执行顺序
-- 先执行 FROM 子句：确定要查询的表
-- 再执行 WHERE 子句：过滤掉不符合条件的记录
-- 最后执行 SELECT 子句：查询出指定字段的值

-- WHERE 子句：条件 -> boolean ,如果是 true 的话，说明符合条件，如果是 false 的话，说明不符合条件需要过滤

----------------------------------------------限定查询二-------------------------------
-- 需求：查询出所有基本工资小于等于 2000 元的全部雇员信息
SELECT *
FROM emp
WHERE sal <= 2000;
-- 需求：查询雇员名字为 SMITH 的详细信息
SELECT *
FROM emp
WHERE ename = 'SMITH';
-- SQL 中，关键字、字段名、表名不区分大小写，但是一个字段的值是区分大小写

-- 需求：查询所有业务员 (CLERK) 的雇员信息
SELECT *
FROM emp
WHERE job = 'CLERK';
-- 需求：查询所有不是业务员 (CLERK) 的雇员信息
SELECT *
FROM emp
WHERE job != 'CLERK';
SELECT *
FROM emp
WHERE job <> 'CLERK';
SELECT *
FROM emp
WHERE NOT job = 'CLERK';
-- != 和 <> 都是表示不等于

-- 需求：查询出基本工资范围在 1500 ~ 3000 (包含 1500 和 3000) 元的全部雇员信息
-- 条件一：sal >= 1500
-- 条件二：sal <= 3000
-- 条件一和条件二是且的关系：条件一 AND 条件二
SELECT *
FROM emp
WHERE sal >= 1500
  AND sal <= 3000;
-- 还可以使用关键字 BETWEEN ... AND ...
SELECT *
FROM emp
WHERE sal BETWEEN 1500 AND 3000;
-- 需求：查询职位是销售人员(SALESMAN)，并且基本工资高于 1200 元的所有雇员信息
-- 查询的表：emp
-- 条件一：job = 'SALESMAN'
-- 条件二：sal > 1200
-- 条件一 AND 条件二
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND sal > 1200;
-- 需求：查询出 10 部门或者 20 部门中的所有雇员的信息
-- 查询的表：emp
-- 条件一：deptno = 10
-- 条件二：deptno = 20
-- 条件一 OR 条件二
SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 20;
-- 可以使用关键字 IN 来代替上面的查询
SELECT *
FROM emp
WHERE deptno IN (10, 20);
SELECT *
FROM emp
WHERE deptno NOT IN (10, 20);

-- 需求：查询出 10 部门中的经理(MANAGER)或者 20 部门中的业务员(CLERK)的信息
-- 查询的表：emp
-- 第一组条件：deptno = 10 AND job = 'MANAGER'
-- 第二组条件：deptno = 20 AND job = 'CLERK'
-- 第一组条件 OR 第二组条件
SELECT *
FROM emp
WHERE (deptno = 10 AND job = 'MANAGER')
   OR (deptno = 20 AND job = 'CLERK');
-- 需求：查询不是业务员(CLERK)且基本工资大于 2000 员的全部雇员信息
-- 查询的表：emp
-- 条件一：job != 'CLERK'
-- 条件二：sal > 2000;
-- AND
SELECT *
FROM emp
WHERE job != 'CLERK'
  AND sal > 2000;
-- NOT 取反
SELECT *
FROM emp
WHERE NOT (job != 'CLERK' AND sal > 2000);

----------------------------------------------限定查询三-------------------------------
-- 判断空 (null)：
-- IS NULL : 判断是否为 null，如果字段值为 null 的话，那么返回 true, 否则返回 false
-- IS NOT NULL : 判断是否不为 null， 如果字段值为 null 的话，则返回 false, 否则返回 true
-- 需求：查询所有没有领取奖金的雇员信息
SELECT *
FROM emp
WHERE COMM IS NULL
   OR comm = 0;
-- 需求：查询所有领取奖金的雇员信息
SELECT *
FROM emp
WHERE COMM IS NOT NULL;
-- 需求：列出所有不领取奖金，同时基本工资大于 2000 元的全部雇员信息
-- 查询的表：emp
-- 条件一：comm IS NULL OR comm = 0
-- 条件二：sal > 2000
-- AND
SELECT *
FROM emp
WHERE (comm IS NULL OR comm = 0)
  AND sal > 2000;
-- 需求：查询不领取奖金或者领取奖金低于 100 的全部雇员信息
-- 查询的表：emp
-- 条件一：comm IS NULL OR comm = 0
-- 条件二：comm < 100
-- OR
SELECT *
FROM emp
WHERE (comm IS NULL OR comm = 0)
   OR comm < 100;
-- 需求：查询领取奖金的员工的不同工作
-- 查询的表：emp
-- 查询的字段：job
-- 条件：comm IS NOT NULL
SELECT DISTINCT job
FROM emp
WHERE comm IS NOT NULL;
----------------------------------------------限定查询四-------------------------------
-- 模糊查询：LIKE ，NOT LIKE
-- 记住两个特殊的符号：
-- 1. % : 表示匹配任意多个任意字符(0个、多个)
-- 2. _ : 表示匹配一个任意字符，用于限定查询字符串的长度

-- 需求：查询出雇员姓名是以 S 开头的全部雇员信息
-- 查询的表：emp
-- 条件 ：ename LIKE 'S%'
SELECT *
FROM emp
WHERE ename LIKE 'S%';
-- 需求：查询出雇员姓名第 2 个字母是 M 的全部雇员信息
-- 查询的表：emp
-- 条件：ename LIKE '_M%'
SELECT *
FROM emp
WHERE ename LIKE '_M%';
-- 需求：查询姓名中任意位置包含字符 F 的全部雇员信息
-- 查询的表：emp
-- 条件：ename LIKE '%F%'
SELECT *
FROM emp
WHERE ename LIKE '%F%';
-- 需求：查询姓名中不包含字符 M 的全部雇员信息
SELECT *
FROM emp
WHERE ename NOT LIKE '%F%';
-- 需求：查询姓名长度为 6 或者超过 6 的全部雇员信息
-- 查询的表：emp
-- 条件：ename LIKE '______%'
SELECT *
FROM emp
WHERE ename LIKE '______%';
----------------------------------------------综合条件查询-----------------------------
-- 需求：找出部门 10 中所有经理(MANAGER)，部门 20 中所有业务员(CLERK)，
-- 既不是经理又不是业务员但其月基本工资大于 2000 元的所有员工的详细信息，
-- 并且要求这些雇员的姓名中包含字母 S 或字母 K。
-- 查询的表：emp
-- 条件一：deptno = 10 AND job = 'MANAGER'
-- 条件二：deptno = 20 AND job = 'CLERK'
-- 条件三：job NOT IN('MANAGER', 'CLERK') AND sal > 2000
-- 条件四：ename LIKE '%S%' OR ename LIKE '%K%'
-- (条件一 OR 条件二 OR 条件三) AND 条件四
SELECT *
FROM emp
WHERE ((deptno = '10' AND job = 'MANAGER') OR (deptno = '20' AND job = 'CLERK')
    OR (job != 'MANAGER' AND job != 'CLERK' AND sal > 2000))
  AND (ename LIKE '%S%' OR ename LIKE '%K%');