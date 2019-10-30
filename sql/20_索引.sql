-- 索引，可以提高查询效率
-- TABLE ACCESS FULL：全表扫描，性能是很差的

-- B树索引
-- 将数据存储成 B 树：左边的节点比中间节点要小，右边节点比中间节点要大
-- 使用索引查询来提高速度
-- ROWID：用来快速的定位节点所在的行中的所有的数据

-- 有了 B 树索引之后，我们根据这个 B 树索引查询数据的话，性能很快
-- 怎么创建 B 树索引：
-- 1. 自动创建，当某一列上设置了主键约束或者唯一约束的时候
-- 2. 手动创建 B 树索引的语法：
CREATE INDEX 索引名称 ON 表名(列名 [ASC|DESC])

CREATE INDEX index_sal ON emp(sal);

SELECT * FROM emp WHERE sal>1500;
-- INDEX RANGE SCAN ：根据索引字段来查询的，效率很高

-- B 树索引一般使用与连续值的列(字段)
-- 对于非连续的值，比如 deptno(10,20,30),不好使用 B 树索引，使用位图索引


CREATE BITMAP INDEX index_deptno ON emp(deptno);
-- 如果查询所有的列的话，不会走位图索引，只查询一列(主键或者外键约束)的话才会走位图索引
SELECT * FROM emp WHERE deptno = 10;