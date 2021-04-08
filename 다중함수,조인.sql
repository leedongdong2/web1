---42) �μ��ڵ尡 80���̰ų� �Ի���� 04���� �������� ��� �޿���?
SELECT CEIL(avg(NVL(salary,0))) AS ��ձ޿� FROM EMPLOYEES WHERE DEPARTMENT_ID = 80 OR TO_CHAR(HIRE_DATE,'MM') = '04';


-----------------------GROUP BY----------------------------
--�׷������ ���� ���ǻ���
--1) SELECT������ GROUP BY���� ����� �÷��� ��밡�� (��Ī���Ұ���)
--2) ���� GROUP BY������ ����� �÷����� �ƴ� ��쿣 �ݵ�� �����ռ������� ����ؾ���


--43) �μ��� �ο����� ���?
SELECT COUNT(EMPLOYEE_ID),DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID ;

---44) �Ի�⵵�� �ο����� ���?
SELECT COUNT(EMPLOYEE_ID) AS �ο���,TO_CHAR(HIRE_DATE,'RRRR') AS �Ի�⵵ FROM EMPLOYEES GROUP BY TO_CHAR(HIRE_DATE,'RRRR');

---45) �μ��� �޿��հ踦 ����Ͻÿ�!
SELECT DEPARTMENT_ID,SUM(NVL(SALARY,0)) AS �޿��հ� FROM EMPLOYEES GROUP BY DEPARTMENT_ID ;

SELECT * FROM DEPARTMENTS WHERE DEPARTMENT_ID =10 OR DEPARTMENT_ID =80;

---46) ������ �ο����� ��� �޿��� ����Ͻÿ�
SELECT  JOB_ID AS ����,COUNT(EMPLOYEE_ID) AS �ο��� ,AVG(NVL(SALARY,0)) AS ��ձ޿� FROM EMPLOYEES GROUP BY JOB_ID ;

---47) �μ��ڵ尡 80���� ������ �� ������ �ο����� ?
SELECT JOB_ID,COUNT(JOB_ID) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80 GROUP BY JOB_ID;

--48) ������ �ο��� ��ȸ
SELECT JOB_ID,COUNT(JOB_ID) FROM EMPLOYEES GROUP BY JOB_ID ;

--49) ������ �ο����� �ο��� 5�� ���� ū ������ ��ȸ
SELECT JOB_ID,COUNT(JOB_ID) CNT FROM EMPLOYEES GROUP BY JOB_ID HAVING COUNT(JOB_ID)>5;  

---50) �μ���,������ �ο��� ��ȸ GROUPING SET
SELECT DEPARTMENT_ID,COUNT(EMPLOYEE_ID) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT JOB_ID,COUNT(EMPLOYEE_ID) FROM EMPLOYEES GROUP BY JOB_ID;

SELECT DEPARTMENT_ID,JOB_ID,COUNT(EMPLOYEE_ID) FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID,JOB_ID
ORDER BY DEPARTMENT_ID ;

SELECT DEPARTMENT_ID,JOB_ID,COUNT(EMPLOYEE_ID) FROM EMPLOYEES 
GROUP BY GROUPING SETS(DEPARTMENT_ID,JOB_ID)
ORDER BY DEPARTMENT_ID ;


-----------------
---JOIN
------------------

---51) LEX�� �μ�����?
SELECT * FROM EMPLOYEES e  WHERE FIRST_NAME ='Lex';
SELECT * FROM DEPARTMENTS d  WHERE DEPARTMENT_ID = 90;

--- oracle join
SELECT DEPARTMENT_NAME FROM EMPLOYEES e,DEPARTMENTS d WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID AND e.FIRST_NAME ='Lex';

---- ansi join
SELECT DEPARTMENT_NAME FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE first_name = 'Lex';

---52) ����� 112�� ������ �̸�,�޿�,�μ��ڵ�,�μ����� ��ȸ�Ͻÿ�
SELECT FIRST_NAME,SALARY,DEPARTMENT_NAME,e.DEPARTMENT_ID FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE EMPLOYEE_ID = 112;

---oracle-----
SELECT FIRST_NAME,SALARY,DEPARTMENT_NAME,e.DEPARTMENT_ID FROM EMPLOYEES e,DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID AND EMPLOYEE_ID = 112;


--53) �μ����� IT�� �������� �̸�, �̸��� �μ��ڵ带 ��ȸ
SELECT FIRST_NAME,EMAIL,e.DEPARTMENT_ID FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE DEPARTMENT_NAME = 'IT';

---oracle-----
SELECT FIRST_NAME,EMAIL,e.DEPARTMENT_ID FROM EMPLOYEES e,DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND DEPARTMENT_NAME = 'IT';


--54) �μ����� SALES�� �μ��� �޿��հ踦 ��ȸ
SELECT DEPARTMENT_NAME �μ��� ,SUM(SALARY) �հ� FROM EMPLOYEES e  JOIN DEPARTMENTS d 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
GROUP BY DEPARTMENT_NAME
HAVING DEPARTMENT_NAME = 'Sales';

