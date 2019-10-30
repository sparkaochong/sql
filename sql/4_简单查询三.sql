-- 在 SELECT 子句中增加一列常量
SELECT e.empno,
       e.ename,
       (e.sal + 200) * 12 / 30 year_sal,
       (e.sal + 200) / 30      day_sal,
       '元'                     salary_unit
FROM emp e;

-- 需求：数据必须按照格式
-- 雇员编号是：XXX 雇员姓名：xxx，基本薪资: XXX元 来进行展示
-- SQL 字符串拼接，|| 来实现字符串的拼接
SELECT '雇员编号：' || empno || ' ,雇员姓名：' || ename || ' ,基本薪资：' || sal || ' 元' emp_info
FROM emp;

-- 总结 查询 SQL 的语法
SELECT [DISTINCT] *|字段名 [[AS] 别名], ...
    FROM 表名 [别名]
