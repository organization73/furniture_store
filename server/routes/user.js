const express = require("express");
const yup = require("yup");

const User = require("../models/user");

const userController = require("../controllers/user");

const router = express.Router();

router.put("/assign-image", userController.assignImage);

router.post("/add-gallary",userController.addGallary);

router.delete("/delete-gallary",userController.deleteGallary);

router.delete("/delete-user",userController.deleteUser);

router.put("/update-user-info",userController.updateUser);

router.put("/update-user-password",userController.updatePassword);

module.exports = router;
