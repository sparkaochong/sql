-- 表(table)
-- 创建一张表，表的名字取为 person
-- 建表 SQL 语句
CREATE TABLE person(
    name VARCHAR2(20),
    birthday DATE ,
    sex VARCHAR2(10),
    email VARCHAR2(40)
);

-- 查询表中是否有数据
SELECT * FROM person;

-- 向 person 中插入数据
INSERT INTO person(name,birthday,sex,email) VALUES('Fred',TO_DATE('1980-06-20','YYYY-MM-DD'),'MALE','fred@example.com');
INSERT INTO person(name,birthday,sex,email) VALUES('Jane',TO_DATE('1990-07-15','YYYY-MM-DD'),'FEMALE','jane@example.com');
INSERT INTO person(name,birthday,sex,email) VALUES('George',TO_DATE('1991-08-13','YYYY-MM-DD'),'MALE','george@example.com');
INSERT INTO person(name,birthday,sex,email) VALUES('Bob',TO_DATE('2000-09-12','YYYY-MM-DD'),'MALE','bob@example.com');

COMMIT;

-- 格式化 SQLPLUS
SET PAGESIZE 300;
SET LINESIZE 300;

COL NAME FOR A15;
COL EMAIL FOR A20;

-- SQL 语言分析数据
-- 1. 年龄大于等于 18 岁，并且小于等于 25 岁的男性的所有人的信息
SELECT * FROM person
WHERE MONTHS_BETWEEN(sysdate,birthday) / 12>=18
AND MONTHS_BETWEEN(sysdate,birthday) / 12<=25
AND sex='MALE';

-- 2. 分析男性有多少人，女性有多少人
SELECT sex,COUNT(*) FROM person
GROUP BY sex;