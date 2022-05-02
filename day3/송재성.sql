--1��-----------------------------------------------------

SELECT LOWER(m.email) AS email
     , m.mobile
     , m.names
     , m.addr
     , m.levels
  FROM membertbl m
 ORDER BY m.names DESC;
 
--2��-------------------------------------------------
 
SELECT b.names AS å����
     , b.author AS ���ڸ�
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') AS ������
     , b.price AS ����
     
  FROM bookstbl b
 ORDER BY b.idx ;
 
--3��----------------------------------------------------
 
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
 
--4��-----------------------------------------------------
 
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
    , 'ȫ�浿'
    , 'A'
    , '�λ�� ���� �ʷ���'
    , '010-7989-0909'
    , 'HDG09@NAVER.COM'
    , 'HGD7989'
    , '12345'
    , null
    , null) ;
    
--5��---------------------------------------------

SELECT NVL(d.names,'--�հ�--') AS �帣
     , SUM(b.price) AS �帣���հ�ݾ�
  FROM bookstbl b 
 INNER JOIN divtbl d
    ON b.division = d.division
GROUP BY ROLLUP(d.names)
ORDER BY d.names ;