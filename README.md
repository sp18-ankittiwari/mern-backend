### Backend Journey 

## Day1
What is Node.js?
Node.js is an open-source, cross-platform JavaScript runtime environment that allows you to run JavaScript on the server side. It’s built on Chrome’s V8 JavaScript engine and is designed for building scalable network applications.

Runtime Environment
Node.js provides a runtime environment for executing JavaScript code outside of a browser. It includes libraries and APIs that enable interaction with the file system, network, and more.

V8 Engine
The V8 engine is Google’s high-performance JavaScript and WebAssembly engine, written in C++. Node.js uses it to compile JavaScript directly to native machine code for fast execution.

Setting Up the Environment
Installing Node.js and npm and nvm

npm (Node Package Manager) is bundled with Node.js and is used to manage project dependencies.

To verify installation:
node -v
npm -v

Node.js Architecture 
Node.js is single-threaded but uses libuv to handle async tasks in the background.
Uses an Event Loop to handle tasks like reading files, APIs, etc.
For heavy tasks (like file reading), Node uses a Thread Pool behind the scenes.

Running JavaScript with Node.js (REPL)
You can run JavaScript code directly in the terminal using Node's REPL (Read-Eval-Print Loop):
node
console.log("Hello, Node.js")
Press Ctrl + C twice to exit REPL.

Node.js Modules
Core Modules
Built into Node.js (e.g., fs, os, path).

Local Modules
Modules you create in your project files.

Third-Party Modules
Installed via npm (e.g., express, router).

Setting Up a Node.js Project
Initialize a New Project
npm init

package.json
Defines project metadata, scripts, and dependencies.
# Make package.json Beautiful

package.lock.json 
package-lock.json ensures consistent installs by locking the exact versions of dependencies and their sub-dependencies.

node_modules
A folder that stores all installed npm packages and their dependencies.




## Day2 
What is Express.js?
Express.js is a web framework for Node.js.
It helps you build web servers and APIs quickly and easily.
Simplifies routing and request handling.
Easy to use and lightweight.
Built on top of Node.js — faster development.

Setting Up an Express Project
Initialize the project:
npm install express

Middleware in Express
Middleware is a function that runs between the request and the response.

Built-in Middleware
app.use(express.json()); // parses JSON in request body
app.use(express.urlencoded({ extended: true })); // parses form data

Custom Middleware
app.use((req, res, next) => {
  console.log('Hello Middleware');
  next(); // pass to next middleware handler
});

Routing Basics
Express routes define how your app responds to different HTTP methods.
Common Methods:
app.get('/', (req, res) => { ... });     // Read
app.post('/', (req, res) => { ... });    // Create
app.put('/', (req, res) => { ... });     // Update
app.delete('/', (req, res) => { ... });  // Delete

Route Parameters or Path Parameter
Used to capture values from the URL.
app.get('/user/:id', (req, res) => {
  res.send(`User ID is ${req.params.id}`);
});
Visit: /user/123 → "User ID is 123"

Query Parameters
Used to pass data in the URL after ?.
app.get('/search', (req, res) => {
  res.send(`You searched for ${req.query.q}`);
});
Visit: /search?q=node → "You searched for node"

# Do intial setup for the project




## Day-3
Route Grouping with express.Router()
Express allows you to split your routes into multiple files using the built-in Router class. This makes your code modular and easier to manage.

Dynamic Routes and Parameters
Dynamic parameters are specified in the route with a colon : and can be accessed via req.params.

app.get('/product/:productId', (req, res) => {
  const { productId } = req.params;
  res.send(`Product ID: ${productId}`);
});
Working with HTTP Methods
Express supports all major HTTP methods:

app.get('/', (req, res) => res.send('GET Request'));
app.post('/', (req, res) => res.send('POST Request'));
app.put('/', (req, res) => res.send('PUT Request'));
app.delete('/', (req, res) => res.send('DELETE Request'));
Each method is used for a specific action in RESTful APIs (Read, Create, Update, Delete).

