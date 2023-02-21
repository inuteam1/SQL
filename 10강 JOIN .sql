-- 조인 : 두 테이블 엮기

-- 일대다의 관계 회원테이블- 구매테이블 --> 한명의 회원이 구매 여러번 할 때

USE market_db;
SELECT * 
   FROM buy -- 첫번째 테이블
     INNER JOIN member -- 두번째 테이블
     ON buy.mem_id = member.mem_id -- 조인될 조건
   WHERE buy.mem_id = 'GRL';

-- WHERE절 없이 전체 조인
SELECT * 
   FROM buy
     INNER JOIN member
     ON buy.mem_id = member.mem_id;
     
SELECT mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) AS '연락처' 
   FROM buy
     INNER JOIN member
     ON buy.mem_id = member.mem_id;
     
-- mem_id라는 열이름이 두 테이블 모두 존재 -> 테이블 지정

SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) AS '연락처' 
   FROM buy
     INNER JOIN member
     ON buy.mem_id = member.mem_id;

-- 테이블 별명 지정후 사용
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, 
        CONCAT(M.phone1, M.phone2) AS '연락처' 
   FROM buy B
     INNER JOIN member M
     ON B.mem_id = M.mem_id;
          
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
   FROM buy B
     INNER JOIN member M
     ON B.mem_id = M.mem_id
   ORDER BY M.mem_id;

SELECT DISTINCT M.mem_id, M.mem_name, M.addr
   FROM buy B
     INNER JOIN member M
     ON B.mem_id = M.mem_id
   ORDER BY M.mem_id;

-- 외부 조인   
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
   FROM member M
     LEFT OUTER JOIN buy B
     ON M.mem_id = B.mem_id
   ORDER BY M.mem_id;

SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
   FROM buy B
     RIGHT OUTER JOIN member M
     ON M.mem_id = B.mem_id
   ORDER BY M.mem_id;
   
SELECT DISTINCT M.mem_id, B.prod_name, M.mem_name, M.addr
   FROM member M
     LEFT OUTER JOIN buy B
     ON M.mem_id = B.mem_id
   WHERE B.prod_name IS NULL
   ORDER BY M.mem_id;
   
-- 상호조인 내용은 없지만 대용량의 데이터를 만들때 사용, 랜덤으로 조인하므로 내용은 무의미함. 

SELECT * 
   FROM buy 
     CROSS JOIN member ;
     
     

SELECT COUNT(*) "데이터 개수"
   FROM sakila.inventory
      CROSS JOIN world.city;

SELECT COUNT(*) "데이터 개수"
   FROM sakila.inventory
      CROSS JOIN world.city;

DROP TABLE cross_table;
CREATE TABLE cross_table
    SELECT *
       FROM sakila.actor
          CROSS JOIN world.country;

SELECT * FROM cross_table LIMIT 5;

-- 자기조인 

USE market_db;
CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));

INSERT INTO emp_table VALUES('대표', NULL, '0000');
INSERT INTO emp_table VALUES('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES('개발주임', '정보이사', '3333-1-1');

-- 경리부장의 직속상관인 관리이사의 사내 연락처 찾기.

SELECT A.emp "직원" , B.emp "직속상관", B.phone "직속상관연락처"
   FROM emp_table A
      INNER JOIN emp_table B
         ON A.manager = B.emp
   WHERE A.emp = '경리부장';
