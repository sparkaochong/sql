-- 行号：ROWNUM，是一个伪列，来生成行号
SELECT ROWNUM,emp.* FROM emp;
-- 这个行号不与任何的记录挂钩
SELECT ROWNUM,emp.* FROM emp WHERE deptno = 10 AND ROWNUM = 1;
-- 取不到第二条数据
SELECT ROWNUM,emp.* FROM emp WHERE deptno = 10 AND ROWNUM = 2;
-- 取得前 N 行数据
SELECT ROWNUM,emp.* FROM emp WHERE ROWNUM <= 5;
-- 取第 6 条到第 10 行数据
SELECT ROWNUM,emp.* FROM emp WHERE ROWNUM BETWEEN 6 AND 10; -- 这是不行的

-- 先取前 10 行数据
SELECT ROWNUM rn,emp.* FROM emp WHERE ROWNUM <= 10;
-- 对上面的结果集的 rn >= 6 取出来
SELECT * FROM (SELECT ROWNUM rn,emp.* FROM emp WHERE ROWNUM <= 10) WHERE rn >= 6;
-- 使用 ROWNUM 对数据进行分页
-- 第一页
SELECT * FROM (SELECT ROWNUM rn,emp.* FROM emp WHERE ROWNUM <= 3*1) WHERE rn >= (1-1)*3+1;
-- 第二页
SELECT * FROM (SELECT ROWNUM rn,emp.* FROM emp WHERE ROWNUM <= 3*2) WHERE rn >= (2-1)*3+1;
-- 第三页
SELECT * FROM (SELECT ROWNUM rn,emp.* FROM emp WHERE ROWNUM <= 3 * 3) WHERE rn >= (3-1)*3+1;

SELECT * FROM emp;

-- currentPage 当前页
-- pageSize 每页行数
SELECT * FROM (SELECT ROWNUM rn,emp.* FROM emp WHERE ROWNUM <= currentPage * pageSize) WHERE rn >= (currentPage-1)*pageSize+1;

-- ROWID：指每一行数据存储的物理地址(这行数据存储在数据库的哪一个文件的哪一行)
-- 跟行数据挂钩，唯一标识一行数据存储的物理位置
-- 面试题：表中有许多重复的记录，需要将重复的数据删掉(保存一个数据)
SELECT ROWID,emp.* FROM emp ;

CREATE TABLE mydept AS SELECT * FROM dept;

SELECT * FROM mydept;

INSERT INTO mydept(deptno,dname,loc) VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO mydept(deptno,dname,loc) VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO mydept(deptno,dname,loc) VALUES(30,'SALES','CHICAGO');
INSERT INTO mydept(deptno,dname,loc) VALUES(20,'RESEARCH','DALLAS');
COMMIT;

SELECT ROWID,mydept.* FROM mydept;

DELETE FROM mydept WHERE ROWID NOT IN(
SELECT MIN(ROWID) FROM mydept GROUP BY deptno,dname,loc);