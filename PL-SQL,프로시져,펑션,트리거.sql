--------------------------------------------------
-----pl-sql
---------------------------------------------------
------��Į�� ���� db������ �⺻ ���� 
---�⺻���
-- ���Կ����� - :=

--1) ����� 100�� ������ �̸��� ����ó�� ���

DECLARE
vname varchar2(50);
vphone varchar2(50);

BEGIN 
	   SELECT FIRST_NAME, phone_number 
	   --����Ʈ�� ����� ���並 ���� ��Ŭ���� ������ ����
	   INTO vname,vphone 
	   FROM EMPLOYEES e
	   WHERE EMPLOYEE_ID = 100;
	  
	   dbms_output.put_line(vname);
	   dbms_output.put_line(vphone);
END;

--2) �μ��ڵ尡 108���� �������� �޿� �հ�� ����� ���

DECLARE
h NUMBER(10);
p NUMBER(7,2);
BEGIN
	SELECT sum(salary), avg(salary)
	INTO h,p
	FROM EMPLOYEES e2 
	WHERE DEPARTMENT_ID =80;

    dbms_output.put_line('�հ�'||h);
    dbms_output.put_line('���'||p);
END;

--3) Oliver�� �μ����� ���
DECLARE 
dname varchar2(40);

BEGIN
SELECT d.DEPARTMENT_NAME
INTO dname
FROM DEPARTMENTS d
WHERE d.DEPARTMENT_ID IN (SELECT e.DEPARTMENT_ID 
                         FROM EMPLOYEES e
                         WHERE e.FIRST_NAME='Oliver');

	dbms_output.put_line('Oliver �μ��� :'||dname);
	
END;

DECLARE 
dname varchar2(40);

BEGIN
SELECT d.DEPARTMENT_NAME 
INTO dname
FROM DEPARTMENTS d JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
WHERE e.FIRST_NAME = 'Oliver';

	dbms_output.put_line('Oliver �μ��� :'||dname);
	
END;





--4)tayler�� ������

DECLARE
jname varchar2(50);
BEGIN
	
SELECT j.JOB_TITLE 
INTO jname
FROM JOBS j 
WHERE j.JOB_ID IN (SELECT e.JOB_ID 
                  FROM EMPLOYEES e
                  WHERE e.FIRST_NAME='Tayler');
                 
          dbms_output.put_line('Tayler ������ : jname');
END;

DECLARE
jname varchar2(50);

BEGIN
	SELECT j.JOB_TITLE 
	INTO jname
	FROM JOBS j JOIN EMPLOYEES e
	ON j.JOB_ID = e.JOB_ID
	WHERE e.FIRST_NAME ='Tayler';

 dbms_output.put_line('Tayler ������ : jname');
END;


/*
PL-SQL
������ ���� ���
1) ��Į���� : ����Ŭ�� �⺻ ������ ����(vachar,number,char....)
2) %TYPE : �ϳ��� �÷� ������ ������./���ϴ� ���̺��� �÷� Ÿ���� �״�� �����´�
3) %ROWTYPE : �� ��ü�� ������ ������.
4) RECORD : %ROWTYPE�� �����ϳ� ������ ��Ҹ� ���Ƿ� �߰�, ������ �� ����
5) TABLE : �ϳ��� �迭�� �����ϴ�
*/

--5) ����� 117�� ������ �̸���, �޿�, ����ó�� ��ȸ�Ͻÿ�.
--   (��, ������ ������ %TYPE �� ����Ұ�
DECLARE 
--���÷��� ���̺��� �۽�Ʈ������ Ÿ���� �����Ͷ�!
-- ������ Ÿ���� Ȯ��ġ ������ ���̺��� Ÿ���� �״�� �����´�
ENAME EMPLOYEES.FIRST_NAME%TYPE;
SAL EMPLOYEES.SALARY%TYPE;
PHONE EMPLOYEES.PHONE_NUMBER%TYPE;
BEGIN 
SELECT FIRST_NAME ,SALARY ,PHONE_NUMBER 
INTO ENAME,SAL,PHONE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 117;

dbms_output.put_line(ENAME);
dbms_output.put_line(SAL);
dbms_output.put_line(PHONE);

END;

--6) Marketing �μ��� �����ȣ(postal_code)�� ������ �ּ�(street_address) ���
---- (��, ������ ������ %type���)
DECLARE
pcode LOCATIONS.POSTAL_CODE%TYPE;
streetadd LOCATIONS.STREET_ADDRESS%TYPE;

