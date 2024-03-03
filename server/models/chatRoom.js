const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const chatRoomSchema = new Schema(
  {
    name: { type: String },
    // Require at least two users
    users: [
      {
        type: Schema.Types.ObjectId,
        ref: "User",
        validate: {
          validator: (arr) => arr.length =2,
          message: "Chat room must have at least 2 users",
        },
      },
    ],
    type: { type: String },
    latestMessage: { type: Schema.Types.ObjectId, ref: "Message" },
  },
  { timestamps: true }
);

module.exports = mongoose.model("ChatRoom", chatRoomSchema);
