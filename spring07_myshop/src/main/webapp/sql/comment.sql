-- comment.sql

-- 상품 댓글 테이블
create table pcomment (
	 cno		number			primary key
	,pno		number			not null
	,content	varchar2(300)	not null
	,wname		varchar2(100)	not null
	,regdate	datetime		default sysdate
);

-- 상품 댓글 테이블(maria DB)
create table pcomment (
	 cno		int 			not null primary key
	,pno		int	    		not null
	,content	varchar(300)	not null
	,wname		varchar(100)	not null
	,regdate	datetime		not null
);

-- 상품 시퀀스
create sequence pcomment_seq;
drop table pcomment;
commit;

select * from pcomment
WHERE pno = 2
order by regdate;
