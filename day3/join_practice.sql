--INNER JOIN ����

SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e 
 INNER JOIN dept d --�� ���̺��� ������
    ON e.deptno = d.deptno --����
 WHERE e.job = 'SALESMAN' ;
 
--PL/SQL INNER JOIN ����

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
 RIGHT OUTER JOIN dept d --left�� �������� left�� ���� ������ right���� ������
    ON e.deptno = d.deptno --key���� null�� ���´ٴ� �� = OUTER JOIN �� �� �ִ�
    
--PL/SQL LEFT OUTER JOIN ����

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
 
 --PL/SQL RIGHT OUTER JOIN ����

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
