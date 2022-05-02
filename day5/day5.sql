-- GROUP 함수: COUNT

---- COUNT(*)은 COUNT()과 다르게 NULL 값도 포함

SELECT
    COUNT(DISTINCT prod_cost),
    COUNT(prod_cost),
    COUNT(prod_cost),
    COUNT(*)
FROM
    prod;

/*
구매내역 (장바구니) 정보에서 회원 아이디 별로 주문(수량)에 대한 평균 조회
회원 아이디를 기준으로 내림차순
*/

SELECT
    cart_member,
    AVG(cart_qty) AS avg_qty
FROM
    cart
GROUP BY
    cart_member
ORDER BY
    cart_member DESC;

/*
상품정보에서 판매가격의 평균 값을 구하라
단, 평균값은 소수점 둘째자리까지 표현한다
*/

SELECT
    to_char(AVG(prod_sale), '999,999.00')
FROM
    prod;

SELECT
    round(AVG(prod_sale), 2)
FROM
    prod;

/*
상품정보에서 상품 분류별 판매가격의 평균값
조회 컬럼은 상품분류코드, 상품분류별 판매가격의 평균 조회
단, 평균값은 소수점 둘째자리까지
*/

SELECT
    prod_lgu,
    round(AVG(prod_sale), 2)
FROM
    prod
GROUP BY
    prod_lgu;

SELECT
    COUNT(DISTINCT mem_like) AS "취미종류수"
FROM
    member;

SELECT
    mem_like        AS "취미",
    COUNT(mem_like) AS "자료수",
    COUNT(*)        AS "자료수(*)"
FROM
    member
GROUP BY
    mem_like;

SELECT DISTINCT
    mem_job        AS "직업",
    COUNT(mem_job) AS "직업 종류 수"
FROM
    member
GROUP BY
    mem_job;

/*
회원 전체의 마일리지 평균보다 큰 회원에 대한
아이디, 이름, 마일리지를 조회
마일리지가 높은 순으로 정렬
*/

SELECT
    mem_id,
    mem_name,
    mem_mileage
FROM
    member
WHERE
    mem_mileage >= (
        SELECT
            AVG(mem_mileage)
        FROM
            member
    )
GROUP BY
    mem_id,
    mem_name,
    mem_mileage
ORDER BY
    mem_mileage DESC;

-- GROUP 함수: MAX, MIN

---- 조회 범위 내 해당 컬럼들 중 최대값과 최소값

SELECT
    MAX(DISTINCT prod_cost),
    MIN(DISTINCT prod_cost)
FROM
    prod;

SELECT
    MAX(cart_no)     AS "현재년월일 기준 가장 높은 주문번호",
    MAX(cart_no) + 1 AS "추가주문번호"
FROM
    cart
WHERE
    cart_no LIKE '20050711%';
 
/*
구매정보에서 연도별로 판매된 상품의 개수, 평균구매수량 조회
연도를 기준으로 내림차순 정렬
*/

SELECT
    substr(cart_no, 1, 4) AS "연도",
    SUM(cart_qty),
    AVG(cart_qty)
FROM
    cart
GROUP BY
    substr(cart_no, 1, 4)
ORDER BY
    substr(cart_no, 1, 4) DESC;

/*
구매정보에서 년도별, 상품분류코드별로 상품의 개수를 조회
연도 기준 내림차순 정렬
*/

SELECT
    substr(cart_no, 1, 4)   AS "연도",
    substr(cart_prod, 1, 4) AS "상품분류코드",
    COUNT(cart_prod)
FROM
    cart
GROUP BY
    substr(cart_no, 1, 4),
    substr(cart_prod, 1, 4)
ORDER BY
    substr(cart_no, 1, 4) DESC;

-- GROUP 함수: SUM
---- WHERE절은 일반 조건만 들어가고, HAVING절은 그룹 조건만 들어감
---- 따라서 HAVING절에는 그룹함수를 이용한 조건처리가 가능함

SELECT
    round(AVG(mem_mileage), 2) AS "마일리지평균",
    SUM(mem_mileage)           AS "마일리지합계",
    MAX(mem_mileage)           AS "최고마일리지",
    MIN(mem_mileage)           AS "최소마일리지",
    COUNT(mem_mileage)         AS "인원수"
FROM
    member;

/*
상품분류별 판매가 전체의 평균, 합계, 최대값, 최소값, 자료수 조회
*/

SELECT
    prod_lgu,
    round(AVG(prod_sale), 2) AS "avg_sale",
    SUM(prod_sale)           AS "sum_sale",
    MAX(prod_sale)           AS "max_sale",
    MIN(prod_sale)           AS "min_sale",
    COUNT(prod_sale)         AS "count_sale"
FROM
    prod
GROUP BY
    prod_lgu
HAVING
    COUNT(prod_sale) >= 20;

SELECT
    substr(mem_add1, 1, 2)   AS "address",
    to_char(mem_bir, 'yyyy') AS "birth",
    AVG(mem_mileage)         AS "avg",
    SUM(mem_mileage)         AS "sum",
    MAX(mem_mileage)         AS "max",
    MIN(mem_mileage)         AS "min",
    COUNT(mem_mileage)       AS "count"
