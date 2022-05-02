/*
회원정보 중 구매내역이 있는 회원에 대한
회원아이디, 회원이름, 생일을 조회
생일 기준 오름차순
*/

SELECT
    mem_id,
    mem_name,
    to_char(mem_bir, 'yyyy-mm-dd') AS "Birth"
FROM
    member
WHERE
    mem_id IN (
        SELECT DISTINCT
            cart_member
        FROM
            cart
    )
ORDER BY
    mem_bir ASC;
    
-- JOIN
---- EXISTS: 서브쿼리 안에 결과가 한 건이라도 존재하면 TRUE, 아니면 FALSE 반환

SELECT
    prod_id,
    prod_name,
    prod_lgu
FROM
    prod
WHERE
    EXISTS (
        SELECT
            lprod_gu
        FROM
            lprod
        WHERE
                lprod_gu = prod.prod_lgu
            AND lprod_gu = 'P301'
    );

SELECT
    COUNT(*)
FROM
    lprod,
    prod,
    buyer;
    
-- TABLE JOIN
---- 일반 방식

SELECT
    p.prod_id    AS "상품코드",
    p.prod_name  AS "상품명",
    l.lprod_nm   AS "분류명",
    b.buyer_name AS "거래처명"
FROM
    prod  p,
    lprod l,
    buyer b
WHERE
        p.prod_lgu = l.lprod_gu
    AND p.prod_buyer = b.buyer_id;
        
---- ANSI 방식        

SELECT
    p.prod_id    AS "상품코드",
    p.prod_name  AS "상품명",
    l.lprod_nm   AS "분류명",
    b.buyer_name AS "거래처명"
FROM
         prod p
    INNER JOIN lprod l ON l.lprod_gu = p.prod_lgu
    INNER JOIN buyer b ON l.lprod_gu = b.buyer_lgu;
    
/*
회원이 구매한 거래처 정보 조회
회원아이디, 회원이름, 상품거래처명, 상품분류명 조회
*/

---- 일반 방식

SELECT
    m.mem_id,
    m.mem_name,
    b.buyer_name,
    l.lprod_nm
FROM
    member m,
    buyer  b,
    lprod  l,
    prod   p,
    cart   c
WHERE
        mem_id = cart_member
    AND cart_prod = prod_id
    AND prod_buyer = buyer_id
    AND prod_lgu = lprod_gu;


---- ANSI 방식

SELECT
    mem_id,
    mem_name,
    buyer_name,
    lprod_nm
FROM
         member
    INNER JOIN cart ON cart_member = mem_id
    INNER JOIN prod ON prod_id = cart_prod
    INNER JOIN buyer ON prod_buyer = buyer_id
    INNER JOIN lprod ON lprod_gu = prod_lgu
ORDER BY
    mem_name;

/*
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처명을 조회
*/

SELECT
    p.prod_id,
    p.prod_name,
    b.buyer_name
FROM
    prod  p,
    buyer b
WHERE
        p.prod_buyer = b.buyer_id
    AND b.buyer_name = '삼성전자';

SELECT
    p.prod_id,
    p.prod_name,
    b.buyer_name
FROM
         prod p
    INNER JOIN buyer b ON p.prod_buyer = b.buyer_id
WHERE
    b.buyer_name = '삼성전자';

/*
판매가격 10만 이하
거래처 주소가 부산인 경우
*/

---- 일반 방식

SELECT
    p.prod_id,
    p.prod_name,
    l.lprod_nm,
    b.buyer_name,
    b.buyer_add1
FROM
    prod  p,
    lprod l,
    buyer b
WHERE
        b.buyer_id = p.prod_buyer
    AND l.lprod_gu = p.prod_lgu
    AND p.prod_sale < 100000
    AND b.buyer_add1 LIKE '부산%';
    
---- ANSI 방식    

SELECT
    p.prod_id,
    p.prod_name,
    l.lprod_nm,
    b.buyer_name,
    b.buyer_add1
FROM
         prod p
    INNER JOIN lprod l ON l.lprod_gu = p.prod_lgu
    INNER JOIN buyer b ON b.buyer_id = p.prod_buyer
WHERE
        p.prod_sale < 100000
    AND b.buyer_add1 LIKE '부산%';
    
/*
상품분류코드 = P101
상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량 조회
단, 상품분류명을 기준으로 내림차순, 상품아이디를 기준으로 오름차순
*/

---- 일반 방식

SELECT
    lprod_nm,
    prod_id,
    prod_sale,
    buyer_charger,
    mem_id,
    cart_qty
FROM
    prod,
    lprod,
    buyer,
    member,
    cart
