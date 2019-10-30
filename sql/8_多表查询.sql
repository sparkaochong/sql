-- 单表查询
-- 8个字段14条记录
SELECT *
FROM emp;
-- 3个字段4条记录
SELECT *
FROM dept;
-- 多表查询
-- 11个字段(8+3)56条记录(每个雇员对应着 4 条部门记录，14 * 4 = 56)
SELECT *
FROM emp,
     dept
ORDER BY empno;
-- 笛卡尔积：数据量膨胀(两张表数据量的乘积)
-- 11个字段(8+3)56条记录(每个雇员对应着 4 条部门记录，14 * 4 = 56)
SELECT *
FROM emp,
     dept;

-- 消除笛卡尔积：通过两张表的关联字段
-- emp.deptno = dept.deptno
-- 11个字段(8+3)，14条记录
-- 关联查询，多表查询
SELECT *
FROM emp,
     dept
WHERE emp.deptno = dept.deptno
ORDER BY empno;

-- 多表查询
-- 需求：查询每个员工的编号、姓名、职位、基本工资、部门名称、部门位置信息。
-- 1. 需要查询的表：
--      员工的编号、姓名、职位、基本工资 ： emp
--      部门名称、部门位置 ：dept
-- 2. 利用关联字段来消除笛卡儿积：emp.deptno = dept.deptno
SELECT e.deptno,
       e.ename,
       e.job,
       e.sal,
       d.dname,
       d.loc
FROM emp e,
     dept d
WHERE e.deptno = d.deptno;

-- 需求：查询每个雇员的编号、姓名、雇佣日期、基本工资、工资等级
-- 1. 需要查询的表
--    雇员的编号、姓名、雇佣日期、基本工资 ：emp
--    工资等级 ：salgrade
-- 2. 消除笛卡儿积：emp.sal BETWEEN salgrade.losal AND salgrade.hisal
SELECT *
FROM emp;
SELECT *
FROM salgrade;

SELECT e.deptno,
       e.ename,
       e.hiredate,
       e.sal,
       s.grade
FROM emp e,
     salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

-- 需求：查询每个雇员的姓名、职位、基本工资、部门名称、工资所在公司的工资等级
-- 1. 查询的表：
--    雇员的姓名、职位、基本工资 ：emp
--    部门名称 ：dept
--    工资等级 : salgrade
-- 2. 关联字段：
--    emp.deptno = dept.deptno
--    emp.sal BETWEEN salgrade.losal AND salgrade.hisal
SELECT e.ename,
       e.job,
       e.sal,
       d.dname,
       s.grade
FROM emp e,
     dept d,
     salgrade s
WHERE e.deptno = d.deptno
  AND e.sal BETWEEN s.losal AND s.hisal;

-- 关联查询、多表查询、多表关联查询
-- 表的连接查询，分为两种：
-- 内连接：等值连接
-- 内连接的特点：
-- 左表没有的数据在连接查询结果中不会出现
-- 右表没有的数据在连接查询结果中也不会出现
-- 只有左表和右表中都存在的数据才会显示到连接查询的结果中
SELECT *
FROM emp e,
     dept d
WHERE e.deptno = d.deptno;
-- 我们也可以使用关键字 JOIN ... ON ...
SELECT *
FROM emp e
         JOIN dept d ON e.deptno = d.deptno;
-- USING 有局限性：两张表的关联字段是一样的时候才可以使用
SELECT *
FROM emp e
         JOIN dept d USING (deptno);
-- 下面的连接语句不能够使用 USING
SELECT e.empno,
       e.ename,
       e.hiredate,
       e.sal,
       s.grade
FROM emp e
         JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;
-- 外连接：左外连接、右外连接、全外连接
-- 左外连接：左表数据全部显示，右表数据如果不存在的话则显示为 null
SELECT *
FROM emp e
         LEFT OUTER JOIN dept d ON e.deptno = d.deptno;

-- 右外连接：右表数据全部显示，左表数据如果不存在的话则显示为 null
SELECT *
FROM emp e
         RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

-- 全外连接：左表右表的数据全部显示，如果没有数据的就显示为 null
SELECT *
FROM emp e
         FULL JOIN dept d ON e.deptno = d.deptno;

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm)
VALUES (8888, '张三', 'CLARK', NULL, sysdate, 2000, NULL);

COMMIT;

SELECT *
FROM emp;

-- 以上 OUTER 关键词可以省略
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE empno = 7369;
-- 领导也是公司员工
SELECT *
FROM emp
WHERE empno = 7902;

SELECT *
FROM emp
WHERE empno = 7566;

SELECT *
FROM emp
WHERE empno = 7839;
-- 自身关联
-- 需求：查询出每个雇员的编号、姓名及其上级领导的编号、姓名
-- 1. 需要查询的表：
--      雇员的编号、姓名：emp
--      上级领导的编号、姓名：emp
-- 2. 关联字段：emp.mgr = emp.empno
SELECT *
FROM emp e,
     emp m
WHERE e.mgr = m.empno;

SELECT *
FROM emp e
         JOIN emp m ON e.mgr = m.empno;

-- 要求：没有领导的员工，也需要查询出来，显示左表的所有数据
SELECT *
FROM emp e
         LEFT JOIN emp m ON e.mgr = m.empno;

