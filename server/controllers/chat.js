const Admin = require("../models/admin");
const User = require("../models/user");

const ChatRoom = require("../models/chatRoom");
const Message = require("../models/message");

exports.createChatRoom = async (req, res, next) => {
  let primaryUser;
  console.log("req.admin:", req.body);
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
    console.log("seondaryUserId:", secondaryUser);
    console.log("prima:", primaryUser);
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
    await newChatRoom.save();
    res
      .status(201)
      .json({ message: "Chat room created", chatRoom: newChatRoom, fullName: secondaryUser.firstName + " " + secondaryUser.lastName });
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
