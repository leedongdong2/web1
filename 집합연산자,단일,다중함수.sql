
-----���̺� ����-----------------
DROP TABLE emp;
-------------------------------

-----------------------------------
-- ���տ����ڸ� �����ϱ� ���� ���̺� ����
-------------------------------------
CREATE TABLE emp AS SELECT * FROM EMPLOYEES e WHERE SALARY>8000;
SELECT * FROM emp;

---17) employees ���̺�� emp ���̺��� ������ union���� �����Ѵ�
SELECT employee_id,first_name,salary FROM employees
UNION 
SELECT employee_id,first_name,salary FROM emp;

---18) employees ���̺�� emp ���̺��� ������ �ߺ�����Ͽ� unionall���� �����Ѵ�
SELECT employee_id,first_name,salary FROM employees--�λ�����
UNION ALL
SELECT employee_id,first_name,salary FROM emp;--��������

---19) employees, emp ���̺��� �ߺ��Ǵ� �ڷḦ ��ȸ�Ͻÿ� (������)(intersect)
SELECT * FROM EMPLOYEES e 
INTERSECT
SELECT * FROM emp;

----20) employees, emp ���̺��� �������� ���� - ������(���ʱ������� �����ʰ� �ߺ��Ǵ°��� �A��)���϶�(minus)
SELECT * FROM EMPLOYEES 
MINUS
SELECT * FROM emp;

SELECT * FROM emp
MINUS
SELECT * FROM EMPLOYEES ;

---21) first_name�� ��� �빮�ڷ�, last_name�� ��� �ҹ��ڷ� ���
SELECT upper(first_name) AS ��,lower(last_name) AS �� FROM EMPLOYEES ;

---22)email �ּ��� ���̸� ����,�̸���,�̸��ϱ��̷� ���(length)
SELECT concat(first_name,last_name) AS ����,email,LENGTH(email) as �̸��ϱ��� FROM EMPLOYEES ;

---23)�μ��ڵ尡 100���� ������� �̸����� �̸���@korea.com ���·� ���(concat)
SELECT DEPARTMENT_ID AS �μ����̵�,concat(email,'@korea.com') AS �̸��� FROM EMPLOYEES WHERE DEPARTMENT_ID = 100;

---24) ���� th�� ���ԵǾ� �ִ� ������� �޿��� �޿���� �ڸ��� 10�ڸ��� �����ѵ� ������ ������ *�� ä�� ���(lpad)
SELECT concat(first_name,last_name) AS ����,lpad(salary,10,'*') AS �޿� FROM EMPLOYEES WHERE concat(first_name,last_name) LIKE '%th%';

--25) �̸��� �� ���ڸ��� '**'���� ��ȯ�Ͽ� ��ȸ�Ͻÿ�(replace,substr)
SELECT first_name,REPLACE(first_name,substr(first_name,1,4),'****') FROM EMPLOYEES ;

--26) ����ó�� ��4�ڸ��� ��� '****'���� �ٲپ� ����,�̸��ϰ� �Բ� ��ȸ
SELECT first_name AS ����,email AS �̸���,REPLACE (phone_number,SUBSTR(PHONE_NUMBER,-4,4),'****') AS ��ȣ FROM EMPLOYEES;

---27) ������� �޿�, ���ʽ�(�޿��� 300%),�Ѿ�(�޿�+���ʽ�)�� ����Ͻÿ�.(��,�Ѿ��� 100���� �̸��� �����Ͽ�)
SELECT first_name AS �̸�, salary AS �޿�,salary*3 AS ���ʽ�, CEIL (salary+salary*3) AS �Ѿ� FROM EMPLOYEES;
SELECT TRUNC(SYSDATE), first_name AS �̸�, salary AS �޿�,salary*3 AS ���ʽ�, CEIL((salary+salary*3)/100)*100 AS �Ѿ� FROM EMPLOYEES;


---28) ������� �޿�,����(�޿���10%),���޾�(�޿�-����)�� ����Ͻÿ�(��,�Ѿ��� �Ҽ������ϴ� �����Ͻÿ�)
SELECT first_name AS �̸�,salary AS �޿�,salary*0.1 AS ����, FLOOR(salary - (salary*0.1)) AS ���޾� FROM EMPLOYEES ;

