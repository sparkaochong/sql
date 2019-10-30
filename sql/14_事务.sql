-- 事务(transaction)
-- 账户表
CREATE TABLE account(
    id NUMBER(4),
    name VARCHAR2(20),
    money NUMBER(18,2)
);

INSERT INTO account(id,name,money) VALUES(1,'zhangsan',300);
INSERT INTO account(id,name,money) VALUES(2,'lisi',400);
COMMIT;

-- 业务：张三给李四转账200元
UPDATE account SET money = money - 200 WHERE name='zhangsan';
UPDATE account SET money = money + 200 WHERE name='lisi';
COMMIT;
-- 业务：李四给张三转账100元
UPDATE account SET money = money - 100 WHERE name='lisi';
COMMIT;
UPDATE account SET money = money + 100 WHERE name='zhangsan';
ROLLBACK;
-- 导致数据不一致
-- 转账这个行为必须是上面两条语句都成功，或者都失败
UPDATE account SET money = money - 100 WHERE name='lisi';
UPDATE account SET money = money + 100 WHERE name='zhangsan';
ROLLBACK;
-- 在一个 Session 中的多个 DML 操作要么全部成功(COMMIT)要么全部失败(ROLLBACK)，我们把这些 DML 操作称之为一个事务

SELECT * FROM account;

-- 事务有四大特性(ACID)：
-- 1. 原子性(Atomicity)：事务是一个不可分割的工作单位，事务中所有的操作要么全部成功，要么全部失败
-- 2. 一致性(Consistency)：事务必须使得数据库从一个一致性的状态变换到另外一个一致性的状态中
-- 3. 隔离性(Isolation)：多个用户(客户端)并发访问数据库的时候，数据库为每一个用户开启一个事务，这些事务之间可以同时访问数据库，
-- 但是事务与事务之间是无法访问的，只有当事务完成最终的操作的时候，其他的事务才可以看到结果
-- 4. 持久性(Durability)：指一个事务一旦被提交了，它对数据库中数据的改变就是永久性的

-- 隔离性，如果不考虑隔离性的话会出现的问题：
-- 1. 脏读，指一个事务读取另一个未提交的事务的数据，这个是非常危险的
-- 2. 不可重复读，指在一个事务内读取表中的某一行数据，多次读取的结果不一致
    -- 脏读和不可重复读的区别：脏读是读取前一事务并未提交的脏数据，不可重复读是读取了前一事务已经提交的数据
-- 3. 虚读(幻读),指在一个事务内读取到了别的事务插入的数据，导致前后读取数据不一致
    -- 幻读和不可重复读的区别：都是读取另一条已经提交的事务，所不同的时不可重复读查询的都是同一行数据，幻读针对的是一批数据整体

-- 为了解决上面的问题的话，数据库引入了隔离级别的概念，SQL 标准中定义了四种隔离级别：
-- 1. READ UNCOMMITED 级别：幻读、不可重复读、脏读都是允许的
-- 2. READ COMMITED 级别：幻读、不可重复读是允许的(Oracle数据库默认的级别)
-- 3. REPEATABLE READ 级别：只允许幻读，不允许脏读、不可重复读
    -- 一个事务肯定不能读取另一个未提交的事务的数据
    -- 在一个事务内读取表中的某一行数据的时候，多次读取的结果必须是一样的
-- 4. SERIALIZABLE 级别：幻读、不可重复读、脏读都是不允许的
    -- 一个事务肯定不能读取另一个未提交的事务的数据
    -- 在一个事务内读取表中的某一行数据的时候，多次读取的结果必须是一样的
    -- 在一个事务内读取数据，不会受到其他提交事务的影响

-- 隔离级别是越来越苛刻，但是性能是越来越差

-- ORACLE数据库中只支持两种级别：READ COMMITED 和 SERIALIZABLE,默认的是 READ COMMITED级别