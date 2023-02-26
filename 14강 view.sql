-- VIEW
-- 테이블인 것처럼 접근
-- 보안을 위해서 예를 들어 전체 정보 중 중요한 개인 정보를 보이지 않게 할 수 있음.
-- 쿼리가 단순해질 수 있음

USE market_db;
SELECT mem_id, mem_name, addr FROM member;

USE market_db;
CREATE VIEW v_member -- VIEW 구분을 위해 v_ 사용 추천
AS
    SELECT mem_id, mem_name, addr FROM member;

SELECT * FROM v_member;

SELECT mem_name, addr FROM v_member
   WHERE addr IN ('서울', '경기'); -- view에 조건을 걸어서도 가능

SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, 
        CONCAT(M.phone1, M.phone2) '연락처' 
   FROM buy B
     INNER JOIN member M
     ON B.mem_id = M.mem_id;

CREATE VIEW v_memberbuy
AS
    SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, 
            CONCAT(M.phone1, M.phone2) '연락처' 
       FROM buy B
         INNER JOIN member M
         ON B.mem_id = M.mem_id;

SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';

-- > 쿼리문이 단순해짐

USE market_db;
CREATE VIEW v_viewtest1
AS
    SELECT B.mem_id 'Member ID', M.mem_name AS 'Member Name', 
            B.prod_name "Product Name", 
            CONCAT(M.phone1, M.phone2) AS "Office Phone" 
       FROM buy B
         INNER JOIN member M
         ON B.mem_id = M.mem_id;
         
SELECT  DISTINCT `Member ID`, `Member Name` FROM v_viewtest1; -- 백틱(`)을 사용 

ALTER VIEW v_viewtest1
AS
    SELECT B.mem_id '회원 아이디', M.mem_name AS '회원 이름', 
            B.prod_name "제품 이름", 
            CONCAT(M.phone1, M.phone2) AS "연락처" 
       FROM buy B
         INNER JOIN member M
         ON B.mem_id = M.mem_id;
         
SELECT  DISTINCT `회원 아이디`, `회원 이름` FROM v_viewtest1;  -- 백틱을 사용

DROP VIEW v_viewtest1;

USE market_db;
CREATE OR REPLACE VIEW v_viewtest2
AS
    SELECT mem_id, mem_name, addr FROM member;

DESCRIBE v_viewtest2; -- 뷰의 정보 확인

DESCRIBE member;

-- member의 pk는 뷰에서는 볼 수 없음.

SHOW CREATE VIEW v_viewtest2; -- view의 구문 볼 수 있음.

UPDATE v_member SET addr = '부산' WHERE mem_id='BLK' ;
SELECT * FROM v_member ;

INSERT INTO v_member(mem_id, mem_name, addr) VALUES('BTS','방탄소년단','경기') ;

CREATE VIEW v_height167
AS
    SELECT * FROM member WHERE height >= 167 ;
    
SELECT * FROM v_height167 ;

DELETE FROM v_height167 WHERE height < 167; -- 0개 삭제됨 당연히 167 이상인 사람들만 뽑았으니.

INSERT INTO v_height167 VALUES('TRA','티아라', 6, '서울', NULL, NULL, 159, '2005-01-01') ; -- 입력이 되긴 하지만 조건에 어긋나므로 바람직하지 못함. 

SELECT * FROM v_height167; -- 입력 된 것이 보이지 않음, 뷰 조건에 해당 되지 않기 때문

ALTER VIEW v_height167
AS
    SELECT * FROM member WHERE height >= 167
        WITH CHECK OPTION ;  -- 조건을 만족 해야만 입력되게 수정.
        
INSERT INTO v_height167 VALUES('TOB','텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01') ; -- WITH CHECK OPTION 으로 입력 되지 않음.

CREATE VIEW v_complex
AS
    SELECT B.mem_id, M.mem_name, B.prod_name, M.addr
        FROM buy B
            INNER JOIN member M
            ON B.mem_id = M.mem_id;
-- 뷰가 참조하는 테이블이 없어서

DROP TABLE IF EXISTS buy, member;

SELECT * FROM v_height167;

CHECK TABLE v_height167;