---29) ������ ��ƿ� �������� ���
SELECT FLOOR( MONTHS_BETWEEN('2021/03/30','1997/02/14')) FROM dual; 

----30)--����� ǥ��
SELECT FIRST_NAME,hire_date,TO_CHAR(hire_date,'MM') AS �Ի�� FROM EMPLOYEES;

--30-1) 3���� �Ի��� ������ �̸�,�Ի����� ��ȸ
SELECT FIRST_NAME,hire_date,TO_CHAR(hire_date,'MM') AS �Ի�� FROM EMPLOYEES WHERE TO_char(hire_date,'MM')='03';

---31) 5���� �Ի��� ������ �̸�, �Ի���, �޿��� ����ϵ�, �޿����� õ���� ��ȣ�� ����Ͽ� ��ȸ
SELECT first_name,hire_date,to_char(salary,'99,999') AS �޿� FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'MM')='05';

---32) �Ի�⵵�� 2007�� 3�� ���Ŀ� �Ի��� ������ ����,�޿�,���ʽ�(�޿�*Ŀ�̼�) ����ϵ� Ŀ�̼��� ���� ������ ���ʽ��� 0���� ó���Ͻÿ�
SELECT first_name AS �̸�,salary AS �޿�,salary*nvl(commission_pct,0) AS ���ʽ�,HIRE_DATE AS �Ի�� FROM EMPLOYEES WHERE TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYYMMDD')) >= 20070400;
SELECT first_name AS �̸�,salary AS �޿�,salary*nvl(commission_pct,0) AS ���ʽ�,HIRE_DATE AS �Ի�� FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY-MM') > '2007-03';

----33) �μ����̵� 100�̸� �μ����̵� �����ʿ� '����μ�'�� �ٿ��� ������ �Բ� ����Ͻÿ�.
SELECT first_name AS �̸�,DECODE(department_id,100,department_id||'(����μ�)',DEPARTMENT_ID) AS �μ� FROM EMPLOYEES;
SELECT first_name AS �̸�,DEPARTMENT_ID||decode(DEPARTMENT_ID,100,'(����μ�)')AS �μ� FROM EMPLOYEES;

---34) �����,�޿�,���ʽ��� ����ϵ�,�μ��ڵ尡 100�̸� ���ʽ��� �޿��� 50% �ƴϸ� �޿��� 10%�� �����ϵ��� ��ȸ.
SELECT first_name AS �̸�,salary AS �޿�,decode(department_id,100,salary*0.5,salary*0.1) AS ���ʽ�,decode(department_id,100,'50%','10%') AS ���ʽ���ġ FROM EMPLOYEES;

---35) �����, �޿��� ����ϵ� �޿��� 15000�� �̻��̸� '(��׿�����)',5000�̸��ΰ���'(���ҵ���)'������ �Բ� ���
SELECT first_name AS �̸�,salary AS �޿�,CASE WHEN salary>=15000 THEN '(��׿�����)' WHEN salary<5000 then'(���ҵ���)' ELSE '(������)' END "�޿��������"  FROM EMPLOYEES;

----locations �� ����� Ǯ�����
--36) �����ȣ�� �����ڰ� ��� �ִ� ������ ��ȸ�Ͻÿ�.
SELECT * FROM LOCATIONS WHERE REGEXP_LIKE(POSTAL_CODE,'[a-zA-Z]'); 

---37) �����ȣ�� �����ڷ� �����ϴ� ������ ��ȸ�Ͻÿ�.
SELECT * FROM LOCATIONS WHERE REGEXP_LIKE(POSTAL_CODE,'^[a-zA-Z]'); 

--38) ���� ��ü �ο����� ��ȸ�Ͻÿ� null ���� ��ȸ x
SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES;

--39) 3���� �Ի��� �������� ��ȸ 
SELECT  COUNT(EMPLOYEE_ID) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'MM') = '03';

---40) �������� �޿��հ踦 ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEES;

----41) �������� ����հ踦 ��ȸ
SELECT  AVG(NVL(SALARY,0)) FROM EMPLOYEES;