Error Handling in Express
Handling errors properly improves debugging and UX.
app.use((req, res) => {
  res.status(404).send('404 Not Found');
});
Custom Error Handler Middleware
app.use((err, req, res, next) => {
  console.error('Error:', err.message);
  res.status(500).json({ error: 'Internal Server Error' });
});

Serving Static Files
To serve static HTML, CSS, images, etc., use:
app.use(express.static('public'));
Create a public/ folder and put your assets inside. Access them directly via the browser, e.g., http://localhost:3000/index.html.

Handling Forms and JSON Input
Enable Body Parsers
app.use(express.urlencoded({ extended: true })); // Parses form data
app.use(express.json());                         // Parses JSON body
Example: Handle a Form Submission
HTML Form:
<form action="/submit" method="POST">
  <input name="username" />
  <button type="submit">Submit</button>
</form>
Server:
app.post('/submit', (req, res) => {
  res.send(`Received username: ${req.body.username}`);
});

Async/Await & Promises
Why Use Async?
Node.js handles async operations like file access, DB calls, or API requests. Instead of blocking the server, async code allows other tasks to continue.

 Promises
A Promise is an object that represents the eventual completion (or failure) of an async operation.
const fetchData = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => resolve("Data loaded"), 1000);
  });
};

fetchData()
  .then(data => console.log(data))
  .catch(err => console.error(err));
Async/Await
Cleaner syntax for working with Promises:

app.get('/async', async (req, res) => {
  try {
    const result = await fetchData();
    res.send(result);
  } catch (err) {
    res.status(500).send('Error occurred');
  }
});

Common Promise Methods
Method	Description
Promise.all()	Waits for all promises to resolve
Promise.race()	Resolves/rejects as soon as one settles
Promise.allSettled()	Returns result for each promise, success or fail
Promise.any()	Resolves when any one promise resolves









## Day-4

- Connecting to MongoDB
Used the mongoose library to connect to a MongoDB database.
Stored the MongoDB URI in an .env file for security and reusability.
Created a separate configuration file (db.js) to handle the database connection logic.
Handled successful and failed connection scenarios with appropriate console messages.

- Understanding Mongoose Models and Schemas
Defined schemas using mongoose.Schema to structure how data should look in MongoDB.
Added validation rules (e.g., required fields, default values) in the schema.
Converted schemas into models, which are used to interact with MongoDB collections.
Followed a modular approach by separating models into their own files.

- CRUD Operations with MongoDB
Implemented full CRUD (Create, Read, Update, Delete) operations using Express routes and Mongoose:

- Create
Created new documents in the MongoDB collection using the .create() method.
Accepted JSON data from the request body.

- Read
Fetched all documents using .find().
Retrieved a single document using .findById().
Handled cases when the requested document does not exist.

- Update
Updated documents using .findByIdAndUpdate().
Ensured updated values are returned using the { new: true } option.
Used { runValidators: true } to enforce schema validation during updates.

- Delete
Deleted a document by its ID using .findByIdAndDelete().
Returned appropriate success or error messages based on the operation outcome.



## Day 5
- Overview
Today's focus was on building a clean and scalable backend API using Express.js and MongoDB, following best practices like MVC architecture, error handling, and API testing.

- Structuring the Project (MVC Architecture)
Followed the Model-View-Controller (MVC) pattern to separate concerns.

Models: Handle MongoDB schema and data logic.
Controllers: Contain business logic and data manipulation.
Routes: Handle endpoint definitions and routing requests to controllers.

- Key Takeaways
Built a functional and clean CRUD API using Express and MongoDB.
Followed MVC architecture for better maintainability and scalability.
Tested API endpoints thoroughly using Postman.
Implemented proper error handling and used async/await syntax.
Secured configuration using environment variables.




# HTTP Status Codes Summary

