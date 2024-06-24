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

    const messages = await Message.find({ chatRoom: roomId })
      .populate("chatRoom")
      .populate({
        path: "sender",
        select: "username email",
      });

    res.status(200).json(messages);
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

exports.sendMessage = async (req, res, next) => {
  const user = req.user;
  const { content, roomId } = req.body;
  console.log(
    `sending message to room ${roomId} from user ${user.username} with content ${content}`
  );
  console.log("req.body", req.body);

  if (!content || !roomId) {
    console.log("Invalid data passed into request");
    return res.sendStatus(400);
  }

  try {
    const chatRoom = await ChatRoom.findById(roomId);
    if (!chatRoom) {
     return throwError("Chat room not found", 404, "roomId");
    }
    if (!chatRoom.users.includes(user._id)) {
     return throwError("You are not a member of this chat room", 403, "roomId");
    }
  }catch (error) {
    next(error);
  }

  let newMessage = {
    sender: user._id,
    content: content,
    chatRoom: roomId,
    type: "text",
  };
  try {
    var message = await Message.create(newMessage);
    message = await message.populate({
      path: "sender",
      model: "User",
      select: "username email",
    });

    message = await message.populate("chatRoom");

    const chatRoom = await ChatRoom.findByIdAndUpdate(roomId, {
      latestMessage: message,
    });
    console.log("chat room", chatRoom);
    if (!chatRoom.users) {
     return throwError("No users in the chat room", 400, "sendMessage");
    }
    console.log("message", message);
    //send message to all users in the room except the sender.
    chatRoom.users.forEach((user) => {
      if (user._id.toString() !== message.sender._id.toString()) {
        console.log("sending message to", user._id.toString());
        io.getIO().in(user._id.toString()).emit("recieve-message", message);
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
