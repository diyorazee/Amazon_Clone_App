const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const jwt = require("jsonwebtoken");

const authRoute = express.Router();

authRoute.post('/api/signup', async (req, res)=>{
    try{
        const {name, email, password} = req.body;
        const exsitingUser = await User.findOne({ email });

        if(exsitingUser){
            return res.status(400).json({msg:"User already exist with this email"});
        }

        const hasedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            name, email, password: hasedPassword
        })

        user = await user.save();
        res.json(user);
        
    } catch(e){
        res.status(500).json({err: e.message});
    }
});

authRoute.post('/api/signin', async (req, res)=>{
    try{
        const {email, password} = req.body;

        const user = await User.findOne({ email });
        if(!user){
            return res.status(400).json({msg:"User does not exist, with given Email"});
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg:"Incorrect Password"});
        }

        const token = jwt.sign({id: user._id}, 'passwordKey');
        res.json({token, ...user._doc}); // used object-destructuring '...'
    } catch(e){
        res.status(500).json({err: e.message});
    }
})



module.exports = authRoute;