| Class         |   Code | Name                          | Description                                          |
|:--------------|-------:|:------------------------------|:-----------------------------------------------------|
| Informational |    100 | Continue                      | Client should continue with the request.             |
| Informational |    101 | Switching Protocols           | Server switches protocols per client's request.      |
| Informational |    102 | Processing                    | Request received, no response available yet.         |
| Informational |    103 | Early Hints                   | Server suggests preload resources.                   |
| Successful    |    200 | OK                            | Request succeeded. Response depends on HTTP method.  |
| Successful    |    201 | Created                       | Request succeeded and a new resource was created.    |
| Successful    |    202 | Accepted                      | Request accepted but not yet acted upon.             |
| Successful    |    203 | Non-Authoritative Information | Metadata from local or third-party copy.             |
| Successful    |    204 | No Content                    | No content to send for this request.                 |
| Successful    |    205 | Reset Content                 | Reset the document view which sent the request.      |
| Successful    |    206 | Partial Content               | Partial response to a range request.                 |
| Successful    |    207 | Multi-Status                  | Multiple responses for WebDAV.                       |
| Successful    |    208 | Already Reported              | Avoid repeated enumeration in WebDAV.                |
| Successful    |    226 | IM Used                       | GET response with delta encoding.                    |
| Redirection   |    300 | Multiple Choices              | Client must choose one of multiple responses.        |
| Redirection   |    301 | Moved Permanently             | Resource has been permanently moved.                 |
| Redirection   |    302 | Found                         | Resource temporarily located at different URI.       |
| Redirection   |    303 | See Other                     | Redirect to another URI using GET.                   |
| Redirection   |    304 | Not Modified                  | Response not modified; use cached version.           |
| Redirection   |    305 | Use Proxy                     | Must use a proxy to access the resource.             |
| Redirection   |    306 | Unused                        | Code reserved but no longer used.                    |
| Redirection   |    307 | Temporary Redirect            | Use same method to access different URI temporarily. |
| Redirection   |    308 | Permanent Redirect            | Resource now permanently at another URI.             |
| Client Error  |    400 | Bad Request                   | Client sent invalid request.                         |
| Client Error  |    401 | Unauthorized                  | Authentication is required.                          |
| Client Error  |    402 | Payment Required              | Reserved for future use.                             |
| Client Error  |    403 | Forbidden                     | Client does not have access rights.                  |
| Client Error  |    404 | Not Found                     | Server can't find the requested resource.            |
| Client Error  |    405 | Method Not Allowed            | Request method not supported by the resource.        |
| Client Error  |    406 | Not Acceptable                | No acceptable representation found.                  |
| Client Error  |    407 | Proxy Authentication Required | Authenticate with proxy first.                       |
| Client Error  |    408 | Request Timeout               | Server timed out waiting for request.                |
| Client Error  |    409 | Conflict                      | Request conflicts with server state.                 |
| Client Error  |    410 | Gone                          | Resource permanently deleted.                        |
| Client Error  |    411 | Length Required               | Content-Length header is missing.                    |
| Client Error  |    412 | Precondition Failed           | Request preconditions not met.                       |
| Client Error  |    413 | Content Too Large             | Request body is too large.                           |
| Client Error  |    414 | URI Too Long                  | Requested URI too long to handle.                    |
| Client Error  |    415 | Unsupported Media Type        | Server doesn't support the data format.              |
| Client Error  |    416 | Range Not Satisfiable         | Requested range is invalid.                          |
| Client Error  |    417 | Expectation Failed            | Expect request-header can't be met.                  |
| Client Error  |    418 | I'm a teapot                  | Server refuses to brew coffee with a teapot.         |
| Server Error  |    500 | Internal Server Error         | Generic server error.                                |
| Server Error  |    501 | Not Implemented               | Server doesn't support the method.                   |
| Server Error  |    502 | Bad Gateway                   | Invalid response from upstream server.               |
| Server Error  |    503 | Service Unavailable           | Server is overloaded or down.                        |
| Server Error  |    504 | Gateway Timeout               | Server didn't get response in time.                  |
| Server Error  |    505 | HTTP Version Not Supported    | Server doesn't support HTTP version.                 |

## Day 6, 7
i have completed the PMS task and generate the PR


