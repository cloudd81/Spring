-- product.sql

-- 상품 테이블
create table product (
	 product_code	int				primary key
	,product_name	varchar(100)	not null
	,description	varchar(2000)
	,price			int             default 0 not null
	,filename		varchar(500)    not null
    ,filesize       int             DEFAULT 0 NOT NULL
    ,regdate        date            default sysdate
);

-- 상품 테이블(마리아DB)
create table product (
	 product_code	int				primary key
	,product_name	varchar(100)	not null
	,description	text
	,price			int             default 0 not null
	,filename		varchar(500)    not null
    ,filesize       bigint          DEFAULT 0 NOT NULL
    ,regdate        datetime        not null
);

CREATE TABLE product2(
      product_code    INT                 NOT NULL PRIMARY KEY    -- 상품 번호
   , product_name  VARCHAR(255)      NOT NULL               -- 상품명
   , description   VARCHAR(2000)     NOT NULL               -- 상품내용
   , price       INT              DEFAULT 0 NOT NULL   -- 상품가격
   , filename       VARCHAR(255)     NOT NULL               -- 파일명
   , filesize       BIGINT               DEFAULT 0 NOT NULL   -- 파일 사이즈
   , regdate       DATETIME          NOT NULL            -- 작성일
);

use cloudd81;
use khdb;
create Database khdb;

show databases;

-- 상품 시퀀스
create sequence product_seq;

drop table product;
drop table product2;

commit;

select * from product;
select * from pcomment;

alter table product add product_name varchar(100) char set utf8 not null;