const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const messageSchema = new Schema({
  chatRoom: { type: Schema.Types.ObjectId, ref: "ChatRoom", required: true },
  sender: { type: Schema.Types.ObjectId, ref: "User", required: true },
  content: { type: String, required: true },
  type: { type: String, required: true },
  isRead: { type: Boolean, default: false },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("Message", messageSchema);
