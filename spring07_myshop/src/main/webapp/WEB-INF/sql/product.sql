-- product.sql

-- 상품 테이블
create table product (
	 product_code	int				primary key
	,product_name	varchar(100)	not null
	,description	varchar(2000)
	,price			int             default 0
	,filename		varchar(500)
    ,filesize       int             default 0
    ,regdate        date            default sysdate
);

-- 상품 테이블(Maria DB)
create table product (
	 product_code	NUMBER          NOT NULL PRIMARY KEY
	,product_name	VARCHAR2(100)	NOT NULL
	,description	VARCHAR2(2000) 
	,price			NUMBER          DEFAULT 0
	,filename		VARCHAR2(500)
    ,filesize       NUMBER          DEFAULT 0
    ,regdate        DATE            NOT NULL
);


-- 상품 댓글 테이블
create table pcomment (
     cno        number          primary key
    ,bno        number          not null
    ,content    varchar2(255)   not null
    ,wname      varchar(100)    not null
    ,regdate    date            default sysdate
);

-- 상품 시퀀스
create sequence product_seq;
drop sequence product_seq;

-- 상품 댓글 시퀀스
create sequence pcomment_seq;

commit;

drop table product;

select * from product;
select * from pcomment;

ALTER TABLE product ADD filesize2 number;
UPDATE product SET filesize2 = filesize;
ALTER TABLE product DROP COLUMN filesize;
ALTER TABLE product RENAME COLUMN filesize2 TO filesize;