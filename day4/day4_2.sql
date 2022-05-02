/*
lprod : ��ǰ�з�����
prod : ��ǰ����
buyer : �ŷ�ó����
member : ȸ������
cart : ����(��ٱ���) ����
buyprod : �԰��ǰ����
remain : ����������
*/

SELECT m.mem_id, m.mem_name
FROM member m;

---- ���̺� alias ���� �� as�� ������� �ʴ´�.

SELECT p.prod_id, p.prod_name
FROM prod p; 

SELECT ROUND(m.MEM_MILEAGE / 12) as mileage
FROM member m ;

SELECT p.prod_id, p.prod_name, p.prod_price * 55 as "PRICE"
FROM prod p ;

-- DISTINCT 
---- �ߺ��� ROW�� ����

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

SELECT prod_name AS "��ǰ", prod_sale AS "�ǸŰ�"
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

SELECT prod_name AS "��ǰ", prod_lgu AS "��ǰ�з�", prod_sale AS "�ǸŰ�"
  FROM prod
 WHERE prod_lgu = 'P201'
   AND prod_sale = 170000 ;
   
SELECT prod_name AS "��ǰ", prod_lgu AS "��ǰ�з�", prod_sale AS "�ǸŰ�"
  FROM prod
 WHERE prod_lgu = 'P201'
    OR prod_sale = 170000 ;
 
SELECT prod_name AS "��ǰ", prod_lgu AS "��ǰ�з�", prod_sale AS "�ǸŰ�"
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

SELECT lprod_gu AS  "�з��ڵ�", lprod_nm AS "�з���"
  FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu FROM prod) ;
 
SELECT lprod_gu AS "�з��ڵ�", lprod_nm AS "�з���"
  FROM lprod
 WHERE lprod_gu NOT IN (SELECT prod_lgu FROM prod) ;
 
/*
[����]
�ѹ��� ������ ���� ���� ȸ�� ���̵�, �̸� ��ȸ
*/
 
SELECT mem_id AS "ȸ�� ���̵�", mem_name AS "ȸ�� �̸�"
  FROM member
 WHERE mem_id NOT IN (SELECT cart_member FROM cart) ;

/*
[����]
�ѹ��� �Ǹŵ� ���� ���� ��ǰ�̸� ��ȸ
*/
 
SELECT prod_name AS "��ǰ�̸�"
  FROM prod
 WHERE prod_id NOT IN (SELECT cart_prod FROM cart) ;
 
/*
[����]
������ ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ�� ��ȸ
*/
 
SELECT DISTINCT prod_name
FROM prod
WHERE prod_id IN (SELECT cart_prod FROM cart WHERE cart_member 
IN (SELECT mem_id FROM member WHERE mem_name = '������')) ;

/*
[����]
��ǰ �� �ǸŰ��� 10�� �̻�, 30�� ������ ��ǰ ��ȸ
��ǰ��, �ǸŰ���
�ǸŰ��� ���� ��������
*/
 
SELECT prod_name AS "��ǰ��", prod_sale AS "�ǸŰ���"
FROM prod
WHERE prod_sale BETWEEN 100000 AND 300000
ORDER BY prod_sale DESC ;

-- ��¥ ����

SELECT mem_name
FROM member
WHERE mem_bir BETWEEN '75/01/01' AND '76/12/31' ;

/*
[����]
�ŷ�ó ����� ���������� ����ϴ� ��ǰ�� ������ ȸ�� ��ȸ
ȸ�� ���̵�, ȸ�� �̸� ��ȸ
*/

SELECT mem_id AS "ȸ�� ���̵�", mem_name AS "ȸ�� �̸�"
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
                      WHERE buyer_charger = '������'
                      )
                  )
              )
          ) ;
          
SELECT prod_name AS "��ǰ��", prod_cost AS "���԰�", prod_sale AS "�ǸŰ�"
FROM prod
WHERE prod_cost BETWEEN 300000 AND 1500000
AND prod_sale BETWEEN 800000 AND 2000000  ;

SELECT mem_id AS "ȸ��ID", mem_name AS "ȸ����", mem_bir AS "����"
FROM member
WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31' ;

-- LIKE

SELECT prod_id AS "��ǰ�ڵ�", prod_name AS "��ǰ��"
  FROM prod
 WHERE prod_name LIKE '��%' ;
 
SELECT prod_id AS "��ǰ�ڵ�", prod_name AS "��ǰ��"
  FROM prod
 WHERE prod_name LIKE '_��%' ;
 
SELECT prod_id AS "��ǰ�ڵ�", prod_name AS "��ǰ��"
  FROM prod
 WHERE prod_name LIKE '%����%' ;
 
SELECT lprod_gu AS "�з��ڵ�", lprod_nm AS "�з���"
  FROM lprod
 WHERE lprod_nm LIKE '%ȫ\%' ;
 
SELECT mem_id AS "ȸ��ID", mem_name AS "����"
  FROM member
 WHERE mem_name LIKE '��%' ;

SELECT mem_id AS "ȸ��ID", mem_name AS "����", 
CONCAT(mem_regno1, CONCAT('-', mem_regno2))
  FROM member
 WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31' ;
 
-- ���ڿ� �Լ�

