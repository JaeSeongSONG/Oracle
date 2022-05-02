--INNER JOIN 구문

SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e 
 INNER JOIN dept d --두 테이블의 교집합
    ON e.deptno = d.deptno --조건
 WHERE e.job = 'SALESMAN' ;
 
--PL/SQL INNER JOIN 구문

SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e, dept d 
 WHERE 1 = 1 --TIP 
   AND e.deptno = d.deptno 
   AND e.job = 'SALESMAN' ;
 
--OUTER JOIN
  
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.deptno
     , d.dname
     , d.loc
  FROM emp e 
 RIGHT OUTER JOIN dept d --left를 기준으로 left의 없는 값까지 right에서 가져옴
    ON e.deptno = d.deptno --key값이 null이 나온다는 것 = OUTER JOIN 이 들어가 있다
    
--PL/SQL LEFT OUTER JOIN 구문

SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.deptno
     , d.dname
     , d.loc
  FROM emp e , dept d
 WHERE e.deptno = d.deptno(+) ;
 
 --PL/SQL RIGHT OUTER JOIN 구문

SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.deptno
     , d.dname
     , d.loc
  FROM emp e , dept d
 WHERE e.deptno(+) = d.deptno ;
 
--3 table join

SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.deptno
     , d.dname
     , d.loc
     , b.comm
  FROM emp e , dept d, bonus b
 WHERE 1 = 1
   AND e.deptno(+) = d.deptno 
   AND e.ename  = b.ename(+) ;
