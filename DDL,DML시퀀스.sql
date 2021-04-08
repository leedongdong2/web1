-------------------------------
-- DDL(CREATE,TRUNCATE,DROP,ALTER)
---------------------------------
--61) CREATE ���̺� 
CREATE TABLE STUDENT(
id varchar(20),
irum varchar(30),
phone varchar(50),
address varchar(100),
emali varchar(50)
);

---62) ��� ���̺� ���̺��� ���� ���� (������+ ����)
DROP TABLE STUDENT ;

---63) ������ ���̺� STUDENT�� �ٽ� ������ �� ��ȣ, �г� �÷��� ALTER�����
---    ����Ͽ� �߰��Ͻÿ�.
ALTER TABLE STUDENT 
ADD(pwd varchar(20));
ALTER TABLE STUDENT 
ADD(grade NUMBER(2));

--64) student ���̺� score(number) �÷��� �߰����� �ٽ� scroe �÷��� ����
ALTER TABLE STUDENT 
ADD(score NUMBER(2));

ALTER TABLE STUDENT 
DROP COLUMN score;

---65) student ���̺��� id �÷����� mid�� ����
ALTER TABLE STUDENT 
RENAME COLUMN id TO mid;


--66) student ���̺��� phone �÷��� ũ�⸦ 30���� ����
ALTER TABLE STUDENT 
MODIFY (PHONE varchar(30));

---67) score ���̺��� �Ʒ��� ���� ������ �����Ͻÿ�.
--- serial number, mid varchar(20), subject vachar(30), score number(4)
CREATE TABLE score(
serial NUMBER,
mid varchar(20),
subject varchar(30),
score number(4)
);

---68) ������ �����͸� scroe�� �Է��� �� truncate ����� ����Ͽ� �����͸� ���� (������ �����ִ� �����Ϳ� ���� ����)  delete �� �����ʹ� �������� ������ ������ �����ִ�
INSERT INTO score(serial,mid,subject,score)
values(100,'hong','����',100);
COMMIT; -- insert,update,delete����� Ȯ������ ���.(rollback ��Ҹ�ɾ�)

SELECT * FROM score;

TRUNCATE TABLE score;

SELECT * FROM score;

---------------------------------------------------
----DML(insert,update,delete,merge)
----------------------------------------------------

---1) INSERT INTO ���̺��(�÷���1,�÷Ÿ�2,....) values(��1,��2,...) ���������� ��ġ�ؾ��� (fm,��õ)
---2) INSERT INTO ���̺�� values(��1,��2,...); 
--- ��� �÷��� ������� ���� ��� �Է��Ϸ� �ҋ��� ���̺�� �ڿ� �ִ� �÷����� �����Ҽ� �մ�
---3) INSERT INTO ���̺�� SELECT�� ��� (ITAS)
---4) ���� ���̺� ���ÿ� ���� ���� �Է��� ��
---   INSERT ALL
---   INTO ���̺��1 VALUES(�÷���1,�÷���2,...)
---   INTO ���̺��2 VALUES(�÷���1,�÷���2,...)
---   SELECT ��

--69) score ���̺� hong,kim ���� ������ �Է��Ͻÿ�
--(1,hong,����,90)
--(2,kim,����,80)
INSERT INTO SCORE(SERIAL,MID,SUBJECT,SCORE) VALUES (1,'hong','����',90);
INSERT INTO SCORE(SERIAL,MID,SUBJECT,SCORE) VALUES (2,'kim','����',80);

--70) �÷����� �����Ͽ� �Ʒ��� ������ �Է��Ͻÿ�.
--(3,park,����,80)
INSERT INTO SCORE VALUES (3,'park','����',80);

--71) score ���̺��� ������ ����Ͽ� tempScore ���̺��� �����Ͻÿ�.
CREATE TABLE TEMPSCORE
AS 
SELECT SERIAL,MID,SUBJECT,SCORE FROM score WHERE 1=2;
--- ���̺��� �����ϸ鼭 �����ϴ� ���̺��� ���� ���� �����ǹǷ�
--- where�� �̿��� �Ϻη� ���� �ش���� �ʴ� ���� �־ ������ �����Ѵ�

--72) score ���̺��� ��� �����͸� tempScore�� ����
INSERT INTO TEMPSCORE 
SELECT SERIAL,MID,SUBJECT,SCORE FROM SCORE ;

SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;
TRUNCATE TABLE TEMPSCORE ;
SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;

--73)score ���̺��� �ڷ��� ���������� �ش��ϴ� �ڷḸ tempScore�� ����
INSERT INTO TEMPSCORE 
SELECT SERIAL,MID,SUBJECT,SCORE FROM SCORE WHERE SUBJECT = '����';

SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;
TRUNCATE TABLE TEMPSCORE ;
SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;

--74)score ���̺��� ������ ����Ͽ� imsiScore ���̺��� �����ѵ�
--   insert all�� ����Ͽ� score ���̺��� ��� �����͸� tempScore,imsiscore �� ����

