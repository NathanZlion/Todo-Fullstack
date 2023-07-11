
import mongoose from "mongoose";

const user = mongoose.Schema(
    {
        userName: {
            type: String,
            required: [true, "Username is required."],
        },
        password: {
            type: String,
            required: [true, "Password is required."]
        },
        email: {
            type: String,
            required: [true, "Email is required."],
        },
    }
);


export default mongoose.model("User", user);