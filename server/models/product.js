const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const productSchema = new Schema(
  {
    creator: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
    title: String,
    price: Number,
    description: String,
    images: [
      {
        imageUrl: {
          // _id: false, // Add this line to remove the _id from the subdocument
          type: String,
          required: true,
        },
      },
    ],
    rate: Number,
    details: {
      wood: String,
      abalakach: String,
      cloth: String,
      condition: String,
      color: String,
      // density: Number,
      delevary: Boolean,
      negotiable: Boolean,
      modefiable: Boolean,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("product", productSchema);
