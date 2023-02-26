use market_db;
DELIMITER $$
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM member; -- 스토어드 프로시저 내용
END $$
DELIMITER ;

CALL user_proc();

DROP procedure user_proc ; -- 프로시저 삭제

-- user_proc() ()에 매개변수 입력 (필수는 아님.)

-- IN user_name varchar(10) 입력 매개변수

use market_db;
DELIMITER $$
CREATE PROCEDURE user_proc(IN user_name varchar(10) )
BEGIN
	SELECT * FROM member WHERE mem_name= user_name; -- 스토어드 프로시저 내용
END $$
DELIMITER ;

CALL user_proc('에이핑크');

use market_db;
DELIMITER $$
CREATE PROCEDURE user_proc2(
	IN user_number int,
	IN user_height int)
BEGIN
	SELECT * FROM member WHERE mem_number > user_number and height > user_height; -- 스토어드 프로시저 내용
END $$
DELIMITER ;

CALL user_proc2(6, 165);

-- 출력 매개변수

use market_db;
DELIMITER $$
CREATE PROCEDURE user_proc3(
	IN txt_value char(10),
	out out_value int)
BEGIN
	insert into noTable values(NULL,txt_value);
    SELECT MAX(id) into out_value from noTable; -- 스토어드 프로시저 내용
END $$
DELIMITER ;

desc noTable; -- 테이블 정보 확인 
SELECT * FROM noTable;
-- 테이블이 없어도 테이블을 이용한 프로시저 '생성' 가능, 실행 안됨

create table if not exists noTable(
	id int auto_increment primary key,
    txt char(10)
);

CALL user_proc3('테스트1', @myvalue); -- 입력 매개변수: 테스트1' 이라 잡고, 출력 매개변수는 (프로시저 밖 @)변수명 myvalue로 지정 
select concat('입력된 ID값 ==>',  @myvalue);
-- out_value 값이 myvalue에 넣어져 나옴.

use market_db;
DELIMITER $$
CREATE PROCEDURE ifelse_proc(
	IN memName varchar(10)
)
BEGIN
	declare debutYear INT; -- 저장 프로시저 안의 변수 선언
    SELECT YEAR(debut_date) into debutYear from member -- 스토어드 프로시저 내용
		where mem_name=memName;
	if (debutYear >= 2015) then
		select '신인가수네요. 화이팅 하세요' as '메세지';
	else 
		select '고참 가수네요. 그동안 수고하셨어요' as '메세지';
	end if;
end$$
DELIMITER ;

CALL ifelse_proc('소녀시대');

-- while문 이용하기.

DROP procedure dynamic_proc ; -- 프로시저 삭제
DELIMITER $$
CREATE PROCEDURE while_proc()
BEGIN
	declare hap INT; -- 합계
    declare num INT; -- 1-100까지 증가
    set hap=0;
    set num=1;
    
    while (num <= 100) DO -- 100까지 반복
		set hap= hap + num;
        set num = num + 1; -- 숫자 증가
	end while;
    
    select hap as '1~100 합계';
end$$
DELIMITER ;

CALL while_proc();

-- 동적 SQL

DROP PROCEDURE IF EXISTS dynamic_proc;
DELIMITER $$
CREATE PROCEDURE dynamic_proc2(
    IN tableName VARCHAR(20)
)
BEGIN
  SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
  PREPARE myQuery FROM @sqlQuery;
  EXECUTE myQuery;
  DEALLOCATE PREPARE myQuery;
END $$
DELIMITER ;

CALL dynamic_proc2 ('member');

