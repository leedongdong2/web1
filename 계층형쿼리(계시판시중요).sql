---------------------------------------------------------------
---계층형 쿼리
---------------------------------------------------------------

SELECT LEVEL ,e.EMPLOYEE_ID,LPAD(' ',LEVEL*3,' ') ||e.FIRST_NAME,e.MANAGER_ID FROM EMPLOYEES e 
--시작점
START WITH manager_id IS NULL -- level1
-- 연결  prior(하위)
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
--정렬 order siblings by 계층마다 정렬
ORDER siblings BY manager_id ; 

---계층형 쿼리와 페이징 처리      3중쿼리 셀렉트문      ((메인)계층형 쿼리작업(선택,조건) → 순서를 지정 → 페이징처리)
-- 1페이지 2페이지 등 내가 표시하고 싶은 범위를 나타낸다

SELECT  * FROM (
SELECT ROWNUM rn,a.*FROM 
(SELECT rownum,LEVEL,e.EMPLOYEE_ID,LPAD(' ',LEVEL*3,' ') ||e.FIRST_NAME,e.MANAGER_ID 
FROM EMPLOYEES e 
--시작점
START WITH manager_id IS NULL -- level1
-- 연결  prior(하위)
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
--정렬 order siblings by 계층마다 정렬
ORDER BY manager_id) a 
)WHERE rn BETWEEN 1 AND 10;