import express from 'express';
import { 
    userRegistration, 
    userLogin, changeUserPassword,
    sendEmailResetPassword,
    userPasswordReset 
} from '../controllers/userController.js';
import checkUserAuth from '../middlewares/auth-middleware.js';
const router = express.Router();


// Route level Middleware - To protect route.
router.use('/changepassword', checkUserAuth);


// Public Routes
router.post('/register', userRegistration);
router.post('/login', userLogin);
router.post('/send-reset-password', sendEmailResetPassword)
router.post('/reset/password/:id/:token', userPasswordReset)


// Protected Routes
router.post('/changepassword', changeUserPassword);


export default router;
