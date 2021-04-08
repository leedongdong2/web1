SELECT * FROM EMPLOYEES e;
SELECT FIRST_NAME FROM EMPLOYEES e;

--1) ��� ������ �̸��ϸ� ��ȸ
SELECT FIRST_NAME,EMAIL FROM EMPLOYEES e;

--2) ��� �μ��� �μ���� �Ŵ��� ���̵� ��ȸ
SELECT DEPARTMENT_NAME,MANAGER_ID FROM DEPARTMENTS d;

--3) �÷����� ��Ī ����ϱ� dual(����Ŭ���� �׽�Ʈ�� �������̺� �÷�1 �ο�1) 
SELECT 10 + 10 AS hap FROM dual;

--4) distinct(�ߺ����ֱ�) ������̺��� �μ��ڵ带 �ߺ����� ��ȸ(�÷����� ��ü�δ� 1���� ������ �ΰ� �̻����� ����쿡�� �ΰ��� ������ ����ũ�� ���� �ȴ� -�ΰ��� ���� �� ���ƾ� �ߺ�����-)
SELECT DISTINCT DEPARTMENT_ID, MANAGER_ID FROM EMPLOYEES e;

--5) ��� ���̺��� ������ �Ʒ��� ���� ����Ͻÿ�.
--   xxx ����� �μ��ڵ���  xxx�Դϴ�.
SELECT first_name||'����� �μ��ڵ��'||DEPARTMENT_ID||'�Դϴ�' AS "NAME AND DEPARTMENT_ID" FROM EMPLOYEES e; 

--6) �޿��� 10000�� �̻��� ������ �̸��� �޿��� ��ȸ
SELECT FIRST_NAME,SALARY FROM EMPLOYEES e WHERE SALARY >= 10000;

--7) �޿��� 10000�� �̻� �̰ų� 4000������ ������ �̸�,�޿�,�̸����� ��ȸ
SELECT FIRST_NAME,SALARY,EMAIL FROM EMPLOYEES e WHERE SALARY >=10000 OR SALARY <= 4000;

--8) �μ��ڵ尡 100�� �̰ų� �޿��� 10000�� �̻��� ������ �μ��ڵ�,�̸�,�޿� ��ȸ
SELECT DEPARTMENT_ID,FIRST_NAME,SALARY FROM EMPLOYEES e WHERE DEPARTMENT_ID = 100 OR SALARY >=10000;

--9) �޿��� 5000�̻��̰� 7000������ ������ ����,�޿��� ����Ͻÿ� BETWEEN �̿�
--salary >= 5000 and salary <=7000 
SELECT FIRST_NAME,SALARY FROM EMPLOYEES e WHERE SALARY BETWEEN 5000 AND 7000;

--10) �μ����̵� 80 �Ǵ� 90 �Ǵ� 100�� ������ �̸� �̸��� �μ��ڵ�
SELECT FIRST_NAME,EMAIL,DEPARTMENT_ID FROM EMPLOYEES e  WHERE DEPARTMENT_ID IN ('80','90','100');

---11) �̸��� S�� �����ϴ� ������ ���̵�, ������ ��ȸ(LIKE)
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES e 
WHERE FIRST_NAME LIKE 'S%';

--12) �̸��� s�� ���ԵǾ��ִ� ������ ���̵� ������ ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES e 
WHERE FIRST_NAME LIKE '%s%';

--13) commission_pct�� �ִ� ������ �̸��� commission_pet����ȸ
SELECT FIRST_NAME,COMMISSION_PCT FROM EMPLOYEES e WHERE COMMISSION_PCT  IS NULL;
SELECT FIRST_NAME,COMMISSION_PCT FROM EMPLOYEES e WHERE COMMISSION_PCT  IS NOT NULL;

---14) commission�� �ִ� �������� ����,�޿�,���ʽ�(�޿�*commission_pct) �� ��ȸ�Ͻÿ�
SELECT FIRST_NAME AS ���� ,SALARY AS �޿� ,SALARY*COMMISSION_PCT AS ���ʽ� FROM EMPLOYEES e WHERE COMMISSION_PCT  IS NOT NULL;
-- ��� ���� NULL�� NULL
SELECT FIRST_NAME AS ���� ,SALARY AS �޿� ,SALARY*COMMISSION_PCT AS ���ʽ� FROM EMPLOYEES e WHERE COMMISSION_PCT  IS NULL;

--15) �޿��� 10000�� �̻��� ������ �̸�,�޿��� �޿������� ��ȸ
SELECT FIRST_NAME||LAST_NAME AS ����,SALARY AS �޿� FROM EMPLOYEES e WHERE SALARY>=10000 ORDER BY SALARY;

--16) 15�� �������� ������ ��쿡�� �̸������� ������ �غ���
SELECT FIRST_NAME||LAST_NAME AS ����,SALARY AS �޿� FROM EMPLOYEES e WHERE SALARY>=10000 ORDER BY SALARY,FIRST_NAME;