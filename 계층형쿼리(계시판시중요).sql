---------------------------------------------------------------
---������ ����
---------------------------------------------------------------

SELECT LEVEL ,e.EMPLOYEE_ID,LPAD(' ',LEVEL*3,' ') ||e.FIRST_NAME,e.MANAGER_ID FROM EMPLOYEES e 
--������
START WITH manager_id IS NULL -- level1
-- ����  prior(����)
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
--���� order siblings by �������� ����
ORDER siblings BY manager_id ; 

---������ ������ ����¡ ó��      3������ ����Ʈ��      ((����)������ �����۾�(����,����) �� ������ ���� �� ����¡ó��)
-- 1������ 2������ �� ���� ǥ���ϰ� ���� ������ ��Ÿ����

SELECT  * FROM (
SELECT ROWNUM rn,a.*FROM 
(SELECT rownum,LEVEL,e.EMPLOYEE_ID,LPAD(' ',LEVEL*3,' ') ||e.FIRST_NAME,e.MANAGER_ID 
FROM EMPLOYEES e 
--������
START WITH manager_id IS NULL -- level1
-- ����  prior(����)
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
--���� order siblings by �������� ����
ORDER BY manager_id) a 
)WHERE rn BETWEEN 1 AND 10;