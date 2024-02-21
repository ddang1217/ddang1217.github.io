/*
    Name: Danny Dang
    DTSC660: Data and Database Managment with SQL
    Module 8
    Assignment 7
	I Chose Netflix dataset because it looked the cleanest.

*/



--------------------------------------------------------------------------------
/*				                 Table Creation		  		          */
--------------------------------------------------------------------------------
CREATE TABLE netflix(
    show_id char(5),
	type_show varchar(8),
	title varchar(255),
	director varchar(255),
	country varchar(40),
	date_added date,
	release_year char(4),
	rating char(8),
	duration varchar(40),
	listed_in varchar(255)
	);

    
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
/*				                 Import Data           		  		          */
--------------------------------------------------------------------------------

COPY netflix
FROM 'C:\Users\Public\netflix.csv'
WITH (FORMAT CSV,HEADER);
--------------------------------------------------------------------------------
/*SELECT COUNT(*)
FROM netflix; */

--------------------------------------------------------------------------------
/*				                 Question 1: 		  		          */
-------------------------------------------------------------------------------
--Create a backup of your imported table
CREATE TABLE netflix_backup AS SELECT * FROM netflix;
/*SELECT (SELECT COUNT(*) FROM netflix) AS "original", (SELECT count(*) from netflix_backup) AS "backup";*/


    
--------------------------------------------------------------------------------
/*				                  Question 2           		  		          */
--------------------------------------------------------------------------------
--Create a duplicate column in the table
ALTER TABLE netflix ADD COLUMN rating2 char(8);
UPDATE netflix SET rating2 = rating;    


--------------------------------------------------------------------------------
/*				                  Question 3           		  		          */
--------------------------------------------------------------------------------
/*Locate and update values representing missing data in one column and perform ONE of
the following modifications:
a. Change values so that they are correctly labeled and recognized by SQL as
NULL values
b. Change their values to another value that accurately represents or reflects the
data (such as substituting the mean of the column for the value)
c. Remove the data containing null values */

SELECT COUNT(*)
FROM netflix;
-- total count of rows (8790)

SELECT *
FROM netflix
WHERE director = 'Not Given';
-- confirm the number of rows that have directors as "not given" (2588 rows)

UPDATE netflix 
SET director = NULL
WHERE director = 'Not Given';
-- director that have Not Given in their row updates to a null values instead

SELECT COUNT(director)
FROM netflix
WHERE director NOTNULL;
/* To check work I find the directors that are not null(6202) and by subtracting the total (8790) I get
2588 rows which means all my conversions to null value worked correctly. */

   
   
   
   
--------------------------------------------------------------------------------
/*				                  Question 4           		  		          */
--------------------------------------------------------------------------------
--Perform step 3 using a different method (e.g. a, b or c from above) on a different column. I chose "Remove the data containing null values"
SELECT COUNT(country)
FROM netflix
WHERE country = 'Not Given';
-- confirm the number of rows that have country as "not given" (287 rows)

UPDATE netflix 
SET country = NULL
WHERE country = 'Not Given';
-- country that have Not Given in their row updates to a null value instead

DELETE FROM netflix WHERE country IS NULL;
-- deletes countries that have null values 


SELECT COUNT(country)
FROM netflix;
/* We got the total from question 3 (8790) subtract the 287 rows with null values in our country column
and our new total should be 8503. Running the above query gets us our new total count for the entire table ensuring its validity */





   

--------------------------------------------------------------------------------
/*				                  Question 5           		  		          */
--------------------------------------------------------------------------------
SELECT title
FROM netflix
WHERE title LIKE 'Pok%';
-- Finds all titles of Pokemon

SELECT title
FROM netflix
WHERE title LIKE '%Journeys: The Series%';
/* I wanted to change "The Series" part because there is already a Pokemon the Series which makes it redundant
therefore anything that has "The Series" at the end will be cut off */

--use transition to test changes
START TRANSACTION;


UPDATE netflix
SET title = 'Pokémon Journeys'
WHERE title = 'Pokémon Journeys: The Series';

UPDATE netflix
SET title = 'Pokémon Master Journeys'
WHERE title = 'Pokémon Master Journeys: The Series';

SELECT title
FROM netflix
WHERE title LIKE 'Pok%';


ROLLBACK; 
COMMIT;
-- Now I repeat the code to permanently alter my table and commit my code


SELECT title
FROM netflix
WHERE title LIKE 'Pok%';
--recheck to see if the Pokemon Journeys and Master Journeys changed

--------------------------------------------------------------------------------
/*				                  Question 6           		  		          */
--------------------------------------------------------------------------------
SELECT * 
FROM netflix 
WHERE director LIKE '%Tosh%';
/*  When I researched Daniel 'Tosh' Gintoga, he didn't have apostrophes in his name and kept it as 
Daniel Tosh Gintoga. He does keep Tosh as a nickname, so I will still keep the Tosh in. */



--transaction to test changes
START TRANSACTION;


UPDATE netflix
SET director = 'David Tosh Gitonga, Michael Jones'
WHERE director = 'David ''Tosh'' Gitonga, Michael Jones';
/* Updating David 'Tosh' Gintoga to just David Tosh Gintoga as that is what he is referred to online. */


SELECT *
FROM netflix 
WHERE show_id = 's1837';
-- Because his name changed, in order to view his name we must refer to the show_id instead */

ROLLBACK; 
COMMIT;


--------------------------------------------------------------------------------
/*				                  Question 7         		  		          */
--------------------------------------------------------------------------------
SELECT *
FROM netflix;
/* The data was too sufficiently cleaned, so I didn't know how to transform this data 
so that it would be better for analysis. I decided to just drop the duplicate column as it would 
just be redundant. */


--transaction to test changes
START TRANSACTION;

ALTER TABLE netflix DROP COLUMN rating2;
--Q3 made it so you add a duplicate column, but for analysis I should remove it.


SELECT *
FROM netflix;
-- to view if changes went through

ROLLBACK; 
COMMIT;






