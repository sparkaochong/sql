-- 数据库中的对象：表，序列，约束，索引，视图
-- 序列：递增的整数值
CREATE SEQUENCE 序列名称;
-- 创建一个序列
CREATE SEQUENCE test_seq;
-- 获取序列的下一个值
SELECT test_seq.nextval FROM dual;
-- 获取序列的当前的值之前，必须先获取序列的下一个值
SELECT test_seq.currval FROM dual;
-- 删除序列
DROP SEQUENCE test_seq;
-- 序列的用处
DROP TABLE member;
CREATE TABLE member -- 父表(主表)
(
    mid  NUMBER(5),
    name VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
);

-- 主键的值：非空唯一
-- 可以使用序列来为主键获取值
CREATE SEQUENCE seq_mid;
INSERT INTO member(mid,name) VALUES(seq_mid.nextval,'张三');
INSERT INTO member(mid,name) VALUES(seq_mid.nextval,'李四');
INSERT INTO member(mid,name) VALUES(seq_mid.nextval,'王五');

SELECT * FROM member;

DROP SEQUENCE seq_mid;

SELECT seq_mid.nextval FROM dual;