## day 8 
SQL Overview
SQL = Structured Query Language
Used for managing and querying relational databases
Common dialects: PostgreSQL

- Database Terminology
Database: A structured collection of related data
Table: Stores data in rows and columns
Row: A single record (entry)
Column: An attribute or field
Primary Key: Uniquely identifies each row
Foreign Key: References the primary key in another table to establish relationships

- Environment Setup
Install PostgreSQL 
Verify installation using:
PostgreSQL: psql
Create a test database:
CREATE DATABASE testdb;
- Basic SQL Commands
CREATE TABLE – Create a new table
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100) UNIQUE,
birthdate DATE,
is_active BOOLEAN
);
DROP TABLE – Delete a table
DROP TABLE users;
ALTER TABLE – Modify a table structure
ALTER TABLE users ADD COLUMN signup_date DATE;
- Common SQL Data Types
INT – Integer numbers
VARCHAR(n) – Variable-length string (max n characters)
DATE – Date (YYYY-MM-DD)
BOOLEAN – True/False
SERIAL – Auto-incrementing integer (PostgreSQL)


## Day 9

 Data Manipulation Language (DML) Commands
1. INSERT
Adds new rows into a table.
Syntax:
INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
2. UPDATE
Modifies existing records in a table.
Use with WHERE to target specific rows.
Syntax:
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
Example:
3. DELETE
Removes rows from a table.
Use with WHERE to avoid deleting all records.
Syntax:
DELETE FROM table_name WHERE condition;
4. TRUNCATE
Deletes all rows from a table instantly and resets identity (auto-increment) columns.
Cannot be rolled back (in most databases).
TRUNCATE TABLE table_name;
- Basic Data Querying
5. SELECT
Retrieves data from one or more tables.
Syntax:
SELECT column1, column2 FROM table_name;
6. WHERE
Filters results based on a condition.
Syntax:
SELECT * FROM table_name WHERE condition;
7. ORDER BY
Sorts the result set by one or more columns.
Default is ascending (ASC); use DESC for descending.
Syntax:
SELECT * FROM users ORDER BY name ASC;
8. LIMIT
Limits the number of rows returned.
Useful for pagination or sampling data.
Syntax:
SELECT * FROM users LIMIT 10;
9. DISTINCT
Removes duplicate values from the result set.
Syntax:
SELECT DISTINCT column_name FROM table_name;
- Logical Operators in WHERE Clause
10. AND
Combines conditions – all must be true.
SELECT * FROM users WHERE is_active = true AND country = 'USA';
11. OR
Combines conditions – at least one must be true.
SELECT * FROM users WHERE country = 'USA' OR country = 'UK';
12. NOT
Negates a condition.
SELECT * FROM users WHERE NOT is_active;
- Tips
  > Always use WHERE with UPDATE or DELETE to avoid modifying all records.
  > Use DISTINCT only when necessary, as it can slow down large queries.
  > TRUNCATE is faster than DELETE for clearing all data, but irreversible.
  > LIMIT + ORDER BY is commonly used for pagination.


## day 10
Aggregate Functions
Used to perform calculations on multiple rows and return a single result.
1. COUNT()
Returns the number of rows.
2. SUM()
Adds all values in a numeric column.
3. AVG()
Calculates the average of numeric values.
4. MIN() / MAX()
Finds the minimum or maximum value.
- Grouping Data
5. GROUP BY
Groups rows that have the same values in specified columns.
Often used with aggregate functions.
6. HAVING
Filters groups after aggregation (like WHERE but for GROUP BY).
SELECT department, AVG(salary) FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
- Joining Tables
Used to combine rows from two or more tables based on a related column.
7. INNER JOIN
Returns matching rows from both tables.
Example:
SELECT users.name, orders.total
FROM users
INNER JOIN orders ON users.id = orders.user_id;
8. LEFT JOIN
Returns all rows from the left table, with matched rows from the right.
SELECT users.name, orders.total
FROM users
LEFT JOIN orders ON users.id = orders.user_id;
9. RIGHT JOIN
Returns all rows from the right table, with matched rows from the left.
SELECT users.name, orders.total
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
10. FULL JOIN
Returns all rows when there is a match in one of the tables.
SELECT users.name, orders.total
FROM users
FULL JOIN orders ON users.id = orders.user_id;
- Nested Queries and Subqueries
Queries inside another SQL query.
11. Subquery in SELECT
Example:
SELECT name, (SELECT COUNT(*) FROM orders WHERE orders.user_id = users.id) AS total_orders
FROM users;
12. Subquery in WHERE
Example:
SELECT name FROM users
WHERE id IN (SELECT user_id FROM orders WHERE total > 100);
13. Subquery in FROM
Used to create temporary result sets.
SELECT dept, avg_salary FROM (
  SELECT department AS dept, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
) AS sub;
- Tips
Use GROUP BY only on selected columns, and always aggregate the rest.
Use aliases for subqueries and join tables for clarity.
Be cautious with FULL JOIN—may return many NULLs.
HAVING works after aggregation, WHERE works before.  


