--�ּ� �Ʒ��� select ������ ������
SELECT * FROM emp;

--�÷��� �����ؼ� select
SELECT ename, job, hiredate
FROM emp ;

--�μ��� ���
SELECT deptno
FROM emp ;

--�ߺ��� ���� ���� distinct
SELECT DISTINCT deptno
FROM emp ;

--2�� �̻��� �÷����� �ߺ��� ���� ���� distinct
SELECT DISTINCT empno, deptno
FROM emp ;

SELECT DISTINCT job, deptno
FROM emp ;

--WHERE ������ ����ϱ�
SELECT *
FROM emp
WHERE empno = 7499 ;

SELECT * FROM emp
WHERE ename = 'SMITH' ;

SELECT * FROM emp
WHERE job = 'CLERK' ;

SELECT * FROM emp
WHERE sal >= 1500 ;