/*
lprod : 상품분류정보
prod : 상품정보
buyer : 거래처정보
member : 회원정보
cart : 구매(장바구니) 정보
buyprod : 입고상품정보
remain : 재고수불정보
*/

SELECT m.mem_id, m.mem_name
FROM member m;

---- 테이블 alias 설정 시 as는 사용하지 않는다.

SELECT p.prod_id, p.prod_name
FROM prod p; 

SELECT ROUND(m.MEM_MILEAGE / 12) as mileage
FROM member m ;

SELECT p.prod_id, p.prod_name, p.prod_price * 55 as "PRICE"
FROM prod p ;

-- DISTINCT 
---- 중복된 ROW를 제거

SELECT DISTINCT p.prod_buyer
FROM prod p ;

-- ORDER BY

SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id ASC;

SELECT mem_id AS id,
       mem_name AS nm,
       mem_bir, mem_mileage 
FROM member
ORDER BY id DESC;

-- WHERE

SELECT prod_name AS "상품", prod_sale AS "판매가"
FROM prod
WHERE prod_sale = 170000 ;

SELECT prod_id, prod_name, prod_price
FROM prod
WHERE prod_price != 170000 
ORDER BY prod_price;

SELECT prod_id, prod_name, prod_price
FROM prod
WHERE prod_price > 170000 
ORDER BY prod_price;

SELECT prod_id, prod_name, prod_cost
FROM prod
WHERE prod_cost <= 200000
ORDER BY prod_id DESC ;

SELECT mem_id, mem_name, mem_regno1
FROM member
WHERE mem_regno1 > 760101
ORDER BY mem_id ASC;

SELECT prod_name AS "상품", prod_lgu AS "상품분류", prod_sale AS "판매가"
  FROM prod
 WHERE prod_lgu = 'P201'
   AND prod_sale = 170000 ;
   
SELECT prod_name AS "상품", prod_lgu AS "상품분류", prod_sale AS "판매가"
  FROM prod
 WHERE prod_lgu = 'P201'
    OR prod_sale = 170000 ;
 
SELECT prod_name AS "상품", prod_lgu AS "상품분류", prod_sale AS "판매가"
  FROM prod
 WHERE NOT prod_lgu = 'P201'
    OR prod_sale = 170000 ;
    
SELECT prod_id, prod_name, prod_sale
FROM prod
WHERE prod_sale >= 300000
AND prod_sale <= 500000 ;

SELECT prod_id, prod_name, prod_sale
FROM prod
WHERE prod_sale IN (150000, 170000, 330000) 
ORDER BY prod_name ASC ;

SELECT mem_id, mem_name
FROM member
WHERE mem_id IN ('c001', 'f001', 'w001') 
ORDER BY mem_regno1 DESC ;

SELECT lprod_gu AS  "분류코드", lprod_nm AS "분류명"
  FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu FROM prod) ;
 
SELECT lprod_gu AS "분류코드", lprod_nm AS "분류명"
  FROM lprod
 WHERE lprod_gu NOT IN (SELECT prod_lgu FROM prod) ;
 
/*
[문제]
한번도 구매한 적이 없는 회원 아이디, 이름 조회
*/
 
SELECT mem_id AS "회원 아이디", mem_name AS "회원 이름"
  FROM member
 WHERE mem_id NOT IN (SELECT cart_member FROM cart) ;

/*
[문제]
한번도 판매된 적이 없는 상품이름 조회
*/
 
SELECT prod_name AS "상품이름"
  FROM prod
 WHERE prod_id NOT IN (SELECT cart_prod FROM cart) ;
 
/*
[문제]
김은대 회원이 지금까지 구매했던 모든 상품명 조회
*/
 
SELECT DISTINCT prod_name
FROM prod
WHERE prod_id IN (SELECT cart_prod FROM cart WHERE cart_member 
IN (SELECT mem_id FROM member WHERE mem_name = '김은대')) ;

/*
[문제]
상품 중 판매가가 10만 이상, 30만 이하인 상품 조회
상품명, 판매가격
판매가격 기준 내림차순
*/
 