CREATE TABLE IMSISCORE 
AS
SELECT SERIAL,MID,SUBJECT,SCORE FROM score;

TRUNCATE TABLE TEMPSCORE ;
TRUNCATE TABLE imsiscore ; 

INSERT ALL 
INTO TEMPSCORE values(SERIAL,MID,SUBJECT,SCORE)
INTO IMSISCORE values(SERIAL,MID,SUBJECT,SCORE)
SELECT SERIAL,MID,SUBJECT,SCORE FROM SCORE;

SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE;
SELECT SERIAL,MID,SUBJECT,SCORE FROM IMSISCORE;

-- update ���̺�� set �÷���1=������1, �÷���=������2,.. where ���� (where���� ������ ��� ���� ������Ʈ�ȴ� �ݵ�� where��
-- ���� ���ϴ� �÷��� ��� �ؾ��Ѵ� ����������)
-- update ���̺�� set �÷���1=������1, �÷���2=������2, ... where �÷��� = (��������)

SELECT * FROM score;
--75) hong�� ���� ������ 100������ �����Ͻÿ�.
UPDATE score SET SCORE = 100
WHERE mid = 'hong' AND SUBJECT = '����';

SELECT * FROM score;

--76) park�� ������ ���п��� ����� �����Ͻÿ�
UPDATE  score SET SUBJECT = '����'
WHERE mid = 'park' AND SUBJECT = '����';

SELECT * FROM SCORE;

--- delete from ���̺�� [where ����]
--- update �� ���������� where�� ���������� ��� �����Ͱ� �����ǹǷ�
--- where �� ���ļ� �� �ϴ°� ���� �Ժη� ������ �ȵ�!

--77) tempScore�� �ִ� �ڷ��� hong�� ���� ���� �ڷḦ ��� �����Ͻÿ�.
DELETE FROM TEMPSCORE
WHERE MID = 'hong';

SELECT * FROM TEMPSCORE;


--78) imsiscore�� �ִ� ��� �ڷḦ ����
DELETE  FROM IMSISCORE ;

SELECT * FROM imsiscore;

---------------------------------------------
---TCL(Ʈ�����) (commit,rollback)
----------------------------------------------
-- DBeaver�� commit �ɼ��� ���信�� �޴���� �ٲ��
-- sql plus�� ��� hr ������ �α���

---79) TEMPSCORE �� �����͸� ��� �������� COMMIT �� Ȯ��, ROLLBACK �� Ȯ��
SELECT * FROM TEMPSCORE ;
DELETE  FROM TEMPSCORE ;
SELECT * FROM  TEMPSCORE ;
ROLLBACK ;
SELECT * FROM TEMPSCORE;

DELETE  FROM TEMPSCORE;
COMMIT;
SELECT * FROM TEMPSCORE;
--- �ѹ��� ���� ������ ����� ��� �ϴ°��ΰ� Ŀ���� Ȯ�����°Ŵ� Ŀ���� ���ķδ� ���������
--- ���� �̻� ���͵ɼ� ����
--- �۾��� �ҋ����� Ȯ���� Ȯ���ϰ� Ŀ���� ���ִ°��� �߿��ϴ�!

---------------------------------------------------
-- ��������
---------------------------------------------------
/*
 * ���� : 
 *  1) not null or null
 *  2) unique : �ߺ������ʴ� ���� �����Ҷ� null���� �ϳ�
 *  3) primary key : not null�� unique ���̺�� �ϳ��� �����Ѵ�, �ڵ������� �ε����� ����ȴ�
 *  4) foreign key : �ٸ� ���̺��� �÷��� �����ؼ� �˻縦 �Ѵ� ���� �⺻Ű�� �����Ǽ� ���̺��� ����
 *  4-1) references : ����
 *  5) check ���ǿ��� ������ ���� �Է��� ����ϰ� �������� �ź�
 * 
 *  ���� ��� : 
 *  1) ���̺� ������ : inline type, table type
 *  2) ���̺� ���� �� ���� ���� : alter table
 */

--80) �������� 5������ ���̺� ������ ����
---inline type 
CREATE TABLE constTest(
nno number(4) CONSTRAINT constTest_nno_pk PRIMARY KEY,
name varchar(20) CONSTRAINT constTest_name_nn NOT NULL,
jumin varchar(13) CONSTRAINT constTest_jumin_nn NOT NULL
CONSTRAINT constTest_jumin_uk UNIQUE,
loc_code number(1) CONSTRAINT constTest_area_ck CHECK(loc_code<5),
deptno number(6) CONSTRAINT constTest_deptno_fk  REFERENCES departments(department_id)
);
 
