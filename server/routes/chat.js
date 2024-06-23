const express = require("express");

const router = express.Router();

const chatController = require("../controllers/chat");

const messageController = require("../controllers/message");

const adminAuth = require("../middleware/admin-auth");

const auth = require("../middleware/is-auth");

router.get("/rooms", auth, chatController.fetchChatRooms);

//search for users
router.get("/users", auth, chatController.allUsers);

//access or create chat room
router.post("/access-room", auth, chatController.accessChatRoom);

router.post("/group", auth, chatController.createGroupChatRoom);

router.put("/rename-group", auth, chatController.renameGroupChatRoom);

router.put("/add-user-to-group", auth, chatController.addUserToGroupChatRoom);

router.put(
  "/remove-user-from-group",
  auth,
  chatController.removeUserFromGroupChatRoom
);

//send message
router.post("/message", auth, messageController.sendMessage);

router.get("/room/:roomId", auth, messageController.FetchMessages);

// router.post("/create-chat-room", adminAuth,chatController.createChatRoom);

module.exports = router;
