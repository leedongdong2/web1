--------------------------------------------------
-----pl-sql
---------------------------------------------------
------스칼라 변수 db에서의 기본 변수 
---기본골격
-- 대입연산자 - :=

--1) 사번이 100인 직원과 이름과 연락처를 출력

DECLARE
vname varchar2(50);
vphone varchar2(50);

BEGIN 
	   SELECT FIRST_NAME, phone_number 
	   --셀렉트된 결과를 인토를 통해 디클레어 변수에 저장
	   INTO vname,vphone 
	   FROM EMPLOYEES e
	   WHERE EMPLOYEE_ID = 100;
	  
	   dbms_output.put_line(vname);
	   dbms_output.put_line(vphone);
END;

--2) 부서코드가 108번인 직원들의 급여 합계와 평균을 출력

DECLARE
h NUMBER(10);
p NUMBER(7,2);
BEGIN
	SELECT sum(salary), avg(salary)
	INTO h,p
	FROM EMPLOYEES e2 
	WHERE DEPARTMENT_ID =80;

    dbms_output.put_line('합계'||h);
    dbms_output.put_line('평균'||p);
END;

--3) Oliver의 부서명을 출력
DECLARE 
dname varchar2(40);

BEGIN
SELECT d.DEPARTMENT_NAME
INTO dname
FROM DEPARTMENTS d
WHERE d.DEPARTMENT_ID IN (SELECT e.DEPARTMENT_ID 
                         FROM EMPLOYEES e
                         WHERE e.FIRST_NAME='Oliver');

	dbms_output.put_line('Oliver 부서명 :'||dname);
	
END;

DECLARE 
dname varchar2(40);

BEGIN
SELECT d.DEPARTMENT_NAME 
INTO dname
FROM DEPARTMENTS d JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
WHERE e.FIRST_NAME = 'Oliver';

	dbms_output.put_line('Oliver 부서명 :'||dname);
	
END;





--4)tayler의 직무명

DECLARE
jname varchar2(50);
BEGIN
	
SELECT j.JOB_TITLE 
INTO jname
FROM JOBS j 
WHERE j.JOB_ID IN (SELECT e.JOB_ID 
                  FROM EMPLOYEES e
                  WHERE e.FIRST_NAME='Tayler');
                 
          dbms_output.put_line('Tayler 직무명 : jname');
END;

DECLARE
jname varchar2(50);

BEGIN
	SELECT j.JOB_TITLE 
	INTO jname
	FROM JOBS j JOIN EMPLOYEES e
	ON j.JOB_ID = e.JOB_ID
	WHERE e.FIRST_NAME ='Tayler';

 dbms_output.put_line('Tayler 직무명 : jname');
END;


/*
PL-SQL
변수의 유형 요약
1) 스칼라형 : 오라클의 기본 데이터 유형(vachar,number,char....)
2) %TYPE : 하나의 컬럼 유형을 가져옴./원하는 테이블의 컬럼 타입을 그대로 가져온다
3) %ROWTYPE : 행 전체의 유형을 가져옴.
4) RECORD : %ROWTYPE과 유사하나 변수의 요소를 임의로 추가, 삭제할 수 있음
5) TABLE : 하나의 배열과 유사하다
*/

--5) 사번이 117인 직원의 이름과, 급여, 연락처를 조회하시오.
--   (단, 변수의 유형은 %TYPE 을 사용할것
DECLARE 
--엠플로이 테이블의 퍼스트네임의 타입을 가져와라!
-- 변수의 타입이 확실치 않을떄 테이블의 타입을 그대로 가져온다
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

--6) Marketing 부서의 우편번호(postal_code)와 지사의 주소(street_address) 출력
---- (단, 변수의 지정은 %type사용)
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
	
	                      dbms_output.put_line('우편번호:'pcode);
	                     dbms_output.put_line('지사번호:'streetadd);
	
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
	
	     dbms_output.put_line('우편번호:'pcode);
	     dbms_output.put_line('지사주소:'streetadd);
	
END;


--7) Adam의 부서코드,부서이름,매니져아이디,로케이션 아이디를 조회하시오
-- 단 변수의 유형은 %rowtype 사용
DECLARE
--- 테이블이 가지고 있는 유형 그대로의 타입을 가져온다
--- 요소를 추가하거나 뺼수는 없다
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

--8) 부서코드가 60번인 부서의 부서명, 매니져명,우편번호를 조회

