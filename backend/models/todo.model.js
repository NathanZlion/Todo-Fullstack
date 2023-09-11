

import mongoose from "mongoose";

const Todo = new mongoose.Schema(
    {
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: [true, "User is required."]
        },
        title: {
            type: String,
            required: [true, "Title is required."]
        },
        completed: {
            type: Boolean,
            required: false,
            default: false
        }
    },
    { timestamps: true }
);


export default mongoose.model("Todo", Todo);