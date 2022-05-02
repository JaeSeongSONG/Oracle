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