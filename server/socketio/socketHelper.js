const io = require("./socket").getIO();

module.exports.signin = (socket, onlineUsers) => {
  let userType = "user";
  socket.on("signin", (token) => {
    if (!token) {
      //check if token is in the cookie (admin)
      const token = socket.handshake.headers.cookie.split("=")[1];
      userType = "admin";
      console.log("token:", token);
    }
    if (!token) {
      return socket.emit("authError", { message: "No token provided" });
    }
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const userId = decoded.userId;
    try {
      let user;
      if (userType === "admin") {
        user = Admin.findById(userId);
      } else {
        user = User.findById(userId);
      }
      if (!user) {
        return socket.emit("authError", { message: "Invalid token}" });
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
