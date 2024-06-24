const io = require("./socket").getIO();
const User = require("../models/user");
const chatRoom = require("../models/chatRoom");

const onlineUsers = require("./socket").onlineUsers;

module.exports.actionListeners = (socket) => {
  let userType = "user";
  //sending notificatoins //can be made on connection
  socket.on("setup", (userData) => {
    console.log("datahere", userData);
    console.log(`user ${userData._id} connected`);
    socket.join(userData._id);
    console.log("join room", userData._id);
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

  //typing
  socket.on("typing", ({ recieverId, senderUsername }) => {
    console.log(senderUsername, "is typing to", recieverId);
    socket.in(recieverId).emit("recieve-typing", senderUsername);
  });

  //sending messages.
  // socket.on("new-message", (newMessage) => {
  //   console.log(
  //     `new message from ${newMessage.sender.username} content: ${newMessage.content}`
  //   );
  //   const chatRoom = newMessage.chatRoom;
  //   if (!chatRoom.users) {
  //     return console.log("no users in the chat room");
  //   }
  //   chatRoom.users.forEach((user) => {
  //     if (user._id.toString() !== newMessage.sender._id.toString()) {
  //       socket.in(user._id).emit("recieve-message", newMessage);
  //     }
  //   });
  //   // socket.to()
  // });

  //disconnecting
  socket.on("disconnect", () => {
    //remove user from online users
    const userIndex = onlineUsers.findIndex(
      (user) => user.socketId === socket.id
    );
    console.log("user disconnected",  socket.id);
    if (userIndex !== -1) {
      socket.leave(onlineUsers[userIndex].userId);
      onlineUsers.splice(userIndex, 1);
    }
  });
};
//if user close the page while he is inside a page.
