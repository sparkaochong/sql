-- 分组聚合
-- 需求：查询每个部门的人数
-- 通过 GROPUP BY 子句来进行分组
SELECT deptno,COUNT(1) FROM emp GROUP BY deptno;
-- 需求：查询每个部门的最高薪资、最低薪资
SELECT deptno,MAX(sal),MIN(sal) FROM emp GROUP BY deptno;
-- 需求：查询每种职位的最低薪资、最高薪资
SELECT job,MAX(sal),MIN(sal) FROM emp GROUP BY job;

-- 分组聚合的要求
-- 1. 如果没有分组的话，在 SELECT 子句后面不能同时出现字段和聚合函数
SELECT ename,MAX(sal),COUNT(1),AVG(sal) FROM emp;
-- 2. 有分组的情况下，在 SELECT 子句后面不能出现分组字段之外的字段
SELECT ename,deptno,MAX(sal),MIN(sal),AVG(sal) FROM emp GROUP BY deptno;
-- 3. 聚合函数可以嵌套，但是在使用了嵌套之后，就不能在 SELECT 子句中有任何的字段(包括分组字段)
SELECT deptno,MAX(AVG(sal)) FROM emp GROUP BY deptno;

-- 需求：查询每个部门的名称、部门人数、部门平均薪资、平均服务年限
-- 1. 确定需要查询的表
--  部门名称：dept
--  部门人数、部门平均工资、平均服务年限：emp
-- 2. 确定关联条件：emp.dept = dept.deptno
SELECT
    d.dname,
    COUNT(e.ename) cnt,
    NVL(ROUND(AVG(e.sal),2),0) avg_salary,
    NVL(ROUND(AVG(MONTHS_BETWEEN(sysdate,e.hiredate)/12),2),0) avg_hireyears
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname;
-- 需求：查询公司各个工资等级雇员的数量、平均薪资
-- 1. 确定需要查询的表
-- 工资等级：salgrade
-- 雇员的数量、平均薪资：emp
-- 2. 确定关联条件：emp.sal BETWEEN salgrade.losal AND salgrade.hisal
SELECT
    s.grade,
    COUNT(e.empno),
    ROUND(AVG(e.sal),2)
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade
ORDER BY s.grade DESC;

-- 需求：统计出领取奖金与不领取奖金的雇员的平均工资、平均雇佣年限、雇员人数
-- 1.确定需要查询的表
-- 领取奖金与不领取奖金的雇员的平均工资、平均雇佣年限、雇员人数：emp
SELECT
    '不领取奖金' chinese_desc,
    ROUND(AVG(sal),2) avg_sal,
    ROUND(AVG(MONTHS_BETWEEN(sysdate,hiredate)/12),2) hireyears,
    COUNT(empno) cnt
FROM emp WHERE comm IS NULL
UNION
SELECT
    '领取奖金' chinese_desc,
    ROUND(AVG(sal),2) avg_sal,
    ROUND(AVG(MONTHS_BETWEEN(sysdate,hiredate)/12),2) hireyears,
    COUNT(empno) cnt
FROM emp WHERE comm IS NOT NULL;

-- GROUP BY 后面可以跟若干个字段
-- 需求：查询所有相同部门名称相同职位的最高薪资
-- 1. 确定需要查询的表
-- 部门名称：dept
-- 职位、最高薪资：emp
-- 2. 确定关联条件：emp.deptno = dept.deptno
SELECT
    d.dname,
    e.job,
    MAX(e.sal) max_salary
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY dname, job
ORDER BY dname,max_salary DESC;

-- HAVING 子句：用来对分组之后的数据进行过滤的子句
-- 需求：查询部门人数超过 5 个人的部门
SELECT
    deptno,
    COUNT(empno) dcnt
FROM emp
GROUP BY deptno
HAVING COUNT(empno) > 5;
-- 需求：查询出所有平均工资大于2000的职位信息，平均工资、雇佣人数
SELECT
    job,
    ROUND(AVG(sal),2) avg_salary,
    COUNT(empno)
FROM emp
GROUP BY job
HAVING AVG(sal) > 2000;
-- 需求：查询至少一个员工的所有部门编号、名称，并统计这些部门的平均工资、最低工资、最高工资
-- 1. emp.deptno = dept.deptno
SELECT
    d.deptno,
    d.dname,
    ROUND(AVG(e.sal),2) avg_salary,
    MAX(e.sal) max_salary,
    MIN(e.sal) min_salary
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
GROUP by d.deptno,d.dname
HAVING COUNT(empno)>0;
-- 需求：查询非销售人员工作名称以及从事同一工作雇员的月工资总和，
-- 并且要满足从事同一工作的雇员的月工资合计大于5000元，返回结果按月工资的合计升序排列
-- emp
-- 步骤一：查询非销售人员工作名称
SELECT * FROM emp WHERE job != 'SALESMAN';
-- 步骤二：从事同一工作雇员的月工资总和
SELECT job,
       SUM(SAL) sum_salary
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job;
-- 步骤三：并且要满足从事同一工作的雇员的月工资合计大于5000元
SELECT job,
       SUM(SAL) sum_salary
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal)>5000;
-- 步骤四：返回结果按月工资的合计升序排列
SELECT job,
       SUM(SAL) sum_salary
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal)>5000
ORDER BY sum_salary ASC;

SELECT * FROM emp;

UPDATE emp SET job='CLERK' WHERE ename='张三';

-- 查询 SQL 语法(SQL 1999规范)
SELECT [DISTINCT] *|字段 [[AS] 别名], 字段 [[AS] 别名], ...
    FROM 表名[别名]
    [JOIN 表名 [别名] USING (关联字段)]
    [JOIN 表名 [别名] ON 关联条件]
    [LEFT | RIGHT | FULL [OUTER] JOIN 表名 [别名] ON 关联条件]
    [WHERE 条件1 AND | OR 条件2...]
    [GROUP BY 字段名,字段名,...]
    [HAVING 过滤条件]
    [ORDER BY 字段名 [DESC | ASC], 字段名 [DESC | ASC], ...]

-- 查询 SQL 中子句的顺序
-- 1. 先执行 FROM 子句：确定需要查询的表
-- 2. 再执行 WHERE 子句：过滤到不符合条件的数据记录
-- 3. 再执行 GROUP BY 子句：对数据按照指定字段进行分组
-- 4. 再执行 HAVING 子句：对分组之后的数据进行过滤
-- 5. 再执行 SELECT 子句：查询出指定的字段(分组的字段，对某个字段应用的聚合函数)的值
-- 6. 最后执行 ORDER BY 子句：对查询出来的结果进行排序


