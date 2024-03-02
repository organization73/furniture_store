const express = require("express");
const { check, body } = require("express-validator");

const authController = require("../adminController/auth");
const User = require("../models/user");
const authValidator = require("../validation/auth");
const router = express.Router();

router.get("/login", authController.getLogin);

router.get("/signup", authController.getSignup);

router.get("/profile", authController.getProfile);

router.post("/login", authValidator.login, authController.postLogin);

router.post("/signup", authValidator.signup, authController.postSignup);

router.get("/reset/:token", authController.getConfirmSignup);

router.post("/logout", authController.postLogout);

module.exports = router;