-- 需求：查询出在 1981 年雇佣的全部雇员的编号、姓名、雇佣日期(按照年-月-日显示)、
-- 工作、领导姓名、雇员月工资、雇员年工资(基本工资+奖金)、雇员工资等级、
-- 部门编号、部门名称、部门位置，并且要求这些雇员的月基本工资在 1500~3500 元之间；
-- 将最后的结果按照年工资的降序排列，如果年工资相等，则按照工作时间进行排序
-- 1. 需要查询的表：
--  雇员的编号、姓名、雇佣日期(按照年-月-日显示)、雇员月工资、雇员年工资(基本工资+奖金)、工作：emp
--  领导姓名: emp
--  部门编号、部门名称、部门位置：dept
--  雇员工资等级：salgrade
-- 2. 确定关联字段(消除笛卡尔积)
--  emp 和 emp 表：emp.mgr = emp.empno
--  emp 和 dept 表：emp.deptno = dept.deptno
--  emp 和 salgrade 表：emp.sal BETWEEN salgrade.losal AND salgrade.hisal

-- 步骤一：查询出在 1981 年雇佣的全部雇员的编号、姓名、雇佣日期(按照年-月-日显示)、工作、
-- 领导姓名、雇员月工资、雇员年工资(基本工资+奖金)、雇员工资等级、
-- 要求这些雇员的月基本工资在 1500~3500 元之间
SELECT e.empno,
       e.ename,
       TO_CHAR(hiredate, 'yyyy-MM-dd') hiredate,
       e.job,
       e.sal,
       (e.sal * 12) + NVL(comm, 0)     year_sal
FROM emp e
WHERE TO_CHAR(hiredate, 'yyyy') = '1981'
  AND e.sal BETWEEN 1500 AND 3500;
-- 步骤二：关联 emp 表，查询领导姓名
SELECT e.empno,
       e.ename,
       TO_CHAR(e.hiredate, 'yyyy-MM-dd') hiredate,
       e.job,
       e.sal,
       (e.sal * 12) + NVL(e.comm, 0)     year_sal,
       m.ename
FROM emp e
         LEFT JOIN emp m ON e.mgr = m.empno
WHERE TO_CHAR(e.hiredate, 'yyyy') = '1981'
  AND e.sal BETWEEN 1500 AND 3500;
-- 步骤三：关联dept表，查询部门编号、部门名称、部门位置
SELECT e.empno,
       e.ename,
       TO_CHAR(e.hiredate, 'yyyy-MM-dd') hiredate,
       e.job,
       e.sal,
       (e.sal * 12) + NVL(e.comm, 0)     year_sal,
       m.ename,
       d.deptno,
       d.dname,
       d.loc
FROM emp e
         LEFT JOIN emp m ON e.mgr = m.empno
         JOIN dept d ON e.deptno = d.deptno
WHERE TO_CHAR(e.hiredate, 'yyyy') = '1981'
  AND e.sal BETWEEN 1500 AND 3500;
-- 步骤四：关联 salgrade 表，查询雇员工资等级
SELECT e.empno,
       e.ename,
       TO_CHAR(e.hiredate, 'yyyy-MM-dd') hiredate,
       e.job,
       e.sal,
       (e.sal * 12) + NVL(e.comm, 0)     year_sal,
       m.ename,
       d.deptno,
       d.dname,
       d.loc,
       s.grade
FROM emp e
         LEFT JOIN emp m ON e.mgr = m.empno
         JOIN dept d ON e.deptno = d.deptno
         JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE TO_CHAR(e.hiredate, 'yyyy') = '1981'
  AND e.sal BETWEEN 1500 AND 3500;
-- 步骤五：将最后的结果按照年工资的降序排列，如果年工资相等，则按照工作时间进行排序
SELECT e.empno,
       e.ename,
       TO_CHAR(e.hiredate, 'yyyy-MM-dd') hiredate,
       e.job,
       e.sal,
       (e.sal * 12) + NVL(e.comm, 0)     year_sal,
       m.ename                           mgr,
       d.deptno,
       d.dname,
       d.loc,
       s.grade
FROM emp e
         LEFT JOIN emp m ON e.mgr = m.empno
         JOIN dept d ON e.deptno = d.deptno
         JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE TO_CHAR(e.hiredate, 'yyyy') = '1981'
  AND e.sal BETWEEN 1500 AND 3500
ORDER BY year_sal DESC, hiredate ASC;

-- 查询 SQL 的语法
SELECT [DISTINCT] *|字段 [[AS] 别名], 字段 [[AS] 别名], ...
    FROM 表名[别名]
    [JOIN 表名 [别名] USING (关联字段)]
    [JOIN 表名 [别名]
ON 关联条件]
    [LEFT | RIGHT | FULL [OUTER] JOIN 表名 [别名] ON 关联条件]
    [
WHERE 条件1 AND | OR 条件2...]
    [
ORDER BY 字段名 [DESC | ASC], 字段名 [DESC | ASC], ...]

-- 查询 SQL 中子句的顺序
-- 1. 先执行 FROM 子句：确定需要查询的表
-- 2. 再执行 WHERE 子句：过滤到不符合条件的数据记录
-- 3. 再执行 SELECT 子句：查询出指定的字段值
-- 4. 最后执行 ORDER BY 子句：对查询出来的结果进行排序

-- UNION：求两个查询 SQL 的并集，不包括重复的记录
-- UNION ALL：求两个查询 SQL 的并集，包括重复的记录
SELECT 12 deptno, '测试部门' dname, '北京' loc
FROM dual
UNION
SELECT *
FROM dept
UNION
SELECT *
FROM dept
WHERE deptno = 10;

-- INTERSECT 求两个查询 SQL 的交集
SELECT *
FROM dept
INTERSECT
SELECT *
FROM dept
WHERE deptno = 10;

-- MINUS 求两个查询 SQL 的差集
SELECT *
FROM dept
MINUS
SELECT *
FROM dept
WHERE deptno = 10;

