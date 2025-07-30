CREATE TYPE genderEnum AS ENUM ('Male', 'Female', 'Other');

CREATE TABLE "students" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "age" INT CHECK ("age" > 3 AND "age" < 80),
  "gender" genderEnum NOT NULL,
  "email" VARCHAR(50) NOT NULL UNIQUE,
  "phone" VARCHAR(15)
);

CREATE TABLE "courses" (
  "id" SERIAL PRIMARY KEY,
  "courseName" VARCHAR(100) NOT NULL,
  "duration" INTERVAL,
  "fee" DECIMAL(10, 2)
);

CREATE TABLE "enrollments" (
  "enrollmentId" SERIAL PRIMARY KEY,
  "studentId" INT NOT NULL,
  "courseId" INT NOT NULL,
  "enrollmentDate" DATE NOT NULL,
  FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE CASCADE,
  FOREIGN KEY ("courseId") REFERENCES "courses"("id") ON DELETE CASCADE
);

INSERT INTO "students" ("name", "age", "gender", "email", "phone") VALUES
('Ankit Tiwari', 23, 'male', 'ankit.tiwari@example.com', '9315842574'),
('Riya Sharma', 22, 'female', 'riya.sharma@example.com', '9876543210'),
('Mohit Verma', 21, 'male', 'mohit.verma@example.com', '9123456780'),
('Sneha Singh', 24, 'female', 'sneha.singh@example.com', '9001122233'),
('Aditya Mehra', 20, 'male', 'aditya.mehra@example.com', '9556677889'),
('Pooja Patel', 23, 'female', 'pooja.patel@example.com', '9898989898'),
('Karan Kapoor', 25, 'male', 'karan.kapoor@example.com', '9000000001'),
('Meena Kumari', 22, 'female', 'meena.kumari@example.com', '9333311111'),
('Rahul Yadav', 21, 'male', 'rahul.yadav@example.com', '9888777666'),
('Neha Bansal', 23, 'female', 'neha.bansal@example.com', '9776655443');

INSERT INTO "courses" ("courseName", "duration", "fee") VALUES
('Full Stack Web Development', INTERVAL '3 months', 15000.00),
('Data Science & Analytics', INTERVAL '6 months', 30000.00),
('Cybersecurity Essentials', INTERVAL '4 months', 25000.50),
('Cloud Computing with AWS', INTERVAL '5 months', 28000.75),
('Machine Learning Advanced', INTERVAL '6 months', 32000.99);

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


UPDATE courses set fee=55000.00 where course_name='Cybersecurity';
select * from courses;