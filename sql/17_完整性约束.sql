-- 完整性约束
-- 1. 非空约束
-- 2. 唯一约束
-- 3. 主键约束
-- 4. 检查约束
-- 5. 外键约束

-- 非空约束
-- 要求一个字段的值不能为 null
DROP TABLE member;
CREATE TABLE member(
    mid NUMBER(5),
    name VARCHAR2(50) NOT NULL
);

INSERT INTO member(mid,name) VALUES(1,'zhangsan');
-- 不能将 null 插入到一个有非空约束的字段中
INSERT INTO member(mid,name) VALUES(2,null);
INSERT INTO member(mid) VALUES(3);

-- 唯一约束
DROP TABLE member;
CREATE TABLE member
(
    mid  NUMBER(5),
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(50),
    CONSTRAINT uk_email UNIQUE(email)
);
INSERT INTO member(mid,name,email) VALUES(1,'aochong','aochong@163.com');
-- 插入重复的值则会报错
INSERT INTO member(mid,name,email) VALUES(2,'zhangsan','aochong@163.com');

-- 主键约束 = 非空约束 + 唯一约束
-- 要求：一个字段必须是非空的，并且必须是唯一的
DROP TABLE member;
CREATE TABLE member
(
    mid  NUMBER(5),
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(50),
    CONSTRAINT uk_email UNIQUE(email),
    CONSTRAINT pk_mid PRIMARY KEY(mid)
);
INSERT INTO member(mid,name,email) VALUES(1,'zhangsan','zhangsan@163.com');
INSERT INTO member(mid,name,email) VALUES(2,'jeffy','jeffy@163.com');
INSERT INTO member(mid,name,email) VALUES(3,'lisi','lisi@163.com');

-- 检查约束
DROP TABLE member;
CREATE TABLE member
(
    mid  NUMBER(5),
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(50),
    age NUMBER(3),
    sex VARCHAR2(5),
    CONSTRAINT uk_email UNIQUE(email),
    CONSTRAINT pk_mid PRIMARY KEY(mid),
    CONSTRAINT ck_age CHECK ( age BETWEEN 0 AND 100),
    CONSTRAINT ck_sex CHECK ( sex IN('男','女'))
);
INSERT INTO member(mid,name,email,age,sex) VALUES(1,'zhangsan','zhangsan@163.com',45,'妖');

-- 外键约束
DROP TABLE member;
DROP TABLE book;
-- 一个成员可以有多本书
CREATE TABLE member -- 父表(主表)
(
    mid  NUMBER(5),
    name VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
);
CREATE TABLE book -- 子表(从表)
(
    bid NUMBER,
    title VARCHAR2(20) NOT NULL,
    mid NUMBER(5), -- 表示这本书属于哪一个成员,就是一个外键
    CONSTRAINT fk_mid FOREIGN KEY (mid) REFERENCES member(mid) -- 定义外键约束
);

INSERT INTO member(mid,name) VALUES(1,'张三');
INSERT INTO member(mid,name) VALUES(2,'李四');

INSERT INTO book(bid,title,mid) VALUES (10,'JAVA开发',1);
INSERT INTO book(bid,title,mid) VALUES (11,'ORACLE开发',1);
INSERT INTO book(bid,title,mid) VALUES (12,'ANDROID开发',2);
INSERT INTO book(bid,title,mid) VALUES (13,'OBJECT-C开发',2);
INSERT INTO book(bid,title,mid) VALUES (20,'精神病与GAY',9);

SELECT * FROM member;
SELECT * FROM book;

-- 外键有很多的限制：
-- 1. 必须是有唯一约束或者主键约束的字段才能作为另外一张表的外键
CREATE TABLE book1
(
    bid NUMBER,
    title VARCHAR2(20) NOT NULL,
    mid NUMBER(5), -- 表示这本书属于哪一个成员,就是一个外键
    CONSTRAINT fk_mid FOREIGN KEY (mid) REFERENCES member(name) -- 定义外键约束
);
-- 2. 如果现在主表中的某一行数据有对应的子表数据，那么必须先删除子表中的数据之后才可以删除主表中的数据
DELETE FROM member WHERE mid = 1;
-- 首先要删除子表(从表)中的数据
DELETE FROM book WHERE mid = 1;
-- 然后删除父表(主表)中的数据
DELETE FROM member WHERE mid = 1;
-- 3. 假设现在想删除主表，那么必须先删除子表，才能再删除主表
-- 先删除子表
DROP TABLE book;
-- 再删除主表
DROP TABLE member;
