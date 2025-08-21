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

## Day 15
What is NoSQL?

NoSQL stands for "Not Only SQL" and refers to a type of database that is non-relational, meaning it does not rely on fixed schemas and tables like traditional SQL databases. It is designed for flexibility, scalability, and handling large amounts of unstructured or semi-structured data. NoSQL databases are especially useful in real-time applications and big data environments.

 Types of NoSQL Databases
- There are four main types of NoSQL databases:
- Document-Oriented Databases – Store data as JSON-like documents (e.g., MongoDB, CouchDB).
- Key-Value Stores – Store data as simple key-value pairs (e.g., Redis, DynamoDB).
- Column-Family Stores – Organize data into columns rather than rows (e.g., Apache Cassandra, HBase).
- Graph Databases – Store data as nodes and edges, making them ideal for relationships (e.g., Neo4j, ArangoDB).

- Introduction to MongoDB

MongoDB is a document-oriented NoSQL database that stores data in a flexible, JSON-like format called BSON (Binary JSON). It is highly scalable, supports replication and sharding, and provides a powerful query language. Its schema-less nature allows developers to quickly adapt to changing requirements without restructuring the entire database.

- Document-Based Model and BSON Format

In MongoDB:
A document is a single record, similar to a row in SQL.
A collection is a group of documents, similar to a table in SQL.
Data is stored in BSON (Binary JSON), which is a binary representation of JSON, optimized for performance.
Example:
{
  "_id": "12345",
  "name": "Alice",
  "age": 25,
  "skills": ["MongoDB", "Node.js", "React"]
}
- Installing MongoDB and Setting up the Environment
Start the MongoDB service:
net start MongoDB             # Windows  

- Using MongoDB Compass (GUI)
MongoDB Compass is a graphical interface to interact with MongoDB databases. It allows you to:
Create and manage databases and collections.
Insert, update, and delete documents visually.
Run queries without using the command line.
You can download it from the MongoDB Compass page.

- Basic MongoDB Commands
Some fundamental MongoDB shell commands include:
show dbs → Displays all databases
use <database> → Switches to (or creates) a database.
db.createCollection("name") → Creates a new collection in the selected database.
db.dropDatabase() → Deletes the current database.

## Day 16

- Understanding JSON and BSON
JSON is a human-readable format used to store and exchange data.
BSON (Binary JSON) is used internally by MongoDB, supports more types (e.g., ObjectId, Date), and is faster for storage/retrieval.
- CRUD Operations (Create, Read, Update, Delete)
Create: Insert documents into a collection using .insertOne() and .insertMany().
Read: Retrieve data using .find() and .findOne().
Update: Modify data using .updateOne() and .updateMany().
Delete: Remove documents using .deleteOne() and .deleteMany().
- MongoDB Query Operators
Comparison Operators: $gt, $lt, $eq, $ne, $in, $nin (filter based on values).
Logical Operators: $and, $or, $not (combine conditions).
Element Operators: $exists, $type (check if a field exists or its data type).

## Day 17 

- Array Fields and Embedded Documents
- MongoDB supports arrays and nested documents inside documents.
- Useful for storing multiple values (like hobbies) or related data (like address).
- Querying Arrays
($size: Match documents where an array has a specific length).
($all: Match documents where the array contains all given values).
($elemMatch: Match documents with array elements satisfying multiple conditions).
- Projection (Selecting Specific Fields)
Use projection to include/exclude fields in query results.
Example: Only return name and age, hide _id.
Sorting and Limiting Results
.sort() to order results (ascending/descending).
.limit() to restrict number of results.
.skip() with .limit() for pagination.
Indexing in MongoDB
Improves query performance by avoiding full collection scans.
- Types of Indexes:
Single-field index.
Compound index (multiple fields).
Unique index (no duplicate values).
Text index (search within text fields).
Indexes make queries faster but can slow down insert/update operations.

## Day 18 

- Aggregation Framework
Used to process and analyze data in stages (pipeline).
- Common Stages:
$match: Filter documents.
$group: Group by a field and perform operations (sum, avg, count).
$sort: Order results.
$limit: Restrict number of results.
$project: Include or transform fields.
$lookup: Join two collections.
- Data Modeling in NoSQL
Embedded Documents (Denormalization): Store related data together in a single document.
 Faster reads.
 Data duplication.
References (Normalization): Store data separately and link with an ID.
 Less duplication.
Requires joins/extra queries.
- When to Use
Use Embedding when data is read together frequently (e.g., user profile + address).
Use Referencing when data is large, reused, or updated frequently (e.g., users and orders).

## Day 19 and weekend
Complete the Online Library assignment with all queries.
Revise CRUD, Query Operators, Indexing, Aggregation.

