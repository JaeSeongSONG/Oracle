--������� ��ȸ�ϴ� select ��
SELECT * FROM emp
WHERE sal = 5000 ;

SELECT * FROM emp
WHERE job = 'CLERK' ;

--OR, AND ������ ISNULL ����
SELECT * FROM emp 
WHERE comm IS NULL 
OR comm = 0 ;

SELECT * FROM emp 
WHERE comm IS NULL 
AND comm = 0 ;

SELECT * FROM emp
WHERE comm IS NULL
AND job = 'ANALYST'  ;

--Projection
SELECT empno, ename, deptno
FROM emp
WHERE sal > 2450 ;

--JOIN & Alias      
SELECT e.ename, e.deptno, d.deptno FROM emp e
JOIN dept d
ON e.deptno = d.deptno ;   

SELECT DISTINCT job FROM emp 
JOIN dept
ON emp.deptno = dept.deptno ;

--Alias �����, ORDER BY ����
SELECT empno, ename, sal, sal*12+NVL(comm,0) AS ANNSEL
FROM emp 
JOIN dept
ON emp.deptno = dept.deptno 
ORDER BY sal DESC ;

--NOT, IN ����
SELECT empno, ename, sal, sal*12+NVL(comm,0) AS ANNSEL
FROM emp 
WHERE NOT sal = 1000 ;

SELECT empno, ename, sal, deptno
FROM emp 
WHERE deptno IN (10,20) 
ORDER BY deptno ASC ;

--BETWEEN A AND B ����
SELECT * FROM emp
WHERE sal BETWEEN 1000 AND 3000 
ORDER BY sal ASC ;

--LIKE ����
SELECT * FROM emp
WHERE sal BETWEEN 0 AND 5000 
AND ename = 'SMITH' ; 

SELECT * FROM emp
WHERE sal BETWEEN 0 AND 5000 
AND ename LIKE 'S%' ; 

SELECT * FROM emp
WHERE sal BETWEEN 0 AND 5000 
AND ename LIKE 'S____' ; 

--NULL
SELECT * FROM emp
WHERE comm IS NULL ;

--����: �� �÷����� ������ �¾ƾ� �ϰ�, ������ �¾ƾ� ��.
SELECT empno, ename, job FROM emp 
UNION
SELECT deptno, dname, loc FROM dept ;

SELECT empno, ename, job FROM emp 
UNION ALL --�ߺ�����
SELECT deptno, dname, loc FROM dept ;
--����
SELECT empno, ename, job FROM emp 
WHERE comm IS NOT NULL
UNION
SELECT deptno, dname, loc FROM dept ;

--MINUS, INTERSECT
SELECT deptno FROM emp 
MINUS
SELECT deptno FROM dept ;

SELECT deptno FROM emp 
INTERSECT
SELECT deptno FROM dept ;