---oracle-----
SELECT DEPARTMENT_NAME �μ��� ,SUM(SALARY) �հ� FROM EMPLOYEES e,DEPARTMENTS d 
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
GROUP BY DEPARTMENT_NAME
HAVING DEPARTMENT_NAME = 'Sales';


--55) �μ����� FINANCE�� �μ��� �Ŵ��� �̸���?
SELECT d.DEPARTMENT_NAME,first_name,d.MANAGER_ID FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE DEPARTMENT_NAME = 'Finance' AND e.EMPLOYEE_ID = d.MANAGER_ID ;

---oracle-----
SELECT first_name,d.MANAGER_ID FROM EMPLOYEES e, DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND DEPARTMENT_NAME = 'Finance' AND e.EMPLOYEE_ID = d.MANAGER_ID ;

SELECT d.department_name �μ���, first_name �̸� FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.EMPLOYEE_ID = d.MANAGER_ID 
WHERE d.DEPARTMENT_NAME = 'Finance';

------ ���� ���ǿ� �°� ����Ǿ�  ���̺��� �����ȴ�
SELECT * FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.EMPLOYEE_ID = d.MANAGER_ID 
----- �� �⺻Ű �ܷ�Ű�� �������� �ʾƵ� �̾����� ������� ������ ���� �� �ִ�. �� �� Ȯ���ϰ� ��Ȯ�� ����� �մ°��� ����


--- outer join,eqiv join ����

---- eqiv����(�������ǿ� ���������� ���� �ʴ´�) �μ��� ���� ������ ī���õ����ʴ´� ��ȸ�������ʴ´�
SELECT count(*) FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

---outer join(�������ǿ� �����ʾƵ� ī���õǰ� ����Ѵ�) �� �������̺� ����̵ǰ� ������ ���̺��� ���� ���� ��ȸ�ȴ�. 
SELECT count(*) FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID  = d.DEPARTMENT_ID; 

---56) departments ���̺��� �������� �μ��ڵ�,�μ���,�����̸��� ��ȸ.

---56.1) join
SELECT d.DEPARTMENT_ID,d.DEPARTMENT_NAME,e.FIRST_NAME 
FROM DEPARTMENTS d JOIN EMPLOYEES e 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID ;

----56.2) LEFT OUTER JOIN

SELECT d.DEPARTMENT_ID,d.DEPARTMENT_NAME,e.FIRST_NAME 
FROM DEPARTMENTS d LEFT OUTER JOIN EMPLOYEES e 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID ;

------------------
--SELF JOIN
------------------
SELECT employee_id,manager_id FROM  EMPLOYEES e ;

---57)sigal ����� �Ŵ��� �̸���?
SELECT manager_id FROM EMPLOYEES e WHERE FIRST_NAME = 'Sigal';
SELECT first_name FROM EMPLOYEES e WHERE EMPLOYEE_ID = 114;

SELECT m.first_name FROM EMPLOYEES e JOIN EMPLOYEES m 
ON e.MANAGER_ID = m.EMPLOYEE_ID
WHERE e.FIRST_NAME = 'Sigal';

--58) �Ŵ��� �̸��� John Russell�� �����ϴ� �������� ���, �̸�, �޿�
SELECT m.employee_id FROM EMPLOYEES m WHERE m.FIRST_NAME = 'John' AND m.LAST_NAME ='Russell';
SELECT e.employee_id,e.first_name,e.salary,e.MANAGER_ID FROM EMPLOYEES e WHERE e.MANAGER_ID  =145;

SELECT *
FROM EMPLOYEES e JOIN EMPLOYEES m 
ON e.MANAGER_ID = m.EMPLOYEE_ID 


SELECT e.employee_id,e.first_name,e.salary,e.manager_id 
FROM EMPLOYEES e JOIN EMPLOYEES m 
ON e.MANAGER_ID = m.EMPLOYEE_ID 
WHERE m.first_name = 'John' AND m.LAST_NAME ='Russell';



SELECT e.EMPLOYEE_ID,e.FIRST_NAME,e.SALARY,e.MANAGER_ID 
FROM EMPLOYEES e JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID 
WHERE m.FIRST_NAME||m.LAST_NAME = 'John'||'Russell';


--59) Luis�� �����ؿ� �Ի��� �������� �̸��� �̸����� ��ȸ
SELECT e.first_name,e.email,TO_CHAR(e.HIRE_DATE,'yyyy') 
FROM EMPLOYEES e JOIN EMPLOYEES m  
ON TO_CHAR(e.HIRE_DATE,'YYYY') = TO_CHAR(m.HIRE_DATE,'YYYY')
WHERE m.FIRST_NAME = 'Luis';



--60) Daivd Austin�� ���� �μ� ������� �̸�, ����ó�� ��ȸ

SELECT m.FIRST_NAME ,m.PHONE_NUMBER,m.DEPARTMENT_ID 
FROM EMPLOYEES m JOIN EMPLOYEES e 
ON m.DEPARTMENT_ID = e.DEPARTMENT_ID 
WHERE e.FIRST_NAME = 'David' AND e.LAST_NAME = 'Austin';







