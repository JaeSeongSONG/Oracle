--주석 아래의 select 구문을 실행함
SELECT * FROM emp;

--컬럼을 구분해서 select
SELECT ename, job, hiredate
FROM emp ;

--부서명만 출력
SELECT deptno
FROM emp ;

--중복된 값을 제거 distinct
SELECT DISTINCT deptno
FROM emp ;

--2개 이상의 컬럼에서 중복된 값을 제거 distinct
SELECT DISTINCT empno, deptno
FROM emp ;

SELECT DISTINCT job, deptno
FROM emp ;

--WHERE 조건절 사용하기
SELECT *
FROM emp
WHERE empno = 7499 ;

SELECT * FROM emp
WHERE ename = 'SMITH' ;

SELECT * FROM emp
WHERE job = 'CLERK' ;

SELECT * FROM emp
WHERE sal >= 1500 ;