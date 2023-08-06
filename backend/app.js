
import mongoose from "mongoose";
import express from "express";
import dotenv from "dotenv";
import cors from "cors"

import userRouter from "./routes/user.routes.js";
import todoRouter from "./routes/todo.routes.js";

dotenv.config();

const app = express();

// MIDDLEWARES, PARSERS TO USE JSON
app.use(express.json());

// SET HEADERS
app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "Authorization, Origin, X-Requested-With, Content-Type, Accept");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, PATCH, DELETE, OPTIONS");
    next();
})

// ROUTES
app.use("/api/user", userRouter);
app.use("/api/todo", todoRouter);

// any origin can access this server
app.use(cors({
    origin: "*",
}));

mongoose.set('strictQuery', false);

async function connectToDb() {
    try {
        console.log(`trying to Connect to database...`);
        await mongoose.connect(process.env.MONGODBURL, { useNewUrlParser: true, useUnifiedTopology: true });
        console.log(`Connected to database successfully`);
    } catch (error) {
        throw new Error(`Database Error: ${error.message}`);
    }
}


async function startListening(){
    try {
        console.log(`Trying to start listening through port ${process.env.PORT}...`);
        app.listen(process.env.PORT);
        console.log(`Server listening through port ${process.env.PORT}`);
    } catch (error) {
        throw new Error(error.message);
    }
}


async function startServer() {
    try {
        await connectToDb();
        await startListening();
        console.log(`✔ Server started successfully ✔`);
    } catch (error) {
        console.log(error.message);
    }
}


startServer();
