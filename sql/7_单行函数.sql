-------------------------------------------------------- 单行函数 ----------------------------------------------------
-- 要求：对于日薪，有小数点的话，就只保留 2 位小数
-- ROUND
-- 单行函数：输入时一行，输出也是一行
SELECT empno,
       ename,
       (sal * 12)         year_sal,
       (sal / 30)         day_sal,
       ROUND(sal / 30, 2) round_day_sal
FROM emp;

-- 需求：将雇员表中所有雇员的姓名小写
-- LOWER 也是单行函数
SELECT ename        original_name,
       LOWER(ename) lower_name
FROM emp;

-- 单行函数分为五大类：
-- 1. 字符串函数：操作字符串的函数，输入是字符串的函数，操作 VARCHAR2 类型
-- 2. 数值函数：输入是数值的函数，NUMBER 类型
-- 3. 日期函数：输入是日期的函数，Date 类型
-- 4. 转换函数：字符串、数值、日期之间的转换函数
-- 5. 通用函数：数据库特有的一些函数

-------------------------------------------------------- 字符串函数 ----------------------------------------------------
-- dual 是 Oracle 中存在的虚拟表
-- 1. LOWER：将字符串转成小写
SELECT LOWER('jeffy')
FROM dual;
-- 2. UPPER：将字符串转成大写
SELECT UPPER('jeffy')
FROM dual;

SELECT lower(ename),
       upper(ename)
FROM emp;

-- 需求：查询雇员姓名是 SMITH 的详细信息
-- 可以在 WHERE 子句中使用单行函数
SELECT *
FROM emp
WHERE ename = UPPER('SmIth');

-- 需求：查询所有雇员的姓名，要求将每个雇员的姓名以首字母大写的形式出现
-- 3. INITCAP：将字符串的首字母大写，其他字母小写
SELECT INITCAP(ename)
FROM emp;

-- 需求：查询所有雇员的姓名，并且将雇员姓名中所有的字母 A 替换成字符 _
-- 4. REPLACE：字符串替换函数
SELECT ename,
       REPLACE(ename, 'A', '_') replace_name
FROM emp;

-- 需求：查询出姓名长度是5的所有雇员信息
-- 5. LENGTH：计算字符串长度
SELECT ename,
       LENGTH(ename)
FROM emp;

SELECT *
FROM emp
WHERE LENGTH(ename) = 5;

SELECT *
FROM emp
WHERE ename LIKE '_____';

-- 一个汉字占多长,长度是 1
SELECT LENGTH('敖')
FROM dual;

-- 6. SUBSTR：字符串截取函数
-- SUBSTR(字段名, 截取开始的下标(0和1都表示第一个字符)[,要截取的长度])
-- 需求：截取雇员姓名的前三个字符
SELECT ename,
       SUBSTR(ename, 1)
FROM emp;

-- 需求：查询姓名前3个字母是 JAM 的雇员信息
SELECT *
FROM emp
WHERE SUBSTR(ename, 1, 3) = 'JAM';

-- 需求：查询所有10部门雇员的姓名，但是不显示每个雇员姓名的前3个字母
SELECT SUBSTR(ename, 4)
FROM emp
WHERE deptno = '10';

-- 需求：查询每个雇员姓名及其姓名的后3个字母
SELECT LENGTH(ename)
FROM emp;

SELECT ename,
       SUBSTR(ename, LENGTH(ename) - 2)
FROM emp;

-- INSTR：找出字符串在父字符串中的位置
SELECT INSTR('zhangsan', 'an'),
       INSTR('zhangsan', 'gs')
FROM dual;
-- INSTR(列 | 父字符串, 子字符串)，子字符串在列 | 父字符串中出现的位置，如果不存在的话返回0

-- 使用 INSTR 和 SUBSTR 组合截取特定的字符串，比如我们想截取 job 中的子字符串 MAN
SELECT job,
       SUBSTR(job, INSTR(job, 'MAN'))
FROM emp;

SELECT *
FROM emp
WHERE SUBSTR(job, INSTR(JOB, 'MAN')) = 'MAN';

SELECT *
FROM emp
WHERE job LIKE '%MAN';

-- RPAD 和 LPAD：如果字符串长度不够，则进行补充
-- 一个汉字占 2个字节，2个长度
SELECT RPAD('敖翀', 10, '*')
FROM dual;

SELECT LPAD('ac', 10, '*')
FROM dual;

-- TRIM：去除字符串左右空格
-- LTRIM：表示去掉左边的空格
-- RTRIM：表示去掉右边的空格
SELECT TRIM('    aochong       ')
FROM dual;

-------------------------------------数值函数--------------------
-- ROUND(列 | 数值[ 小数位])：四舍五入的方式保留指定的小数位
SELECT ename,
       empno,
       ROUND((sal * 12), 2),
       ROUND((sal / 30), 2)
FROM emp;
-- ROUND 的小数位可以是负数
SELECT ROUND(7889.456223, 1),
       ROUND(7889.456223),
       ROUND(7889.456223, -1)
