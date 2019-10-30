-- 先创建一张名为 new_emp 的表，将 emp 表中为部门 20 和 30 的数据导入到表 new_emp
CREATE TABLE new_emp AS SELECT * FROM emp WHERE deptno IN(20,30);
-- new_emp 的表结构和 emp 是一模一样的
SELECT * FROM new_emp;
SELECT * FROM emp;
-- 增
-- INSERT 子句向表中增加一条记录
INSERT INTO new_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(9999,'jeffy','CLERK',7902, to_date('1990-10-30','yyyy-mm-dd'),2000,200,30);

INSERT INTO new_emp(empno,ename,job,hiredate,sal)
VALUES(6666,'zhangsan','CLERK', to_date('1990-01-30','yyyy-mm-dd'),3450);

SELECT * FROM emp WHERE deptno = 10;
-- 将 emp 中的部门10的所有数据插入到 new_emp 中
INSERT INTO new_emp SELECT * FROM emp WHERE deptno = 10;

-- 改
-- UPDATE 子句
-- 需求：将 SMITH(员工编号是7369) 的工资修改为 3000 元，并且每个月有 500 元的奖金
UPDATE new_emp SET SAL=3000,comm=500 WHERE ename='SMITH';
-- 需求：将工资低于平均工资的雇员的基本工资上涨20%
SELECT *  FROM new_emp WHERE sal < (SELECT AVG(sal) FROM new_emp);

UPDATE new_emp SET sal = sal * 1.2 WHERE sal < (SELECT AVG(sal) FROM new_emp);
-- 需求：一次性上涨公司全部员工的基本工资，每个雇员的基本工资上涨10%
UPDATE new_emp SET sal = sal * 1.1;

SELECT * FROM new_emp;
-- 需求：将雇员 7369 的职位、基本工资、雇用日期更新为 7839 相同的信息
SELECT * FROM emp WHERE empno IN(7369,7839);

UPDATE new_emp SET (job,sal,hiredate) = (SELECT job,sal,hiredate FROM emp WHERE empno=7839) WHERE empno=7369;
INSERT INTO new_emp SELECT * FROM emp WHERE empno=7839;
SELECT * FROM new_emp;
-- 删(DELETE)
-- 需求：删除雇员编号是 7566 的雇员信息
SELECT * FROM new_emp WHERE empno=7566;
DELETE FROM new_emp WHERE empno=7566;
-- 需求：想删除部门为 30 内的所有员工
SELECT * FROM new_emp WHERE deptno=30;
DELETE FROM new_emp WHERE deptno=30;
-- 需求：删除雇员编号为 7369, 7566, 7788 的雇员信息
SELECT * FROM new_emp WHERE empno IN(7369,7566,7788);
DELETE FROM new_emp WHERE empno IN(7369,7566,7788);
-- 需求：删除所有在 1987 年雇佣的雇员
SELECT * FROM new_emp WHERE TO_CHAR(hiredate,'yyyy')='1987';
DELETE FROM new_emp WHERE TO_CHAR(hiredate,'yyyy') = '1987';
-- 需求：删除公司工资最高的员工
SELECT * FROM new_emp WHERE sal=(SELECT MAX(sal) max_salary FROM emp);
DELETE FROM new_emp WHERE sal = (SELECT MAX(sal) max_salary FROM emp);
-- 需求：清空表中所有数据
DELETE FROM new_emp;
TRUNCATE TABLE new_emp;
SELECT * FROM new_emp;
-- 提交和回滚的问题
INSERT INTO new_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(9999,'jeffy','CLERK',7902, to_date('1990-10-30','yyyy-mm-dd'),2000,200,30);
-- 回滚：从缓冲区删除数据
ROLLBACK;
-- 提交：从缓冲区提交数据到数据库
-- 1. 当前的 Session 可以查询数据，其他的 Session 也可以查询当前 Session 更改之后的数据
-- 2. 提交了之后，就不能再回滚了(缓冲区就没有数据了)
COMMIT;
-- 设置自动提交
SET AUTOCOMMIT ON;
-- 设置手动提交
SET AUTOCOMMIT OFF;
-- 只要是 DML 操作(INSERT, UPDATE, DELETE) 都需要考虑是回滚还是提交