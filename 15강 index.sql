-- index 반드시 필요한 것은 아니지만 데이터량이 큰 실무에서는 꼭 필요함.
-- 장점: select문 검색 속도가 빨라짐 -> 전체적 데이터 속도 빨라짐. 

-- 클러스터형 인덱스: 영어사전, 국어사전과 같이 책이 인덱스 자체
-- 보조 인덱스: 책 뒤의 찾아보기와 같은 형태

-- 자동으로 생성되는 인덱스 - 프라이머리키로 지정한 열 -> 클러스터형 인덱스가 생김

USE market_db;
CREATE TABLE table1  (
    col1  INT  PRIMARY KEY,
    col2  INT,
    col3  INT
);
SHOW INDEX FROM table1; -- PRIMARY KEY 클러스터형 인덱스

CREATE TABLE table2  (
    col1  INT  PRIMARY KEY,
    col2  INT  UNIQUE,
    col3  INT  UNIQUE
);
SHOW INDEX FROM table2; -- unique는 보조 인덱스 생성 (여러 개 가능)

USE market_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id      CHAR(8) , 
  mem_name    VARCHAR(10),
  mem_number  INT ,  
  addr        CHAR(2)  
 );

-- 자동 인덱스 xx

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM member;
-- 인덱스 없이 입력한 순서대로 결과 나옴

ALTER TABLE member
     ADD CONSTRAINT 
     PRIMARY KEY (mem_id);
SELECT * FROM member;

-- PRIMARY KEY 로 영어사전처럼 정렬됨.

ALTER TABLE member DROP PRIMARY KEY ; -- 기본 키 제거
ALTER TABLE member 
    ADD CONSTRAINT 
    PRIMARY KEY(mem_name);
SELECT * FROM member;

-- 가나다 순으로 정렬

INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member;

-- mem_name 순서에 맞게 정렬됨 (입력순 x)

USE market_db;
DROP TABLE IF EXISTS member;
CREATE TABLE member 
( mem_id      CHAR(8) , 
  mem_name    VARCHAR(10),
  mem_number  INT ,  
  addr        CHAR(2)  
 );

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM member;

ALTER TABLE member
     ADD CONSTRAINT 
     UNIQUE (mem_id);
SELECT * FROM member;

-- 유니크 키 넣음-> 정렬 순서 같음 
-- 보조 인덱스 = 찾아보기
ALTER TABLE member
     ADD CONSTRAINT 
     UNIQUE (mem_name);
SELECT * FROM member;

INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member;

-- 맨 뒤에 추가 됨.