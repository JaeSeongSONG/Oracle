SELECT b.names AS å����
     , b.author AS ���ڸ�
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') AS ������
     , b.price AS ����
     
  FROM bookstbl b
 ORDER BY b.idx ;