BEGIN
	SELECT L.POSTAL_CODE,L.STREET_ADDRESS 
	INTO PCODE,STREETADD 
	FROM LOCATIONS l 
	WHERE L.LOCATION_ID = (SELECT d.LOCATION_ID 
	                       FROM DEPARTMENTS d
	                       WHERE D.DEPARTMENT_NAME = 'Marketing');
	
	                      dbms_output.put_line('�����ȣ:'pcode);
	                     dbms_output.put_line('�����ȣ:'streetadd);
	
END;

DECLARE
pcode LOCATIONS.POSTAL_CODE%TYPE;
streetadd LOCATIONS.STREET_ADDRESS%TYPE;

BEGIN
	SELECT l.POSTAL_CODE,l.STREET_ADDRESS 
	INTO pcode,streetadd
	FROM LOCATIONS l JOIN DEPARTMENTS d
	ON l.LOCATION_ID = d.LOCATION_ID 
	WHERE d.DEPARTMENT_NAME = 'Marketing';
	
	     dbms_output.put_line('�����ȣ:'pcode);
	     dbms_output.put_line('�����ּ�:'streetadd);
	
END;


--7) Adam�� �μ��ڵ�,�μ��̸�,�Ŵ������̵�,�����̼� ���̵� ��ȸ�Ͻÿ�
-- �� ������ ������ %rowtype ���
DECLARE
--- ���̺��� ������ �ִ� ���� �״���� Ÿ���� �����´�
--- ��Ҹ� �߰��ϰų� �E���� ����
  dept departments%rowtype;
BEGIN
  SELECT d.*
  INTO   dept
  FROM DEPARTMENTS d JOIN EMPLOYEES e 
  ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
  WHERE e.FIRST_NAME = 'Adam';

dbms_output.put_line('id : '||dept.department_id);
dbms_output.put_line('name : '||dept.department_name);
dbms_output.put_line('m id : '||dept.manager_id);
dbms_output.put_line('location : '||dept.location_id);
END;

--8) �μ��ڵ尡 60���� �μ��� �μ���, �Ŵ�����,�����ȣ�� ��ȸ

DECLARE 
--- manager_record��� �̸�����  ���ڵ�Ÿ���� ���� (vachar,number���� Ÿ����) 
TYPE manager_record IS RECORD
(dname departments.department_name%TYPE,
 mname employees.first_name%TYPE,
 pcode locations.postal_code%TYPE
);
-- Ÿ���� �ٷ� ���� ������ ������ ����������Ѵ�
manager manager_record;

BEGIN 
SELECT  d.DEPARTMENT_NAME ,e.FIRST_NAME ,l.POSTAL_CODE 
INTO manager
FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.EMPLOYEE_ID = d.MANAGER_ID 
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID 
WHERE d.DEPARTMENT_ID = 60;

dbms_output.put_line('�μ��� : '||manager.dname);
dbms_output.put_line('�Ŵ����̸� : '||manager.mname);
dbms_output.put_line('�����ȣ : '||manager.pcode);
	
END;



SELECT  d.DEPARTMENT_NAME ,e.FIRST_NAME ,l.POSTAL_CODE 
FROM DEPARTMENTS d JOIN EMPLOYEES e
ON d.MANAGER_ID = e.EMPLOYEE_ID 
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID 
WHERE d.DEPARTMENT_ID = 60;

-----------------------------------------------------------
---if��
-----------------------------------------------------------

--9) Allan�� �޿��հ�(�޿�+�޿�*��������) �� 15,000�̻��̸� ��׿����� �ƴϸ� ��տ����ڶ�
--���ڿ��� �޿��հ�� �Բ� ����Ͻÿ�
DECLARE
 str varchar2(30);
 hap NUMBER;
BEGIN
SELECT e.SALARY+(e.SALARY*e.COMMISSION_PCT) 
INTO hap
FROM EMPLOYEES e
WHERE e.FIRST_NAME = 'Allan';
IF(hap>=15000)
THEN
str := '��׿�����';
ELSE 
str := '��տ�����';
END IF;
dbms_output.put_line('hap:'||hap||':'||str);
END;

---10) Burce�� �μ��ڵ尡 60 ���̸� 'it�μ�',80���̸� '�����μ�',100���̸� 'ȸ��μ�',�׿ܴ� ��Ÿ�� ����Ͻÿ�
---case��
DECLARE
dcode departments.department_id%TYPE;
dname varchar2(20);


BEGIN

SELECT e.DEPARTMENT_ID 
INTO dcode
FROM EMPLOYEES e 
WHERE e.FIRST_NAME ='Bruce';
	
dname := CASE dcode
WHEN 60 THEN 'it�μ�'
WHEN 80 THEN '�����μ�'
WHEN 100 THEN 'ȸ��μ�'
ELSE  '��Ÿ'
END;

dbms_output.put_line('code :'||dcode);
dbms_output.put_line('name :'||dname);

END;

