SELECT d.names AS �帣
     , b.names AS å����
     , b.author AS ����
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') AS ������
     , b.isbn AS å�ڵ��ȣ
     , b.price || '��' AS ����
  FROM bookstbl b 
 INNER JOIN divtbl d
    ON b.division = d.division
 ORDER BY b.idx DESC ;