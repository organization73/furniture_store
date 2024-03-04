const io = require("./socket").getIO();

module.exports.signin = (socket, onlineUsers) => {
  socket.on("signin", (token) => {
    console.log("signin token:", token);
    if (!token) {
      return socket.emit("authError", { message: "No token provided" });
    }
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const userId = decoded.userId;
    try {
      const user = User.findById(userId);
      if (!user) {
        user = Admin.findById(userId);
      }
      if (!user) {
        return socket.emit("authError", { message: "Invalid token" });
      }
      onlineUsers[userId] = socket.id;
      console.log("onlineUsers:", onlineUsers);
      socket.emit("authSuccess", { message: "Auth success" });
    } catch (error) {
      console.log("signin error:", error);
      socket.emit("authError", { message: "Invalid token" });
    }
  });
};