## day 11

- Database Constraints
Constraints enforce rules at the table level to maintain data integrity and consistency.
1. PRIMARY KEY
Uniquely identifies each row in a table.
Must be unique and NOT NULL.
Only one primary key per table.
2. FOREIGN KEY
Creates a relationship between two tables.
References a primary key in another table.
Ensures referential integrity.
CREATE TABLE orders (
  id INT PRIMARY KEY,
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
3. UNIQUE
Ensures all values in a column are different.
Unlike primary key, a table can have multiple UNIQUE constraints.
4. NOT NULL
Prevents null values in a column.
5. CHECK
Validates data with a condition.
6. DEFAULT
Assigns a default value when no value is provided.
- Indexing (Performance Optimization)
7. INDEX
Improves query performance by speeding up search and filtering.
Automatically created on primary keys and unique constraints.
Manual index creation:
CREATE INDEX idx_email ON users(email);
Use wisely — too many indexes can slow down INSERT/UPDATE.

- Transactions 
Ensure data integrity during multi-step operations.
8. BEGIN / START TRANSACTION
Begins a transaction block.
9. COMMIT
Saves all changes permanently.
10. ROLLBACK
Cancels all changes since BEGIN.
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT; -- or ROLLBACK;

- Stored Procedures and Functions (Basics)
Encapsulate SQL logic for reuse and automation.
11. Stored Procedure
A set of SQL statements stored in the database.
Can accept parameters.
DELIMITER //
CREATE PROCEDURE GetUsers()
BEGIN
  SELECT * FROM users;
END //
DELIMITER ;

- Tips
Use CHECK for domain-level rules (e.g., age ≥ 18).
Always index columns used frequently in WHERE, JOIN, or ORDER BY.
Wrap COMMIT/ROLLBACK logic in error handling for safe rollbacks.
Use stored procedures to enforce complex business logic inside the database.  
  
## Day 12
Started working on school management system task and completed till evening.

- School Management System
Database Setup
Create a PostgreSQL database named: SchoolManagementSystem
Design and create the following tables:
Students
Courses
Enrollments
enrollment_id (Primary Key)
student_id (Foreign Key → Students)
course_id (Foreign Key → Courses)
enrollment_date
- Data Population
Insert at least:
10 records into the Students table
5 records into the Courses table
15 records into the Enrollments table
Use INSERT INTO SQL statements for all data entry
- Query Tasks
Retrieve the list of all students with their enrolled courses.
List all courses along with the number of students enrolled in each.
Display all students not enrolled in any course.
Get the list of students enrolled in more than one course.
Show all courses with no enrolled students.
Display the student who enrolled most recently.
- Data Modification Tasks
Update course fee for "Mathematics" to 5500.
Delete all enrollments for a student who has dropped out.
Change course duration for "Computer Science" to 18 weeks.
- Constraints & Indexing
Add a UNIQUE constraint to the phone column in the Students table.
Add an INDEX on the enrollment_date column in the Enrollments table.
Add a CHECK constraint on the fee column in the Courses table to ensure fee >= 1000.



