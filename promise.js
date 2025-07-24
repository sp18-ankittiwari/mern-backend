

const p1 = new Promise ((resolve , reject) => {
    setTimeout(()=> {
        try{
            console.log("I am inside promise1");
            resolve("Promise  is reolved by p1");
        }catch(error){
            reject("There is some error is p1");
        }
    } , 2000);
});



const p2 = new Promise ((resolve , reject) => {
    setTimeout(()=> {
        try{
            console.log("I am inside promise2");
            resolve("Promise reolved in p2");
        }catch(error){
            reject("There is some error is p2");
        }
    } , 3000);
});


const p3 = new Promise ((resolve , reject) => {
    setTimeout(()=> {
        try{
            console.log("I am inside promise3");
            resolve("Promise  is reolved in p3");
        }catch(error){
            reject("There is some error is p3");
        }
    } , 4000);
});




const p4 = new Promise ((resolve , reject) => {
    setTimeout(()=> {
        try{
            // resolve("Inside p4");
            throw new Error("Error inside p4");
        }catch(error){
            reject("There is some error is p4" + error);
        }
    } , 5000);
});

p4.then ((res) => {
    console.log(res);
})
.catch((error) => {
    console.log("Something Wrong inside p4" + error);
});


//Promise.all
var output = Promise.all([p1 , p2 , p3]);
console.log(output); // Promise all immediately return a pending promise 

output.then ((res) => {
    console.log(output);
    console.log(res);
})


// Promise.allSettled

Promise.allSettled([p1 , p4 , p2 , p3])
.then ((res) => {
    console.log(res);
});

//Promise.race
Promise.race([p4 , p2 , p1 , p3])
.then((res) => {
    console.log("Implemeting Race");
})
.catch((err) => {
    console.log(`Error found ${err}`)
});


//Promise.any

Promise.any([p1 , p2 , p3 , p4])
.then ((res) => {
    console.log("Getting output from Promise.any");
})
.catch((err) => {
    console.log("Error in handling Promise.any");
})





//Implementing Promise.all inside asyn-await

const fetchAllPromise = async () => {
    try {
        const result = await Promise.all([p1, p2, p3]);
        console.log(result);
    } catch (error) {
        console.log("Error in fetching data from Promise.all", error.message);
    }
};

console.log(fetchAllPromise());




//Read csv file 

import fs from "fs";

//read file async

fs.readFile('player.csv' , 'utf-8' , (err , data) => {
    if (err) {
        console.log ("Error in reading the file " , err.message);
        return ;
    }
    console.log ("CSV file data is " , data );
})


//Read file Synchronous

try {
  const data = fs.readFileSync('player.csv', 'utf-8');
  console.log('Sync read:', data);
} catch (err) {
  console.error('Error reading file synchronously:', err.message);
}

console.log("hey");
