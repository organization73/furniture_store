const express = require("express");


const shopController = require("../adminController/shop");

const router = express.Router();
router.get("/", shopController.getIndex);

module.exports = router;
