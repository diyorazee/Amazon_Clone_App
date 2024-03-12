const mongoose = require("mongoose");
const connectionString = "mongodb+srv://zeeldiyora310:Zeel%40123@zeelcluster.iely2fa.mongodb.net/amazon-clone?retryWrites=true&w=majority";

const userSchema = mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true,
    },
    email:{
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value)=>{
                const regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(regex);
            },
            msg: "Please enter valid email",
        }
    },
    password:{
        required: true,
        type: String,
    },
    address:{
        type: String,
        default: "",
    },
    type:{
        type: String,
        default: "User",
    },
    //cart:{}
})

const User = mongoose.model("User", userSchema);

module.exports = User;