FROM
    member
GROUP BY
    substr(mem_add1, 1, 2),
    to_char(mem_bir, 'yyyy')
ORDER BY
    substr(mem_add1, 1, 2);
         
-- NULL
---- ISNULL, IS NOT NULL
---- NVL(C, r)
---- NVL2(c, r1, r2)
---- NULLIF(c ,d) c와 d를 비교하여 같으면 NULL, 다르면 c 반환
---- COALESCE(p[,p...]) 파라미터 중 NULL이 아닌 첫 번째 파라미터 반환

UPDATE buyer
SET
    buyer_charger = NULL
WHERE
    buyer_charger LIKE '김%';

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger LIKE '김%';

UPDATE buyer
SET
    buyer_charger = ''
WHERE
    buyer_charger LIKE '성%';

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger LIKE '성%';

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger = NULL;

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger IS NULL;

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger IS NOT NULL;

SELECT
    buyer_name,
    nvl(buyer_charger, '없음')
FROM
    buyer;

SELECT
    buyer_name,
    nvl2(buyer_charger, '없음', '있음')
FROM
    buyer;

SELECT
    mem_name                  AS "성명",
    nvl(mem_mileage, 0)       AS "마일리지",
    nvl(mem_mileage, 0) + 100 AS "변경마일리지"
FROM
    member;

SELECT
    mem_name                           AS "성명",
    mem_mileage                        AS "마일리지",
    nvl2(mem_mileage, '정상회원', '비정상회원') AS "회원상태"
FROM
    member;

-- DECODE, CASE WHEN
---- IF 문과 비슷
---- CASE WHEN ~ THEN ~ ELSE ~ END
---- DECODE는 간단한 등가 비교에만 사용함

SELECT
    decode(substr(prod_lgu, 1, 2), 'P1', '컴퓨터/전자 제품', 'P2', '의류',
           'P3', '잡화', '기타')
FROM
    prod;

SELECT
    prod_name         AS "상품명",
    prod_sale         AS "판매가",
    decode(substr(prod_lgu, 1, 2), 'P1', prod_sale * 1.1, 'P2', prod_sale * 1.15,
           prod_sale) AS "변경판매가"
FROM
    prod;

SELECT
    mem_name                                    AS "회원명",
    concat(mem_regno1, concat('-', mem_regno2)) AS "주민등록번호",
    CASE
        WHEN substr(mem_regno2, 1, 1) = '1' THEN
            'MALE'
        ELSE
            'FEMALE'
    END                                         AS "성별"
FROM
    member;

/*
[문제 만들기]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 2월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬
*/

SELECT
    mem_id   AS "회원 아이디",
    mem_name AS "회원 이름"
FROM
    member
WHERE
        substr(mem_regno2, 1, 1) = 2
    AND mem_memorial LIKE '결혼기념일'
    AND to_char(mem_memorialday, 'mm') = 2
    AND mem_id IN (
        SELECT
            cart_member
        FROM
            cart
        WHERE
            cart_prod NOT IN (
                SELECT
                    prod_id
                FROM
                    prod
                WHERE
                    prod_lgu IN (
                        SELECT
                            lprod_gu
                        FROM
                            lprod
                        WHERE
                            lprod_gu IN (
                                SELECT DISTINCT
                                    buyer_lgu
                                FROM
                                    buyer
                                WHERE
                                    buyer_add1 LIKE '대전%'
                            )
                    )
            )
    )
ORDER BY
    mem_name ASC;

/*
[문제 만들기]
대전에 사는 담당자가 담당하는 상품 중
안전재고수량별 빈도수가 가장 높은 상품을 구매한 회원 중 자영업 아닌 회원의 id와 name
*/

SELECT
    mem_id,
    mem_name
FROM
    member
WHERE
        mem_job != '자영업'
    AND mem_id IN (
        SELECT
            cart_member
        FROM
            cart
        WHERE
            cart_prod IN (
                SELECT
                    prod_id
                FROM
                    prod
                WHERE
                    prod_properstock IN (
                        SELECT
                            prod_properstock
                        FROM
                            prod
                        GROUP BY
                            prod_properstock
                        HAVING
                            COUNT(prod_properstock) = (
                                SELECT
                                    MAX(cnt) AS max_cnt
                                FROM
                                    (
                                        SELECT
                                            prod_properstock, COUNT(prod_properstock) AS cnt
                                        FROM
                                            prod
                                        GROUP BY
                                            prod_properstock
                                    )
                            )
                    )
                    AND prod_lgu IN (
                        SELECT
                            lprod_gu
                        FROM
                            lprod
                        WHERE
                            lprod_gu IN (
                                SELECT DISTINCT
                                    buyer_lgu
                                FROM
                                    buyer
                                WHERE
                                    buyer_add1 LIKE '대전%'
                            )
                    )
            )
    );