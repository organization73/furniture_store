const express = require("express");


const shopController = require("../test_controllers/shop");

const router = express.Router();
router.get("/", shopController.getIndex);

module.exports = router;
