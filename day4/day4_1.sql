-- 테이블 생성

CREATE TABLE lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
) ;

-- 조회하기

SELECT *
FROM lprod ;

-- 데이터 입력하기

INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    1, 'P101', '컴퓨터제품'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    2, 'P102', '전자제품'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    3, 'P201', '여성캐주얼'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    4, 'P202', '남성캐주얼'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    5, 'P301', '피혁잡화'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    6, 'P302', '화장품'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    7, 'P401', '음반/CD'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    8, 'P402', '도서'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    9, 'P403', '문구류'
) ;

/*
상품분류정보에서 상품분류코드의 값이 
P201인 데이터를 조회해 주세요
P201 보다 큰 데이터를 조회해주세요
*/

SELECT * 
FROM lprod
WHERE lprod_gu = 'P201' ;

SELECT *
FROM lprod
WHERE lprod_gu > 'P201' ;

/*
데이터 수정
상품분류코드가 P102에 대해서
상품분류명의 값을 향수로 수정해주세요
*/

SELECT *
FROM lprod
WHERE lprod_gu = 'P102' ;

UPDATE lprod
   SET lprod_nm = '향수'
 WHERE lprod_gu = 'P102' ;

/*
상품분류정보에서
상품분류코드가 P202에 대한 데이터를
삭제해 주세요
*/

SELECT *
  FROM lprod
 WHERE lprod_gu = 'P202' ;
 
DELETE FROM lprod
WHERE lprod_gu = 'P202' ;

commit ;

-- 거래처 정보 생성

CREATE TABLE buyer
(buyer_id           char(6)          NOT NULL,  -- 거래처 코드
 buyer_name         varchar2(40)     NOT NULL,  -- 거래처명
 buyer_lgu          char(4)          NOT NULL,  -- 취급상품 대분류
 buyer_bank         varchar2(60)     NOT NULL,  -- 은행
 buyer_bankno       varchar2(60),               -- 계좌번호
 buyer_bankname     varchar2(15),               -- 예금주
 buyer_zip          char(7),                    -- 우편번호
 buyer_add1         varchar2(100),              -- 주소1
 buyer_add2         varchar2(70),               -- 주소2
 buyer_comtel       varchar2(14)     NOT NULL,  -- 전화번호
 buyer_fax          varchar2(20)     NOT NULL) ;-- FAX 번호
 
 ---- 테이블과 관련된 수정은 ALTER
 ---- 테이블의 이름을 변경하는 것은 불가능함
 ---- 테이블의 추가나 테이블의 사이즈, 타입을 변경하고, 특정 컬럼을 삭제할 수 있음
 ---- 제약조건을 추가하는 것도 가능

---- column 추가

ALTER TABLE buyer ADD (buyer_mail varchar2(60) NOT NULL, 
                       buyer_charger varchar2(20),
                       buyer_telext varchar2(2)) ;
            
---- size 변경     

ALTER TABLE buyer MODIFY (buyer_name varchar2(60) ) ; 

---- buyer_lgu는 lprod_gu를 참조

ALTER TABLE buyer
    ADD(CONSTRAINT pk_buyer Primary Key (buyer_id),
        CONSTRAINT fr_buyer_lprod Foreign Key (buyer_lgu) 
        REFERENCES lprod(lprod_gu)) ; 