const mongoose = require("mongoose");

const Admin = require("../models/admin");
const User = require("../models/user");

const ChatRoom = require("../models/chatRoom");
const Message = require("../models/message");
const chatRoom = require("../models/chatRoom");

const io = require("../socketio/socket");

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

/* /chat/rooms?search=abdo => GET request */
exports.allUsers = async (req, res, next) => {
  const keyword = req.query.search
    ? {
        $or: [
          { username: { $regex: req.query.search, $options: "i" } },
          { email: { $regex: req.query.search, $options: "i" } },
        ],
      }
    : {};

  const user = req.user;
  try {
    const conditions = {
      ...keyword,
      _id: { $ne: user._id },
    };

    const users = await User.find(conditions).select("-password").limit(5);
    const limitedUsers = users.slice(0, 5);
    // console.log("users:", users);
    res.status(200).json({ users: limitedUsers });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

/* /chat/access-room?roomId=123 => POST request */
exports.accessChatRoom = async (req, res, next) => {
  const { userId } = req.body;
  const primaryUser = req.user;
  try {
    //validate input
    if (!userId) {
      throwError("No userId provided", 400, "userId");
    }
    //check if user exists
    let secondaryUser = await User.findById(userId);

    if (!secondaryUser) {
      throwError("No secondaryUser found", 404, "secondaryUser");
    }
    //check if chat room already exists
    const chatRoom = await ChatRoom.findOne({
      users: { $all: [primaryUser._id, secondaryUser._id] },
      isGroupChat: false,
    })
      .populate({
        path: "users",
        select: "-password",
      })
      .populate({
        path: "latestMessage",
        populate: {
          path: "sender",
          model: req.admin ? "Admin" : "User", // Use the appropriate model for 'sender'
          select: "-password",
        },
      });
    //if chat room exists, return it
    if (chatRoom) {
      console.log("chatRoom:", chatRoom);
      return res.status(200).json({ chatRoom });
    } else {
      //create chat room
      console.log("create chat room");
      const newChatRoom = new ChatRoom({
        fullName: "sender",
        isGroupChat: false,
        users: [primaryUser._id, secondaryUser._id],
      });
      newChatRoom.type = "client-client";
      const savedChatRoom = await newChatRoom.save();

      //open chatroom on reciever's side.
      io.getIO().in(secondaryUser._id).emit("recieve-new-room", savedChatRoom);

      return res.status(201).json({
        message: "Chat room created",
        chatRoom: savedChatRoom,
        fullName: secondaryUser.firstName + " " + secondaryUser.lastName,
      });
    }
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

/* /chat/message => POST request */
exports.fetchChatRooms = async (req, res, next) => {
  const user = req.user;

  try {
    const chatRooms = await ChatRoom.find({
      users: {
        $elemMatch: {
          $eq: user._id,
          // Additional criteria for matching users array elements
        },
      },
    })
      .populate({
        path: "users",
        select: "-password",
      })
      .populate({
        path: "admin",
        model: "Admin", // Use the appropriate model for 'sender'
        select: "-password",
      })
      .populate({
        path: "latestMessage",
        populate: {
          path: "sender",
          select: "-password",
        },
      })
      .sort({ updatedAt: -1 });

    const updatedChatRooms = chatRooms.map((chatRoom) => {
      chatRoom.users.map((u) => {
        if (u._id.toString() !== user._id.toString()) {
          chatRoom.fullName = u.firstName + " " + u.lastName;
        }
      });
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

/* /chat/group => POST request */
exports.createGroupChatRoom = async (req, res, next) => {
  const user = req.admin || req.user;
  const name = req.body.name;
  if (!req.body.users || !req.body.name) {
    return res.status(400).send({ message: "Please Fill all the feilds" });
  }

  // Split the comma-separated user IDs and convert them to ObjectId

  const users = JSON.parse(req.body.users).map(
    (userId) => new mongoose.Types.ObjectId(userId.trim())
  );

  if (users.length < 2) {
    return res
      .status(400)
      .send("More than 2 users are required to form a group chat");
  }

  users.push(user._id);

  try {
    console.log(name, users, user);
    const chatRoom = new ChatRoom({
      fullName: name,
      users: users,
      isGroupChat: true,
      admin: user._id,
    });
    console.log("here");
    const savedChatRoom = await chatRoom.save();
    const populatedChatRoom = await ChatRoom.findById(
      savedChatRoom._id
    ).populate({
      path: "users",
      model: "Admin",
      select: "-password",
    });
    console.log("here3");
    res
      .status(201)
      .json({ message: "Group chat room created", populatedChatRoom });
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};

/* /chat/rename-group => PUT request */

exports.renameGroupChatRoom = async (req, res, next) => {
  const { roomId, newName } = req.body;

  if (!roomId || !newName || newName.length > 25) {
    const error = new Error("Failed to fetch input data.");
    error.statusCode = 400;
    next(error);
  }
  try {
    const updatedRoom = await ChatRoom.findByIdAndUpdate(
      roomId,
      { fullName: newName },
      { new: true }
    )
      .populate({
        path: "users",
        model: "Admin", // Use 'Admin' model instead of 'User' model
        select: "-password",
      })
      .populate({
        path: "admin",
        model: "Admin",
        select: "-password",
      });

    if (updatedRoom) {
      res.status(200).json({
        message: `updated name successfully to ${newName}`,
        updatedRoom,
      });
    } else {
      throwError("updating room name whent wrong", 400, "new name");
    }
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    next(error);
  }
};
/* /add-user-to-group => put request */
exports.addUserToGroupChatRoom = async (req, res, next) => {
  const { roomId, userId } = req.body;

  if (!roomId || !userId) {
    const error = new Error("Failed to fetch input data.");
    error.statusCode = 400;
    next(error);
  }
  try {
    const updatedRoom = await ChatRoom.findByIdAndUpdate(
      roomId,
      { $push: { users: userId } },
      { new: true }
    )
      .populate({
        path: "users",
        model: "Admin",
        select: "-password",
      })
      .populate({
        path: "admin",
        model: "Admin",
        select: "-password",
      });
    if (updatedRoom) {
      res.status(200).json({
        message: `user with id ${userId} was added to group ${updatedRoom.fullName}.`,
        updatedRoom,
      });
    } else {
      throwError("updating room name whent wrong", 400, "new name");
    }
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    next(error);
  }
};

/* /remove-user-from-group => put request */
exports.removeUserFromGroupChatRoom = async (req, res, next) => {
  const { roomId, userId } = req.body;

  if (!roomId || !userId) {
    const error = new Error("Failed to fetch input data.");
    error.statusCode = 400;
    next(error);
  }
  try {
    const updatedRoom = await ChatRoom.findByIdAndUpdate(
      roomId,
      { $pull: { users: userId } },
      { new: true }
    )
      .populate({
        path: "users",
        model: "Admin",
        select: "-password",
      })
      .populate({
        path: "admin",
        model: "Admin",
        select: "-password",
      });
    if (updatedRoom) {
      res.status(200).json({
        message: `user with id ${userId} was removed from group ${updatedRoom.fullName}.`,
        updatedRoom,
      });
    } else {
      throwError("updating room name whent wrong", 400, "new name");
    }
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    next(error);
  }
};
/*
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
    //send message to socket
    io.to(roomId).emit("message", {
      message: savedMessage,
      sender: user._id,
      chatRoom: roomId,
    });
    //update chat room
    chatRoom.latestMessage = savedMessage._id;
    await chatRoom.save();
    //
    chatRoom.users.forEach((user) => {
      if (user._id.toString() !== newMessage.sender._id.toString()) {
        socket.in(user._id).emit("recieve-message", newMessage);
      }
    });
    //
    res.status(201).json({ message: "Message sent", message: savedMessage });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};
*/
function throwError(message, statusCode, path) {
  const error = new Error(message);
  error.statusCode = statusCode;
  error.path = path;
  throw error;
}
