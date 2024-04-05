const express = require("express");

const User = require("../models/user");

const router = express.Router();

router.put("/assign-image", async (req, res, next) => {
  const { imageUrl } = req.body;
  req.user.imageUrl = imageUrl;
  await req.user.save();
  res.status(200).json({ message: "Image assigned" });
});

module.exports = router;
