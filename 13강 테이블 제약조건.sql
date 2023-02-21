-- 제약조건

-- 1. 기본키 PRIMARY KEY: 중복X  --> 클러스터형 인덱스가 자동 생성

USE naver_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL
);

-- 또는

DROP TABLE IF EXISTS member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL,
  PRIMARY KEY (mem_id)
);

-- 또는

DROP TABLE IF EXISTS member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL
);
ALTER TABLE member   -- 테이블 수정해라
     ADD CONSTRAINT  -- 제약조건을 추가해라
     PRIMARY KEY (mem_id);


DESCRIBE member;




-- 2. 왜래키 FOREIGN KEY 데이터의 무결성

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL
);
CREATE TABLE buy 
(  num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   mem_id      CHAR(8) NOT NULL, 
   prod_name     CHAR(6) NOT NULL, 
   FOREIGN KEY(mem_id) REFERENCES member(mem_id)
);

-- 또는 위에 거 사용 권장

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL
);
CREATE TABLE buy 
(  num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   user_id      CHAR(8) NOT NULL, 
   prod_name     CHAR(6) NOT NULL, 
   FOREIGN KEY(user_id) REFERENCES member(mem_id)
);

-- 또는

DROP TABLE IF EXISTS buy;
CREATE TABLE buy 
(  num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   mem_id      CHAR(8) NOT NULL, 
   prod_name     CHAR(6) NOT NULL
);
ALTER TABLE buy
    ADD CONSTRAINT 
    FOREIGN KEY(mem_id) REFERENCES member(mem_id);
    
-- ----------------------------------------------

INSERT INTO member VALUES('BLK', '블랙핑크', 163);
INSERT INTO buy VALUES(NULL, 'BLK', '지갑');
INSERT INTO buy VALUES(NULL, 'BLK', '맥북');

SELECT M.mem_id, M.mem_name, B.prod_name 
   FROM buy B
      INNER JOIN member M
      ON B.mem_id = M.mem_id;
      
UPDATE member SET mem_id = 'PINK' WHERE mem_id='BLK';

DELETE FROM member WHERE  mem_id='BLK'; -- PK, FK 로 엮어 있다면 수정, 삭제가 안 됨

DROP TABLE IF EXISTS buy;
CREATE TABLE buy 
(  num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   mem_id      CHAR(8) NOT NULL, 
   prod_name     CHAR(6) NOT NULL
);
ALTER TABLE buy
    ADD CONSTRAINT 
    FOREIGN KEY(mem_id) REFERENCES member(mem_id)
    ON UPDATE CASCADE  -- 업데이트시 자동으로 변경
    ON DELETE CASCADE;
    
INSERT INTO buy VALUES(NULL, 'BLK', '지갑');
INSERT INTO buy VALUES(NULL, 'BLK', '맥북');

UPDATE member SET mem_id = 'PINK' WHERE mem_id='BLK';

SELECT M.mem_id, M.mem_name, B.prod_name 
   FROM buy B
      INNER JOIN member M
      ON B.mem_id = M.mem_id;

DELETE FROM member WHERE  mem_id='PINK';

SELECT * FROM buy;


-- 3. UNIQUE 중복이 되지 않는 유일값 기본키와는 달리 null허용
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL,
  email       CHAR(30)  NULL UNIQUE
);

INSERT INTO member VALUES('BLK', '블랙핑크', 163, 'pink@gmail.com');
INSERT INTO member VALUES('TWC', '트와이스', 167, NULL);
INSERT INTO member VALUES('APN', '에이핑크', 164, 'pink@gmail.com'); -- 고유키 지정으로 이메일 중복 안됨
SELECT * FROM member;

-- 4. CHECK

DROP TABLE IF EXISTS member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL CHECK (height >= 100),
  phone1      CHAR(3)  NULL
);

INSERT INTO member VALUES('BLK', '블랙핑크', 163, NULL);
INSERT INTO member VALUES('TWC', '트와이스', 99, NULL); -- 체크 제약 조건으로 오류

ALTER TABLE member
    ADD CONSTRAINT 
    CHECK  (phone1 IN ('02', '031', '032', '054', '055', '061' )) ; -- in 되어 있는 값만 가능

INSERT INTO member VALUES('TWC', '트와이스', 167, '02');
INSERT INTO member VALUES('OMY', '오마이걸', 167, '010'); -- 체크 조건에 해당 x

-- 5. DEFAULT 정의 기본값 정의 - 입력하지 않을 때 기본값 설정

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name    VARCHAR(10) NOT NULL, 
  height      TINYINT UNSIGNED NULL DEFAULT 160,
  phone1      CHAR(3)  NULL
);


ALTER TABLE member
    ALTER COLUMN phone1 SET DEFAULT '02'; 

INSERT INTO member VALUES('RED', '레드벨벳', 161, '054');
INSERT INTO member VALUES('SPC', '우주소녀', default, default);
SELECT * FROM member;

