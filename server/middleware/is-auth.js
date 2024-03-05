const jwt = require("jsonwebtoken");
const User = require("../models/user"); // Assuming you have a User model

const authMiddleware = async (req, res, next) => {
  // Get the token from the request headers
  let token;
  try {
    token = req.headers.authorization.split(" ")[1];
    if (!token) {
      return res.status(401).json({ message: "No token provided" });
    }
    console.log("token:", token);
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }

  try {
    // Verify and decode the token
    console.log("start decoding");
    const decoded = jwt.verify(token, "thisisaverylong");
    // Check if the user exists in the database
    const user = await User.findById(decoded.userId);
    if (!user) {
      return res.status(401).json({ message: "Invalid token1" });
    }
    //checking confirmation startus
    //if yes home
    //no verify
    // Attach the user object to the request for further use
    req.user = user;
    // console.log("req.user:", user);
    // Call the next middleware or route handler
    next();
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

module.exports = authMiddleware;
