-- 表的创建、修改、删除等 SQL 语句
-- 使用 DESC 来查看一个表结构
DESC|DESCRIBE emp;

-- Oracle 支持的数据类型
-- 1. NUMBER
-- NUMBER(n)：表示长度为 n 的整数，n 的范围是(1,38)，可以使用 INT 来代替
-- NUMBER()：表示长度为(1,38) 的整数
-- NUMBER(m,n)：表示小数数字,n 表示小数的长度，m 表示整个数字的长度，整数的长度 = 数字的长度 - 小数的长度
    -- 可以使用 FLOAT 来代替
-- NUMBER(18,2)：小数位是2，整数位是16位
-- 2. VARCHAR2
-- VARCHAR2(n)：表示字符串的长度最大可以为n，n的范围是(1,4000) 字节
-- VARCHAR2(10)：可以存储 2 个字节的字符串，4个字节...1~10 个字节，可变的
-- CHAR(n)：保存定长的字符串 n 的范围是 1 ~ 2000 字节
-- 3. 日期相关：DATE
-- DATE：时间类型(包含毫秒)
-- TIMESTAMP：时间类型(包含毫秒)
-- 4. 大数据类型(GB)
-- CLOB：用于存放海量文字的类型，比如：红楼梦，三国演义，大小：4GB
-- BLOB：用于保存二进制数据，比如图片、电影、音乐等

-- 表的创建：
-- 成员表(member)
CREATE TABLE member(
    mid NUMBER(5),
    name VARCHAR2(50) DEFAULT '无名氏',
    age NUMBER(3) DEFAULT 0,
    birthday DATE DEFAULT sysdate,
    note CLOB
);

-- 对于这种 DDL 语句不需要使用 COMMIT
INSERT INTO member(mid,name,age,birthday,note)
VALUES(1,'zhangsan',23,TO_DATE('1996-11-15','yyyy-mm-dd'),'总公司活动的提倡者......................');

ROLLBACK;

INSERT INTO member(mid,name,age,birthday,note)
VALUES(2,'lisi',24,TO_DATE('1995-10-19','yyyy-mm-dd'),'活动志愿者');

INSERT INTO member(mid,age,note)
VALUES(3,20,'活动策划');

COMMIT;

SELECT * FROM member;

-- 另外一种创建表的方式
-- 创建一张表，并且将子查询查询的数据插入到这张新表中
CREATE TABLE 表名 AS 子查询;
CREATE TABLE new_member AS SELECT * FROM member;

SELECT * FROM new_member;

-- 需求：创建一张表，表名是 employee , 这张表的表结构和 emp 保持一模一样
CREATE TABLE employee AS SELECT * FROM emp WHERE 1 != 1;

-- 如果有一个复杂查询的数据需要查询多次，我们可以一次性的将复杂查询的结果放入一张表中
CREATE TABLE emp_statictic_info
AS
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

SELECT * FROM emp_statictic_info;

-- 表的重命名
-- emp_statictic_info 重新命名为 employee_statistic_info
RENAME 旧的表名 TO 新的表名;
RENAME emp_statictic_info TO employee_statistic_info;

-- 表的删除
DROP TABLE 表名;
DROP TABLE employee_statistic_info;
DROP TABLE new_emp;

-- 给一张表新增字段
ALTER TABLE member ADD(sex VARCHAR2(10) DEFAULT '男');
ALTER TABLE member ADD(photo VARCHAR2(100));

-- 修改表的字段
ALTER TABLE member MODIFY(photo VARCHAR2(100) DEFAULT 'photo.jpg');
ALTER TABLE member MODIFY(sex VARCHAR2(5) DEFAULT '女');

-- 修改字段名的话，先删除原有字段，再新增
-- sex --> gender
-- 先需要删除 sex 字段
ALTER TABLE member DROP COLUMN sex;
-- 新增一个名为 gender 的字段
ALTER TABLE member ADD(gender VARCHAR2(5) DEFAULT '女');

ALTER TABLE member DROP COLUMN photo;

SELECT * FROM member;

-- schema 等价于