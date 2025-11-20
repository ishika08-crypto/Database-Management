create database first_code;
use first_code;
CREATE TABLE student
	(
		first_name varchar(30),
		last_name varchar(30),
		roll_no int,
		dob date
	);
INSERT INTO student(first_name,last_name,roll_no,dob) 
VALUES
("Saksham","Chaudhary",1, "2010-11-15"),
("Ayush","Dubey",2, "2005-09-07"),
("Ishika","Choudhary",3,"2006-02-06");
set sql_safe_updates=0;
SELECT * FROM student;
drop table student;
ALTER TABLE student ADD email varchar(30);      					-- to add a new column
ALTER TABLE student MODIFY email int;								-- to change data type of a column
ALTER TABLE student CHANGE email email_id varchar(30);				-- to rename the column
ALTER TABLE student MODIFY email_id varchar(30) AFTER last_name;	-- modifying the column position
ALTER TABLE student DROP COLUMN email_id;							-- to delete a column
ALTER TABLE student RENAME COLUMN roll_no to roll_id;				-- to rename a column using rename
ALTER TABLE student RENAME student_1;								-- to rename table
TRUNCATE TABLE student_1;											-- to delete the rows in table
DROP TABLE student_1;												-- to delete the whole table