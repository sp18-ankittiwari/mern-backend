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