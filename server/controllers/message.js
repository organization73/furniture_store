// exports.sendMessage = async (req, res, next) => {
//   const user = req.admin || req.user;
//   const { roomId, message } = req.body;
//   try {
//     //validate input
//     if (!roomId) {
//       throwError("No roomId provided", 400, "roomId");
//     }
//     if (!message) {
//       throwError("No message provided", 400, "message");
//     }
//     //check if chat room exists
//     const chatRoom = await ChatRoom.findById(roomId);
//     if (!chatRoom) {
//       throwError("No chatRoom found", 404, "chatRoom");
//     }
//     //check if user is authorized to send message
//     if (!chatRoom.users.includes(user._id)) {
//       throwError("User not authorized", 403, "user");
//     }
//     //create message
//     const newMessage = new Message({
//       chatRoom: roomId,
//       sender: user._id,
//       content: message,
//       type: "text",
//     });
//     const savedMessage = await newMessage.save();

//     savedMessage = await savedMessage.populate("sender", "name ");
//     savedMessage = await savedMessage.populate("chatRoom");
//     savedMessage = await User.populate(savedMessage, {
//       path: "chatRoom.users",
//       model: "Admin",
//       select: "username",
//     });
//     // //send message to socket
//     // io.to(roomId).emit("message", {
//     //   message: savedMessage,
//     //   sender: user._id,
//     //   chatRoom: roomId,
//     // });
//     //update chat room
//     chatRoom.latestMessage = savedMessage._id;
//     await chatRoom.save();
//     res.status(201).json({ message: "Message sent", message: savedMessage });
//   } catch (err) {
//     if (!err.statusCode) {
//       err.statusCode = 500;
//     }
//     next(err);
//   }
// };
const Message = require("../models/message");
const charRoom = require("../models/chatRoom");
const User = require("../models/user");
const Admin = require("../models/admin");
const ChatRoom = require("../models/chatRoom");
// exports.allMessages = async (req, res) => {
//   const user = req.admin || req.user;
//   try {
//     const messages = await Message.find({ chat: req.params.chatId })
//       .populate("sender", "name pic email")
//       .populate("chat");
//     res.json(messages);
//   } catch (error) {
//     res.status(400);
//     throw new Error(error.message);
//   }
// };

exports.sendMessage = async (req, res, next) => {
  const user = req.admin || req.user;
  const { content, roomId } = req.body;

  if (!content || !roomId) {
    console.log("Invalid data passed into request");
    return res.sendStatus(400);
  }

  var newMessage = {
    sender: user._id,
    content: content,
    chatRoom: roomId,
    type: "text",
  };
  console.log("newMessage:",newMessage);
  console.log("user._id:",user._id);

  try {
    var message = await Message.create(newMessage);

    message = await message.populate({
      path: "sender",
      model: "Admin",
      select: "username email",
    })

    message = await message.populate("chatRoom");
    message = await Admin.populate(message, {
      path: "chatRoom.users",
      model: "Admin",
      select: "username email",
    });

    await ChatRoom.findByIdAndUpdate(roomId, {
      latestMessage: message,
    });

    res.status(200).json(message);
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

function throwError(message, statusCode, path) {
  const error = new Error(message);
  error.statusCode = statusCode;
  error.path = path;
  throw error;
}