DECLARE
dcode departments.department_id%TYPE;
dname varchar2(20);


BEGIN

SELECT e.DEPARTMENT_ID 
INTO dcode
FROM EMPLOYEES e 
WHERE e.FIRST_NAME ='Bruce';
	
dname := CASE 
WHEN dcode = 60 THEN 'it�μ�'
WHEN dcode = 80 THEN '�����μ�'
WHEN dcode = 100 THEN 'ȸ��μ�'
ELSE  '��Ÿ'
END;

dbms_output.put_line('code :'||dcode);
dbms_output.put_line('name :'||dname);

END;
---if�� ����� ���Կ����� //case���� case�� ��ü�� ���Կ����ڸ� ���ش�

--------------------------------------------------------
--�ݺ��� loop while for
--------------------------------------------------------

--11) loop~end�� ����Ͽ� 5���� ����Ͻÿ�.
-- loop �� exit when���� �������� ������ �ɰ�
-- ����� ���϶����� �ݺ��Ѵ�
DECLARE
 dan NUMBER := 5;
 su  NUMBER := 0;
 r   NUMBER := 0;
BEGIN
dbms_output.put_line(dan||'�� ���.....');	

LOOP
su:= su + 1;
r := dan*su;
dbms_output.put_line(dan||'*'||su||'='||r);
EXIT WHEN su = 9;
END LOOP;	
END;

--12) while ���� ����Ͽ� 5���� ���
DECLARE 
dan NUMBER(2) := 5;
su NUMBER(2) := 0;
r NUMBER(4) := 0;

BEGIN
	dbms_output.put_line(dan||'�� ���......');

WHILE su<9 LOOP
su := su+1;
r := dan*su;
dbms_output.put_line(dan||'*'||su||'='||r);
END LOOP;
	
	
	
END;

--13) for ���� ����Ͽ� 5���� ����Ͻÿ�.
DECLARE 
  dan NUMBER :=5;
  su NUMBER :=0;
  r NUMBER :=0;
BEGIN
	FOR su IN 1..9 LOOP
	r := dan*su;
    dbms_output.put_line(dan||'*'||su||'='||r);
	END LOOP;
	
END;

----reverse �Ųٷ� 
DECLARE 
  dan NUMBER :=5;
  su NUMBER :=0;
  r NUMBER :=0;
BEGIN
	FOR su IN reverse 1..9 LOOP
	r := dan*su;
    dbms_output.put_line(dan||'*'||su||'='||r);
	END LOOP;
	
END;


--14) �μ��ڵ尡 80���� �������� �̸��� �̸���,�޿��� for���� ����Ͽ� ����Ͻÿ�
DECLARE



BEGIN
FOR cur IN 
(SELECT FIRST_NAME,EMAIL,SALARY 
 FROM EMPLOYEES 
 WHERE DEPARTMENT_ID=80)
LOOP
dbms_output.put_line(cur.first_name||' '||cur.email||' '||cur.salary);
END LOOP;
		
END;
-------cursor�� ���� for��Ȱ���ϱ�
------- cursor�� ����Ʈ������ ��ȸ�� ���� ��´� 
--15) �μ��ڵ尡 80���� �������� �̸��� �̸���,�޿��� for���� cursor�� ����Ͽ� ����Ͻÿ�.

DECLARE
---cur��� ������ cursor Ÿ������ ����Ȱ���
CURSOR cur IS 
SELECT first_name,email,salary
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 100;


BEGIN
	dbms_output.put_line('Ŀ���� Ȱ���� �����');
	---cur�� �ִ� �����͸� ���������� �ѰǾ� rec�� ����ش�
	FOR rec IN cur LOOP
	dbms_output.put_line(rec.first_name||' '|| rec.email||' '||rec.salary);
	END LOOP;

	
END;





-------------------------------------
--���ν���
---------------------------------------
--or replace ���ν����� �����ϴ� ��ɾ�� ������ �ƴ�
--������ÿ��� ����� �����ؾ��Ѵ� ���x
---------------------------------

--16) ����� 206�� ������ �޿��� 5000���� �����Ͻÿ�(proceduer�� ���)
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID =206;

-------���ν��� ����
CREATE OR REPLACE PROCEDURE up_sal
(vempid employees.employee_id%type)---�Ű�����
IS
--- ���� �Է� ����
BEGIN 
---- ��� 
	UPDATE EMPLOYEES SET SALARY = 5000
	WHERE DEPARTMENT_ID = vempid;
END;

---- ��������� ��� ���� ���̿� �־���ְ�
---- ������ exec�� ����Ѵ�
---- exec up_sal(206);

BEGIN	
up_sal(90);
COMMIT;
END;

SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 90;

