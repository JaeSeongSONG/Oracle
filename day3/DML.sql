--테이블 생성 

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

--데이터입력 INSERT

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
    , '내용증명'
    , '내용내용내용' ) ;
    
--null 값을 넣고 싶으면 null을 넣어야함.

COMMIT;      --완전저장
ROLLBACK;    --취소

--열 추가 후 데이터 넣기 (테이블편집, add)

INSERT INTO test
     ( idx
     , title
     , descs
     , REGDATE)
VALUES 
    ( 3
    , '내용증명3'
    , '내용내용내용3'
    , SYSDATE ) ;
    
INSERT INTO test
     ( idx
     , title
     , descs
     , REGDATE)
VALUES 
    ( 4
    , '내용증명4'
    , '내용내용내용4'
    , TO_DATE('22-01-04','yy-mm-dd' )) ;
    
--시퀀스 (자동으로 순서 매기기)
--시퀀스 편집으로 만듦
--시퀀스는 테이블 바로 하단에 붙음

SELECT SEQ_TEST.CURRVAL FROM dual ;
SELECT SEQ_TEST.NEXTVAL FROM dual ; --시퀀스 첫 사용일때 nextval = 1
                                    --두번 째에는 nextval = 2, currval = 1   

INSERT INTO test
     ( idx
     , title
     , descs
     , REGDATE)
VALUES 
    ( SEQ_TEST.NEXTVAL
    , '내용증명3'
    , '내용내용내용3'
    , SYSDATE ) ;
    

--UPDATE, DELETE 구문
--where 절을 필수로 써야함!!
--where 절을 쓰지 않으면 모든 데이터가 변해버림

UPDATE test
   SET title = '내용증명요?'  --PK는 거의 수정하지 않음
     , descs = '내용이 변경됩니다.'   
 WHERE idx = 1 ;            --key 를 쓰는 것이 일반적인 원칙
 

DELETE FROM test
 WHERE idx = 2 ;
 
commit ;

--SUBQUERY

SELECT ROWNUM, su.ename, su.job, su.sal, su.comm FROM (
    SELECT ename, job, sal, comm
      FROM emp 
     ORDER BY sal DESC 
) su 
WHERE ROWNUM = 1 ;     --ROWNUM 이랑 idx 는 다름.
 








