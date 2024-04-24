const express = require("express");

const router = express.Router();

const chatController = require("../controllers/chat");

const messageController = require("../controllers/message");

const adminAuth = require("../middleware/admin-auth");

const auth = require("../middleware/is-auth");

router.get("/rooms", adminAuth, auth, chatController.fetchChatRooms);

//search for users
router.get("/users", adminAuth, auth, chatController.allUsers);

//access or create chat room
router.post("/access-room", adminAuth, auth, chatController.accessChatRoom);

router.post("/group", adminAuth, auth, chatController.createGroupChatRoom);

router.put(
  "/rename-group",
  adminAuth,
  auth,
  chatController.renameGroupChatRoom
);

router.put(
  "/add-user-to-group",
  adminAuth,
  chatController.addUserToGroupChatRoom
);

router.put(
  "/remove-user-from-group",
  adminAuth,
  auth,
  chatController.removeUserFromGroupChatRoom
);

//send message
router.post("/message", adminAuth, auth, messageController.sendMessage);

router.get("/room/:roomId", adminAuth, auth, messageController.FetchMessages);

// router.post("/create-chat-room", adminAuth,chatController.createChatRoom);

module.exports = router;
