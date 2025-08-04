-- Create gender ENUM type
CREATE TYPE genderEnum AS ENUM ('Male', 'Female', 'Other');
-- Create enrollmentStatus ENUM type
CREATE TYPE enrollmentStatus AS ENUM ('Enrolled', 'Dropped', 'Completed');

-- Create students table
CREATE TABLE "students" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "age" INT CHECK ("age" > 3 AND "age" < 80),
  "gender" genderEnum NOT NULL,
  "email" VARCHAR(50) NOT NULL UNIQUE,
  "phone" VARCHAR(15)
);

-- Create courses table
CREATE TABLE "courses" (
  "id" SERIAL PRIMARY KEY,
  "courseName" VARCHAR(100) NOT NULL,
  "duration" INTERVAL,
  "fee" DECIMAL(10, 2)
);

-- Create enrollments table
CREATE TABLE "enrollments" (
  "enrollmentId" SERIAL PRIMARY KEY,
  "studentId" INT NOT NULL,
  "courseId" INT NOT NULL,
  "enrollmentDate" DATE NOT NULL,
  FOREIGN KEY ("studentId") REFERENCES "students"("id"),
  FOREIGN KEY ("courseId") REFERENCES "courses"("id")
);

-- create studentstatus table
CREATE TABLE "studentStatus" (
  "id" SERIAL PRIMARY KEY,
  "enrollmentId" INT NOT NULL,
  "status" enrollmentstatus NOT NULL,
  "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("enrollmentId") REFERENCES enrollments("enrollmentId")
);

-- Insert students
INSERT INTO "students" ("name", "age", "gender", "email", "phone") VALUES
('Ankit Tiwari', 23, 'Male', 'ankit.tiwari@example.com', '9315842574'),
('Riya Sharma', 22, 'Female', 'riya.sharma@example.com', '9876543210'),
('Mohit Verma', 21, 'Male', 'mohit.verma@example.com', '9123456780'),
('Sneha Singh', 24, 'Female', 'sneha.singh@example.com', '9001122233'),
('Aditya Mehra', 20, 'Male', 'aditya.mehra@example.com', '9556677889'),
('Pooja Patel', 23, 'Female', 'pooja.patel@example.com', '9898989898'),
('Karan Kapoor', 25, 'Male', 'karan.kapoor@example.com', '9000000001'),
('Meena Kumari', 22, 'Female', 'meena.kumari@example.com', '9333311111'),
('Rahul Yadav', 21, 'Male', 'rahul.yadav@example.com', '9888777666'),
('Neha Bansal', 23, 'Female', 'neha.bansal@example.com', '9776655443');

-- Insert courses
INSERT INTO "courses" ("courseName", "duration", "fee") VALUES
('Full Stack Web Development', INTERVAL '3 months', 15000.00),
('Data Science & Analytics', INTERVAL '6 months', 30000.00),
('Cybersecurity Essentials', INTERVAL '4 months', 25000.50),
('Cloud Computing with AWS', INTERVAL '5 months', 28000.75),
('Machine Learning Advanced', INTERVAL '6 months', 32000.99);

-- Insert enrollments
INSERT INTO "enrollments" ("studentId", "courseId", "enrollmentDate") VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-02-10'),
(3, 3, '2024-03-05'),
(4, 4, '2024-01-20'),
(5, 5, '2024-03-15'),
(6, 1, '2024-02-25'),
(7, 2, '2024-04-01'),
(8, 3, '2024-05-12'),
(9, 4, '2024-06-08'),
(10, 5, '2024-06-18'),
(1, 2, '2024-04-11'),
(2, 3, '2024-05-03'),
(3, 1, '2024-06-01'),
(4, 5, '2024-07-07'),
(5, 4, '2024-07-15');

-- insert student status
INSERT INTO "studentStatus" ("enrollmentId", "status") VALUES
(2, 'Enrolled'),
(3, 'Dropped'),
(4, 'Completed'),
(5, 'Enrolled'),
(6, 'Dropped'),
(7, 'Completed'),
(8, 'Enrolled'),
(9, 'Dropped'),
(10, 'Completed'),
(11, 'Enrolled'),
(12, 'Dropped'),
(13, 'Completed'),
(14, 'Enrolled'),
(15, 'Dropped');

