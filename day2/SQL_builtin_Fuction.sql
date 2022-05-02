--���ڿ� �Լ�

--�빮��, �ҹ���
SELECT UPPER(ename), UPPER(job)
FROM emp 
WHERE job = UPPER('analyst') ;

SELECT UPPER('analyst') FROM dual ;
--���̺��� �����Ͱ� �ƴ� ���� �����ͼ� ���� ���� �� dual�� ���
SELECT LOWER(ename) AS ename, 
       LOWER(job) AS job 
FROM emp
WHERE comm IS NOT NULL  ;

--INITCAP(�ձ��ڸ� �빮�ڷ�)
SELECT INITCAP(ename) AS ename, 
       INITCAP(job) AS job 
FROM emp
WHERE comm IS NOT NULL  ;

--LENGTH ����, LENGTHB ����Ʈ ����
SELECT ename, LENGTH(ename) AS ���ڼ�, LENGTHB(ename) AS ����Ʈ��
FROM emp 
ORDER BY LENGTH(ename) ASC ;

--SUBSTR(sub string)
SELECT SUBSTR('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.',8,9) AS phase
FROM dual ;

--REPLACE
SELECT REPLACE('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.','�ȳ��ϼ���','�Ⱦ��') AS phase
FROM dual ;

--INSTR
SELECT INSTR('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.','�Ѱ���',3,1) AS phase
FROM dual ;

--LPAD,RPAD(�÷�, ���ڱ��� ����, ���� ���� ä�� ����)
SELECT LPAD(ename, 10, '*')
FROM emp;

--CONCAT
SELECT CONCAT('A', 'B')
FROM dual ;

SELECT 'A' || 'B'
FROM dual ;

--TRIM(�ݺ����� ���ڳ�, Ư�� ���ڿ�, ���� ������ ������ �ȵ�)
SELECT RTRIM(     'hi'     ), '      hi        '
FROM emp ;

SELECT RTRIM('his$','$'), 'his$',RTRIM('      hi        '),'      hi        '
FROM emp ;

--ROUND, CEIL, FLOOR, TRUNC
SELECT ROUND(19.3) FROM dual ;

SELECT TRUNC(19.3) FROM dual ;

SELECT CEIL(19.3) FROM dual ;

SELECT FLOOR(19.3) FROM dual ;

--SYSDATE
SELECT SYSDATE FROM dual ;

--TO_CHAR, TO_NUMBER, TO_DATE
SELECT ename, hiredate, sal, TO_CHAR(sal)+1000 FROM emp ;

SELECT ename, 
       TO_CHAR(hiredate, 'yyyy-mm-dd') AS ��¥, 
       TO_CHAR(hiredate) AS ��¥2
FROM emp ;

SELECT '13'+1000, TO_NUMBER('13')+1000 FROM dual ; --���� �ȵ�

SELECT TO_DATE('2021-03-23') FROM dual ;
SELECT TO_DATE('03/23/21') FROM dual ; --���� �ȵ�
SELECT TO_DATE('03/23/21','mm/dd/yy') FROM dual ;

--NVL, NVL2
SELECT comm, 
       NVL(comm, '0') AS comm, 
       NVL2(comm,'1','0') AS comm2
FROM emp ;

--DECODE, CASE

SELECT DECODE(ename, 'SMITH', '���', 'JAMES', '����', '��Ÿ')
FROM emp ;

SELECT CASE WHEN ename = 'SMITH' THEN '���'
            WHEN ename = 'JAMES' THEN '����'
            ELSE '��Ÿ' END AS case  --END�ʼ� 
FROM emp ;

--������ �Լ�
SELECT SUM(sal) AS �հ� FROM emp ;
SELECT COUNT(*) FROM emp ;
SELECT MAX(sal) FROM emp ;
SELECT MIN(sal) FROM emp ;
SELECT ROUND(AVG(sal)) FROM emp ;

--������ �׷�ȭ (�÷��� 2�� �̻��� ���)
SELECT job, deptno, ROUND(AVG(sal)) AS ���, SUM(sal) AS �հ�
FROM emp
WHERE sal >2000
GROUP BY job, deptno --job���� ���� grouping ���� deptno�� grouping
ORDER BY job, deptno ASC ;

--GROUP BY ���� ������ �ִ� HAVING
SELECT job, deptno, 
       ROUND(AVG(sal)) AS ���, 
       SUM(sal) AS �հ�
FROM emp
WHERE sal >1000 -- WHERE ������ ������ �Լ��� �� �� ����.
GROUP BY job, deptno 
HAVING ROUND(AVG(sal)) >=1000
ORDER BY job, deptno ASC ;

--ROLLUP(�Ұ�)
SELECT NVL(TO_CHAR(deptno),'�Ѱ�'), NVL(job,'�Ұ�'), ROUND(AVG(sal),0), MAX(sal), SUM(sal), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno, job)
HAVING AVG(sal) >= 1000
ORDER BY deptno, job ;
