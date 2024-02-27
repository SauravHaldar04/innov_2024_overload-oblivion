import userModal from "../models/User.js";
import bcrypt from  "bcrypt";
import jwt from "jsonwebtoken";

// register new user...
const userRegistration = async (req, res)=>{
    const {name, email, password, cpassword, tc} = req.body;
    const user = await userModal.findOne({email: email});
    if (user) {
        res.send({"status": "failed", "message": "Email already exists"});
    }else{
        // validate all field contain data or not
        if (name && email && password && cpassword && tc) {
            if (password === cpassword) {
               try {
                    const salt = await bcrypt.genSalt(10);
                    const hashPassword = await bcrypt.hash(password, salt);
                    const createUser = new userModal({
                        name: name,
                        email: email,
                        password: hashPassword,
                        tc: tc
                    })

                        const newUser = await createUser.save();
                        // Now generate JWT 
                        const token = jwt.sign({userID: newUser._id}, process.env.JWT_SECRET_KEY, {expiresIn: '5d'});
                        res.status(201).json({user:newUser, token});

               } catch (error) {
                    res.send({"status": "failed", "message": "unable to register"});
               }
            }else{
                res.send({"status": "failed", "message": "password and confirm password not matched"});
            }
        }else{
            res.send({"status": "failed", "message": "All Fields are required"});
        }
    }
}

//  user login..
const userLogin = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (email && password) {
            const user = await userModal.findOne({email: email});
            if (user) {
                const isMatch = await bcrypt.compare(password, user.password);
                if (isMatch) {
                     // Now generate JWT 
                     const token = jwt.sign({userID: user._id}, process.env.JWT_SECRET_KEY, {expiresIn: '5d'});
                    res.status(200).json({user, token});
                }else{
                    res.send({"status": "failed", "message": "invalid email or password"});
                }
            }else{
                res.send({"status": "failed", "message": "You are not registered"});
            }
        }else{
            res.send({"status": "failed", "message": "All Fields are required"});
        }
    } catch (error) {
        res.send({"status": "failed", "message": "Unable to login"});

    }
}
// change user password after login through settings etc..
const changeUserPassword = async (req, res) => {
    const { password, cpassword } = req.body;
    if (password && cpassword) {
        if (password === cpassword) {
            const salt = await bcrypt.genSalt(10);
            const newHashPassword = await bcrypt.hash(password, salt);
            await userModal.findByIdAndUpdate(req.user._id, {$set: {password: newHashPassword}})
            res.send({"status": "200", "message": "change password successfully"});

        }else{
            res.send({"status": "failed", "message": "password and confirm password not matched"});
        }
    }else{
        res.send({"status": "failed", "message": "All Fields are required"});
    }
}



// Reset password, or forget password to send email...
const sendEmailResetPassword = async (req, res) => {
    const { email } = req.body;
    if (email) {
        const user = await userModal.findOne({ email: email });
        if (user) {
            const secret = user._id + process.env.JWT_SECRET_KEY;
            const token = jwt.sign({ userID: user._id }, secret, { expiresIn: '1d' });
            const link = `http://127.0.0.1:3000/api/user/reset/${user._id}/${token}`;
            console.log(link, 'starting token');
            res.send({ "status": "success", "message": "Email sent successfully" });
        } else {
            res.send({ "status": "failed", "message": "Email does not exist" });
        }
    } else {
        res.send({ "status": "failed", "message": "Email is required" });
    }
}

// After email send allow password reset..
const userPasswordReset = async (req, res) => {
    const { password, cpassword } = req.body;
    const { id, token } = req.params;
    const user = await userModal.findById(id);
    const new_secret = user._id + process.env.JWT_SECRET_KEY;
    try {
        console.log(token,"xxxxx",  new_secret);
        jwt.verify(token, new_secret);
        if (password && cpassword) {
            if (password === cpassword) {
                const salt = await bcrypt.genSalt(10);
                const newHashPassword = await bcrypt.hash(password, salt);
                await userModal.findByIdAndUpdate(id, { $set: { password: newHashPassword } });
                res.send({ "status": "200", "message": "Password reset successfully" });
            } else {
                res.send({ "status": "failed", "message": "Passwords do not match" });
            }
        }
    } catch (error) {
        res.send({ "status": "failed", "message": "Token does not match" });
    }
}


export {
    userRegistration,
    userLogin,
    changeUserPassword,
    sendEmailResetPassword,
    userPasswordReset 
};