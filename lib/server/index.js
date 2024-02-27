// index.js
import dotenv from 'dotenv';
import express from 'express';
import cors from 'cors';
import connectDb from './config/connectdb.js';

dotenv.config();

const app = express();

connectDb(); // Call the connectDb function

import userRouter from './routes/userRoutes.js';

const port = process.env.PORT;

app.use(cors());
app.use(express.json());

// Load Routes
app.use("/api/user/", userRouter);

app.listen(port, () => {
    console.log(`Server listening at localhost:${port}`);
});
