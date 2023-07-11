

// import all controllers here

import todoControllers from '../controllers/todo.controller.js';
import express from "express";
import authMiddleware from "../middleware/auth.js";

const todoRouter = express.Router();

// auth middleware to check if user is logged in
todoRouter.use(authMiddleware);

// write all routes here
todoRouter.post("/", todoControllers.createTodo);
todoRouter.get("/", todoControllers.getAllTodos);
todoRouter.get("/:id", todoControllers.getTodo);
todoRouter.patch("/:id", todoControllers.updateTodo);
todoRouter.delete("/:id", todoControllers.deleteTodo);

export default todoRouter;