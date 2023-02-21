-- 데이터 변경을 위한 SQL

USE market_db;
create table hongong1 (toy_id INT, toy_name CHAR(4), age INT);
insert into hongong1 values (1, '우디', 25);

insert into hongong1 (toy_id, toy_name) values (2, '버즈');
insert into hongong1 (toy_name,age,toy_id) values ('제시',20 ,3);

CREATE TABLE hongong2(
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int);
    
insert into hongong2 values (null, '보핍', 25);
insert into hongong2 values (null, '슬링키', 22);
insert into hongong2 values (null, '렉스', 21);
 
select * from hongong2;
select last_insert_id(); -- 마지막 번호

alter table  hongong2 auto_increment=100; -- 번호 설정
insert into hongong2 values (null, '재남', 35);
select * from hongong2;

CREATE TABLE hongong3(
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int);
alter table  hongong3 auto_increment=1000;
set @@auto_increment_increment=3; -- 3씩 증가하게 설정

insert into hongong3 values (null, '토마스', 20);
insert into hongong3 values (null, '제임스', 23);
insert into hongong3 values (null, '고든', 25);
select * from hongong3;

select count(*) from world.city;

desc world.city; -- 구성 볼 수 있음 DESC

    
CREATE TABLE city_popula (city_name CHAR(35), population INT);

Insert into city_popula
	select Name, Population from world.city;

-- update 수정하는 명령어
use market_db;

select * from city_popula where city_name='Seoul';
update city_popula
	set city_name='서울'
    where city_name='Seoul';
select * from city_popula where city_name='서울';

update city_popula
	set city_name='뉴욕', population =0
    where city_name='New York';
select * from city_popula where city_name='뉴욕';

-- where절 없이 사용하면 데이터가 모두 날라감. 사용 안 해야함.
-- 종종 숫자의 단위를 바꿀 경우는 사용 주의 해야함.

-- 데이터 삭제 DELETE문

delete from city_popula
	where city_name like 'New%'
    limit 5;
    



