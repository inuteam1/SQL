-- SQL 프로그래밍

-- IF 문 참이면 실행

USE market_db;
DROP PROCEDURE IF EXISTS ifProc1; -- 기존에 만든적이 있다면 삭제
DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
   IF 100 = 100 THEN  
      SELECT '100은 100과 같습니다.';
   END IF;
END $$
DELIMITER ;
CALL ifProc1();

-- if ~ else 문 아닐 경우 결과 나오게 함.

DROP PROCEDURE IF EXISTS ifProc2; 
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
   DECLARE myNum INT;  -- myNum 변수선언 저장 PROCEDURE 안에서는  @ 필요 없음
   SET myNum = 200;  -- 변수에 값 대입
   IF myNum = 100 THEN  
      SELECT '100입니다.';
   ELSE
      SELECT '100이 아닙니다.';
   END IF;
END $$
DELIMITER ;
CALL ifProc2();



DROP PROCEDURE IF EXISTS ifProc3; 
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
    DECLARE debutDate DATE; -- 데뷰일 변수 생성
    DECLARE curDate DATE; -- 오늘
    DECLARE days INT; -- 활동한 일수

    SELECT debut_date INTO debutDate -- debut_date 결과를 hireDATE에 대입
       FROM market_db.member
       WHERE mem_id = 'APN';

    SET curDATE = CURRENT_DATE(); -- 현재 날짜
    SET days =  DATEDIFF(curDATE, debutDate); -- 날짜의 차이, 일 단위를 알려주는 함수

    IF (days/365) >= 5 THEN -- 5년이 지났다면
          SELECT CONCAT('데뷔한지 ', days, '일이나 지났습니다. 핑순이들 축하합니다!');
    ELSE
          SELECT '데뷔한지 ' + days + '일밖에 안되었네요. 핑순이들 화이팅~' ;
    END IF;
END $$
DELIMITER ;
CALL ifProc3();

-- 두 날짜간의 차이.
SELECT CURRENT_DATE(), DATEDIFF('2021-12-31', '2000-1-1');

-- case문의 형식 보기
DROP PROCEDURE IF EXISTS caseProc; 
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 88 ;
    
    CASE 
        WHEN point >= 90 THEN
            SET credit = 'A';
        WHEN point >= 80 THEN
            SET credit = 'B';
        WHEN point >= 70 THEN
            SET credit = 'C';
        WHEN point >= 60 THEN
            SET credit = 'D';
        ELSE
            SET credit = 'F';
    END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();

-- case문 할용하기.

SELECT mem_id, SUM(price*amount) "총구매액"
   FROM buy
   GROUP BY mem_id;
   
SELECT mem_id, SUM(price*amount) "총구매액"
   FROM buy
   GROUP BY mem_id
   ORDER BY SUM(price*amount) DESC ; -- 내림차순으로

SELECT B.mem_id, M.mem_name, SUM(price*amount) "총구매액"
   FROM buy B
         INNER JOIN member M
         ON B.mem_id = M.mem_id
   GROUP BY B.mem_id
   ORDER BY SUM(price*amount) DESC ;


-- 구매하지 않은 친구들 데이터까지 아웃조인으로 불러오기.
SELECT M.mem_id, M.mem_name, SUM(price*amount) "총구매액"
   FROM buy B
         RIGHT OUTER JOIN member M
         ON B.mem_id = M.mem_id
   GROUP BY M.mem_id
   ORDER BY SUM(price*amount) DESC ;
   

SELECT M.mem_id, M.mem_name, SUM(price*amount) "총구매액",
        CASE  
           WHEN (SUM(price*amount)  >= 1500) THEN '최우수고객'
           WHEN (SUM(price*amount)  >= 1000) THEN '우수고객'
           WHEN (SUM(price*amount) >= 1 ) THEN '일반고객'
           ELSE '유령고객'
        END "회원등급"
   FROM buy B
         RIGHT OUTER JOIN member M
         ON B.mem_id = M.mem_id
   GROUP BY M.mem_id
   ORDER BY SUM(price*amount) DESC ;


-- 반복문 while
DROP PROCEDURE IF EXISTS whileProc; 
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    WHILE (i <= 100) DO
        SET hap = hap + i;  -- hap의 원래의 값에 i를 더해서 다시 hap에 넣으라는 의미
        SET i = i + 1;      -- i의 원래의 값에 1을 더해서 다시 i에 넣으라는 의미
    END WHILE;

    SELECT '1부터 100까지의 합 ==>', hap;   
END $$
DELIMITER ;
CALL whileProc();

-- 4의 배수 빼고 하기 **다시 보기.
DROP PROCEDURE IF EXISTS whileProc2; 
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    myWhile: -- while 자체에 이름을 지어줌.
    WHILE (i <= 100) DO  -- While문에 label을 지정
       IF (i%4 = 0) THEN
         SET i = i + 1;     
         ITERATE myWhile; -- 지정한 label문으로 가서 계속 진행
       END IF;
       SET hap = hap + i; 
       IF (hap > 1000) THEN 
         LEAVE myWhile; -- 지정한 label문을 떠남. 즉, While 종료.
       END IF;
       SET i = i + 1;
    END WHILE;

    SELECT '1부터 100까지의 합(4의 배수 제외), 1000 넘으면 종료 ==>', hap; 
END $$
DELIMITER ;


CALL whileProc2();


use market_db;
PREPARE myQuery FROM 'SELECT * FROM member WHERE mem_id = "BLK"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;


DROP TABLE IF EXISTS gate_table;
CREATE TABLE gate_table (id INT AUTO_INCREMENT PRIMARY KEY, entry_time DATETIME);

SET @curDate = CURRENT_TIMESTAMP(); -- 현재 날짜와 시간 알 수 있음

PREPARE myQuery FROM 'INSERT INTO gate_table VALUES(NULL, ?)';  -- 준비
EXECUTE myQuery USING @curDate; -- 실행
DEALLOCATE PREPARE myQuery; -- 문장을 해제

SELECT * FROM gate_table;

