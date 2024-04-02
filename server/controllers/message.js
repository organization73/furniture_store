const Message = require("../models/message");
const charRoom = require("../models/chatRoom");
const User = require("../models/user");
const Admin = require("../models/admin");
const ChatRoom = require("../models/chatRoom");
const io = require("../socketio/socket");


exports.FetchMessages = async (req, res, next) => {
  const user = req.admin || req.user;
  const { roomId } = req.params;
  try {
    if (!roomId) {
      throwError("No roomId provided", 400, "roomId");
    }
    const messages = await Message.find({ chatRoom: roomId })
      .populate({
        path: "sender",
        model: req.admin ? "Admin" : "User",
        select: "username",
      })
      .populate("chatRoom");
    res.status(200).json(messages);
  } catch (error) {
    res.status(400);
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

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
  try {
    var message = await Message.create(newMessage);
    message = await message.populate({
      path: "sender",
      model: req.admin ? "Admin" : "User",
      select: "username email",
    });

    message = await message.populate("chatRoom");
    message = await Admin.populate(message, {
      path: "chatRoom.users",
      model: req.admin ? "Admin" : "User",
      select: "username email",
    });

    const chatRoom = await ChatRoom.findByIdAndUpdate(roomId, {
      latestMessage: message,
    });
    console.log("chat room", chatRoom);
    //
    if (!chatRoom.users) {
      return console.log("no users in the chat room");
    }
    console.log("message", message);
    chatRoom.users.forEach((user) => {
      if (user._id.toString() !== message.sender._id.toString()) {
        console.log("sending message to", user._id.toString());
        io.getIO().in(user._id.toString()).emit("recieve-message",message);
      }
    });
    //

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
