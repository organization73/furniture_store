const express = require("express");

const router = express.Router();

const chatController = require("../controllers/chat");

const adminAuth = require("../middleware/admin-auth");

router.get("/", adminAuth, chatController.getChatRooms);

router.post("/create-chat-room", adminAuth,chatController.createChatRoom);


module.exports = router;