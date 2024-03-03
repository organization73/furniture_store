const Admin = require("../models/admin");
const User = require("../models/user");

const ChatRoom = require("../models/chatRoom");
const Message = require("../models/message");

exports.createChatRoom = async (req, res, next) => {
  let primaryUser;
  if (req.admin) {
    primaryUser = req.admin;
  } else {
    primaryUser = req.user;
  }

  const seondaryUserId = req.body.seondaryUserId;
  if (!seondaryUserId) {
    const error = new Error("No seondaryUserId provided");
    error.statusCode = 400;
    error.path = "seondaryUserId";
    next(error);
  }
  //getting the secondary user
  let secondaryUser;
  try {
    secondaryUser = await Admin.findById(seondaryUserId);
    if (!secondaryUser) {
      const error = new Error("No secondaryUser found");
      throwError("No secondaryUser found", 404, "secondaryUser");
    }
    //check if chat room already exists
    const chatRoom = await ChatRoom.findOne({
      users: { $all: [primaryUser._id, secondaryUser._id] },
    });
    if (chatRoom) {
      throwError("Chat room already exists", 400, "chatRoom");
      ``;
      // return res.status(200).json({message: 'Chat room already exists', chatRoom});
    }
    //create chat room
    const newChatRoom = new ChatRoom({
      users: [primaryUser._id, secondaryUser._id],
    });
    if (req.admin) {
      newChatRoom.type = "admin-client";
    } else {
      newChatRoom.type = "client-client";
    }
    const savedChatRoom = await newChatRoom.save();
    res.status(201).json({
      message: "Chat room created",
      chatRoom: savedChatRoom,
      fullName: secondaryUser.firstName + " " + secondaryUser.lastName,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getChatRooms = async (req, res, next) => {
  const user = req.admin || req.user;

  try {
    const chatRooms = await ChatRoom.find({ users: { $in: [user._id] } })
      .populate({
        path: "users",
        model: "Admin", // Use 'Admin' model instead of 'User' model
      })
      .populate("latestMessage");

    // console.log("chatRooms:", chatRooms[0].users[0]);
    const updatedChatRooms = chatRooms.map((chatRoom) => {
      chatRoom.users.map((u) => {
        if (u._id.toString() !== user._id.toString()) {
          chatRoom.fullName = u.firstName + " " + u.lastName;
          console.log("chatRoom:", chatRoom.fullName);
        }
      });
      console.log("out:", chatRoom.fullName);

      return chatRoom;
    });
    res.status(200).json({ chatRooms: updatedChatRooms });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};
exports.sendMessage = async (req, res, next) => {
  const user = req.admin || req.user;
  const { roomId, message } = req.body;
  try {
    //validate input
    if (!roomId) {
      throwError("No roomId provided", 400, "roomId");
    }
    if (!message) {
      throwError("No message provided", 400, "message");
    }
    //check if chat room exists
    const chatRoom = await ChatRoom.findById(roomId);
    if (!chatRoom) {
      throwError("No chatRoom found", 404, "chatRoom");
    }
    //check if user is authorized to send message
    if (!chatRoom.users.includes(user._id)) {
      throwError("User not authorized", 403, "user");
    }
    //create message
    const newMessage = new Message({
      chatRoom: roomId,
      sender: user._id,
      content: message,
      type: "text",
    });
    const savedMessage = await newMessage.save();
    //update chat room
    chatRoom.latestMessage = savedMessage._id;
    await chatRoom.save();
    res.status(201).json({ message: "Message sent", message: savedMessage });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

function throwError(message, statusCode, path) {
  const error = new Error(message);
  error.statusCode = statusCode;
  error.path = path;
  throw error;
}
