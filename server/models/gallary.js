const { name } = require("ejs");
const mongoose = require("mongoose");
const { string } = require("yup");
const Schema = mongoose.Schema;

const gallarySchema = new Schema(
  {
    creator: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    country: String,
    city: String,
    street: String,
    images: [
      {
        imageUrl: {
          type: String,
        },
      },
    ],
    certificate: {
      type: String,
    },
    coordinates: {
      lat: { type: Number },
      lng: { type: Number },
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Gallary", gallarySchema);