-- Add timestamps to courses table
ALTER TABLE courses 
ADD COLUMN "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN "updatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add timestamps to students table
ALTER TABLE students 
ADD COLUMN "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN "updatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add timestamps to enrollments table
ALTER TABLE enrollments 
ADD COLUMN "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN "updatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add status column
ALTER TABLE enrollments
ADD COLUMN "status" enrollmentStatus DEFAULT 'Enrolled';

-- Query Tasks
-- Student details with their course info
SELECT 
s."name",
s."age",
s."gender",
s."email",
s."phone",
c."courseName",
c."duration",
c."fee"
FROM 
students AS s
LEFT JOIN enrollments AS e 
ON s."id" = e."studentId"
LEFT JOIN courses AS c 
ON e."courseId" = c."id";

-- Total students enrolled per course
SELECT 
c."id" AS courseId,
c."courseName",
COUNT(e."studentId") AS totalStudents
FROM 
courses AS c
LEFT JOIN enrollments AS e 
ON c."id" = e."courseId"
GROUP BY 
c."id", c."courseName";

-- Students not enrolled in any course
SELECT 
s."id" AS studentId,
s."name",
s."age",
s."gender",
s."email",
s."phone"
FROM 
students AS s
LEFT JOIN enrollments AS e 
ON s."id" = e."studentId"
WHERE 
e."courseId" IS NULL;

-- Students enrolled in more than one course
SELECT  
s."name" AS studentName,  
COUNT(e."courseId") AS totalCourses  
FROM students AS s  
LEFT JOIN enrollments AS e  
ON s."id" = e."studentId"  
GROUP BY s."id", s."name"  
HAVING COUNT(e."courseId") > 1;

-- Courses with no students enrolled
SELECT 
c."id" AS courseId,
c."courseName" AS courseName
FROM courses AS c 
LEFT JOIN enrollments AS e
ON c."id" = e."courseId"
WHERE e."studentId" IS NULL;

-- Most recently enrolled student
SELECT 
s."name",
e."enrollmentDate"
FROM students AS s 
LEFT JOIN enrollments AS e
ON s."id" = e."studentId"
ORDER BY e."enrollmentDate" DESC 
LIMIT 1;


-- modification
-- Update fee for "Full Stack Web Development"
UPDATE courses
SET "fee" = 50000
WHERE "courseName" = 'Full Stack Web Development';

-- Remove all enrollments of a student who has dropped out.
DELETE FROM enrollments
WHERE "studentId" IN (
  SELECT e."studentId"
  FROM enrollments e
  JOIN studentStatus s ON e."enrollmentId" = s."enrollmentId"
  GROUP BY e."studentId"
  HAVING COUNT(*) = COUNT(*) FILTER (WHERE s."status" = 'Dropped')
);

-- Update duration for "Data Science & Analytics"
UPDATE courses
SET "duration" = INTERVAL '12 months'
WHERE "courseName" = 'Data Science & Analytics';


-- add contraint and index 
-- Make phone number in students table unique
ALTER TABLE students
ADD CONSTRAINT unique_phone
UNIQUE ("phone");

-- Index on enrollmentDate for faster queries
CREATE INDEX indexDate
ON enrollments ("enrollmentDate");

-- Ensure course fee is at least 1000
ALTER TABLE courses
ADD CONSTRAINT minFee
CHECK ("fee" >= 1000);


-- basic practice query 
-- count 
SELECT gender, COUNT(*) AS totalStudents
FROM students
GROUP BY gender;

-- avg
SELECT gender, AVG(age) AS avgAge
FROM students
GROUP BY gender;

--max and min age 
SELECT gender, MAX(age) AS maxAge, MIN(age) AS minAge
FROM students
GROUP BY gender;

-- sum
SELECT gender, SUM(age) AS avgAge
FROM students
GROUP BY gender;

