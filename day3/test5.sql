SELECT NVL(d.names,'--합계--') AS 장르
     , SUM(b.price) AS 장르별합계금액
  FROM bookstbl b 
 INNER JOIN divtbl d
    ON b.division = d.division
GROUP BY ROLLUP(d.names)
ORDER BY d.names ;