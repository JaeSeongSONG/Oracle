/*
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
단, 상품분류코드가 'P101', 'P201', 'P301' 인 것들에 대해 조회
매입수량이 15개 이상인 것들과 '서울'에 살고 있는 회원 중에 생일이 1974년생인 사람 조회
회원아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순
*/

---- 일반 방식

SELECT
    l.lprod_nm,
    p.prod_name,
    p.prod_color,
    b.buy_qty,
    c.cart_qty,
    bb.buyer_name
FROM
    lprod   l,
    prod    p,
    buyprod b,
    cart    c,
    buyer   bb,
    member  m
WHERE
        buyer_id = prod_buyer
    AND lprod_gu = prod_lgu
    AND prod_id = buy_prod
    AND prod_id = cart_prod
    AND mem_id = cart_member
    AND lprod_gu IN ( 'P101', 'P201', 'P301' )
    AND b.buy_qty >= 15
    AND mem_add1 LIKE '%서울%'
    AND to_char(mem_bir, 'yyyy') = '1974';

---- ANSI 방식

SELECT
    l.lprod_nm,
    p.prod_name,
    p.prod_color,
    b.buy_qty,
    c.cart_qty,
    bb.buyer_name
FROM
         prod p
    INNER JOIN buyprod b ON p.prod_id = b.buy_prod
    INNER JOIN buyer   bb ON p.prod_buyer = bb.buyer_id
    INNER JOIN cart    c ON p.prod_id = c.cart_prod
    INNER JOIN member  m ON m.mem_id = c.cart_member
    INNER JOIN lprod   l ON l.lprod_gu = p.prod_lgu
WHERE
    lprod_gu IN ( 'P101', 'P201', 'P301' )
    AND b.buy_qty >= 15
    AND mem_add1 LIKE '%서울%'
    AND to_char(mem_bir, 'yyyy') = '1974';
    
-- OUTER JOIN 
---- 누락된 ROW까지 검색되도록 하는 방법
---- JOIN에서 부족한 쪽에 (+) 연산자 기호를 사용
---- NULL행을 생성하여 조인하게 함

---- 일반방식

SELECT
    lprod_gu,
    lprod_nm,
    COUNT(prod_lgu)
FROM
    lprod,
    prod
WHERE
    lprod_gu = prod_lgu (+)
GROUP BY
    lprod_gu,
    lprod_nm;

---- ANSI 방식

SELECT
    lprod_gu,
    lprod_nm,
    COUNT(prod_lgu)
FROM
    lprod
    LEFT OUTER JOIN prod ON ( lprod_gu = prod_lgu )
GROUP BY
    lprod_gu,
    lprod_nm;
    
---- 일반방식
---- 조건을 만드는 순간 outer join 이 깨져버림

SELECT
    prod_id,
    prod_name,
    SUM(buy_qty)
FROM
    prod,
    buyprod
WHERE
        prod_id = buy_prod (+)
    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
GROUP BY
    prod_id,
    prod_name;

---- ANSI 방식
---- 따라서 ANSI 방식으로 사용함
---- WHERE을 사용하지 않고, ON 안에 넣는 방식을 사용

SELECT
    prod_id,
    prod_name,
    SUM(buy_qty)
FROM
    prod
    LEFT OUTER JOIN buyprod ON ( prod_id = buy_prod
                                 AND buy_date BETWEEN '2005-01-01' AND '2005-01-31' )
GROUP BY
    prod_id,
    prod_name;
--------------------------------------------------------------------------------
SELECT
    prod_id,
    prod_name,
    SUM(nvl(buy_qty, 0))
FROM
    prod
    LEFT OUTER JOIN buyprod ON ( prod_id = buy_prod
                                 AND buy_date BETWEEN '2005-01-01' AND '2005-01-31' )
GROUP BY
    prod_id,
    prod_name;
--------------------------------------------------------------------------------
SELECT
    mem_id,
    mem_name,
    SUM(nvl(cart_qty, 0))
FROM
    member
    LEFT OUTER JOIN cart ON ( mem_id = cart_member
                              AND substr(cart_no, 1, 6) = '200504' )
GROUP BY
    mem_id,
    mem_name
ORDER BY
    mem_id,
    mem_name;
-------------------------------------------------------------------------------- 
SELECT
    to_char(buy_date, 'MM'),
    SUM(buy_qty),
    to_char(SUM(buy_qty * prod_cost), 'L999,999,999')
FROM
    buyprod,
    prod
WHERE
        buy_prod = prod_id
    AND EXTRACT(YEAR FROM buy_date) = 2005
GROUP BY
    to_char(buy_date, 'MM')
ORDER BY
    to_char(buy_date, 'MM') ASC;
--------------------------------------------------------------------------------
SELECT
    substr(cart_no, 1, 4) AS 매입년,
    substr(cart_no, 5, 2) AS 매입월,
    SUM(cart_qty),
    to_char(SUM(cart_qty * prod_cost), 'L999,999,999')
FROM
    prod,
    cart
WHERE
        cart_prod = prod_id
    AND substr(cart_no, 1, 4) = 2005
GROUP BY
    substr(cart_no, 1, 4),
    substr(cart_no, 5, 2)
ORDER BY
    매입월 ASC;
    
--------------------------------------------------------------------------------

SELECT
    substr(cart_no, 1, 8),
    SUM(cart_qty * prod_sale),
    SUM(cart_qty)
FROM
    cart
    prod,
WHERE
    cart_no LIKE '2005%'
    AND prod_id = cart_prod
    AND prod_lgu = 'P101'
GROUP BY
    substr(cart_no, 1, 8)
HAVING
    SUM(cart_qty * prod_sale) > 5000000
ORDER BY
substr(cart_no, 1, 8);

-- SUB QUERY

SELECT
    mem_name,
    mem_job,
    mem_mileage
FROM
    member
WHERE
        mem_job != '공무원'
    AND mem_mileage > ALL (
        SELECT
            mem_mileage
        FROM
            member
        WHERE
            mem_job = '공무원'
    );