DECLARE 
--- manager_record라는 이름으로  레코드타입을 선언 (vachar,number같이 타입임) 
TYPE manager_record IS RECORD
(dname departments.department_name%TYPE,
 mname employees.first_name%TYPE,
 pcode locations.postal_code%TYPE
);
-- 타입을 바로 쓸순 없으니 변수로 지정해줘야한다
manager manager_record;

BEGIN 
SELECT  d.DEPARTMENT_NAME ,e.FIRST_NAME ,l.POSTAL_CODE 
INTO manager
FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.EMPLOYEE_ID = d.MANAGER_ID 
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID 
WHERE d.DEPARTMENT_ID = 60;

dbms_output.put_line('부서명 : '||manager.dname);
dbms_output.put_line('매니저이름 : '||manager.mname);
dbms_output.put_line('우편번호 : '||manager.pcode);
	
END;



SELECT  d.DEPARTMENT_NAME ,e.FIRST_NAME ,l.POSTAL_CODE 
FROM DEPARTMENTS d JOIN EMPLOYEES e
ON d.MANAGER_ID = e.EMPLOYEE_ID 
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID 
WHERE d.DEPARTMENT_ID = 60;

-----------------------------------------------------------
---if문
-----------------------------------------------------------

--9) Allan의 급여합계(급여+급여*수수료율) 가 15,000이상이면 고액연봉자 아니면 평균연봉자란
--문자열을 급여합계와 함께 출력하시오
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
str := '고액연봉자';
ELSE 
str := '평균연봉자';
END IF;
dbms_output.put_line('hap:'||hap||':'||str);
END;

---10) Burce의 부서코드가 60 번이면 'it부서',80번이면 '영업부서',100번이면 '회계부서',그외는 기타로 출력하시오
---case문
DECLARE
dcode departments.department_id%TYPE;
dname varchar2(20);


BEGIN

SELECT e.DEPARTMENT_ID 
INTO dcode
FROM EMPLOYEES e 
WHERE e.FIRST_NAME ='Bruce';
	
dname := CASE dcode
WHEN 60 THEN 'it부서'
WHEN 80 THEN '영업부서'
WHEN 100 THEN '회계부서'
ELSE  '기타'
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
WHEN dcode = 60 THEN 'it부서'
WHEN dcode = 80 THEN '영업부서'
WHEN dcode = 100 THEN '회계부서'
ELSE  '기타'
END;

dbms_output.put_line('code :'||dcode);
dbms_output.put_line('name :'||dname);

END;
---if는 결과에 대입연산자 //case문은 case문 자체에 대입연산자를 해준다

--------------------------------------------------------
--반복문 loop while for
--------------------------------------------------------

--11) loop~end를 사용하여 5단을 출력하시오.
-- loop 는 exit when으로 빠져나갈 조건을 걸고
-- 결과가 참일때까지 반복한다
DECLARE
 dan NUMBER := 5;
 su  NUMBER := 0;
 r   NUMBER := 0;
BEGIN
dbms_output.put_line(dan||'단 출력.....');	

LOOP
su:= su + 1;
r := dan*su;
dbms_output.put_line(dan||'*'||su||'='||r);
EXIT WHEN su = 9;
END LOOP;	
END;

--12) while 문을 사용하여 5단을 출력
DECLARE 
dan NUMBER(2) := 5;
su NUMBER(2) := 0;
r NUMBER(4) := 0;

BEGIN
	dbms_output.put_line(dan||'단 출력......');

WHILE su<9 LOOP
su := su+1;
r := dan*su;
dbms_output.put_line(dan||'*'||su||'='||r);
END LOOP;
	
	
	
END;

--13) for 문을 사용하여 5단을 출력하시오.
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

----reverse 거꾸로 
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


--14) 부서코드가 80번인 직원들의 이름과 이메일,급여를 for문을 사용하여 출력하시오
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
-------cursor를 만들어서 for문활용하기
------- cursor는 셀렉트문으로 조회된 값을 담는다 
--15) 부서코드가 80번인 직원들의 이름과 이메일,급여를 for문과 cursor를 사용하여 출력하시오.

DECLARE
---cur라는 변수가 cursor 타입으로 선언된거임
CURSOR cur IS 
SELECT first_name,email,salary
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 100;


BEGIN
	dbms_output.put_line('커서를 활용한 결과물');
	---cur에 있는 데이터를 순차적으로 한건씩 rec에 담아준다
	FOR rec IN cur LOOP
	dbms_output.put_line(rec.first_name||' '|| rec.email||' '||rec.salary);
	END LOOP;

	
