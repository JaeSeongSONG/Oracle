--���̺� ���� 

CREATE TABLE TEST 
(
  IDX INTEGER NOT NULL 
, TITLE VARCHAR2(20) NOT NULL 
, DESCS VARCHAR2(1000) 
, CONSTRAINT TEST_PK PRIMARY KEY 
  (
    IDX 
  )
  ENABLE 
);

--�������Է� INSERT

INSERT INTO bonus 
    ( ename
    , job
    , sal
    , comm
    )
VALUES
    ( 'JaeSeong'
    , 'FRESHMAN'
    , 4000
    , 500
    ) ;


INSERT INTO test
     ( idx
     , title
     , descs )
VALUES 
    ( 2
    , '��������'
    , '���볻�볻��' ) ;
    
--null ���� �ְ� ������ null�� �־����.

COMMIT;      --��������
ROLLBACK;    --���

--�� �߰� �� ������ �ֱ� (���̺�����, add)

INSERT INTO test
     ( idx
     , title
     , descs
     , REGDATE)
VALUES 
    ( 3
    , '��������3'
    , '���볻�볻��3'
    , SYSDATE ) ;
    
INSERT INTO test
     ( idx
     , title
     , descs
     , REGDATE)
VALUES 
    ( 4
    , '��������4'
    , '���볻�볻��4'
    , TO_DATE('22-01-04','yy-mm-dd' )) ;
    
--������ (�ڵ����� ���� �ű��)
--������ �������� ����
--�������� ���̺� �ٷ� �ϴܿ� ����

SELECT SEQ_TEST.CURRVAL FROM dual ;
SELECT SEQ_TEST.NEXTVAL FROM dual ; --������ ù ����϶� nextval = 1
                                    --�ι� °���� nextval = 2, currval = 1   

INSERT INTO test
     ( idx
     , title
     , descs
     , REGDATE)
VALUES 
    ( SEQ_TEST.NEXTVAL
    , '��������3'
    , '���볻�볻��3'
    , SYSDATE ) ;
    

--UPDATE, DELETE ����
--where ���� �ʼ��� �����!!
--where ���� ���� ������ ��� �����Ͱ� ���ع���

UPDATE test
   SET title = '���������?'  --PK�� ���� �������� ����
     , descs = '������ ����˴ϴ�.'   
 WHERE idx = 1 ;            --key �� ���� ���� �Ϲ����� ��Ģ
 

DELETE FROM test
 WHERE idx = 2 ;
 
commit ;

--SUBQUERY

SELECT ROWNUM, su.ename, su.job, su.sal, su.comm FROM (
    SELECT ename, job, sal, comm
      FROM emp 
     ORDER BY sal DESC 
) su 
WHERE ROWNUM = 1 ;     --ROWNUM �̶� idx �� �ٸ�.
 








