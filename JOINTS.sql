CREATE DATABASE JOINT;
USE JOINT;

CREATE TABLE Students
(student_id INT Primary key,
student_name varchar(20),
course_id int
);
drop table Students;
insert into Students (student_id,student_name,course_id)
value (1,"John",101),
(2,"Emma",102),
(3,"Raj",103),
(4,"Sara",NULL),
(5,"Alex",101);

create table Courses
(course_id int PRIMARY KEY,
course_name varchar(20),
instructor_id int
);
DROP TABLE COURSES;
insert into Courses (course_id,course_name,instructor_id)
value (101,"DataScience",1),
(102,"MachineLearning",2),
(103,"DatabaseSystems",3),
(104,"WebDevelopment",4);

CREATE TABLE Instructors
(instructor_id int ,
instructor_name varchar(20)
);
insert into Instructors (instructor_id,instructor_name)
value (1,"Dr.Smith"),
(2,"Dr.Miller"),
(3,"Dr.Patel"),
(4,"Dr.Brown"),
(5,"Dr.Jones");

SELECT S.STUDENT_NAME 
FROM STUDENTS S 
INNER JOIN COURSES C
ON S.COURSE_ID=C.COURSE_ID
WHERE COURSE_NAME="MACHINE LEARNINNG";

SELECT S.STUDENT_NAME, C.COURSE_NAME, A.INSTRUCTOR_NAME
FROM STUDENTS S
INNER JOIN COURSES ON S.STUDENT_NAME=C.COURSE_NAME
INNER JOIN INSTRUCTORS ON C.COURSE_NAME=A.INSTRUCTOR_NAME;

select * from courses;

SELECT s.student_name,c.course_name,COUNT(*) AS TOTAL_STUDENT
FROM students s
INNER JOIN courses c ON C.course_id=s.course_id
GROUP BY s.student_name,c.course_name
HAVING COUNT(*)>=1;



-- DISPLAY COURSES HAVING AT LEAST ONE STUDENT.

select c.course_name,s.student_name
from students s 
inner join courses c on s.course_id=c.course_id
group by s.student_name,c.course_name
having count(*)>=1;

-- SHOW INSTRUCTOR AND CORRESPONDING STUDENTS. 

select i.instructor_name,s.student_name
from students s
inner join courses c on s.course_id=c.course_id
inner join instructors i on c.instructor_id=i.instructor_id;

-- List all students with instructors whose name start with 'Dr. p'.

select s.student_name,i.instructor_name
from students s
inner join courses c on s.course_id=c.course_id
inner join instructors i on c.instructor_id=i.instructor_id
where i.instructor_name like 'Dr.p%';

-- Get all students and their courses name (including those are not enrolled)

select s.student_name,c.course_name
from students s
left join courses c on s.course_id=c.course_id;

-- Find students who are not enrolled in any courses.

select s.student_name,c.course_name
from students s 
left join courses c on s.course_id= s.course_id
where c.course_name is null;

-- list all courses and enrolled students (including courses without students).

select c.course_name,s.student_name
from courses c 
left join students s on c.course_id=s.course_id;

-- find students who are not enrolled in any courses.

select s.student_name,c.course_name
from students s
left join courses c  on s.course_id=c.course_id
where s.course_id is null; 

select s.student_name
from courses c
left join students s  on c.course_id=s.course_id
where s.course_id is null; 

-- display all courses and instructions, even if no instructor is assigned.

select c.course_name,i.instructor_name
from courses c
left join instructors i on c.instructor_id=i.instructor_id; 

-- show all instructors with their courses(even if no course).

select c.course_name,i.instructor_name
from courses c
right join instructors i on c.instructor_id=i.instructor_id; 

-- Display students and instructors (even if no courses assigned).

select s.student_name,i.instructor_name
from students s
left join courses c on s.course_id=c.course_id
left join instructors i on c.instructor_id=i.instructor_id;

select s.student_name,i.instructor_name
from students s
left join courses c on s.course_id=c.course_id
right join instructors i on c.instructor_id=i.instructor_id;

-- Display all students and courses using Right Join.

select s.student_name,c.course_name
from courses c
right join students s on s.course_id=c.course_id;
 
-- * 

select s.student_name,c.course_name
from students s
right join courses c on s.course_id=c.course_id;
 
-- * 
 
 
select s.student_name,c.course_name
from students s
left join courses c on s.course_id=c.course_id;

select s.student_name,c.course_name
from students s
inner join courses c on s.course_id=c.course_id;

-- Show all instructions and courses (ensure all courses are displayed).

select i.instructor_name,c.course_name
from instructors i
left join courses c on c.instructor_id=i.instructor_id;

select i.instructor_name,c.course_name
from courses c
left join instructors i on c.instructor_id=i.instructor_id;


select i.instructor_name,c.course_name
from instructors i
right join courses c on c.instructor_id=i.instructor_id;

select i.instructor_name,c.course_name
from instructors i
inner join courses c on c.instructor_id=i.instructor_id;


-- find all instructors with students use right join.

select i.instructor_name,s.student_name
from instructors i
right join courses c on i.instructor_id=c.instructor_id
right join students s on s.course_id=c.course_id;

-- Find all instructors with students (use right join).

select i.instructor_name,s.student_name
from instructors i
right join courses c on i.instructor_id=c.instructor_id
right join students s on s.course_id=c.course_id;

-- Display all courses and corresponding students; show null if no student.


select c.course_name,s.student_name
from students s
right join courses c on s.course_id=c.course_id;

