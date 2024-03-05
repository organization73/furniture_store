const io = require("./socket").getIO();
const jwt = require("jsonwebtoken");
const Admin = require("../models/admin");
const User = require("../models/user");

module.exports.actionListeners = (socket, onlineUsers) => {
  let userType = "user";
  socket.on("signin", async (data) => {
    console.log("join-room data:", data);
    const { roomId, token } = data;
    if (!roomId) {
      return socket.emit("authError", { message: "No roomId provided" });
    }
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
      //check if user is already online
      const userIndex = onlineUsers.findIndex((user) => user.userID === userId);
      if (userIndex !== -1) {
        //update the socketId
        onlineUsers[userIndex].socketId = socket.id;
      } else {
        //add user to online users
        let userObj = {
          userID: user._id.toString(),
          userType,
          socketId: socket.id,
        };
        onlineUsers.push(userObj);
      }
      // //join the room
      // socket.join(roomId);
      console.log("onlineUsers:", onlineUsers);
      socket.emit("authSuccess", { message: "Auth success" });
    } catch (error) {
      console.log("signin error:", error);
      socket.emit("authError", { message: "Invalid token" });
    }
  });

  socket.on("disconnect", () => {
    console.log("Client: " + socket.id + " disconnected");
    //remove user from online users
    const userIndex = onlineUsers.findIndex(
      (user) => user.socketId === socket.id
    );
    if (userIndex !== -1) {
      onlineUsers.splice(userIndex, 1);
    }
    console.log("onlineUsers:", onlineUsers);
  });

};
