-- 需求：查询出雇员中工资最低的那个雇员的全部信息
-- 步骤一：查询出 emp 表中最低的工资
SELECT MIN(sal)
FROM emp;
-- 步骤二：查询出工资等于 800 的这个雇员的信息
SELECT *
FROM emp
WHERE sal = 800;

-- 一个 SQL 语句：子查询
SELECT *
FROM emp
WHERE sal = (SELECT MIN(sal) FROM emp);

-- 需求：查询出基本工资比 ALLEN 低的全部雇员信息
-- 1. 查询 ALLEN 雇员的工资
SELECT sal
FROM emp
WHERE ename = 'ALLEN';
-- 2. 查询工资小于 1600 的雇员
SELECT *
FROM emp
WHERE sal < (SELECT sal FROM emp WHERE ename = 'ALLEN');

-- 需求：查询基本工资高于公司平均薪资的全部雇员信息
-- 1. 查询公司平均薪资
SELECT AVG(sal)
FROM emp;
-- 2. 查询基本工资高于高于公司基本薪资的雇员
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

-- 需求：查询出与 ALLEN 从事同一工作，并且基本薪资高于雇员编号为 7521 的全部雇员信息
-- 1. 查询 ALLEN 的工作
SELECT job
FROM emp
WHERE ename = 'ALLEN';
-- 2. 查询出编号 7521 的雇员信息
SELECT sal
FROM emp
WHERE empno = '7521';
-- 3. 查询出与 ALLEN 从事同一工作，并且基本薪资高于雇员编号为 7521 的全部雇员信息
SELECT *
FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN')
  AND sal > (SELECT sal FROM emp WHERE empno = '7521');

-- 到现在为止，子查询返回的值都是一行一列，=> 来进行过滤
-- 子查询也可以返回一行多列的数据

-- 需求：查询与 SCOTT 从事同一工作且工资相同的雇员信息
-- 1. 查询 SCOTT 从事的工作和工资
SELECT job, sal
FROM emp
WHERE ename = 'SCOTT';
-- 2. 查询与SCOTT从事同一工作且工资相同的雇员信息
SELECT *
FROM emp
WHERE (job, sal) = (SELECT job, sal FROM emp WHERE ename = 'SCOTT');
-- 3. 过滤本人
SELECT *
FROM emp
WHERE (job, sal) = (SELECT job, sal FROM emp WHERE ename = 'SCOTT')
  AND ename <> 'SCOTT';

-- 需求：查询与雇员 7566 从事同一工作且领导相同的全部雇员信息
-- 1. 查询雇员 7566 的工作与领导
SELECT job, mgr
FROM emp
WHERE empno = '7566';
-- 2. 查询与雇员 7566 从事同一工作且领导相同的全部雇员信息
SELECT *
FROM emp
WHERE (job, mgr) = (SELECT job, mgr FROM emp WHERE empno = '7566');

-- 需求：查询与 ALLEN 从事同一工作且在同一年雇佣的全部雇员信息(包括 ALLEN)
-- 1. 查询 ALLEN 从事的工作与雇员日期
SELECT job, TO_CHAR(hiredate, 'yyyy')
FROM emp
WHERE ename = 'ALLEN';
-- 2. 查询与 ALLEN 从事同一工作且在同一年雇佣的全部雇员信息(包括 ALLEN)
SELECT *
FROM emp
WHERE (job, TO_CHAR(hiredate, 'yyyy')) = (SELECT job, TO_CHAR(hiredate, 'yyyy') FROM emp WHERE ename = 'ALLEN');

-- WHERE 子句中的子查询可以返回：单行单列，单行多列
-- WHERE 子查询还可以返回多行单列的数据
-- 需求：查询出每一个部门中最低工资相同的全部雇员信息
-- 1. 查询出每一个部门中最低工资
SELECT MIN(sal)
FROM emp
WHERE deptno IS NOT NULL
GROUP BY deptno;
-- 2. 查询出每一个部门中最低工资相同的全部雇员信息
SELECT *
FROM emp
WHERE sal IN (SELECT MIN(sal) FROM emp WHERE deptno IS NOT NULL GROUP BY deptno);

-- ANY 关键字实现
-- =ANY：等于其中任意一个就符合条件
SELECT *
FROM emp
WHERE sal = ANY (SELECT MIN(sal) FROM emp WHERE deptno IS NOT NULL GROUP BY deptno);

-- 需求：查询出每一个部门中最低工资不相同的全部雇员信息
-- 1. 查询每一个部门最低工资
SELECT MIN(sal)
FROM emp
WHERE deptno IS NOT NULL
GROUP BY deptno;
-- ALL 关键字
-- <>ALL：不等于所有的值则符合条件
SELECT *
FROM emp
WHERE sal <> ALL (SELECT MIN(sal) FROM emp WHERE deptno IS NOT NULL GROUP BY deptno);

