SELECT NVL(d.names,'--�հ�--') AS �帣
     , SUM(b.price) AS �帣���հ�ݾ�
  FROM bookstbl b 
 INNER JOIN divtbl d
    ON b.division = d.division
GROUP BY ROLLUP(d.names)
ORDER BY d.names ;