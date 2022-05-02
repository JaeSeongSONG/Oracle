/*
ȸ������ �� ���ų����� �ִ� ȸ���� ����
ȸ�����̵�, ȸ���̸�, ������ ��ȸ
���� ���� ��������
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
---- EXISTS: �������� �ȿ� ����� �� ���̶� �����ϸ� TRUE, �ƴϸ� FALSE ��ȯ

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
---- �Ϲ� ���

SELECT
    p.prod_id    AS "��ǰ�ڵ�",
    p.prod_name  AS "��ǰ��",
    l.lprod_nm   AS "�з���",
    b.buyer_name AS "�ŷ�ó��"
FROM
    prod  p,
    lprod l,
    buyer b
WHERE
        p.prod_lgu = l.lprod_gu
    AND p.prod_buyer = b.buyer_id;
        
---- ANSI ���        

SELECT
    p.prod_id    AS "��ǰ�ڵ�",
    p.prod_name  AS "��ǰ��",
    l.lprod_nm   AS "�з���",
    b.buyer_name AS "�ŷ�ó��"
FROM
         prod p
    INNER JOIN lprod l ON l.lprod_gu = p.prod_lgu
    INNER JOIN buyer b ON l.lprod_gu = b.buyer_lgu;
    
/*
ȸ���� ������ �ŷ�ó ���� ��ȸ
ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��, ��ǰ�з��� ��ȸ
*/

---- �Ϲ� ���

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


---- ANSI ���

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
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ
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
    AND b.buyer_name = '�Ｚ����';

SELECT
    p.prod_id,
    p.prod_name,
    b.buyer_name
FROM
         prod p
    INNER JOIN buyer b ON p.prod_buyer = b.buyer_id
WHERE
    b.buyer_name = '�Ｚ����';

/*
�ǸŰ��� 10�� ����
�ŷ�ó �ּҰ� �λ��� ���
*/

---- �Ϲ� ���

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
    AND b.buyer_add1 LIKE '�λ�%';
    
---- ANSI ���    

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
    AND b.buyer_add1 LIKE '�λ�%';
    
/*
��ǰ�з��ڵ� = P101
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ�з����� �������� ��������, ��ǰ���̵� �������� ��������
*/

---- �Ϲ� ���

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
    
---- ANSI ���    

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
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
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
                            mem_name = '��ö��'
                    )
            )
            AND prod_name LIKE '%TV%'
    );
/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005��4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� �ŷ��ϴ� ���ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).*/

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
                            mem_add1 LIKE '%����%'
                            AND mem_job = '�ֺ�'
                            AND to_char(mem_bir, 'yy') > 73
                    )
                    AND substr(cart_no, 1, 6) = 200504
            )
    );

/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ 
������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ����Ƚ���� ���� ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
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
2�� 
���� ������ �����ϰ� ������ 2���̰� �������ڰ� 4�� ~ 6�� ������ ȸ�� �� 
���ż����� ��üȸ���� ��� ���ż������� ���� ȸ�� ��ȸ �� 

"(mem_name) ȸ������ (Extract(month form mem_bir)) �� ������ �������� �����մϴ�. 
2��Ʈ (mem_add �� 2����) ���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�." ���

(Alias ȸ����, ����, �ּ�, �̸��� �ּ�, ���� ���� ����)
*/

SELECT
    mem_name
    || ' ȸ������ '
    || EXTRACT(MONTH FROM mem_bir)
    || '�� ������ �������� �����մϴ�. '
    || substr(mem_add1, 1, 2)
    || '���� �̿��� �ּż� �����մϴ�.'
    || ' �̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.'
FROM
    member
WHERE
        substr(mem_add1, 1, 2) = '����'
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
[1����]
2��
�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�.)
(��ȭǥ�� �� õ��������)
(Alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)
*/

SELECT prod_sale
FROM prod
WHERE prod_sale BETWEEN 500000 AND 1000000 ;

SELECT
    prod_lgu          ��ǰ�з�,
    prod_sale         �ǸŰ�,
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