FROM dual;

-- TRUNC(列|数值,小数位数)：不是使用四舍五入的方式保留指定的小数位
SELECT TRUNC(7889.456223, 1),
       TRUNC(7889.456223),
       TRUNC(7889.456223, -1)
FROM dual;

-------------------------------------日期函数--------------------
-- 输入的数据类型是 ：DATE
-- 查询当前的时间
-- sysdate 年、月、日、时分秒，不包含毫秒
SELECT sysdate
FROM dual;
-- 包含毫秒数
SELECT systimestamp
FROM dual;
-- 日期是可以进行相加减的
SELECT (sysdate - 3) three_day_befor
FROM dual;

SELECT (sysdate + 3) three_day_later
FROM dual;

-- 日期 - 日期 = 天数
-- 需求：查询出每个雇员到今天为止的雇佣天数，以及十天前每个雇员的雇佣天数
SELECT emp.*,
       TRUNC(sysdate - hiredate),
       TRUNC(sysdate - hiredate - 10)
FROM emp;

-- ADD_MONTHS 函数
-- ADD_MONTHS(日期|日期字段，月数)：对指定的日期增加月数
SELECT ADD_MONTHS(sysdate, 3)
FROM dual;
SELECT ADD_MONTHS(sysdate, -3)
FROM dual;

-- 需求：查询显示所有雇员在被雇佣三个月之后的日期
SELECT emp.*, ADD_MONTHS(hiredate, 3)
FROM emp;

SELECT hiredate
FROM emp;

-- MONTH_BETWEEN 函数
-- MONTH_BETWEEN(日期1,日期2)：求两个指定日期之间的月数
-- 需求：查询出每个雇员的编号、姓名、雇佣日期、雇佣的月数及年份
-- 年份：MONTH_BETWEEN(sysdate,hiredate) / 12
SELECT empno,
       ename,
       hiredate,
       TRUNC(MONTHS_BETWEEN(sysdate, hiredate))      hire_month,
       TRUNC(MONTHS_BETWEEN(sysdate, hiredate) / 12) year
FROM emp;
-- 查询下一个星期二的日期
-- NEXT_DAY(日期|日期列, 星期x)：查询下一个星期 x 的日期
SELECT NEXT_DAY(sysdate, '星期一')
FROM dual;

-- 查询当前月份的最后一天日期
-- LAST_DAY(日期|日期列)：指定的日期所在月份的最后一天日期
SELECT LAST_DAY(sysdate)
FROM dual;

-- 需求：查询所有是在其雇佣所在月的倒数第三天被公司雇佣的雇员的完整信息
-- 雇佣日期所在月的倒数第三天 = 所在月最后一天日期 - 2
SELECT *
FROM emp
WHERE hiredate = LAST_DAY(hiredate) - 2;

-- EXTRACT ：提取一个日期中的年、月、日、时、分、秒
SELECT EXTRACT(YEAR FROM sysdate)          year,
       EXTRACT(MONTH FROM sysdate)         month,
       EXTRACT(DAY FROM sysdate)           day,
       EXTRACT(HOUR FROM systimestamp) + 8 hour,
       EXTRACT(MINUTE FROM systimestamp)   minute,
       EXTRACT(SECOND FROM systimestamp)   second
FROM dual;

-- 需求：查询每个雇员雇佣日期的年、月、日
SELECT EXTRACT(YEAR FROM hiredate),
       EXTRACT(MONTH FROM hiredate),
       EXTRACT(DAY FROM hiredate)
FROM emp;

----------------------------------------转换函数---------------------
-- 字符串、日期、数值之间的转换
-- TO_CHAR ：转成字符串
-- TO_DATE ：转成日期类型的数据
-- TO_NUMBER ：转成数值

-- TO_CHAR(日期 | 日期字段, 一定的格式)
SELECT sysdate,
       TO_CHAR(sysdate, 'YYYY-MM-DD'),
       TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:ss'),
       TO_CHAR(sysdate, 'FMYYYY-MM-DD HH24:MI:ss')
FROM dual;

-- 需求：查询出所有在每年 2 月份雇佣的雇员信息
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) = 2;
SELECT *
FROM emp
WHERE TO_CHAR(hiredate, 'MM') = '02';
SELECT *
FROM emp
WHERE TO_CHAR(hiredate, 'MM') = 2;

-- 需求：将每个雇员的雇佣日期进行格式化显示
-- 要求所有的雇佣日期可以按照 年-月-日 的形式显示，雇佣的年、月、日也拆开分别显示
SELECT TO_CHAR(hiredate, 'YYYY-MM-DD'),
       TO_CHAR(hiredate, 'yyyy') year,
       TO_CHAR(hiredate, 'mm')   month,
       TO_CHAR(hiredate, 'dd')   day
FROM emp;

-- TO_DATE(字符串日期, 对应的日期格式)：将字符串转成日期
-- 2019-08-08 12:23:23
SELECT TO_DATE('2019/10/27 15-41-35', 'yyyy-MM-dd HH24:MI;ss')
FROM dual;

