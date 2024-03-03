const express = require("express");

const router = express.Router();

const chatController = require("../controllers/chat");

const adminAuth = require("../middleware/admin-auth");

router.get("/rooms", adminAuth, chatController.getChatRooms);

// router.get("/room/:roomId", adminAuth, chatController.getChatRoom);

router.post("/message", adminAuth, chatController.sendMessage);

router.post("/create-chat-room", adminAuth,chatController.createChatRoom);


module.exports = router;