--17) ����� �޿��� ���޹޾� ����� �޿��� �����ϴ� proceduer��  �ۼ��Ͻÿ�.(���ν��� �̸��� up_sal2)
CREATE OR REPLACE PROCEDURE up_sal2 
(empid IN employees.employee_id%TYPE,
 emsal IN employees.salary%TYPE )
 IS 
 BEGIN
	 UPDATE EMPLOYEES SET 
	 SALARY = emsal
	 WHERE EMPLOYEE_ID = empid;
	 
 END;

SELECT * FROM EMPLOYEES  WHERE EMPLOYEE_ID = 206;

BEGIN 
	up_sal2(206, 10000);
END;

SELECT * FROM EMPLOYEES  WHERE EMPLOYEE_ID = 206;

--18) �μ��ڵ带 �Է¹޾� �ش� �μ��� �ѱ޿��� ��ȸ�ϴ� function �ۼ��Ͻÿ�.
CREATE OR REPLACE FUNCTION tot_sal
(dcode employees.DEPARTMENT_ID%type)
--- ������ ���� Ÿ���� ���� ����x Ÿ�Ը� ����
RETURN NUMBER 
IS 
---�����Է�
resal employees.salary%TYPE;
BEGIN 
	SELECT sum(salary) 
	---����Ʈ�Ѱ��� ������ �Է��ϰ�
	INTO resal
	FROM EMPLOYEES 
	WHERE DEPARTMENT_ID = dcode;
	
    ---�� ���� ���Ͻ�Ų��
	RETURN resal;
	
END;

---- ����Ʈ������ ����Ͽ� ���� �޾� ������ش�
                       ---
SELECT tot_sal(80) FROM dual;


--18) ����� �Է¹޾� �μ����� ��ȸ�ϴ� fucction�� �ۼ��Ͻÿ�./

CREATE OR REPLACE FUNCTION getDeptName
(eid employees.employee_id%type)
RETURN varchar2
IS
dname departments.department_name%TYPE;
BEGIN
	SELECT d.DEPARTMENT_NAME 
	INTO dname
	FROM DEPARTMENTS d JOIN EMPLOYEES e
	ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
	WHERE e.EMPLOYEE_ID = eid ;

    RETURN dname;
	
END;

SELECT getDeptName(107) ����μ� FROM dual;
SELECT FIRST_name , getDeptName(206) FROM EMPLOYEES e
WHERE EMPLOYEE_ID = 206;





-------------------------------------------------------
---Ʈ����
--------------------------------------------------------

--20) score ���̺� �ڷᰡ �ԷµǸ� �ܼ�â�� �޽����� ����Ͻÿ�.(trigger)
CREATE TRIGGER triA
AFTER INSERT ON score

BEGIN
dbms_output.put_line ('score���̺� �ڷᰡ �߰���.');	
	
END;

INSERT INTO score(serial,mid,subject,score) values(seq_score.nextval,'abc','����',90);
INSERT INTO tempscore(serial,mid,subject,score) values(seq_score.nextval,'abc','����',90);

--21) score ���̺��� score�÷��� �ڷᰡ update�Ǹ� ������ score�� ������ score �ֿܼ� ǥ���Ͻÿ�.
CREATE OR REPLACE TRIGGER tirb
AFTER UPDATE ON SCORE 
----���� �ٲ� ���� for each row
FOR EACH ROW 
BEGIN 
	dbms_output.put_line('������ ���� :'|| :OLD.score);
    dmbs_output.put_line('������ ���� :' || :NEW.score);
END;

SELECT * FROM SCORE ;
UPDATE SCORE SET SCORE = 50 WHERE SERIAL = 44;

--22) score ���̺� �����Ͱ� �߰��Ǹ� ���� ������ tempScore���� ����ǵ��� Ʈ���Ÿ� �����Ͻÿ� (tria����)
SELECT * FROM TEMPSCORE ;

CREATE OR REPLACE TRIGGER triA
AFTER INSERT ON score  --- ���� ���̺� 
FOR EACH ROW 
BEGIN
INSERT INTO TEMPSCORE(SERIAL,MID,SUBJECT,SCORE) 
----:new �� ���� �ԷµȰ��� ���Ѵ�(�μ�Ʈ,������Ʈ ���)
----:old �� :new �Ǳ����� ���� �ִ���
----     ���Ӱ� �Էµ� score�� �ø��� ��ȣ
VALUES(:NEW.serial,:NEW.mid,:NEW.subject,:NEW.score);
	
END;

INSERT INTO score(serial,mid,subject,score) values(seq_score.nextval,'abc','����',90);

SELECT * FROM TEMPSCORE ;

 ---23) �μ��� 80���� ��� ������� �����͸� ���ϴ� ������ ������
 
