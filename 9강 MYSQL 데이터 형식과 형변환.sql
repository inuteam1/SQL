-- my sql 데이터 형식
-- 정수형 ( TINYINT 1byte -128~ 127 --> 나이에 적절 / SMALLINT / INT / BIGINT)

use market_db;
CREATE TABLE hongong4(
	tinyint_col TINYINT,
    smallint_col SMALLINT,
    int_col INT,
    bigint_col BIGINT);
    
insert into hongong4 values (127, 32767, 2147483647, 90000000000000000);
insert into hongong4 values (128, 32767, 2147483647, 90000000000000000); -- smallint 열이 범위를 넘음

-- 틀린 건 아니지만, 인원수가 큰편이 아닌데 int로 쓴다? 낭비..!!
-- tinyint -128~ 127인데 tinyint unsigned 0~ 255 똑같이 256개의 수. 

-- 문자형 CHAR 속도 향상 -> 글자 크기가 고정인 경우가 좋다.
-- 문자형 VARCHAR 공간 효율적  -> 글자 크기가 변동하는 경우가 좋다.
-- 연락처의 국번 (02, 032, 031) 도 CHAR로 -> INT일 경우 2,32,31로 인식.
-- 연락처의 나머지(하이픈 제외) 번호로 연산할 일은 없으니 문자형이 더 일반적.

-- CHAR(255) VARCHAR(16383) 최대 글자 수

CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie
	(movie_id INT,
	 movie_title VARCHAR(30),
     movie_director VARCHAR(20),
     movie_star VARCHAR(20),
     movie_script LONGTEXT,
     movie_film LONGBLOB);
     
	-- LONGTEXT 자막과 같은 긴 텍스트 LONGBLOB 영화 파일과 같은 다른 형식
    
-- 실수형 FLOAT: 4바이트, 소수점 아래 7자리까지/ DOUBLE: 8바이트, 소수점아래 15자리까지
-- 날짜형 (DATE 3바이트, 날짜만 YYYY-MM-DD,
-- TIME 3바이트, 시간만 HH:MM:SS, DATETIME 8바이트, 날짜 및 시간 YYYY-MM-DD HH:MM:SS)

-- 변수 
USE market_db;
SET @myVar1 =5;

SELECT @myVar1; -- 현재 상황에서 사용하는, 임시로 하는 저장일 뿐임.

SET @txt = '가수이름==>';
SET @height = 166;
SELECT @txt, mem_name FROM member WHERE height > @height;
SELECT '가수이름==>', mem_name FROM member WHERE height > 166;

SET @count =3;
SELECT mem_name, height FROM member ORDER BY height LIMIT @count;

-- 오류가 남. limit 변수로 안 됨 그래서 사용하는 방법이 밑의 방법

SET @count =3;
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?'; -- 실행하지 않고 준비까지만. ? 꼭 써야함. 무얼 넣을지 모르기 때문에.
EXECUTE mySQL USING @count;

-- 명시적인 형변환

SELECT AVG(price) '평균가격' FROM buy;

SELECT CAST (AVG(price) AS SIGNED) '평균가격' FROM buy; -- SIGNED 양수인 정수.
-- 또는
SELECT CONVERT (AVG(price), SIGNED) '평균가격' FROM buy; 

SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR) ,'=' ) '가격X수량',
    price*amount '구매액' 
  FROM buy ;
 
 -- CONCAT 잇다.
 -- 암시적인 형병환
 
SELECT '100' + '200' ; -- 문자와 문자를 더함 (정수로 변환되서 연산됨)
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결 (문자로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결 (정수가 문자로 변환되서 처리)
     
 