--------------------------------------------
--VIEW 
--------------------------------------------

--86) 성명, 연락처, 이메일, 매니져이름, 부서코드 부서명을 조회하시오.
CREATE VIEW emp_view 
AS
SELECT E.FIRST_NAME 성명,E.PHONE_NUMBER 연락처,E.EMAIL 이메일,M.FIRST_NAME 매니저이름,
       E.DEPARTMENT_ID 부서코드,D.DEPARTMENT_NAME 부서명
       FROM EMPLOYEES E JOIN EMPLOYEES M 
       ON E.MANAGER_ID = M.EMPLOYEE_ID 
       JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID ; 
       
SELECT * FROM emp_view;
SELECT * FROM emp_view WHERE 성명 = 'Lisa';
SELECT * FROM emp_view WHERE 매니저이름 = 'Nancy';

--- OR REPLACE 뷰를 업데이트 시킬수 있다 하지만 굉장히 중요하게 사용해야함
--- 다른사람꺼를 혹시 내가 강제로 업데이트 시킬수 있따
CREATE OR REPLACE VIEW emp_view 
AS
SELECT E.FIRST_NAME 성명,E.PHONE_NUMBER 연락처,E.EMAIL 이메일,M.FIRST_NAME 매니저이름,
       E.DEPARTMENT_ID 부서코드,D.DEPARTMENT_NAME 부서명
       FROM EMPLOYEES E JOIN EMPLOYEES M 
       ON E.MANAGER_ID = M.EMPLOYEE_ID 
       JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID ;
       
SELECT * FROM EMP_VIEW ;

--------------------------------------------------------------------
--Sub Query
-----------------------------------------------------------------------
--87) 부서명이 Sales 인 직원들의 명단

--a)join
SELECT e.*,d.DEPARTMENT_NAME FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE d.DEPARTMENT_NAME = 'Sales';



--b) sub query
SELECT * FROM EMPLOYEES e --테이블명시
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID --on 부분
                       FROM DEPARTMENTS d   ---테이블 명시
                       WHERE d.DEPARTMENT_ID = 100); --정식조건
                       
--88) job_title이 programmer인 직원들의 이름과 연락처를 조회(employess,jobs)
SELECT * FROM JOBS;
SELECT * FROM EMPLOYEES  ;

--a)join
SELECT e.first_name,e.phone_number 
FROM EMPLOYEES e JOIN JOBS j 
ON e.JOB_ID = j.JOB_ID 
WHERE JOB_TITLE = 'Programmer';
                       
                       
--b)sub query

SELECT e.first_name,e.phone_number
FROM EMPLOYEES e
WHERE e.JOB_ID IN (SELECT j.JOB_ID 
                  FROM JOBS j
                  WHERE JOB_TITLE = 'Programmer');
                       

--89)CITY가 LONDON인 부서의 이름을 조회(DEPARTMENTS,LOCATIONS)

--a)
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT d.department_name
FROM DEPARTMENTS d join LOCATIONS l
ON d.LOCATION_ID IN l.LOCATION_ID 
WHERE l.CITY = 'London';



--b)
SELECT d.department_name
FROM DEPARTMENTS d
WHERE d.LOCATION_ID IN (SELECT l.LOCATION_ID
                       FROM LOCATIONS l
                       WHERE L.CITY = 'London');
 
--90) department_name이 it인 부서의 우편번호(departments,locations)

---a) 
SELECT l.POSTAL_CODE
FROM LOCATIONS l JOIN DEPARTMENTS d 
ON l.LOCATION_ID = d.LOCATION_ID 
WHERE d.DEPARTMENT_NAME = 'IT';



--b)
SELECT l.POSTAL_CODE
FROM LOCATIONS l 
WHERE l.LOCATION_ID IN (SELECT d.LOCATION_ID
                       FROM DEPARTMENTS d
                       WHERE d.DEPARTMENT_NAME = 'IT');

                      
                      
 --91) David의 부서명(departments,employees)
                      
 --a)
 SELECT * FROM EMPLOYEES e WHERE e.FIRST_NAME  = 'David';
                      
                      
 SELECT d.DEPARTMENT_NAME, e.FIRST_NAME || e.LAST_NAME 
 FROM DEPARTMENTS d JOIN EMPLOYEES e 
 ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
 WHERE e.FIRST_NAME = 'David';
               
                      
--b) 
SELECT d.DEPARTMENT_NAME 
FROM DEPARTMENTS d 
WHERE d.DEPARTMENT_ID IN (SELECT e.DEPARTMENT_ID 
                         FROM EMPLOYEES e
                         WHERE e.FIRST_NAME = 'David');
                        


                        
---92) Adam Fripp의 직무명(job_title)은? (employees, jobs)

--a)
SELECT j.JOB_TITLE 
FROM EMPLOYEES e JOIN JOBS j 
ON e.JOB_ID = j.JOB_ID 
WHERE e.FIRST_NAME = 'Adam' AND e.LAST_NAME = 'Fripp';
                        
                      
--b)
SELECT j.JOB_TITLE 
FROM JOBS j
WHERE j.JOB_ID IN (SELECT e.JOB_ID 
                  FROM EMPLOYEES e
                  WHERE e.FIRST_NAME = 'Adam' AND e.LAST_NAME = 'Fripp');



                      
 ---- join - select 우측(밑)의 결과값을 좌측(위)의 테이블과 비교시켜
 ---- 그 결과값으로 테이블을 연결시켜 보여준다
                      
---다중행 쿼리
--93) 부서 아이디가 30번인 부서 직원들의 최소급여보다 작은 급여를 받는 직원의 이름,급여 조회
SELECT e.FIRST_NAME,e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY <ALL (SELECT e2.SALARY 
                         FROM EMPLOYEES e2 
                         WHERE e2.DEPARTMENT_ID=30)
                         
                         

--94) 2007년도에 입사한 직원들의 최대 급여보다 급여를 많이 받는 직원들의 이름,급여 조회
SELECT e.FIRST_NAME,e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY  >ALL (SELECT e2.SALARY 
                     FROM EMPLOYEES e2
                     WHERE TO_CHAR(e2.HIRE_DATE,'YYYY')='2007') ;
                      
               
                    
                    
 ----------- 연산관계나 셀프조인은 서브쿼리가 편하고 다중으로 연결할때나 여러 테이블에서 여러값을 가져와야할떄는 조인이 편한거같다
 
                      