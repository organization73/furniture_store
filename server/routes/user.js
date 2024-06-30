const express = require("express");
const yup = require("yup");

const User = require("../models/user");

const userController = require("../controllers/user");

const router = express.Router();

router.put("/assign-image", userController.assignImage);

router.post("/add-gallary",userController.addGallary);

module.exports = router;