END;





-------------------------------------
--프로시져
---------------------------------------
--or replace 프로시져를 수정하는 명령어로 내꺼가 아닌
--공용사용시에는 사용을 자제해야한다 사용x
---------------------------------

--16) 사번인 206인 직원의 급여를 5000으로 수정하시오(proceduer를 사용)
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID =206;

-------프로시져 생성
CREATE OR REPLACE PROCEDURE up_sal
(vempid employees.employee_id%type)---매개변수
IS
--- 변수 입력 공간
BEGIN 
---- 기능 
	UPDATE EMPLOYEES SET SALARY = 5000
	WHERE DEPARTMENT_ID = vempid;
END;

---- 비버에서는 비긴 엔드 사이에 넣어서써주고
---- 보통은 exec로 사용한다
---- exec up_sal(206);

BEGIN	
up_sal(90);
COMMIT;
END;

SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 90;

--17) 사번과 급여를 전달받아 사번에 급여를 수정하는 proceduer를  작성하시오.(프로시져 이름은 up_sal2)
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

--18) 부서코드를 입력받아 해당 부서의 총급여를 조회하는 function 작성하시오.
CREATE OR REPLACE FUNCTION tot_sal
(dcode employees.DEPARTMENT_ID%type)
--- 리턴할 값의 타입을 지정 범위x 타입만 지정
RETURN NUMBER 
IS 
---변수입력
resal employees.salary%TYPE;
BEGIN 
	SELECT sum(salary) 
	---셀렉트한것을 변수에 입력하고
	INTO resal
	FROM EMPLOYEES 
	WHERE DEPARTMENT_ID = dcode;
	
    ---그 값을 리턴시킨다
	RETURN resal;
	
END;

---- 셀렉트문에서 사용하여 값을 받아 출력해준다
                       ---
SELECT tot_sal(80) FROM dual;


--18) 사번을 입력받아 부서명을 조회하는 fucction을 작성하시오./

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

SELECT getDeptName(107) 사원부서 FROM dual;
SELECT FIRST_name , getDeptName(206) FROM EMPLOYEES e
WHERE EMPLOYEE_ID = 206;





-------------------------------------------------------
---트리거
--------------------------------------------------------

--20) score 테이블에 자료가 입력되면 콘솔창에 메시지를 출력하시오.(trigger)
CREATE TRIGGER triA
AFTER INSERT ON score

BEGIN
dbms_output.put_line ('score테이블에 자료가 추가됨.');	
	
END;

INSERT INTO score(serial,mid,subject,score) values(seq_score.nextval,'abc','영어',90);
INSERT INTO tempscore(serial,mid,subject,score) values(seq_score.nextval,'abc','영어',90);

--21) score 테이블에서 score컬럼의 자료가 update되면 수정전 score와 수정후 score 콘솔에 표시하시오.
CREATE OR REPLACE TRIGGER tirb
AFTER UPDATE ON SCORE 
----행이 바뀔때 쓴다 for each row
FOR EACH ROW 
BEGIN 
	dbms_output.put_line('수정전 점수 :'|| :OLD.score);
    dmbs_output.put_line('수정후 점수 :' || :NEW.score);
END;

SELECT * FROM SCORE ;
UPDATE SCORE SET SCORE = 50 WHERE SERIAL = 44;

--22) score 테이블에 데이터가 추가되면 관련 정보를 tempScore에도 저장되도록 트리거를 생성하시오 (tria편집)
SELECT * FROM TEMPSCORE ;

CREATE OR REPLACE TRIGGER triA
AFTER INSERT ON score  --- 기준 테이블 
FOR EACH ROW 
BEGIN
INSERT INTO TEMPSCORE(SERIAL,MID,SUBJECT,SCORE) 
----:new 는 새로 입력된값을 뜻한다(인서트,업데이트 등등)
----:old 는 :new 되기전의 원래 있던값
----     새롭게 입력된 score의 시리얼 번호
VALUES(:NEW.serial,:NEW.mid,:NEW.subject,:NEW.score);
	
END;

INSERT INTO score(serial,mid,subject,score) values(seq_score.nextval,'abc','영어',90);

SELECT * FROM TEMPSCORE ;

 ---23) 부서가 80번인 모든 사람들의 데이터를 구하는 변수를 만들어라
 
