USE market_db;
SELECT mem_id, mem_name, debut_date
	FROM member
    order by debut_date;  -- 오름차순
    
SELECT mem_id, mem_name, debut_date
	FROM member
    order by debut_date DESC;  -- 내림차순

SELECT mem_id, mem_name, debut_date, height
	FROM member
    where height >= 164
    order by height DESC, debut_date ASC;  -- 내림차순 
    
SELECT mem_id, mem_name, debut_date, height
	FROM member
    order by height DESC
    LIMIT 3;  -- 3번째까지
    
SELECT mem_id, mem_name, debut_date, height
	FROM member
    order by height DESC
    LIMIT 3,2;  -- 3번째부터 두개까지    
    
SELECT distinct addr from member; -- 중복 제외하고 항목만

SELECT mem_id, amount FROM buy ORDER BY mem_id;

SELECT mem_id, SUM(amount) FROM buy group by mem_id;

SELECT mem_id" 회원 아이디", SUM(price *amount)"총 구매 금액" 
from buy group by mem_id;

SELECT mem_id" 회원 아이디", AVG(amount) "평균 구매 개수" 
FROM buy 
group by mem_id;

select count(*) FROM member; -- * 모든 행의 개수를 셈

select count(phone1) "연락처가 있는 회원" FROM member; -- null인 값은 뺴고 함

SELECT mem_id" 회원 아이디",  sum(price  * amount) "총 구매 금액" 
FROM buy
WHERE sum(price  * amount) > 1000
group by mem_id;

-- > 되지 않음  group by에서 조건절 사용시 where절이 아닌 having 절 사용하기

SELECT mem_id" 회원 아이디",  sum(price  * amount) "총 구매 금액" 
FROM buy
group by mem_id
having sum(price  * amount) > 1000;

SELECT mem_id" 회원 아이디",  sum(price  * amount) "총 구매 금액" 
FROM buy
group by mem_id
having sum(price*amount) > 1000
order by sum(price*amount) desc;