-- 需求：查询薪资大于任何一个经理薪资的员工信息
-- 1. 查询所有经理薪资
SELECT sal
FROM emp
WHERE job = 'MANAGER';
-- 2. 查询薪资大于任何一个经理薪资的员工信息
-- 查询出了大于所有经理最小薪资的员工
SELECT *
FROM emp
WHERE sal > ANY (SELECT sal FROM emp WHERE job = 'MANAGER');

-- 需求：查询薪资大于全部经理薪资的员工
SELECT *
FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE job = 'MANAGER');

-- 需求：查询薪资小于任何一个经理薪资的员工信息
-- 查询出小于所有经理中薪资最高的员工
SELECT *
FROM emp
WHERE sal < ANY (SELECT sal FROM emp WHERE job = 'MANAGER');

-- 需求：查询薪资小于全部经理薪资的员工信息
-- 查询出小于所有经理中薪资最低的员工
SELECT *
FROM emp
WHERE sal < ALL (SELECT sal FROM emp WHERE job = 'MANAGER');

-- 需求：查询部门编号、雇员人数、平均工资、并且要求这些部门的平均薪资高于公司平均薪资
-- 1. 查询公司平均薪资
SELECT AVG(sal)
FROM emp;
-- 2. 查询部门编号、雇员人数、平均工资、并且要求这些部门的平均薪资高于公司平均薪资
SELECT deptno,
       COUNT(empno),
       AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (SELECT AVG(sal) FROM emp);

-- 需求：查询出每个部门平均工资最高的部门名称及平均工资
-- 1. 查询出每个部门的最高工资
SELECT MAX(AVG(sal))
FROM emp
GROUP BY deptno;

-- 2. 查询出每个部门的最高工资的部门名称
SELECT d.dname,
       AVG(e.sal)
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING AVG(e.sal) = (SELECT MAX(AVG(sal)) FROM emp GROUP BY deptno);

-- FROM 子句中放子查询
-- 需求：查询出每个部门的编号、名称、位置、部门人数、平均工资
-- 1. 查询出部门编号、名称、位置
SELECT deptno, dname, loc
FROM dept;
-- 2. 部门的编号、部门人数、平均工资
SELECT deptno, COUNT(empno), ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno;
-- 3. 查询出每个部门的编号、名称、位置、部门人数、平均工资
-- 产生笛卡尔积：4 * 4 = 16
SELECT d.deptno,
       d.dname,
       d.loc,
       temp.cnt,
       temp.avg_salary
FROM dept d
         JOIN (SELECT deptno, COUNT(empno) cnt, ROUND(AVG(sal), 2) avg_salary
               FROM emp
               GROUP BY deptno) temp ON d.deptno = temp.deptno;

-- 在 FROM 子句中的子查询相当于一张临时表

-- 完全可以使用 GROUP BY 来完成
-- 产生笛卡尔积：4 * 15 = 60
SELECT d.deptno,
       d.dname,
       d.loc,
       COUNT(e.empno) cnt,
       ROUND(AVG(e.sal), 2)
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
GROUP BY d.deptno, d.dname, d.loc;

-- 在 FROM 子句中使用子查询可以减少笛卡尔积的数据量

-- 需求：查询所有在部门 SALES 工作的员工编号、姓名、基本工资、奖金、职位、雇佣日期、部门的最高和最低工资
-- 1. 查询名字为 SALES 部门的部门编号
SELECT deptno
FROM dept
WHERE dname = 'SALES';
-- 2. 查询所有在部门 SALES 工作的员工编号、姓名、基本工资、奖金、职位、雇佣日期
SELECT empno, ename, sal, comm, job, hiredate
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');
-- 3. 查询部门的最高和最低工资
SELECT deptno,
       ROUND(MAX(sal), 2) max_salary,
       ROUND(MIN(sal), 2) min_salary
FROM emp
GROUP BY deptno;
-- 4. 查询所有在部门 SALES 工作的员工编号、姓名、基本工资、奖金、职位、雇佣日期、部门的最高和最低工资
SELECT e.empno,
       e.ename,
       e.sal,
       e.comm,
       e.job,
       e.hiredate,
       t.max_salary,
       t.min_salary
FROM emp e
         JOIN (SELECT deptno,
                      ROUND(MAX(sal), 2) max_salary,
                      ROUND(MIN(sal), 2) min_salary
               FROM emp
               GROUP BY deptno) t ON e.deptno = t.deptno
WHERE e.deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');

SELECT empno,
       ename,
       sal,
       NVL(comm, 0)       comm,
       job,
       hiredate,
       ROUND(MAX(sal), 2) max_salary,
       ROUND(MIN(sal), 2) min_salary
FROM (SELECT * FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES'))
GROUP BY empno, ename, sal, comm, job, hiredate;

SELECT e.empno,
       e.ename,
       e.sal,
       NVL(e.comm, 0)       comm,
       e.job,
       e.hiredate,
       ROUND(MAX(e.sal), 2) max_salary,
       ROUND(MIN(e.sal), 2) min_salary
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
WHERE d.dname = 'SALES'
GROUP BY e.empno, e.ename, e.sal, e.job, e.hiredate, e.comm;


