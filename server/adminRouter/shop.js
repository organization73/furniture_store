const express = require("express");

const shopController = require("../adminController/shop");
const isAuth = require("../middleware/admin-auth");

const router = express.Router();
router.get("/", isAuth, shopController.getIndex);

router.get("/chat", isAuth, shopController.getChat);

module.exports = router;
