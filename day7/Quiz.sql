/*
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
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
                            mem_name = '�輺��'
                    )
            )
    );

/*
<�°�>
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� 
*/

SELECT
    concat(replace(substr(mem_name, 1, 1), '��', '��'), substr(mem_name, 2, 2)) AS "name_change",
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
                                buyer_bank = '��ȯ����'
                            AND buyer_add1 NOT LIKE '%����%'
                    )
            )
    );

/*
<����>
¦�� �޿� ���ŵ� ��ǰ�� �� ��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ���� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, ���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)
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
                        prod_delivery != '��Ź ����'
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
                        prod_delivery != '��Ź ����'
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
    END AS ����
FROM
    prod
WHERE
        prod_delivery != '��Ź ����'
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
[����]
1. 
'����ĳ�־�'�̸鼭 ��ǰ �̸��� '����'�� ���� ��ǰ�̰�, 
���Լ����� 30���̻��̸鼭 6���� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ��ȸ�Ͻÿ�
Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���
*/

SELECT
    prod_name,
    prod_sale,
    prod_sale + nvl(prod_mileage, 0) AS "�ǸŰ���+���ϸ���"
FROM
    prod
WHERE
    prod_name LIKE '%����%'
    AND prod_lgu IN (
        SELECT
            lprod_gu
        FROM
            lprod
        WHERE
            lprod_nm = '����ĳ�־�'
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
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/

SELECT
    mem_name,
    mem_mileage,
    CASE
        WHEN mem_mileage >= 2500 THEN
            '���ȸ��'
        ELSE
            '�Ϲ�ȸ��'
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
6���� ����(5���ޱ���)�� �԰�� ��ǰ �߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� 
�Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/

SELECT
    mem_name,
    mem_mileage,
    CASE
        WHEN substr(mem_regno2, 1, 1) = 1 THEN
            '����'
        ELSE
            '����'
    END AS "����"
FROM
    member
WHERE
    mem_name LIKE '��%'
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
                    AND prod_delivery = '��Ź ����'
                    AND prod_color IS NULL
            )
    );
