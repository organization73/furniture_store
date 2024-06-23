const jwt = require("jsonwebtoken");
const Admin = require("../models/user"); // Assuming you have a User model

const authMiddleware = async (req, res, next) => {
  //if request isn't from website, skip this middleware
  const source = req.useragent.isDesktop ? 'website' : 'mobile';
  if (source !== 'website') {
    next();
  }
  // Get the token from the request headers
  let token;
  try {
    // token = req.headers.authorization.split(" ")[1];
    // console.log("req.cookies",req.cookies)
    token = req.cookies.token;
    if (!token) {
      return res.status(403).render("auth/login", {
        errorMessage: "No token provided",
        pageTitle: "Login",
        isAuthenticated: false,
        path: "/login",
        validationErrors: [],
        oldInput: {},
      });
    }
    // Verify and decode the token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    // Check if the admin exists in the database
    const admin = await Admin.findById(decoded.userId);
    if (!admin) {
      const error = new Error("No admin found");
      error.statusCode = 401;
      throw error;
      // return res.status(401).json({ message: "Invalid token1" });
    }
    req.admin = admin;
    req.isAuthenticated = true;
    console.log('authorized requist.')
    next();
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

module.exports = authMiddleware;
