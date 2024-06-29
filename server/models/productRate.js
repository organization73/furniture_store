const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const productRatesSchema = new Schema(
  {
    product: {
      type: Schema.Types.ObjectId,
      required: true,
    },
    customer: {
      type: Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    rate: Number,
    description: String,
  },
  { timestamps: true }
);

module.exports = mongoose.model("productRate", productRatesSchema);
