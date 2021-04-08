
-----테이블 삭제-----------------
DROP TABLE emp;
-------------------------------

-----------------------------------
-- 집합연산자를 연습하기 위한 테이블 생성
-------------------------------------
CREATE TABLE emp AS SELECT * FROM EMPLOYEES e WHERE SALARY>8000;
SELECT * FROM emp;

---17) employees 테이블과 emp 테이블의 내용을 union으로 병합한다
SELECT employee_id,first_name,salary FROM employees
UNION 
SELECT employee_id,first_name,salary FROM emp;

---18) employees 테이블과 emp 테이블의 내용을 중복허용하여 unionall으로 병합한다
SELECT employee_id,first_name,salary FROM employees--부산지사
UNION ALL
SELECT employee_id,first_name,salary FROM emp;--제주지사

---19) employees, emp 테이블의 중복되는 자료를 조회하시오 (교집합)(intersect)
SELECT * FROM EMPLOYEES e 
INTERSECT
SELECT * FROM emp;

----20) employees, emp 테이블에서 차집합을 왼쪽 - 오른쪽(왼쪽기준으로 오른쪽과 중복되는값을 뺸다)구하라(minus)
SELECT * FROM EMPLOYEES 
MINUS
SELECT * FROM emp;

SELECT * FROM emp
MINUS
SELECT * FROM EMPLOYEES ;

---21) first_name은 모두 대문자로, last_name은 모두 소문자로 출력
SELECT upper(first_name) AS 성,lower(last_name) AS 명 FROM EMPLOYEES ;

---22)email 주소의 길이를 성명,이메일,이메일길이로 출력(length)
SELECT concat(first_name,last_name) AS 성명,email,LENGTH(email) as 이메일길이 FROM EMPLOYEES ;

---23)부서코드가 100번인 사원들의 이메일을 이메일@korea.com 형태로 출력(concat)
SELECT DEPARTMENT_ID AS 부서아이디,concat(email,'@korea.com') AS 이메일 FROM EMPLOYEES WHERE DEPARTMENT_ID = 100;

---24) 성명 th가 포함되어 있는 사원들의 급여를 급여출력 자리는 10자리로 지정한뒤 나머지 공간은 *로 채워 출력(lpad)
SELECT concat(first_name,last_name) AS 성명,lpad(salary,10,'*') AS 급여 FROM EMPLOYEES WHERE concat(first_name,last_name) LIKE '%th%';

--25) 이름의 앞 두자리는 '**'으로 변환하여 조회하시오(replace,substr)
SELECT first_name,REPLACE(first_name,substr(first_name,1,4),'****') FROM EMPLOYEES ;

--26) 연락처의 뒷4자리를 모두 '****'으로 바꾸어 성명,이메일과 함께 조회
SELECT first_name AS 성명,email AS 이메일,REPLACE (phone_number,SUBSTR(PHONE_NUMBER,-4,4),'****') AS 번호 FROM EMPLOYEES;

---27) 사원들의 급여, 보너스(급여의 300%),총액(급여+보너스)를 출력하시오.(단,총액은 100단위 미만은 절상하여)
SELECT first_name AS 이름, salary AS 급여,salary*3 AS 보너스, CEIL (salary+salary*3) AS 총액 FROM EMPLOYEES;
SELECT TRUNC(SYSDATE), first_name AS 이름, salary AS 급여,salary*3 AS 보너스, CEIL((salary+salary*3)/100)*100 AS 총액 FROM EMPLOYEES;


---28) 사원들의 급여,세금(급여의10%),지급액(급여-세금)을 출력하시요(단,총액은 소수점이하는 절삭하시오)
SELECT first_name AS 이름,salary AS 급여,salary*0.1 AS 세금, FLOOR(salary - (salary*0.1)) AS 지급액 FROM EMPLOYEES ;

---29) 본인이 살아온 개월수를 계산
SELECT FLOOR( MONTHS_BETWEEN('2021/03/30','1997/02/14')) FROM dual; 

----30)--년월일 표시
SELECT FIRST_NAME,hire_date,TO_CHAR(hire_date,'MM') AS 입사월 FROM EMPLOYEES;

--30-1) 3월에 입사한 직원의 이름,입사일을 조회
SELECT FIRST_NAME,hire_date,TO_CHAR(hire_date,'MM') AS 입사월 FROM EMPLOYEES WHERE TO_char(hire_date,'MM')='03';

---31) 5월에 입사한 직원의 이름, 입사일, 급여를 출력하되, 급여에는 천단위 기호를 사용하여 조회
SELECT first_name,hire_date,to_char(salary,'99,999') AS 급여 FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'MM')='05';

---32) 입사년도가 2007년 3월 이후에 입사한 직원의 성명,급여,보너스(급여*커미션) 출력하되 커미션이 없는 직원의 보너스는 0으로 처리하시오
SELECT first_name AS 이름,salary AS 급여,salary*nvl(commission_pct,0) AS 보너스,HIRE_DATE AS 입사월 FROM EMPLOYEES WHERE TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYYMMDD')) >= 20070400;
SELECT first_name AS 이름,salary AS 급여,salary*nvl(commission_pct,0) AS 보너스,HIRE_DATE AS 입사월 FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY-MM') > '2007-03';

----33) 부서아이디가 100이면 부서아이디 오른쪽에 '우수부서'를 붙여서 사원명과 함께 출력하시오.
SELECT first_name AS 이름,DECODE(department_id,100,department_id||'(우수부서)',DEPARTMENT_ID) AS 부서 FROM EMPLOYEES;
SELECT first_name AS 이름,DEPARTMENT_ID||decode(DEPARTMENT_ID,100,'(우수부서)')AS 부서 FROM EMPLOYEES;

---34) 사원명,급여,보너스를 출력하되,부서코드가 100이면 보너스를 급여의 50% 아니면 급여의 10%를 지급하도록 조회.
SELECT first_name AS 이름,salary AS 급여,decode(department_id,100,salary*0.5,salary*0.1) AS 보너스,decode(department_id,100,'50%','10%') AS 보너스수치 FROM EMPLOYEES;

---35) 사원명, 급여를 출력하되 급여가 15000원 이상이면 '(고액연봉자)',5000미만인경우는'(저소득사원)'문장을 함께 출력
SELECT first_name AS 이름,salary AS 급여,CASE WHEN salary>=15000 THEN '(고액연봉자)' WHEN salary<5000 then'(저소득사원)' ELSE '(보통사원)' END "급여별사원평가"  FROM EMPLOYEES;

----locations 를 사용해 풀어보세요
--36) 우편번호에 영문자가 들어 있는 정보를 조회하시오.
SELECT * FROM LOCATIONS WHERE REGEXP_LIKE(POSTAL_CODE,'[a-zA-Z]'); 

---37) 우편번호가 영문자로 시작하는 정보를 조회하시오.
SELECT * FROM LOCATIONS WHERE REGEXP_LIKE(POSTAL_CODE,'^[a-zA-Z]'); 

--38) 직원 전체 인원수를 조회하시오 null 값은 조회 x
SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES;

--39) 3월에 입사한 직원수를 조회 
SELECT  COUNT(EMPLOYEE_ID) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'MM') = '03';

---40) 전직원의 급여합계를 조회
SELECT SUM(SALARY) FROM EMPLOYEES;

----41) 전직원의 평균합계를 조회
SELECT  AVG(NVL(SALARY,0)) FROM EMPLOYEES;