WHERE
        mem_id = cart_member
    AND prod_id = cart_prod
    AND buyer_id = prod_buyer
    AND prod_lgu = lprod_gu
    AND lprod_gu = 'P101'
ORDER BY
    lprod_nm DESC,
    prod_id ASC;
    
---- ANSI 방식    

SELECT
    lprod_nm,
    prod_id,
    prod_sale,
    buyer_charger,
    mem_id,
    cart_qty
FROM
         member
    INNER JOIN cart ON mem_id = cart_member
    INNER JOIN prod ON prod_id = cart_prod
    INNER JOIN buyer ON buyer_id = prod_buyer
    INNER JOIN lprod ON prod_lgu = lprod_gu
WHERE
    lprod_gu = 'P101'
ORDER BY
    lprod_nm DESC,
    prod_id ASC;
    
/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/

SELECT
    buyer_name,
    buyer_comtel
FROM
    buyer
WHERE
    buyer_id IN (
        SELECT
            prod_buyer
        FROM
            prod
        WHERE
            prod_id IN (
                SELECT
                    cart_prod
                FROM
                    cart
                WHERE
                    cart_member IN (
                        SELECT
                            mem_id
                        FROM
                            member
                        WHERE
                            mem_name = '오철희'
                    )
            )
            AND prod_name LIKE '%TV%'
    );
/*
2. 대전에 사는 73년이후에 태어난 주부들중 2005년4월에 구매한 물품을 조회하고, 
그상품을 거래하는 각거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).*/

SELECT
    buyer_bank
    || '-'
    || buyer_bankno
FROM
    buyer
WHERE
    buyer_id IN (
        SELECT
            prod_buyer
        FROM
            prod
        WHERE
            prod_id IN (
                SELECT
                    cart_prod
                FROM
                    cart
                WHERE
                    cart_member IN (
                        SELECT
                            mem_id
                        FROM
                            member
                        WHERE
                            mem_add1 LIKE '%대전%'
                            AND mem_job = '주부'
                            AND to_char(mem_bir, 'yy') > 73
                    )
                    AND substr(cart_no, 1, 6) = 200504
            )
    );

/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 
쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매횟수에 따라 오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/

SELECT
    mem_id,
    mem_hp,
    (
        SELECT
            SUM(cart_qty) AS tmp
        FROM
            cart
        WHERE
            cart_member = member.mem_id
    ) AS tmp2
FROM
    member
ORDER BY
    tmp2 ASC;
    
/*
2조 
대전 지역에 거주하고 생일이 2월이고 구매일자가 4월 ~ 6월 사이인 회원 중 
구매수량이 전체회원의 평균 구매수량보다 높은 회원 조회 후 

"(mem_name) 회원님의 (Extract(month form mem_bir)) 월 생일을 진심으로 축하합니다. 
2마트 (mem_add 중 2글자) 점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다." 출력

(Alias 회원명, 성별, 주소, 이메일 주소, 생일 축하 문구)
*/

SELECT
    mem_name
    || ' 회원님의 '
    || EXTRACT(MONTH FROM mem_bir)
    || '월 생일을 진심으로 축하합니다. '
    || substr(mem_add1, 1, 2)
    || '점을 이용해 주셔서 감사합니다.'
    || ' 이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.'
FROM
    member
WHERE
        substr(mem_add1, 1, 2) = '대전'
    AND EXTRACT(MONTH FROM mem_bir) = 2
    AND mem_id IN (
        SELECT
            cart_member
        FROM
            cart
        WHERE
                cart_qty >= (
                    SELECT
                        AVG(cart_qty)
                    FROM
                        cart
                )
            AND substr(cart_no, 1, 6) BETWEEN 200504 AND 200506
    );
    
/*
[1문제]
2조
주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오.)
(원화표기 및 천단위구분)
(Alias 상품분류, 판매가, 변경판매가)
*/

SELECT prod_sale
FROM prod
WHERE prod_sale BETWEEN 500000 AND 1000000 ;

SELECT
    prod_lgu          상품분류,
    prod_sale         판매가,
    decode(substr(prod_lgu, 3, 4), '01', prod_sale * 0.9, '02', prod_sale * 1.05,
           prod_sale) AS new_sale
FROM
    prod
WHERE
    prod_sale BETWEEN 500000 AND 1000000
    AND prod_id IN (
        SELECT
            cart_prod
        FROM
            cart
        WHERE
            cart_member IN (
                SELECT
                    mem_id
                FROM
                    member
                WHERE
                    EXTRACT(month FROM mem_bir) = 1
            )
    )
ORDER BY
    new_sale DESC;