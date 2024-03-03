const jwt = require("jsonwebtoken");
const Admin = require("../models/admin"); // Assuming you have a User model

const authMiddleware = async (req, res, next) => {
  // Get the token from the request headers
  let token;
  try {
    // token = req.headers.authorization.split(" ")[1];
    token = req.cookies.token;
    if (!token) {
      return res.render("auth/login",{
        errorMessage: "No token provided",
      })
    }
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }

  try {
    // Verify and decode the token
    console.log("start decoding", process.env.JWT_SECRET);
    console.log("token:", token);
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log("end decoding");

    // Check if the admin exists in the database
    const admin = await Admin.findById(decoded.adminId);
    if (!admin) {
      const error = new Error("No admin found");
      error.statusCode = 401;
      throw error;
      // return res.status(401).json({ message: "Invalid token1" });
    }
    req.admin = admin;
    req.isAuthenticated = true;
    next();
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

module.exports = authMiddleware;
