-------------------------------
-- DDL(CREATE,TRUNCATE,DROP,ALTER)
---------------------------------
--61) CREATE 테이블 
CREATE TABLE STUDENT(
id varchar(20),
irum varchar(30),
phone varchar(50),
address varchar(100),
emali varchar(50)
);

---62) 드랍 테이블 테이블을 완전 삭제 (데이터+ 구조)
DROP TABLE STUDENT ;

---63) 삭제된 테이블 STUDENT를 다시 생성한 후 암호, 학년 컬럼을 ALTER명령을
---    사용하여 추가하시오.
ALTER TABLE STUDENT 
ADD(pwd varchar(20));
ALTER TABLE STUDENT 
ADD(grade NUMBER(2));

--64) student 테이블에 score(number) 컬럼을 추가한후 다시 scroe 컬럼을 삭제
ALTER TABLE STUDENT 
ADD(score NUMBER(2));

ALTER TABLE STUDENT 
DROP COLUMN score;

---65) student 테이블의 id 컬럼명을 mid로 수정
ALTER TABLE STUDENT 
RENAME COLUMN id TO mid;


--66) student 테이블의 phone 컬럼의 크기를 30으로 수정
ALTER TABLE STUDENT 
MODIFY (PHONE varchar(30));

---67) score 테이블을 아래와 같은 구조로 생성하시오.
--- serial number, mid varchar(20), subject vachar(30), score number(4)
CREATE TABLE score(
serial NUMBER,
mid varchar(20),
subject varchar(30),
score number(4)
);

---68) 임의의 데이터를 scroe에 입력한 후 truncate 명령을 사용하여 데이터만 삭제 (구조는 남아있다 데이터와 영역 삭제)  delete 는 데이터는 지우지만 구조와 영역은 남아있다
INSERT INTO score(serial,mid,subject,score)
values(100,'hong','영어',100);
COMMIT; -- insert,update,delete명령을 확정짓는 명령.(rollback 취소명령어)

SELECT * FROM score;

TRUNCATE TABLE score;

SELECT * FROM score;

---------------------------------------------------
----DML(insert,update,delete,merge)
----------------------------------------------------

---1) INSERT INTO 테이블명(컬럼명1,컬렴명2,....) values(갑1,갑2,...) 순서갯수가 일치해야함 (fm,추천)
---2) INSERT INTO 테이블명 values(값1,값2,...); 
--- 모든 컬럼의 순서대로 값을 모두 입력하려 할떄는 테이블명 뒤에 있는 컬럼명을 생략할수 잇다
---3) INSERT INTO 테이블명 SELECT절 사용 (ITAS)
---4) 여러 테이블에 동시에 같은 값을 입력할 때
---   INSERT ALL
---   INTO 테이블명1 VALUES(컬럼명1,컬럼명2,...)
---   INTO 테이블명2 VALUES(컬럼명1,컬럼명2,...)
---   SELECT 절

--69) score 테이블에 hong,kim 성적 정보를 입력하시오
--(1,hong,국어,90)
--(2,kim,영어,80)
INSERT INTO SCORE(SERIAL,MID,SUBJECT,SCORE) VALUES (1,'hong','국어',90);
INSERT INTO SCORE(SERIAL,MID,SUBJECT,SCORE) VALUES (2,'kim','영어',80);

--70) 컬럼명을 생략하여 아래의 점수를 입력하시오.
--(3,park,수학,80)
INSERT INTO SCORE VALUES (3,'park','수학',80);

--71) score 테이블의 구조를 사용하여 tempScore 테이블을 생성하시오.
CREATE TABLE TEMPSCORE
AS 
SELECT SERIAL,MID,SUBJECT,SCORE FROM score WHERE 1=2;
--- 테이블을 생성하면서 참조하는 테이블의 값도 같이 생성되므로
--- where을 이용해 일부로 모든게 해당되지 않는 값을 주어서 구조만 생성한다

--72) score 테이블의 모든 데이터를 tempScore에 저장
INSERT INTO TEMPSCORE 
SELECT SERIAL,MID,SUBJECT,SCORE FROM SCORE ;

SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;
TRUNCATE TABLE TEMPSCORE ;
SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;

--73)score 테이블의 자료중 국어점수에 해당하는 자료만 tempScore에 저장
INSERT INTO TEMPSCORE 
SELECT SERIAL,MID,SUBJECT,SCORE FROM SCORE WHERE SUBJECT = '국어';

SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;
TRUNCATE TABLE TEMPSCORE ;
SELECT SERIAL,MID,SUBJECT,SCORE FROM TEMPSCORE ;

--74)score 테이블의 구조를 사용하여 imsiScore 테이블을 생성한뒤
--   insert all을 사용하여 score 테이블의 모든 데이터를 tempScore,imsiscore 에 저장

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

-- update 테이블명 set 컬럼명1=수정값1, 컬럼명=수정갑2,.. where 조건 (where절이 없으면 모든 절이 업데이트된다 반드시 where로
-- 내가 원하는 컬럼을 집어서 해야한다 굉장히위험)
-- update 테이블명 set 컬럼명1=수정값1, 컬럼명2=수정값2, ... where 컬럼명 = (서브쿼리)

SELECT * FROM score;
--75) hong의 국어 성적을 100점으로 수정하시오.
UPDATE score SET SCORE = 100
WHERE mid = 'hong' AND SUBJECT = '국어';

SELECT * FROM score;

