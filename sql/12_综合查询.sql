-- 需求：查询所有薪资高于公司平均薪资的员工编号、姓名、基本工资、职位、雇用日期
-- 以及所在部门名称、位置、上级领导姓名，公司的工资等级，所在部门的人数，所在部门的平均工资，所在部门平均服务年限
-- 1. 查询公司平均薪资
SELECT AVG(sal) avg_salary FROM emp;
-- 2. 查询所有薪资高于公司平均薪资的员工编号、姓名、基本工资、职位、雇用日期
SELECT empno,
       ename,
       sal,
       job,
       hiredate
FROM emp
WHERE sal > (SELECT AVG(sal) avg_salary FROM emp);
-- 3. 关联 dept 表，查询所在部门名称，部门位置
SELECT e.empno,
       e.ename,
       e.sal,
       e.job,
       e.hiredate,
       d.dname,
       d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE sal > (SELECT AVG(sal) avg_salary FROM emp);
-- 4. 自关联 emp ，查询上级领带姓名
SELECT e.empno,
       e.ename,
       e.sal,
       e.job,
       e.hiredate,
       d.dname,
       d.loc,
       m.ename manager_name
FROM emp e JOIN dept d ON e.deptno = d.deptno
LEFT JOIN emp m ON e.mgr=m.empno
WHERE e.sal > (SELECT AVG(sal) avg_salary FROM emp);
-- 步骤五：关联 salgrade ，查询公司的工资等级
SELECT e.empno,
       e.ename,
       e.sal,
       e.job,
       e.hiredate,
       d.dname,
       d.loc,
       m.ename manager_name,
       s.grade
FROM emp e
JOIN dept d ON e.deptno = d.deptno
LEFT JOIN emp m ON e.mgr=m.empno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal > (SELECT AVG(sal) avg_salary FROM emp);
-- 步骤六：查询每个部门的人数，每个部门的平均工资，每个部门平均服务年限
SELECT
       deptno,
       COUNT(empno) cnt,
       ROUND(AVG(sal),2) avg_salary,
       ROUND(AVG(MONTHS_BETWEEN(sysdate,hiredate)/12)) avg_years
FROM emp
GROUP BY deptno
HAVING deptno IS NOT NULL;
-- 步骤七：查询所有薪资高于公司平均薪资的员工编号、姓名、基本工资、职位、雇用日期，以及所在部门名称、位置、上级领导姓名，公司的工资等级，所在部门的人数，所在部门的平均工资，所在部门平均服务年限
SELECT e.empno,
       e.ename,
       e.sal,
       e.job,
       e.hiredate,
       d.dname,
       d.loc,
       m.ename manager_name,
       s.grade,
       t.cnt,
       t.avg_salary,
       t.avg_years
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
         LEFT JOIN emp m ON e.mgr=m.empno
         JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
         JOIN (SELECT
                   deptno,
                   COUNT(empno) cnt,
                   ROUND(AVG(sal),2) avg_salary,
                   ROUND(AVG(MONTHS_BETWEEN(sysdate,hiredate)/12)) avg_years
               FROM emp
               GROUP BY deptno
               HAVING deptno IS NOT NULL) t ON e.deptno = t.deptno
WHERE e.sal > (SELECT AVG(sal) avg_salary FROM emp);

-- 我们可以定义一个 WITH 子句独立的定义一个子查询
WITH dept_agg AS(
    SELECT
        deptno,
        COUNT(empno) cnt,
        ROUND(AVG(sal),2) avg_salary,
        ROUND(AVG(MONTHS_BETWEEN(sysdate,hiredate)/12)) avg_years
    FROM emp
    GROUP BY deptno
    HAVING deptno IS NOT NULL
)
SELECT e.empno,
       e.ename,
       e.sal,
       e.job,
       e.hiredate,
       d.dname,
       d.loc,
       m.ename manager_name,
       s.grade,
       t.cnt,
       t.avg_salary,
       t.avg_years
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
         LEFT JOIN emp m ON e.mgr=m.empno
         JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
         JOIN dept_agg t ON e.deptno = t.deptno
WHERE e.sal > (SELECT AVG(sal) avg_salary FROM emp);
