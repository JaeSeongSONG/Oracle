SELECT b.names AS 책제목
     , b.author AS 저자명
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') AS 출판일
     , b.price AS 가격
     
  FROM bookstbl b
 ORDER BY b.idx ;