SELECT prod_name AS "상품명", prod_sale AS "판매가격"
FROM prod
WHERE prod_sale BETWEEN 100000 AND 300000
ORDER BY prod_sale DESC ;

-- 날짜 포맷

SELECT mem_name
FROM member
WHERE mem_bir BETWEEN '75/01/01' AND '76/12/31' ;

/*
[문제]
거래처 담당자 강남구씨가 담당하는 상품을 구매한 회원 조회
회원 아이디, 회원 이름 조회
*/

SELECT mem_id AS "회원 아이디", mem_name AS "회원 이름"
  FROM member
 WHERE mem_id IN (
          SELECT cart_member 
          FROM cart 
          WHERE cart_prod IN (
              SELECT prod_id
              FROM prod 
              WHERE prod_lgu IN (
                  SELECT lprod_gu 
                  FROM lprod 
                  WHERE lprod_gu IN (
                      SELECT buyer_lgu
                      FROM buyer
                      WHERE buyer_charger = '강남구'
                      )
                  )
              )
          ) ;
          
SELECT prod_name AS "상품명", prod_cost AS "매입가", prod_sale AS "판매가"
FROM prod
WHERE prod_cost BETWEEN 300000 AND 1500000
AND prod_sale BETWEEN 800000 AND 2000000  ;

SELECT mem_id AS "회원ID", mem_name AS "회원명", mem_bir AS "생일"
FROM member
WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31' ;

-- LIKE

SELECT prod_id AS "상품코드", prod_name AS "상품명"
  FROM prod
 WHERE prod_name LIKE '삼%' ;
 
SELECT prod_id AS "상품코드", prod_name AS "상품명"
  FROM prod
 WHERE prod_name LIKE '_성%' ;
 
SELECT prod_id AS "상품코드", prod_name AS "상품명"
  FROM prod
 WHERE prod_name LIKE '%여름%' ;
 
SELECT lprod_gu AS "분류코드", lprod_nm AS "분류명"
  FROM lprod
 WHERE lprod_nm LIKE '%홍\%' ;
 
SELECT mem_id AS "회원ID", mem_name AS "성명"
  FROM member
 WHERE mem_name LIKE '김%' ;

SELECT mem_id AS "회원ID", mem_name AS "성명", 
CONCAT(mem_regno1, CONCAT('-', mem_regno2))
  FROM member
 WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31' ;
 
-- 문자열 함수

SELECT mem_id || 'name is' || mem_name FROM member ;

SELECT LOWER('DATA manipulation Language') "LOWER",
       UPPER('DATA manipulation Language') "UPPER",
       INITCAP('DATA manipulation Language') "INITCAP"
FROM dual ;

SELECT mem_id AS "변환 전 ID", UPPER(mem_id) AS "변환 후 ID"
FROM member ;

SELECT LPAD('Java', 10, '*') AS "LPAD",
       RPAD('Java', 10, '*') AS "RPAD"
FROM dual ;

SELECT SUBSTR('SQL PROJECT', 1, 3) RESULT_1
FROM dual ;

SELECT TRANSLATE('2009-02-28', '0123456789', 'ABCDEFGHIJK') RESULT
FROM dual ;

---- 인자가 없어서 삭제됨

SELECT REPLACE('SQL Project', 'SQL', 'SSQQLL') 문자치환_1,
       REPLACE('Java Flex Via', 'a') 문자치환_2 
FROM dual ;

SELECT CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'),
SUBSTR(mem_name, 2))
FROM member ; 

SELECT GREATEST(10,20,30) "큰값",
       LEAST(10,20,30) "작은값"
FROM dual ;

SELECT ROUND(123.245346, 0) FROM dual ;
SELECT ROUND(123.245346, 1) FROM dual ; -- 소수점 한자리
SELECT ROUND(123.245346, -1) FROM dual ; -- 십의 자리

SELECT MOD(10,3) FROM dual ;

-- 날짜 함수

SELECT SYSDATE "현재시간",
       SYSDATE - 1 "하루 전",
       SYSDATE + 1 "하루 후"
