CREATE DATABASE MOVIE;
USE MOVIE;
CREATE TABLE ACTOR ( ACT_ID INT, ACT_NAME VARCHAR (20), ACT_GENDER CHAR (1), PRIMARY KEY (ACT_ID)); 
CREATE TABLE DIRECTOR ( DIR_ID INT, DIR_NAME VARCHAR (20), DIR_PHONE LONG, PRIMARY KEY (DIR_ID)); 
CREATE TABLE MOVIES ( MOV_ID INT, MOV_TITLE VARCHAR (25), MOV_YEAR INT, MOV_LANG VARCHAR (12), DIR_ID INT, PRIMARY KEY (MOV_ID), FOREIGN KEY (DIR_ID) REFERENCES DIRECTOR (DIR_ID));
CREATE TABLE MOVIE_CAST ( ACT_ID INT, MOV_ID INT, AROLE VARCHAR(10), PRIMARY KEY (ACT_ID, MOV_ID), FOREIGN KEY(ACT_ID) REFERENCES ACTOR(ACT_ID) ON DELETE CASCADE, FOREIGN KEY(MOV_ID) REFERENCES MOVIES(MOV_ID) ON DELETE CASCADE); 
CREATE TABLE RATING ( MOV_ID INT, REV_STARS VARCHAR (25), PRIMARY KEY (MOV_ID), FOREIGN KEY (MOV_ID) REFERENCES MOVIES (MOV_ID));
INSERT INTO ACTOR VALUES 
(301,'ANUSHKA','F'),
(302,'PRABHAS','M'),
(303,'PUNITH','M'),
(304,'JERMY','M'); 
INSERT INTO DIRECTOR VALUES 
(60,'RAJAMOULI', 8751611001),
(61,'HITCHCOCK', 7766138911),
(62,'FARAN', 9986776531),
(63,'STEVEN SPIELBERG', 8989776530); 
INSERT INTO MOVIES VALUES 
(1001,'BAHUBALI-2', 2017,'TELAGU', 60),
(1002,'BAHUBALI-1', 2015, 'TELAGU', 60),
(1003,'AKASH', 2008, 'KANNADA', 61),
(1004,'WAR HORSE', 2011, 'ENGLISH', 63); 
INSERT INTO MOVIE_CAST VALUES 
(301, 1002, 'HEROINE'),
(301, 1001, 'HEROINE'),
(303, 1003, 'HERO'),
(303, 1002, 'GUEST'),
(304, 1004, 'HERO'); 
INSERT INTO RATING VALUES 
(1001, 4), 
(1002, 2),
(1003, 5),
(1004, 4);

SELECT MOV_TITLE 
FROM MOVIES 
WHERE DIR_ID IN (SELECT DIR_ID 
FROM DIRECTOR 
WHERE DIR_NAME = 'HITCHCOCK');

SELECT MOV_TITLE 
FROM MOVIES M, MOVIE_CAST MV 
WHERE M.MOV_ID=MV.MOV_ID AND ACT_ID IN (SELECT ACT_ID 
FROM MOVIE_CAST GROUP BY ACT_ID 
HAVING COUNT(ACT_ID)>1) 
GROUP BY MOV_TITLE 
HAVING COUNT(*)>1;

SELECT ACT_NAME, MOV_TITLE, MOV_YEAR
FROM ACTOR A 
JOIN MOVIE_CAST C 
ON A.ACT_ID=C.ACT_ID 
JOIN MOVIES M 
ON C.MOV_ID=M.MOV_ID 
WHERE M.MOV_YEAR NOT BETWEEN 2000 AND 2015;

SELECT MOV_TITLE, MAX(REV_STARS) 
FROM MOVIES 
INNER JOIN RATING USING (MOV_ID) 
GROUP BY MOV_TITLE 
HAVING MAX(REV_STARS)>0 
ORDER BY MOV_TITLE;

SELECT MOV_TITLE, MAX(REV_STARS) 
FROM MOVIES 
INNER JOIN RATING USING (MOV_ID) 
GROUP BY MOV_TITLE 
HAVING MAX(REV_STARS)>0 
ORDER BY MOV_TITLE;

UPDATE RATING 
SET REV_STARS=5 
WHERE MOV_ID IN(SELECT MOV_ID FROM MOVIES 
WHERE DIR_ID IN(SELECT DIR_ID 
FROM DIRECTOR 
WHERE DIR_NAME = 'STEVEN SPIELBERG'));