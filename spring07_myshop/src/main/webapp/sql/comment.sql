-- comment.sql

-- 상품 댓글 테이블
create table pcomment (
	 cno		number			primary key
	,pno		number			not null
	,content	varchar2(255)	not null
	,wname		varchar(100)	not null
	,regdate	date			default sysdate
);

-- 상품 시퀀스
create sequence pcomment_seq;

commit;