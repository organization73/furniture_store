const express = require("express");

const authController = require("../adminController/auth");
const authValidator = require("../validation/auth");
const isAuth = require("../middleware/admin-auth");
const router = express.Router();

router.get("/signup", authController.getSignup);

router.post("/signup", authValidator.signup, authController.postSignup);

router.get("/login", authController.getLogin);

router.post("/login", authValidator.login, authController.postLogin);

router.post("/logout", authController.postLogout);

router.get("/reset/:token", authController.getConfirmSignup);

module.exports = router;
