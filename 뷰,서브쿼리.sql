--------------------------------------------
--VIEW 
--------------------------------------------

--86) ����, ����ó, �̸���, �Ŵ����̸�, �μ��ڵ� �μ����� ��ȸ�Ͻÿ�.
CREATE VIEW emp_view 
AS
SELECT E.FIRST_NAME ����,E.PHONE_NUMBER ����ó,E.EMAIL �̸���,M.FIRST_NAME �Ŵ����̸�,
       E.DEPARTMENT_ID �μ��ڵ�,D.DEPARTMENT_NAME �μ���
       FROM EMPLOYEES E JOIN EMPLOYEES M 
       ON E.MANAGER_ID = M.EMPLOYEE_ID 
       JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID ; 
       
SELECT * FROM emp_view;
SELECT * FROM emp_view WHERE ���� = 'Lisa';
SELECT * FROM emp_view WHERE �Ŵ����̸� = 'Nancy';

--- OR REPLACE �並 ������Ʈ ��ų�� �ִ� ������ ������ �߿��ϰ� ����ؾ���
--- �ٸ�������� Ȥ�� ���� ������ ������Ʈ ��ų�� �ֵ�
CREATE OR REPLACE VIEW emp_view 
AS
SELECT E.FIRST_NAME ����,E.PHONE_NUMBER ����ó,E.EMAIL �̸���,M.FIRST_NAME �Ŵ����̸�,
       E.DEPARTMENT_ID �μ��ڵ�,D.DEPARTMENT_NAME �μ���
       FROM EMPLOYEES E JOIN EMPLOYEES M 
       ON E.MANAGER_ID = M.EMPLOYEE_ID 
       JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID ;
       
SELECT * FROM EMP_VIEW ;

--------------------------------------------------------------------
--Sub Query
-----------------------------------------------------------------------
--87) �μ����� Sales �� �������� ���

--a)join
SELECT e.*,d.DEPARTMENT_NAME FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE d.DEPARTMENT_NAME = 'Sales';



--b) sub query
SELECT * FROM EMPLOYEES e --���̺���
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID --on �κ�
                       FROM DEPARTMENTS d   ---���̺� ���
                       WHERE d.DEPARTMENT_ID = 100); --��������
                       
--88) job_title�� programmer�� �������� �̸��� ����ó�� ��ȸ(employess,jobs)
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
                       

--89)CITY�� LONDON�� �μ��� �̸��� ��ȸ(DEPARTMENTS,LOCATIONS)

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
 
--90) department_name�� it�� �μ��� �����ȣ(departments,locations)

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

                      
                      
 --91) David�� �μ���(departments,employees)
                      
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
                        


                        
---92) Adam Fripp�� ������(job_title)��? (employees, jobs)

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



                      
 ---- join - select ����(��)�� ������� ����(��)�� ���̺�� �񱳽���
 ---- �� ��������� ���̺��� ������� �����ش�
                      
---������ ����
--93) �μ� ���̵� 30���� �μ� �������� �ּұ޿����� ���� �޿��� �޴� ������ �̸�,�޿� ��ȸ
SELECT e.FIRST_NAME,e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY <ALL (SELECT e2.SALARY 
                         FROM EMPLOYEES e2 
                         WHERE e2.DEPARTMENT_ID=30)
                         
                         

--94) 2007�⵵�� �Ի��� �������� �ִ� �޿����� �޿��� ���� �޴� �������� �̸�,�޿� ��ȸ
SELECT e.FIRST_NAME,e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY  >ALL (SELECT e2.SALARY 
                     FROM EMPLOYEES e2
                     WHERE TO_CHAR(e2.HIRE_DATE,'YYYY')='2007') ;
                      
               
                    
                    
 ----------- ������質 ���������� ���������� ���ϰ� �������� �����Ҷ��� ���� ���̺��� �������� �����;��ҋ��� ������ ���ѰŰ���
 
                      