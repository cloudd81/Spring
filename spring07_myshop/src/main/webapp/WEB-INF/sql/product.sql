-- product.sql

-- 상품 테이블
create table product (
	 product_code	int				primary key
	,product_name	varchar(100)	not null
	,description	varchar(2000)
	,price			int
	,filename		varchar(500)
    ,filesize       int
);

-- 상품 시퀀스
create sequence product_seq;

commit;

drop table product;

select * from product;
select * from pcomment;

ALTER TABLE product ADD filesize2 number;
UPDATE product SET filesize2 = filesize;
ALTER TABLE product DROP COLUMN filesize;
ALTER TABLE product RENAME COLUMN filesize2 TO filesize;