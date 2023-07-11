
import User from "../models/user.model.js";
import bcrypt from "bcryptjs";
import Validator from "validator";
import { isStrongPassword } from "../utils/custom_validators.js";
import jwt from "jsonwebtoken";
import { getUserFromToken } from "../middleware/auth.js";


/**
 * 
 * A class to handle all user related controllers 
 */
export class userControllers {

    /**
     * register controller to handle user registration
     * @param {*} req
     * @param {*} res
     * @returns  user details if user is registered successfully. If not error message.
     */
    static async register(req, res) {
        const { userName, email, password } = req.body;

        try {
            if (!userName || !email || !password) {
                return res.status(400).json({ message: "Please fill in all fields" });
            }

            if (!Validator.isEmail(email)) {
                return res.status(400).json({ message: "Please enter a valid email" });
            }

            const existingUser = await User.findOne({ email });

            if (existingUser) {
                return res.status(400).json({ message: "User already exists" });
            }

            if (!isStrongPassword(password)) {
                return res.status(400).json({ message: "Password is not strong enough" });
            }

            // I save the hashed password in the database
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);
            const newUser = new User({ userName, email, password: hashedPassword });
            await newUser.save();
            // sign a token and send it to the user
            const token = jwt.sign({ _id: newUser._id }, process.env.JWT_SECRET);

            res.status(200).json({ token, user: { userName: newUser.userName, email: newUser.email } });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while registering." });
        }
    }


    /**
     * login controller to handle user login
     * @param {*} req 
     * @param {*} res 
     * @returns  user details if user exists and has valid credentials. If not error message.
     */
    static async login(req, res) {
        // get the email and password from the request body
        const { email, password } = req.body;

        try {
            if (!email || !password) {
                return res.status(400).json({ message: "Please fill in all fields" });
            }

            if (!Validator.isEmail(email)) {
                return res.status(400).json({ message: "Please enter a valid email" });
            }

            const existingUser = await User.findOne({ email });

            if (!existingUser) {
                return res.status(400).json({ message: "User does not exist" });
            }

            const isPasswordCorrect = await bcrypt.compare(password, existingUser.password);

            if (!isPasswordCorrect) {
                return res.status(400).json({ message: "Invalid credentials" });
            }

            // sign a token and send it to the user
            const token = jwt.sign({ _id: existingUser._id }, process.env.JWT_SECRET);

            res.status(200).json({ token, user: { userName: existingUser.userName, email: existingUser.email } });

        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while logging in." });
        }

    }

    /**
     * 
     * @param {*} req 
     * @param {*} res 
     * @returns user details if user exists. If not error message.
     */
    static async getUser(req, res) {
        try {
            const user = await getUserFromToken(req, res);
            if (!user) {
                return res.status(401).json({ message: "Unauthorized" });
            }
            res.status(200).json({ user: { userName: user.userName, email: user.email } });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while getting user." });
        }
    }

    /**
     * 
     * @param {*} req
     * @param {*} res
     * @returns user details if updated user is updated successfully. If not error message.
     * 
     */
    static async updateUser(req, res) {
        // updates the user's username
        const { userName } = req.body;

        if (!userName) {
            return res.status(400).json({ message: "Please fill in all fields" });
        }

        try {
            const user = await getUserFromToken(req, res);
            if (!user) {
                return res.status(401).json({ message: "Unauthorized" });
            }
            user.userName = userName;
            await user.save();
            res.status(200).json({ user: { userName: user.userName, email: user.email } });
        } catch (error) {
            console.log(error); z
            res.status(500).json({ message: "Something went wrong while updating user." });
        }
    }

    static async deleteUser(req, res) {
        try {
            const user = await getUserFromToken(req, res);
            if (!user) {
                return res.status(401).json({ message: "Unauthorized" });
            }
            await User.findByIdAndDelete(user._id);
            res.status(200).json({ message: "User deleted successfully" });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Something went wrong while getting user." });
        }
    }
}