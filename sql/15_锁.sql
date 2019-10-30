-- 锁
-- 可以多个事务同时去修改同一条记录
-- 2个事务去修改张三这个账号的余额
-- 数据库解决并发问题的方式：锁机制
-- 给表中的某条记录上锁(行级排它锁)
SELECT * FROM account WHERE name = 'zhangsan' FOR UPDATE ;
COMMIT;
UPDATE account SET money = money  + 100 WHERE name='zhangsan';
SELECT * FROM account FOR UPDATE ;
-- 在执行 UPDATE,INSERT,DELETE,SELECT FOR UPDATE,都会隐式上锁