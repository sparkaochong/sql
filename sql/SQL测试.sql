-- 1. 列出至少有一个员工的所有部门的全部信息
select d.dname,count(empno) cnt
from emp e
         right join dept d on d.deptno=e.deptno
group by d.dname,e.deptno
having count(empno)>=1;
-- 2. 查询出基本工资比'SMITH'多的所有员工的全部信息
SELECT * FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename='SMITH');
-- 3. 列出所有员工的姓名及其直接领导的姓名(没有领导的员工也需要查询出来)
SELECT e.ename,m.ename FROM emp e LEFT JOIN emp m ON e.mgr=m.empno;
-- 4. 列出雇佣日期早于其直接领导的所有员工姓名、员工雇佣日期、领导姓名以及领导雇佣日期
SELECT e.ename,e.hiredate,m.ename,m.hiredate FROM emp e JOIN emp m ON e.mgr=m.empno
WHERE e.hiredate < m.hiredate;
-- 5. 查询出部门名称和这些部门的员工信息，同时查询出那些没有员工的部门
SELECT d.dname,e.* FROM dept d LEFT JOIN emp e ON e.deptno=d.deptno;
-- 6. 查询出工作是'CLERK'的员工姓名及其部门名称
SELECT e.ename,d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE e.job='CLERK';
-- 7. 查询出最低基本工资大于1500的各种工作
SELECT job FROM emp GROUP BY job HAVING MIN(sal) > 1500;
-- 8. 查询出在部门 'SALES' 工作的员工的姓名
SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE dname='SALES');
-- 9. 查询基本薪资高于公司平均薪资的所有员工
SELECT * FROM emp WHERE sal>(SELECT AVG(sal) avg_salary FROM emp);
-- 10. 查询在每个部门工作的员工数量、平均工资(保留两位小数)和平均雇佣年限(去掉小数)
SELECT COUNT(e.empno) cnt,
       ROUND(AVG(e.sal),2) avg_salary,
       TRUNC(AVG(MONTHS_BETWEEN(sysdate,e.hiredate)/12)) hire_years
FROM emp e GROUP BY deptno;
-- 11. 查询所有雇员的姓名、部门名称和工资(工资等于基本工资加上奖金)
SELECT e.ename,d.dname,(sal + NVL(comm,0)) sal FROM emp e LEFT JOIN dept d ON e.deptno=d.deptno;
-- 12. 查询所有部门的详细信息和部门人数
WITH dept_cnt AS(
    SELECT deptno,COUNT(*) cnt FROM emp GROUP BY deptno
)
SELECT d.*,t.cnt FROM dept d LEFT JOIN dept_cnt t ON d.deptno = t.deptno;
-- 13. 列出各种工作的最低工资(工资等于基本工资加上奖金)
SELECT job,MIN(sal + NVL(comm,0)) min_salary FROM emp e GROUP BY job;
-- 14. 查询各个部门的 MANAGER 的最低基本工资
SELECT deptno,MIN(sal) min_salary FROM emp e WHERE job='MANAGER' GROUP BY deptno;
-- 15. 查询所有雇员的姓名和年工资(基本工资加上奖金乘以12个月)，按年薪从低到高进行排序
SELECT ename,(sal + NVL(comm,0)) * 12 year_salary FROM emp ORDER BY year_salary;
