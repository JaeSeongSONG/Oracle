--문자열 함수

--대문자, 소문자
SELECT UPPER(ename), UPPER(job)
FROM emp 
WHERE job = UPPER('analyst') ;

SELECT UPPER('analyst') FROM dual ;
--테이블의 데이터가 아닌 것을 가져와서 보고 싶을 때 dual을 사용
SELECT LOWER(ename) AS ename, 
       LOWER(job) AS job 
FROM emp
WHERE comm IS NOT NULL  ;

--INITCAP(앞글자만 대문자로)
SELECT INITCAP(ename) AS ename, 
       INITCAP(job) AS job 
FROM emp
WHERE comm IS NOT NULL  ;

--LENGTH 길이, LENGTHB 바이트 길이
SELECT ename, LENGTH(ename) AS 글자수, LENGTHB(ename) AS 바이트수
FROM emp 
ORDER BY LENGTH(ename) ASC ;

--SUBSTR(sub string)
SELECT SUBSTR('안녕하세요, 한가람IT전문학원 빅데이터반입니다.',8,9) AS phase
FROM dual ;

--REPLACE
SELECT REPLACE('안녕하세요, 한가람IT전문학원 빅데이터반입니다.','안녕하세요','싫어요') AS phase
FROM dual ;

--INSTR
SELECT INSTR('안녕하세요, 한가람IT전문학원 빅데이터반입니다.','한가람',3,1) AS phase
FROM dual ;

--LPAD,RPAD(컬럼, 문자길이 지정, 남은 공간 채울 문자)
SELECT LPAD(ename, 10, '*')
FROM emp;

--CONCAT
SELECT CONCAT('A', 'B')
FROM dual ;

SELECT 'A' || 'B'
FROM dual ;

--TRIM(반복적인 문자나, 특정 문자열, 글자 사이의 여백은 안됨)
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
       TO_CHAR(hiredate, 'yyyy-mm-dd') AS 날짜, 
       TO_CHAR(hiredate) AS 날짜2
FROM emp ;

SELECT '13'+1000, TO_NUMBER('13')+1000 FROM dual ; --실행 안됨

SELECT TO_DATE('2021-03-23') FROM dual ;
SELECT TO_DATE('03/23/21') FROM dual ; --실행 안됨
SELECT TO_DATE('03/23/21','mm/dd/yy') FROM dual ;

--NVL, NVL2
SELECT comm, 
       NVL(comm, '0') AS comm, 
       NVL2(comm,'1','0') AS comm2
FROM emp ;

--DECODE, CASE

SELECT DECODE(ename, 'SMITH', '사원', 'JAMES', '사장', '기타')
FROM emp ;

SELECT CASE WHEN ename = 'SMITH' THEN '사원'
            WHEN ename = 'JAMES' THEN '사장'
            ELSE '기타' END AS case  --END필수 
FROM emp ;

--다중행 함수
SELECT SUM(sal) AS 합계 FROM emp ;
SELECT COUNT(*) FROM emp ;
SELECT MAX(sal) FROM emp ;
SELECT MIN(sal) FROM emp ;
SELECT ROUND(AVG(sal)) FROM emp ;

--데이터 그룹화 (컬럼이 2개 이상일 경우)
SELECT job, deptno, ROUND(AVG(sal)) AS 평균, SUM(sal) AS 합계
FROM emp
WHERE sal >2000
GROUP BY job, deptno --job으로 먼저 grouping 이후 deptno로 grouping
ORDER BY job, deptno ASC ;

--GROUP BY 절에 조건을 주는 HAVING
SELECT job, deptno, 
       ROUND(AVG(sal)) AS 평균, 
       SUM(sal) AS 합계
FROM emp
WHERE sal >1000 -- WHERE 절에는 다중행 함수를 쓸 수 없다.
GROUP BY job, deptno 
HAVING ROUND(AVG(sal)) >=1000
ORDER BY job, deptno ASC ;

--ROLLUP(소계)
SELECT NVL(TO_CHAR(deptno),'총계'), NVL(job,'소계'), ROUND(AVG(sal),0), MAX(sal), SUM(sal), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno, job)
HAVING AVG(sal) >= 1000
ORDER BY deptno, job ;
