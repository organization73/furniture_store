const io = require("./socket").getIO();
const jwt = require("jsonwebtoken");
const Admin = require("../models/admin");
const User = require("../models/user");

const onlineUsers = require("./socket").onlineUsers;

module.exports.actionListeners = (socket) => {
  let userType = "user";
  //sending notificatoins //can be made on connection
  socket.on("setup", (userData) => {
    socket.join(userData._id);
    //check if the user already exists in the online users
    const userIndex = onlineUsers.findIndex(
      (user) => user.userId === userData._id
    );
    //if the user is not in the online users
    if (userIndex === -1) {
      onlineUsers.push({
        userId: userData._id,
        socketId: socket.id,
        userType: userType,
      });
    }
    //if the user is in the online users update the socket id
    else {
      onlineUsers[userIndex].socketId = socket.id;
    }
    socket.emit("connected");
  });

  //leaving the chat page.
  socket.off("setup", () => {
    socket.leave(userData._id);
  });

  //joining room
  socket.on("join-room", (roomId) => {
    socket.join(roomId);
  });
  socket.on("leave-room", (roomId) => {
    socket.leave(roomId);
  });

  //sending messages.
  socket.on("new-message", (newMessage) => {
    // socket.to()
  });

  socket.on("disconnect", () => {
    console.log("disconnecting user...", socket.id);
    console.log("onlineUsers before remove:", onlineUsers);
    //remove user from online users
    const userIndex = onlineUsers.findIndex(
      (user) => user.socketId === socket.id
    );
    console.log("user index:", userIndex);
    if (userIndex !== -1) {
      console.log("disconnecting user...", onlineUsers[userIndex]);
      console.log("disconnecting usre index:", userIndex);
      socket.leave(onlineUsers[userIndex].userId);
      onlineUsers.splice(userIndex, 1);
      console.log("onlineUsers after remove:", onlineUsers);
    }
  });
};
//if user close the page while he is inside a page.
