-- mem_sql.txt

-- 테이블 생성
create table mem(
   num number,
   name varchar2(20),
   age number
);

-- 시퀀스 생성
create sequence mem_seq;

commit;