SELECT mem_id || 'name is' || mem_name FROM member ;

SELECT LOWER('DATA manipulation Language') "LOWER",
       UPPER('DATA manipulation Language') "UPPER",
       INITCAP('DATA manipulation Language') "INITCAP"
FROM dual ;

SELECT mem_id AS "��ȯ �� ID", UPPER(mem_id) AS "��ȯ �� ID"
FROM member ;

SELECT LPAD('Java', 10, '*') AS "LPAD",
       RPAD('Java', 10, '*') AS "RPAD"
FROM dual ;

SELECT SUBSTR('SQL PROJECT', 1, 3) RESULT_1
FROM dual ;

SELECT TRANSLATE('2009-02-28', '0123456789', 'ABCDEFGHIJK') RESULT
FROM dual ;

---- ���ڰ� ��� ������

SELECT REPLACE('SQL Project', 'SQL', 'SSQQLL') ����ġȯ_1,
       REPLACE('Java Flex Via', 'a') ����ġȯ_2 
FROM dual ;

SELECT CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'),
SUBSTR(mem_name, 2))
FROM member ; 

SELECT GREATEST(10,20,30) "ū��",
       LEAST(10,20,30) "������"
FROM dual ;

SELECT ROUND(123.245346, 0) FROM dual ;
SELECT ROUND(123.245346, 1) FROM dual ; -- �Ҽ��� ���ڸ�
SELECT ROUND(123.245346, -1) FROM dual ; -- ���� �ڸ�

SELECT MOD(10,3) FROM dual ;

-- ��¥ �Լ�

SELECT SYSDATE "����ð�",
       SYSDATE - 1 "�Ϸ� ��",
       SYSDATE + 1 "�Ϸ� ��"
FROM dual ;

---- NEXT_DAY, LAST_DAY

SELECT NEXT_DAY(SYSDATE, '������'), -- ������ ������
       LAST_DAY(SYSDATE) -- �� ���� ������ ��
FROM dual ;

SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM dual ; -- ���� �̹��� ��¥

---- EXTRACT

SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
       EXTRACT(MONTH FROM SYSDATE) "��",
       EXTRACT(DAY FROM SYSDATE) "��"
FROM dual ;

SELECT mem_name
FROM MEMBER 
WHERE (EXTRACT(MONTH FROM mem_bir)) = 3 ; -- ������ 3���� ȸ��

/*
ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� �������� ����
��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ, �ߺ�����
*/

SELECT DISTINCT prod_name AS "��ǰ��"
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
AND prod_name LIKE '%�Ｚ%' 
ORDER BY prod_name ASC ;

-- �� ��ȯ �Լ� (��¥)

SELECT '[' || CAST('HEllo' AS CHAR(30)) || ']' "����ȯ"
FROM dual ;

SELECT CAST('1997/12/25' AS DATE) FROM dual ;

SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC"����"')
FROM dual ;

SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
                     'YYYY.MM.DD HH24:MI')
FROM dual ;

SELECT prod_name AS "��ǰ��", prod_sale AS "��ǰ�ǸŰ�", 
       TO_CHAR(CAST(prod_insdate AS DATE), 'YYYY-MM-DD') AS "�԰���"
FROM prod ;

SELECT mem_name || '���� ' || TO_CHAR(CAST(mem_bir AS DATE), 'YYYY') || '�� ' ||
TO_CHAR(CAST(mem_bir AS DATE), 'mm') || '�� ����̰� �¾ ������ ' ||
TO_CHAR(CAST(mem_bir AS DATE), 'day')
FROM member ;

-- �� ��ȯ �Լ� (����)

SELECT TO_CHAR(1234.6, '99,999.00') FROM dual ; -- ��ȿ�� �ڸ� ���, ��ȿ�϶� 0 ���
SELECT TO_CHAR(-1234.6, 'L99,999.00PR') FROM dual ; -- ȭ���ȣ + ��ȣ ����
SELECT TO_CHAR(255, 'XXX') FROM dual ; -- 16������ ���

SELECT TO_NUMBER('3.1415') FROM dual ;
SELECT TO_NUMBER(LTRIM('$1,200', '$')) FROM dual ;

SELECT SUBSTR(mem_id, 1, 2) ||
      (SUBSTR(mem_id, 3, 2) + 10)
  FROM member 
 WHERE mem_name = '�̻���' ;

-- GROUP

SELECT AVG(DISTINCT prod_cost), AVG(ALL prod_cost),
       AVG(prod_cost) AS "���԰����"
FROM prod ;

SELECT prod_lgu,
       ROUND(AVG(prod_cost), 2) AS "�з��� ���԰��� ���"
FROM prod 
GROUP BY prod_lgu ;

SELECT AVG(prod_sale) AS "��ǰ �� �Ǹ� ���� ���"
FROM prod ;

SELECT prod_lgu, AVG(prod_sale) AS "avg_sale"
FROM prod
GROUP BY prod_lgu ;

SELECT cart_member, COUNT(cart_member) AS "mem_count"
FROM cart
GROUP BY cart_member ;

/*
���ż����� ��ü ��� �̻��� ������ ȸ������ ���̵�� �̸� ��ȸ
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

 