---------------------------------------通用函数---------------------
-- NVL(表达式, 默认值)：如果表达式不为 null 的话，那么返回表达式的值，否则返回默认值
SELECT NVL(NULL, 0)
FROM dual;
SELECT NVL(4, 0)
FROM dual;

-- 需求：要求查询每个雇员的编号、姓名、职位、雇佣日期、年薪
-- 年薪等于：月基本薪资 * 12 + 奖金
-- 和 null 进行计算结果就是 null
SELECT empno,
       ename,
       job,
       hiredate,
       sal * 12 + NVL(comm, 0) year_sal
FROM emp;

-- NVL2(表达式, 表达式, 默认值)：如果表达式一不为 null 的话，那么返回表达式二的值，否则返回默认值
SELECT empno,
       ename,
       job,
       hiredate,
       NVL2(comm, sal * 12 + comm, sal * 12) year_sal
FROM emp;

-- NULLIF(表达式1, 表达式2)
-- 如果 表达式1 和 表达式2 的值相等的话，那么返回 null，否则的话返回 表达式1 的值
SELECT NULLIF(1, 1)
FROM dual;
SELECT NULLIF(1, 5)
FROM dual;

-- 需求：将雇员的姓名和职位的长度进行比较，如果一样的话则返回0，否则返回姓名的长度
SELECT ename, job, NVL(NULLIF(LENGTH(ename), LENGTH(job)), 0)
FROM emp;

-- DECODE(列|值,判断值1,返回结果1,判断值2, 返回结果2, ...,默认值)

-- 需求：查询每个雇员的基本信息，要求，工作使用中文来替换
-- 如果 job 是 CLERK 那么就换成业务员，
-- 如果 job 是 SALESMAN 那么就换成销售人员，
-- 如果 job 是 MANAGER 那么就换成经理，
-- 如果 job 是 ANALYST 那么就换成分析员，
-- 如果 job 是 PRESIDENT 那么就换成总裁
SELECT emp.*,
       DECODE(job, 'CLERK', '业务员'
           , 'SALESMAN', '销售人员',
              'MANAGER', '经理',
              'ANALYST', '分析员', '职员') ch_job
FROM emp;

-- CASE WHEN
SELECT emp.*,
       CASE job
           WHEN 'CLERK' THEN '业务员'
           WHEN 'SALESMAN' THEN '销售人员'
           WHEN 'MANAGER' THEN '经理'
           WHEN 'ANALYST' THEN '分析员'
           WHEN 'PRESIDENT' THEN '总裁'
           END ch_job
FROM emp;

-- 需求：显示每个雇员的姓名、工资、职位，同时显示新的工资，
-- 新工资的标准为业务员增长 10%，销售人员增长 20%，经理增长 30%，其他职位的人增长 50%
-- 等值判断，和 DECODE 功能一样
-- 范围判断，DECODE实现不了
SELECT emp.*,
       CASE job
           WHEN 'CLERK' THEN sal * 1.1
           WHEN 'SALESMAN' THEN sal * 1.2
           WHEN 'MANAGER' THEN sal * 1.3
           WHEN 'ANALYST' THEN sal * 1.5
           WHEN 'PRESIDENT' THEN sal * 1.5
           END
FROM emp;

-- 需求：查询雇员的姓名、工资、工资的等级
-- 工资的等级是：
-- 大于0元且小于等于 1500 的话就是level1
-- 大于1500且小于等于2500 的话就是level2
-- 大于2500且小于等于4500 的话就是level3
-- 大于4500 的话就是level4
SELECT ename,
       sal,
       CASE
           WHEN sal > 0 AND sal <= 1500 THEN 'level1'
           WHEN sal > 1500 AND sal <= 2500 THEN 'level2'
           WHEN sal > 2500 AND sal <= 4500 THEN 'level3'
           ELSE 'level4'
           END sal_grade
FROM emp
ORDER BY sal DESC;

-- DECODE 和 CASE WHEN 的区别：
-- 1. DECODE 只有 Oracle 才有，其他数据库不支持
-- 2. CASE WHEN的用法，Oracle、SQL Server、MySQL都支持
-- 3. DECODE 只能做等值判断，CASE WHEN可用于=,>=,<,<=,<>,is null,is not null等的判断
-- 4. DECODE 使用其来比较简洁，CASE 虽然复杂但更为灵活
-- 5. 另外，在DECODE中，null 和 null 是相等的，但在 CASE WHEN 中，只能用 is null 来判断，示例如下：

-- 需求：emp表中有一列comm,如果这列为null，则显示为0，否则，显示为原值
SELECT comm,
       DECODE(comm, NULL, 0, comm)
FROM emp;

SELECT comm,
       CASE comm
           WHEN NULL THEN 0
           ELSE comm
           END
FROM emp;

SELECT comm,
       CASE
           WHEN comm IS NULL THEN 0
           ELSE comm
           END
FROM emp;


