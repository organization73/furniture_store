const Message = require("../models/message");
const charRoom = require("../models/chatRoom");
const User = require("../models/user");
const Admin = require("../models/admin");
const ChatRoom = require("../models/chatRoom");
const io = require("../socketio/socket");

exports.FetchMessages = async (req, res, next) => {
  const { roomId } = req.params;
  try {
    if (!roomId) {
      const error = new Error("No roomId provided");
      error.statusCode = 400;
      throw error;
    }

    const messages = await Message.find({ chatRoom: roomId }).populate(
      "chatRoom"
    );

    for (let message of messages) {
      if (message.sender) {
        const admin = await Admin.findById(message.sender).select("username");
        if (admin) {
          message.sender = admin;
        } else {
          const user = await User.findById(message.sender).select("username");
          if (user) {
            message.sender = user;
          }
        }
      }
    }

    res.status(200).json(messages);
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

exports.sendMessage = async (req, res, next) => {
  const admin = req.admin;
  const { content, roomId } = req.body;
  console.log("req.body", req.body);

  if (!content || !roomId) {
    console.log("Invalid data passed into request");
    return res.sendStatus(400);
  }

  let newMessage = {
    sender: admin._id,
    senderType: "admin",
    content: content,
    chatRoom: roomId,
    type: "text",
  };
  try {
    let message = await Message.create(newMessage);
    message = await message.populate({
      path: "sender",
      model: "Admin",
      select: "username email",
    });

    message = await message.populate("chatRoom");



    const chatRoom = await ChatRoom.findByIdAndUpdate(roomId, {
      latestMessage: message,
    });
    console.log("chat room", chatRoom);

    //
    if (!chatRoom.users) {
      return console.log("no users in the chat room");
    }
    console.log("message", message);

    //send message to all users in the chat room except the sender.
    chatRoom.users.forEach((reciever) => {
      if (reciever._id.toString() !== message.sender._id.toString()) {
        console.log("sending message to", reciever._id.toString());
        io.getIO().in(reciever._id.toString()).emit("recieve-message", message);
      }
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
