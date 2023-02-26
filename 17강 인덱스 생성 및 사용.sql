-- 인덱스 생성 문법
-- 자동 생성 인덱스 말고 직접 생성해야하는 인덱스
USE market_db;
SELECT * FROM member;

SHOW INDEX FROM member; -- 기존의 인덱스 확인 -> PK로 클러스터형 인덱스

SHOW TABLE STATUS LIKE 'member';

CREATE INDEX idx_member_addr 
   ON member (addr);
   
   -- CREATE INDEX 인덱스 이름 
   -- 	ON 테이블이름 (열이름);

SHOW INDEX FROM member;

SHOW TABLE STATUS LIKE 'member';

ANALYZE TABLE member; -- 적용을 시켜 주어야 함.
SHOW TABLE STATUS LIKE 'member'; -- 보조인덱스 생성으로 index_lenghth 변함

CREATE UNIQUE INDEX idx_member_mem_number
    ON member (mem_number); -- 오류 발생
-- unique 인덱스 => 중복이 되지 않아야 함.  기존 데이터에 중복이 있음 => 오류 발생

CREATE UNIQUE INDEX idx_member_mem_name
    ON member (mem_name);

SHOW INDEX FROM member;

INSERT INTO member VALUES('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10');

ANALYZE TABLE member;  -- 지금까지 만든 인덱스를 모두 적용
SHOW INDEX FROM member;

-- 인덱스 사용하기.

SELECT * FROM member; -- 인덱스 사용 안함. => 전체 찾기

SELECT mem_id, mem_name, addr FROM member; -- SELECT 다음에 나오는 것은 인덱스 사용 x

SELECT mem_id, mem_name, addr 
    FROM member 
    WHERE mem_name = '에이핑크';
--  ***WHERE 다음에 나오는 것에 인덱스 사용
    
    
CREATE INDEX idx_member_mem_number
    ON member (mem_number);
ANALYZE TABLE member; -- 인덱스 적용

SELECT mem_name, mem_number 
    FROM member 
    WHERE mem_number >= 7; 
    
SELECT mem_name, mem_number 
    FROM member 
    WHERE mem_number >= 1; 
-- mysql 자체로 인덱스 사용하지 않는 것이 효율적이라 판단하고 사용 x

SELECT mem_name, mem_number 
    FROM member 
    WHERE mem_number*2 >= 14;     
    -- 인덱스 열에 가공을 하지 않아야 인덱스 사용 할 수 있음.
    
SELECT mem_name, mem_number 
    FROM member 
    WHERE mem_number >= 14/2;   
    
SHOW INDEX FROM member;

-- 인덱스 제거하기

DROP INDEX idx_member_mem_name ON member;
DROP INDEX idx_member_addr ON member;
DROP INDEX idx_member_mem_number ON member;

ALTER TABLE member 
    DROP PRIMARY KEY;

-- DB의 테이블의 왜래키 알아오기.
SELECT table_name, constraint_name
    FROM information_schema.referential_constraints
    WHERE constraint_schema = 'market_db';

ALTER TABLE buy 
    DROP FOREIGN KEY buy_ibfk_1;
ALTER TABLE member 
    DROP PRIMARY KEY;

    
SELECT mem_id, mem_name, mem_number, addr 
    FROM member 
    WHERE mem_name = '에이핑크';