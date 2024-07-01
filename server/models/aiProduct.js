const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const aiProductsSchema = new Schema(
  {
    creator: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    title: String,
    price: Number,
    category: String,
    subCategory: String,
    imageUrl: String,
    description: String,
    rates: { type: Schema.Types.ObjectId, ref: "productRate" },
  },
  { timestamps: true }
);

module.exports = mongoose.model("aiProduct", aiProductsSchema);