COMMIT;
/*
 table type
CREATE TABLE constTest2(
nno number(4), 
name varchar(20) CONSTRAINT constTest_name_nnNOT NULL,
jumin varchar(13) CONSTRAINT constTest_jumin_nn NOT NULL,
loc_code number(1), 
deptno number(6), 

CONSTRAINT constTest_nno_pk PRIMARY KEY(nno),
CONSTRAINT constTest_jumin_uk UNIQUE(jumin),
CONSTRAINT constTest_area_ck CHECK(loc_code<5),
CONSTRAINT constTest_deptno_fk  FOREIGN KEY(deptno) REFERENCES departments(department_id)
);
*/


INSERT INTO CONSTTEST VALUES (1,'home','900200',1,100);
SELECT * FROM CONSTTEST;
COMMIT;

--81) no�÷��� �ߺ��� ���� �Է��Ͽ� primary key �Ӽ��� �׽�Ʈ�Ͻÿ�

INSERT INTO CONSTTEST VALUES (1,'home','900200',1,100);
-- ���Ἲ ���� ���� ����(Ű���Ⱚ �ߺ�)

--82) no�÷��� null�� �����Ͽ� primary key �Ӽ��� �׽�Ʈ �Ͻÿ�
INSERT INTO CONSTTEST (name,jumin,loc_code,deptno) VALUES ('kim','990101',1,100);
-- null���� ��������� ���� ����

--83) jumin ��ȣ�� �ߺ��Է��Ͽ� unique �Ӽ��� �׽�Ʈ �Ͻÿ�.
INSERT INTO CONSTTEST VALUES (2,'kim','900200',2,100);
-- unique �� �ߺ����� ������� �ʱ� ������ �ߺ� ����
INSERT INTO CONSTTEST VALUES (2,'kim','900220',2,100);
SELECT * FROM CONSTTEST ;
COMMIT; 

---84) loc_code�� 8�� �Է��Ͽ� check �Ӽ��� ������� �׽�Ʈ �Ͻÿ�.
INSERT INTO CONSTTEST VALUES (3,'kim','900200',8,100);
---üũ �������ǿ� ����ȴ�

---85) departments ���̺� �ִ� department_id�� ���� ���� �Է��Ͽ� foreign key �Ӽ��� �׽�Ʈ �Ͻÿ�.
INSERT INTO CONSTTEST VALUES (5,'kim','900230',2,9999);
-- �����Ǵ� ���� �θ�Ű�� ���� ���� �����Ǵ� ���̺��� �⺻Ű�� ������ �ܷ�Ű�� �����ؾ��Ѵ�

--- constTest ���̺� �����Ǿ� �ִ� ���� ���� ����
--- not null�� ����� ���ݴٸ���
--�������� Ȯ�ι�
SELECT * FROM user_constraints WHERE table_name = UPPER('constTest');
COMMIT;
ALTER TABLE CONSTTEST 
DROP CONSTRAINT constTest_nno_pk;

ALTER TABLE CONSTTEST 
DROP CONSTRAINT constTest_jumin_uk;

ALTER TABLE CONSTTEST 
DROP CONSTRAINT constTest_area_ck;

ALTER TABLE CONSTTEST 
DROP CONSTRAINT constTest_deptno_fk;

SELECT * FROM user_constraints WHERE table_name = UPPER('constTest');
--- ���̺� ������ alter table�� ����� ���� ���� ����
ALTER TABLE CONSTTEST 
ADD CONSTRAINT constTest_no_pk PRIMARY KEY(nno);

ALTER TABLE CONSTTEST 
ADD CONSTRAINT constTest_jumin_uk UNIQUE(jumin);

ALTER  TABLE CONSTTEST 
ADD CONSTRAINT constTest_area_ck
CHECK (loc_code>5);

ALTER TABLE CONSTTEST 
ADD CONSTRAINT constTest_deptno_fk
FOREIGN KEY(deptno) REFERENCES departments(department_id);

SELECT * FROM user_constraints WHERE table_name = UPPER('constTest');

----null�� not null�� modify�� �����ؾ��Ѵ�
--- null�� not null �ΰ��� �ϳ�
ALTER TABLE CONSTTEST 
MODIFY jumin NULL;

-------------------------------------------
--- SEQUENCE (�Ϸù�ȣ) - �ߺ������ʴ� ��ȣ�� �߻�
--------------------------------------------
-- �������� �߻���Ű�� ��ɾ� : ��������.NEXTVAL
-- ���� �������� ��ȸ : ��������.CURRVAL

--95) �⺻���� ����Ͽ� �������� ���� 
CREATE SEQUENCE SEQ_SCORE;

--96) ������ �������� �߻�
SELECT SEQ_SCORE.NEXTVAL FROM DUAL;

--97) ���� ���������� ��ȸ
SELECT SEQ_SCORE.CURRVAL FROM DUAL;

--98) SCORE ���̺� ������ �Է��� �� SERIAL�÷��� �������� ����
INSERT INTO SCORE (SERIAL,MID,SUBJECT,SCORE)
VALUES (SEQ_SCORE.NEXTVAL,'KIM','����',100);

SELECT * FROM SCORE s ;
