const express = require("express");

const authController = require("../controllers/auth");
const authValidator = require("../validation/auth");
const router = express.Router();

// router.get("/login", authController.getLogin);

router.put("/signup", authController.creatUser);

router.get('/verify/:token', authController.verifyUser);

router.post("/login", authController.login);

router.post("/re-verify-email", authController.reVerifyEmail);

router.post("/is-confirmed", authController.isConfirmed);

router.post("/send-reset-password-email", authController.sendResetPassword);

router.get("/reset-password/:token", authController.getResetPassword);

router.post("/reset-password", authController.resetPassword);


module.exports = router;
