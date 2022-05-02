--1번-----------------------------------------------------

SELECT LOWER(m.email) AS email
     , m.mobile
     , m.names
     , m.addr
     , m.levels
  FROM membertbl m
 ORDER BY m.names DESC;
 
--2번-------------------------------------------------
 
SELECT b.names AS 책제목
     , b.author AS 저자명
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') AS 출판일
     , b.price AS 가격
     
  FROM bookstbl b
 ORDER BY b.idx ;
 
--3번----------------------------------------------------
 
SELECT d.names AS 장르
     , b.names AS 책제목
     , b.author AS 저자
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') AS 출판일
     , b.isbn AS 책코드번호
     , b.price || '원' AS 가격
  FROM bookstbl b 
 INNER JOIN divtbl d
    ON b.division = d.division
 ORDER BY b.idx DESC ;
 
--4번-----------------------------------------------------
 
INSERT INTO membertbl
     ( idx
     , names
     , levels
     , addr
     , mobile
     , email
     , userid
     , password
     , lastlogindt
     , loginipaddr)
VALUES 
    ( TEST4_SEQ.NEXTVAL
    , '홍길동'
    , 'A'
    , '부산시 동구 초량동'
    , '010-7989-0909'
    , 'HDG09@NAVER.COM'
    , 'HGD7989'
    , '12345'
    , null
    , null) ;
    
--5번---------------------------------------------

SELECT NVL(d.names,'--합계--') AS 장르
     , SUM(b.price) AS 장르별합계금액
  FROM bookstbl b 
 INNER JOIN divtbl d
    ON b.division = d.division
GROUP BY ROLLUP(d.names)
ORDER BY d.names ;