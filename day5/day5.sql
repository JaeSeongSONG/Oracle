-- GROUP �Լ�: COUNT

---- COUNT(*)�� COUNT()�� �ٸ��� NULL ���� ����

SELECT
    COUNT(DISTINCT prod_cost),
    COUNT(prod_cost),
    COUNT(prod_cost),
    COUNT(*)
FROM
    prod;

/*
���ų��� (��ٱ���) �������� ȸ�� ���̵� ���� �ֹ�(����)�� ���� ��� ��ȸ
ȸ�� ���̵� �������� ��������
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
��ǰ�������� �ǸŰ����� ��� ���� ���϶�
��, ��հ��� �Ҽ��� ��°�ڸ����� ǥ���Ѵ�
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
��ǰ�������� ��ǰ �з��� �ǸŰ����� ��հ�
��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ��� ��ȸ
��, ��հ��� �Ҽ��� ��°�ڸ�����
*/

SELECT
    prod_lgu,
    round(AVG(prod_sale), 2)
FROM
    prod
GROUP BY
    prod_lgu;

SELECT
    COUNT(DISTINCT mem_like) AS "���������"
FROM
    member;

SELECT
    mem_like        AS "���",
    COUNT(mem_like) AS "�ڷ��",
    COUNT(*)        AS "�ڷ��(*)"
FROM
    member
GROUP BY
    mem_like;

SELECT DISTINCT
    mem_job        AS "����",
    COUNT(mem_job) AS "���� ���� ��"
FROM
    member
GROUP BY
    mem_job;

/*
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
���̵�, �̸�, ���ϸ����� ��ȸ
���ϸ����� ���� ������ ����
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

-- GROUP �Լ�: MAX, MIN

---- ��ȸ ���� �� �ش� �÷��� �� �ִ밪�� �ּҰ�

SELECT
    MAX(DISTINCT prod_cost),
    MIN(DISTINCT prod_cost)
FROM
    prod;

SELECT
    MAX(cart_no)     AS "�������� ���� ���� ���� �ֹ���ȣ",
    MAX(cart_no) + 1 AS "�߰��ֹ���ȣ"
FROM
    cart
WHERE
    cart_no LIKE '20050711%';
 
/*
������������ �������� �Ǹŵ� ��ǰ�� ����, ��ձ��ż��� ��ȸ
������ �������� �������� ����
*/

SELECT
    substr(cart_no, 1, 4) AS "����",
    SUM(cart_qty),
    AVG(cart_qty)
FROM
    cart
GROUP BY
    substr(cart_no, 1, 4)
ORDER BY
    substr(cart_no, 1, 4) DESC;

/*
������������ �⵵��, ��ǰ�з��ڵ庰�� ��ǰ�� ������ ��ȸ
���� ���� �������� ����
*/

SELECT
    substr(cart_no, 1, 4)   AS "����",
    substr(cart_prod, 1, 4) AS "��ǰ�з��ڵ�",
    COUNT(cart_prod)
FROM
    cart
GROUP BY
    substr(cart_no, 1, 4),
    substr(cart_prod, 1, 4)
ORDER BY
    substr(cart_no, 1, 4) DESC;

-- GROUP �Լ�: SUM
---- WHERE���� �Ϲ� ���Ǹ� ����, HAVING���� �׷� ���Ǹ� ��
---- ���� HAVING������ �׷��Լ��� �̿��� ����ó���� ������

SELECT
    round(AVG(mem_mileage), 2) AS "���ϸ������",
    SUM(mem_mileage)           AS "���ϸ����հ�",
    MAX(mem_mileage)           AS "�ְ��ϸ���",
    MIN(mem_mileage)           AS "�ּҸ��ϸ���",
    COUNT(mem_mileage)         AS "�ο���"
FROM
    member;

/*
��ǰ�з��� �ǸŰ� ��ü�� ���, �հ�, �ִ밪, �ּҰ�, �ڷ�� ��ȸ
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
---- NULLIF(c ,d) c�� d�� ���Ͽ� ������ NULL, �ٸ��� c ��ȯ
---- COALESCE(p[,p...]) �Ķ���� �� NULL�� �ƴ� ù ��° �Ķ���� ��ȯ

UPDATE buyer
SET
    buyer_charger = NULL
WHERE
    buyer_charger LIKE '��%';

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger LIKE '��%';

UPDATE buyer
SET
    buyer_charger = ''
WHERE
    buyer_charger LIKE '��%';

SELECT
    buyer_name,
    buyer_charger
FROM
    buyer
WHERE
    buyer_charger LIKE '��%';

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
    nvl(buyer_charger, '����')
FROM
    buyer;

SELECT
    buyer_name,
    nvl2(buyer_charger, '����', '����')
FROM
    buyer;

SELECT
    mem_name                  AS "����",
    nvl(mem_mileage, 0)       AS "���ϸ���",
    nvl(mem_mileage, 0) + 100 AS "���渶�ϸ���"
FROM
    member;

SELECT
    mem_name                           AS "����",
    mem_mileage                        AS "���ϸ���",
    nvl2(mem_mileage, '����ȸ��', '������ȸ��') AS "ȸ������"
FROM
    member;

-- DECODE, CASE WHEN
---- IF ���� ���
---- CASE WHEN ~ THEN ~ ELSE ~ END
---- DECODE�� ������ � �񱳿��� �����

SELECT
    decode(substr(prod_lgu, 1, 2), 'P1', '��ǻ��/���� ��ǰ', 'P2', '�Ƿ�',
           'P3', '��ȭ', '��Ÿ')
FROM
    prod;

SELECT
    prod_name         AS "��ǰ��",
    prod_sale         AS "�ǸŰ�",
    decode(substr(prod_lgu, 1, 2), 'P1', prod_sale * 1.1, 'P2', prod_sale * 1.15,
           prod_sale) AS "�����ǸŰ�"
FROM
    prod;

SELECT
    mem_name                                    AS "ȸ����",
    concat(mem_regno1, concat('-', mem_regno2)) AS "�ֹε�Ϲ�ȣ",
    CASE
        WHEN substr(mem_regno2, 1, 1) = '1' THEN
            'MALE'
        ELSE
            'FEMALE'
    END                                         AS "����"
FROM
    member;

/*
[���� �����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 2���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ����
*/

SELECT
    mem_id   AS "ȸ�� ���̵�",
    mem_name AS "ȸ�� �̸�"
FROM
    member
WHERE
        substr(mem_regno2, 1, 1) = 2
    AND mem_memorial LIKE '��ȥ�����'
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
                                    buyer_add1 LIKE '����%'
                            )
                    )
            )
    )
ORDER BY
    mem_name ASC;

/*
[���� �����]
������ ��� ����ڰ� ����ϴ� ��ǰ ��
������������ �󵵼��� ���� ���� ��ǰ�� ������ ȸ�� �� �ڿ��� �ƴ� ȸ���� id�� name
*/

SELECT
    mem_id,
    mem_name
FROM
    member
WHERE
        mem_job != '�ڿ���'
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
                                    buyer_add1 LIKE '����%'
                            )
                    )
            )
    );