-- 视图(View)
-- 创建一个视图
CREATE VIEW 视图名称 AS 子查询

-- 视图：基本薪资大于2000元的雇员信息的视图
CREATE VIEW sal_greater_than_2000_view
AS
SELECT * FROM emp WHERE sal>2000;

-- 简化用户的查询操作
SELECT * FROM sal_greater_than_2000_view;

-- 使得用户可以以多种角度来看待同一数据
CREATE VIEW emp_20_view
AS
SELECT * FROM emp WHERE deptno=20;

SELECT * FROM emp_20_view;

-- 赋予创建视图的权限
GRANT CREATE VIEW TO scott;