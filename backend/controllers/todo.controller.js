
import todoModel from "../models/todo.model.js";
import userModel from "../models/user.model.js";

/**
 * 
 * A class to handle all todo related controllers
 */
export default class todoControllers {
    static async createTodo(req, res) {
        try {
            const { title, description, completed } = req.body;
            const user = res.locals.user;
            if (!title) {
                return res.status(400).json({ message: "Title is required" });
            }

            const newTodo = new todoModel({ title, description, completed, user: user._id });
            await newTodo.save();

            res.status(200).json({ message: "Todo created successfully", newTodo });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while creating todo." });
        }
    }

    static async getAllTodos(req, res) {
        try {
            const user = res.locals.user;
            const todos = await todoModel.find({ user: user._id });

            res.status(200).json({ message: "Todos fetched successfully", todos });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while fetching todos." });
        }
    }

    static async getTodo(req, res) {
        try {
            const user = res.locals.user;
            const { id } = req.params;
            const todo = await todoModel.findById(id);

            if (!todo) {
                return res.status(404).json({ message: "Todo not found" });
            }

            if (todo.user.toString() !== user._id.toString()) {
                return res.status(401).json({ message: "Unauthorized" });
            }

            res.status(200).json({ message: "Todo fetched successfully", todo });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while fetching todo." });
        }
    }

    static async updateTodo(req, res) {
        try {
            const user = res.locals.user;
            const { id } = req.params;
            const { title, description, completed } = req.body;
            const todo = await todoModel.findById(id);

            if (!todo) {
                return res.status(404).json({ message: "Todo not found" });
            }

            if (todo.user.toString() !== user._id.toString()) {
                return res.status(401).json({ message: "Unauthorized" });
            }

            todo.title = title;
            todo.description = description;
            todo.completed = completed;
            await todo.save();

            res.status(200).json({ message: "Todo updated successfully", todo });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while updating todo." });
        }
    }

    static async deleteTodo(req, res) {
        try {
            const user = res.locals.user;
            const { id } = req.params;
            const todo = await todoModel.findById(id);

            if (!todo) {
                return res.status(404).json({ message: "Todo not found" });
            }

            if (todo.user.toString() !== user._id.toString()) {
                return res.status(401).json({ message: "Unauthorized" });
            }

            await todoModel.findByIdAndDelete(id);

            res.status(200).json({ message: "Todo deleted successfully" });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while deleting todo." });
        }
    }
}
