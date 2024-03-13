const express = require("express");

const isAuth = require("../middleware/admin-auth");

const adminController = require("../adminController/admin");

const router = express.Router();

router.get("/profile", isAuth, adminController.getProfile);

module.exports = router;