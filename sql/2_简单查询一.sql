-- 查询雇员表所有的数据
SELECT *
FROM emp;
-- 先执行 FROM 子句：确定你要查询的表
-- 再执行 SELECT 子句：查询出指定的字段的记录，* 表示所有的字段

-- 指定字段查询
SELECT empno, ename
FROM emp;