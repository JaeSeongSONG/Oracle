-- ���̺� ����

CREATE TABLE lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
) ;

-- ��ȸ�ϱ�

SELECT *
FROM lprod ;

-- ������ �Է��ϱ�

INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    1, 'P101', '��ǻ����ǰ'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    2, 'P102', '������ǰ'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    3, 'P201', '����ĳ�־�'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    4, 'P202', '����ĳ�־�'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    5, 'P301', '������ȭ'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    6, 'P302', 'ȭ��ǰ'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    7, 'P401', '����/CD'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    8, 'P402', '����'
) ;
INSERT INTO lprod (
    lprod_id, lprod_gu, lprod_nm
) VALUES (
    9, 'P403', '������'
) ;

/*
��ǰ�з��������� ��ǰ�з��ڵ��� ���� 
P201�� �����͸� ��ȸ�� �ּ���
P201 ���� ū �����͸� ��ȸ���ּ���
*/

SELECT * 
FROM lprod
WHERE lprod_gu = 'P201' ;

SELECT *
FROM lprod
WHERE lprod_gu > 'P201' ;

/*
������ ����
��ǰ�з��ڵ尡 P102�� ���ؼ�
��ǰ�з����� ���� ����� �������ּ���
*/

SELECT *
FROM lprod
WHERE lprod_gu = 'P102' ;

UPDATE lprod
   SET lprod_nm = '���'
 WHERE lprod_gu = 'P102' ;

/*
��ǰ�з���������
��ǰ�з��ڵ尡 P202�� ���� �����͸�
������ �ּ���
*/

SELECT *
  FROM lprod
 WHERE lprod_gu = 'P202' ;
 
DELETE FROM lprod
WHERE lprod_gu = 'P202' ;

commit ;

-- �ŷ�ó ���� ����

CREATE TABLE buyer
(buyer_id           char(6)          NOT NULL,  -- �ŷ�ó �ڵ�
 buyer_name         varchar2(40)     NOT NULL,  -- �ŷ�ó��
 buyer_lgu          char(4)          NOT NULL,  -- ��޻�ǰ ��з�
 buyer_bank         varchar2(60)     NOT NULL,  -- ����
 buyer_bankno       varchar2(60),               -- ���¹�ȣ
 buyer_bankname     varchar2(15),               -- ������
 buyer_zip          char(7),                    -- �����ȣ
 buyer_add1         varchar2(100),              -- �ּ�1
 buyer_add2         varchar2(70),               -- �ּ�2
 buyer_comtel       varchar2(14)     NOT NULL,  -- ��ȭ��ȣ
 buyer_fax          varchar2(20)     NOT NULL) ;-- FAX ��ȣ
 
 ---- ���̺�� ���õ� ������ ALTER
 ---- ���̺��� �̸��� �����ϴ� ���� �Ұ�����
 ---- ���̺��� �߰��� ���̺��� ������, Ÿ���� �����ϰ�, Ư�� �÷��� ������ �� ����
 ---- ���������� �߰��ϴ� �͵� ����

---- column �߰�

ALTER TABLE buyer ADD (buyer_mail varchar2(60) NOT NULL, 
                       buyer_charger varchar2(20),
                       buyer_telext varchar2(2)) ;
            
---- size ����     

ALTER TABLE buyer MODIFY (buyer_name varchar2(60) ) ; 

---- buyer_lgu�� lprod_gu�� ����

ALTER TABLE buyer
    ADD(CONSTRAINT pk_buyer Primary Key (buyer_id),
        CONSTRAINT fr_buyer_lprod Foreign Key (buyer_lgu) 
        REFERENCES lprod(lprod_gu)) ; 