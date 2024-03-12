const express = require("express");
const authRoute = require("./routes/authRoute");
const mongoose = require("mongoose");
const connectionString = "mongodb+srv://zeeldiyora310:Zeel%40123@zeelcluster.iely2fa.mongodb.net/amazon-clone?retryWrites=true&w=majority";

mongoose.connect(connectionString)
    .then(()=>{
        console.log("Successfully connected to Database!");
    })
    .catch((e)=>{
        console.log(e);
    })

const app = express();
const port = 3000;

app.use(express.json());
app.use(authRoute);

app.listen(port, '0.0.0.0' , (req, res) => {
    console.log(`Server listening on port ${port}`);
})