--76) park의 과목을 수학에서 영어로 수정하시오
UPDATE  score SET SUBJECT = '영어'
WHERE mid = 'park' AND SUBJECT = '수학';

SELECT * FROM SCORE;

--- delete from 테이블명 [where 조건]
--- update 와 마찬가지로 where을 쓰지않으면 모든 데이터가 삭제되므로
--- where 과 합쳐서 꼭 하는게 좋다 함부로 지워선 안됨!

--77) tempScore에 있는 자료중 hong의 국어 성적 자료를 모두 삭제하시오.
DELETE FROM TEMPSCORE
WHERE MID = 'hong';

SELECT * FROM TEMPSCORE;


--78) imsiscore에 있는 모든 자료를 삭제
DELETE  FROM IMSISCORE ;

SELECT * FROM imsiscore;

---------------------------------------------
---TCL(트랜잭션) (commit,rollback)
----------------------------------------------
-- DBeaver의 commit 옵션을 오토에서 메뉴얼로 바꿔라
-- sql plus를 열어서 hr 유저로 로그인

---79) TEMPSCORE 의 데이터를 모두 삭제한후 COMMIT 전 확인, ROLLBACK 후 확인
SELECT * FROM TEMPSCORE ;
DELETE  FROM TEMPSCORE ;
SELECT * FROM  TEMPSCORE ;
ROLLBACK ;
SELECT * FROM TEMPSCORE;

DELETE  FROM TEMPSCORE;
COMMIT;
SELECT * FROM TEMPSCORE;
--- 롤백은 내가 실행한 명령을 취소 하는것인고 커밋은 확정짓는거다 커밋을 한후로는 백업파일이
--- 없는 이상 복귀될수 없다
--- 작업을 할떄마다 확실히 확인하고 커밋을 해주는것이 중요하다!

---------------------------------------------------
-- 제약조건
---------------------------------------------------
/*
 * 종류 : 
 *  1) not null or null
 *  2) unique : 중복되지않는 값을 설정할때 null또한 하나
 *  3) primary key : not null과 unique 테이블당 하나만 존재한다, 자동적으로 인덱스가 선언된다
 *  4) foreign key : 다른 테이블의 컬럼을 참조해서 검사를 한다 보통 기본키랑 연관되서 테이블을 연결
 *  4-1) references : 참조
 *  5) check 조건에서 설정된 값만 입력을 허용하고 나머지는 거부
 * 
 *  지정 방법 : 
 *  1) 테이블 생성시 : inline type, table type
 *  2) 테이블 생성 후 구조 변경 : alter table
 */

--80) 제약조건 5가지를 테이블 생성시 지정
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

--81) no컬럼에 중복된 값을 입력하여 primary key 속성을 테스트하시오

INSERT INTO CONSTTEST VALUES (1,'home','900200',1,100);
-- 무결성 제약 조건 오류(키본기값 중복)

--82) no컬럼에 null을 대입하여 primary key 속성을 테스트 하시오
INSERT INTO CONSTTEST (name,jumin,loc_code,deptno) VALUES ('kim','990101',1,100);
-- null값을 집어넣을수 없다 오류

--83) jumin 번호를 중복입력하여 unique 속성을 테스트 하시오.
INSERT INTO CONSTTEST VALUES (2,'kim','900200',2,100);
-- unique 는 중복값을 허용하지 않기 떄문에 중복 오류
INSERT INTO CONSTTEST VALUES (2,'kim','900220',2,100);
SELECT * FROM CONSTTEST ;
COMMIT; 

---84) loc_code에 8을 입력하여 check 속성에 위배됨을 테스트 하시오.
INSERT INTO CONSTTEST VALUES (3,'kim','900200',8,100);
---체크 제약조건에 위배된다

---85) departments 테이블에 있는 department_id에 없는 값을 입력하여 foreign key 속성을 테스트 하시오.
INSERT INTO CONSTTEST VALUES (5,'kim','900230',2,9999);
-- 참조되는 곳에 부모키가 없는 오류 참조되는 테이블의 기본키의 값으로 외래키를 설정해야한다

--- constTest 테이블에 설정되어 있는 제약 조건 삭제
--- not null은 방식이 조금다르다
--제약조건 확인법
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
--- 테이블 생성후 alter table을 사용한 제약 조건 수정
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

----null과 not null은 modify로 수정해야한다
--- null과 not null 두값중 하나
ALTER TABLE CONSTTEST 
MODIFY jumin NULL;

-------------------------------------------
--- SEQUENCE (일련번호) - 중복되지않는 번호를 발생
--------------------------------------------
-- 시퀀스를 발생시키는 명령어 : 시퀀스명.NEXTVAL
-- 현재 시퀀스를 조회 : 시퀀스명.CURRVAL

--95) 기본값을 사용하여 시퀀스를 생성 
CREATE SEQUENCE SEQ_SCORE;

--96) 생성된 시퀀스를 발생
SELECT SEQ_SCORE.NEXTVAL FROM DUAL;

--97) 현재 시퀀스값만 조회
SELECT SEQ_SCORE.CURRVAL FROM DUAL;

--98) SCORE 테이블에 성적을 입력할 때 SERIAL컬럼에 시퀀스를 적용
INSERT INTO SCORE (SERIAL,MID,SUBJECT,SCORE)
VALUES (SEQ_SCORE.NEXTVAL,'KIM','국어',100);

SELECT * FROM SCORE s ;
