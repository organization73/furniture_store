const express = require("express");

const router = express.Router();

const chatController = require("../controllers/chat");

const messageController = require("../controllers/message");

const adminAuth = require("../middleware/admin-auth");

router.get("/rooms", adminAuth, chatController.fetchChatRooms);

//search for users
router.get("/users", adminAuth, chatController.allUsers);

//access or create chat room
router.post("/access-room", adminAuth, chatController.accessChatRoom);

router.post("/group", adminAuth, chatController.createGroupChatRoom);

router.put("/rename-group", adminAuth, chatController.renameGroupChatRoom);

router.put(
  "/add-user-to-group",
  adminAuth,
  chatController.addUserToGroupChatRoom
);

router.put(
  "/remove-user-from-group",
  adminAuth,
  chatController.removeUserFromGroupChatRoom
);
 
router.get("/room/:roomId", adminAuth, messageController.FetchMessages);
//send message
router.post("/message", adminAuth, messageController.sendMessage);

// router.post("/create-chat-room", adminAuth,chatController.createChatRoom);

module.exports = router;
