/*
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/

SELECT
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
                            mem_name = '김성욱'
                    )
            )
    );

/*
<태경>
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 
*/

SELECT
    concat(replace(substr(mem_name, 1, 1), '이', '리'), substr(mem_name, 2, 2)) AS "name_change",
    mem_bir
FROM
    member
WHERE
    mem_id IN (
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
                    prod_buyer IN (
                        SELECT
                            buyer_id
                        FROM
                            buyer
                        WHERE
                                buyer_bank = '외환은행'
                            AND buyer_add1 NOT LIKE '%서울%'
                    )
            )
    );

/*
<덕현>
짝수 달에 구매된 상품들 중 세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가장 높은 값은 10퍼센트 인하된 값으로, 가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)
*/

SELECT
    prod_id,
    prod_name,
    CASE prod_price - prod_cost
        WHEN (
                SELECT
                    MAX(prod_price - prod_cost)
                FROM
                    prod
                WHERE
                        prod_delivery != '세탁 주의'
                    AND prod_id IN (
                        SELECT
                            cart_prod
                        FROM
                            cart
                        WHERE
                            substr(cart_no, 5, 2) IN ( 02, 04, 06,
                                                       08, 10, 12 )
                    )
            ) THEN
            ( prod_price - prod_cost ) * 0.9
        WHEN (
                SELECT
                    MIN(prod_price - prod_cost)
                FROM
                    prod
                WHERE
                        prod_delivery != '세탁 주의'
                    AND prod_id IN (
                        SELECT
                            cart_prod
                        FROM
                            cart
                        WHERE
                            substr(cart_no, 5, 2) IN ( 02, 04, 06,
                                                       08, 10, 12 )
                    )
            ) THEN
            ( prod_price - prod_cost ) * 1.1
        ELSE
            prod_price - prod_cost
    END AS 마진
FROM
    prod
WHERE
        prod_delivery != '세탁 주의'
    AND prod_id IN (
        SELECT
            cart_prod
        FROM
            cart
        WHERE
            substr(cart_no, 5, 2) IN ( 02, 04, 06,
                                       08, 10, 12 )
    )
GROUP BY
    prod_id,
    prod_name,
    prod_price - prod_cost;

/*    
[문제]
1. 
'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
*/

SELECT
    prod_name,
    prod_sale,
    prod_sale + nvl(prod_mileage, 0) AS "판매가격+마일리지"
FROM
    prod
WHERE
    prod_name LIKE '%여름%'
    AND prod_lgu IN (
        SELECT
            lprod_gu
        FROM
            lprod
        WHERE
            lprod_nm = '여성캐주얼'
    )
    AND prod_id IN (
        SELECT
            buy_prod
        FROM
            buyprod
        WHERE
                buy_qty >= 30
            AND to_char(buy_date, 'mm') = 6
    );

/*
2. 
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/

SELECT
    mem_name,
    mem_mileage,
    CASE
        WHEN mem_mileage >= 2500 THEN
            '우수회원'
        ELSE
            '일반회원'
    END AS "classify"
FROM
    member
WHERE
    mem_id IN (
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
                        to_char(prod_insdate, 'yymm') > 0501
                    AND prod_cost > 200000
                    AND prod_buyer IN (
                        SELECT
                            buyer_id
                        FROM
                            buyer
                        WHERE
                            buyer_id LIKE 'P20%'
                    )
            )
    );

/*
3. 
6월달 이전(5월달까지)에 입고된 상품 중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 
판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/

SELECT
    mem_name,
    mem_mileage,
    CASE
        WHEN substr(mem_regno2, 1, 1) = 1 THEN
            '남자'
        ELSE
            '여자'
    END AS "성별"
FROM
    member
WHERE
    mem_name LIKE '김%'
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
            AND cart_prod IN (
                SELECT
                    prod_id
                FROM
                    prod
                WHERE
                    to_char(prod_insdate, 'yymm') < 0506
                    AND prod_delivery = '세탁 주의'
                    AND prod_color IS NULL
            )
    );