FROM dual ;

---- NEXT_DAY, LAST_DAY

SELECT NEXT_DAY(SYSDATE, '월요일'), -- 다음번 월요일
       LAST_DAY(SYSDATE) -- 그 달의 마지막 날
FROM dual ;

SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM dual ; -- 남은 이번달 날짜

---- EXTRACT

SELECT EXTRACT(YEAR FROM SYSDATE) "년도",
       EXTRACT(MONTH FROM SYSDATE) "월",
       EXTRACT(DAY FROM SYSDATE) "일"
FROM dual ;

SELECT mem_name
FROM MEMBER 
WHERE (EXTRACT(MONTH FROM mem_bir)) = 3 ; -- 생일이 3월인 회원

/*
회원 생일 중 1973년생이 주로 구매한 상품을 오름차순 정렬
단, 상품명에 삼성이 포함된 상품만 조회, 중복제거
*/

SELECT DISTINCT prod_name AS "상품명"
FROM prod
WHERE prod_id IN (
    SELECT cart_prod 
    FROM cart 
    WHERE cart_member IN (
        SELECT mem_id 
        FROM member 
        WHERE EXTRACT(YEAR FROM mem_bir) = 1973
    )
)
AND prod_name LIKE '%삼성%' 
ORDER BY prod_name ASC ;

-- 형 변환 함수 (날짜)

SELECT '[' || CAST('HEllo' AS CHAR(30)) || ']' "형변환"
FROM dual ;

SELECT CAST('1997/12/25' AS DATE) FROM dual ;

SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC"세기"')
FROM dual ;

SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
                     'YYYY.MM.DD HH24:MI')
FROM dual ;

SELECT prod_name AS "상품명", prod_sale AS "상품판매가", 
       TO_CHAR(CAST(prod_insdate AS DATE), 'YYYY-MM-DD') AS "입고일"
FROM prod ;

SELECT mem_name || '님은 ' || TO_CHAR(CAST(mem_bir AS DATE), 'YYYY') || '년 ' ||
TO_CHAR(CAST(mem_bir AS DATE), 'mm') || '월 출생이고 태어난 요일은 ' ||
TO_CHAR(CAST(mem_bir AS DATE), 'day')
FROM member ;

-- 형 변환 함수 (숫자)

SELECT TO_CHAR(1234.6, '99,999.00') FROM dual ; -- 유효한 자리 출력, 무효일때 0 출력
SELECT TO_CHAR(-1234.6, 'L99,999.00PR') FROM dual ; -- 화폐기호 + 괄호 묶기
SELECT TO_CHAR(255, 'XXX') FROM dual ; -- 16진수로 출력

SELECT TO_NUMBER('3.1415') FROM dual ;
SELECT TO_NUMBER(LTRIM('$1,200', '$')) FROM dual ;

SELECT SUBSTR(mem_id, 1, 2) ||
      (SUBSTR(mem_id, 3, 2) + 10)
  FROM member 
 WHERE mem_name = '이쁜이' ;

-- GROUP

SELECT AVG(DISTINCT prod_cost), AVG(ALL prod_cost),
       AVG(prod_cost) AS "매입가평균"
FROM prod ;

SELECT prod_lgu,
       ROUND(AVG(prod_cost), 2) AS "분류별 매입가격 평균"
FROM prod 
GROUP BY prod_lgu ;

SELECT AVG(prod_sale) AS "상품 총 판매 가격 평균"
FROM prod ;

SELECT prod_lgu, AVG(prod_sale) AS "avg_sale"
FROM prod
GROUP BY prod_lgu ;

SELECT cart_member, COUNT(cart_member) AS "mem_count"
FROM cart
GROUP BY cart_member ;

/*
구매수량의 전체 평균 이상을 구매한 회원들의 아이디와 이름 조회
*/

SELECT mem_id, mem_name
FROM member
WHERE mem_id IN (
    SELECT cart_member
    FROM cart
    WHERE cart_qty >= (
        SELECT AVG(cart_qty)
        FROM cart
    )
)
ORDER BY mem_regno1 ASC ;

 