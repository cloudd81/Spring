-- mariaDB.sql

-- 미디어 테이블 생성
CREATE TABLE mediagroup(
  mediagroupno int          NOT NULL PRIMARY KEY,
  title        varchar(100) NOT NULL
);


CREATE TABLE media(
  mediano      int          NOT NULL PRIMARY KEY,
  title        varchar(300) NOT NULL,       
  rdate        datetime     NOT NULL,
  poster       varchar(50)  DEFAULT 'poster.jpg' NOT NULL,
  filename     varchar(100) NOT NULL,
  filesize     bigint       DEFAULT 0 NOT NULL,
  mview        char(1)      DEFAULT 'Y' NOT NULL,
  mediagroupno int          NULL
);

use cloudd81;
select * from media;

-------------------------------------------------
-- 시퀀스 생성
create sequence media_seq;

commit;

select * from media;

update media
set poster = 'suyoungkim.jpg'
where mediano = 1;

-- 행 목록
SELECT mediano, title, poster, filename, filesize, mview, rdate, mediagroupno
FROM media
WHERE mview = 'Y' AND  mediagroupno = 1
ORDER BY mediano DESC;
