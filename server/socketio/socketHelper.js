const io = require("./socket").getIO();
const jwt = require("jsonwebtoken");
const Admin = require("../models/admin");
const User = require("../models/user");


module.exports.actionListeners =(socket, onlineUsers) => {
  let userType = "user";
  socket.on("signin", async (token) => {
    if (!token) {
      //check if token is in the cookie (admin)
      token = socket.handshake.headers.cookie.split("=")[1];
      userType = "admin";
    }
    if (!token) {
      return socket.emit("authError", { message: "No token provided" });
    }
    try {
      const decoded = await jwt.verify(token, process.env.JWT_SECRET);
      if (!decoded) {
        return socket.emit("authError", { message: "Invalid token" });
      }
      const userId = decoded.userId || decoded.adminId;
      let user;
      if (userType === "admin") {
        user = await Admin.findById(userId);
      } else {
        user = await User.findById(userId);
      }

      if (!user) {
        return socket.emit("authError", { message: "Invalid token2" });
      }

      let userObj = { userID: user._id, userType, socketId: socket.id };
      onlineUsers.push(userObj);
      console.log("onlineUsers:", onlineUsers);
      socket.emit("authSuccess", { message: "Auth success" });
    } catch (error) {
      console.log("signin error:", error);
      socket.emit("authError", { message: "Invalid token" });
    }
  });
};