# Day 22 
- What is ORM and ODM?
- ORM (Object Relational Mapper):
Used with SQL databases (e.g., PostgreSQL, MySQL).
Maps JavaScript objects to relational database tables.
Example: Sequelize.
- ODM (Object Document Mapper):
Used with NoSQL databases (MongoDB).
Maps JavaScript objects to document-based collections.
Example: Mongoose.
- Difference between ORM (Sequelize) and ODM (Mongoose)
Sequelize works with relational databases → Tables, Rows, Foreign Keys.
Mongoose works with MongoDB → Collections, Documents, References.
Sequelize → Structured schema with relations.
Mongoose → Flexible schema with embedded/nested documents.
- Setting Up PostgreSQL with Sequelize (ORM)
Install Sequelize & CLI:
npm install sequelize pg pg-hstore
npm install --save-dev sequelize-cli
Configure Sequelize (config/config.json or .env).
Initialize Sequelize:
npx sequelize-cli init
Setting Up MongoDB with Mongoose (ODM)
Install Mongoose:
npm install mongoose
Connect using mongoose.connect(MONGO_URI).
Store URI in .env for security.
Creating Basic Models
Sequelize:
Example Models: User, Post.
Define fields with data types (STRING, INTEGER, BOOLEAN, etc.).
Mongoose:
Example Models: Product, Review.
Define schema with validation rules.

## Day 23

- Sequelize (ORM)
Migrations & Seeders
Migration = Version-controlled schema changes.
Seeder = Populating initial/sample data.
- Generate migration:
npx sequelize-cli model:generate --name User --attributes name:string,email:string
Run migration:
npx sequelize-cli db:migrate
- Adding Validations
Unique email
Password min length.
Non-null fields.
Data Seeding
npx sequelize-cli seed:generate --name demo-user
npx sequelize-cli db:seed:all
- Mongoose (ODM)
Validation Rules in Schema
Required fields.
Default values.
Correct data types
Custom Validations
Example: Price must be greater than 0.
Enum Validation
Restrict field values (e.g., category: "Electronics" | "Clothing" | "Books").

## Day 24

- Sequelize (ORM)
Types of Associations
One-to-One → User -> Profile.
One-to-Many → User -> Posts.
Many-to-Many → Post <-> Tags (through PostTags).
Eager vs Lazy Loading
Eager: Load related models immediately (include).
Lazy: Load when accessed
Cascading Deletes
- Using ON DELETE CASCADE ensures child rows are removed when parent is deleted.
Mongoose (ODM)
- Types of Relationships
One-to-Many → Array of IDs (Product -> Reviews).
One-to-One → Reference field (User -> Profile).
- Population
Replace referenced ObjectIds with actual documents using .populate().

## Day 25

- Sequelize (ORM) – Hooks
- Lifecycle Hooks
beforeCreate, beforeUpdate.
afterCreate, afterDestroy.
- Use Cases
Hashing password before saving.
Logging changes to data.
- Mongoose (ODM) – Middleware
- Pre and Post Middleware
pre('save'), post('save').
pre('findOne'), post('findOne').
- Common Use Cases
Validate/modify data before save.
Auto-set timestamps.
Populate fields automatically.
Error Handling in Middleware
Use next(err) to prevent invalid saves.
Gracefully handle validation errors.

## Day 26 and weekend

Build the Student Course Management System using Sequelize + PostgreSQL with one-to-one, one-to-many, and many-to-many relations.
Implement validations, constraints, and hooks (password hashing, auto-set dates).
Build the Library Management System using Mongoose + MongoDB with profile, borrow records, and validations.
Add hooks (auto-set dates, update copies, overdue check) and Express middleware for error handling.

## Day 29 

- Authentication vs Authorization
Authentication → Verifies who you are.
Authorization → Verifies what you can do.
- RBAC vs ABAC
RBAC → Access based on roles (Admin, User).
ABAC → Access based on attributes (age, subscription, etc).
- JWT Authentication
JWT = JSON Web Token.
Structure → Header + Payload + Signature.
Use in Express API → Login → Generate JWT → Verify JWT in routes.
- OAuth 2.0
Delegated login (Google, GitHub, etc).
Example: Google OAuth → Redirect → Token → Access user profile.

## Day 30 

RBAC (Role-Based Access Control)
Define roles → Admin, User, Editor.
Protect routes with role-based middleware.
- ABAC (Attribute-Based Access Control)
Access based on user attributes (e.g., age > 18, plan = premium).
More flexible than RBAC.
- Environment Variables Security
Use dotenv for secrets.
Never expose keys in code.
- Basic Security Practices
helmet → Secure HTTP headers.
express-rate-limit → Prevent brute force / DDoS attacks.

## Day 31 
- SOLID Principles in Node.js
S: Single Responsibility → One function = one job.
O: Open/Closed → Open for extension, closed for modification.
L: Liskov Substitution → Child classes replace parent without breaking.
I: Interface Segregation → Don’t force unnecessary methods.
D: Dependency Inversion → Depend on abstractions, not details.
- Class-based Development
Use Classes for Controllers in Express.
Apply Dependency Injection for cleaner, testable code.
- Error Handling Best Practices
Centralized error handler in Express.
Custom errors (e.g., NotFoundError, ValidationError).