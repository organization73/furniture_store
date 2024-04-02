const io = require("../socketio/socket").getIO();

exports.sendMessage = (message)=>{
  //sending messages.
  socket.on("new-message", (newMessage) => {
    console.log(
      `new message from ${newMessage.sender.username} content: ${newMessage.content}`
    );
    const chatRoom = newMessage.chatRoom;
    if (!chatRoom.users) {
      return console.log("no users in the chat room");
    }
    chatRoom.users.forEach((user) => {
      if (user._id.toString() !== newMessage.sender._id.toString()) {
        socket.in(user._id).emit("recieve-message", newMessage);
      }
    });

    // socket.to()
  });
}