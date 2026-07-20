const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const adminSchema = new Schema({
  firstName: { type: String, default:"temp" },
  lastName: { type: String, default:"temp" },
  username: { type: String, default:"temp" },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("Admin", adminSchema);
