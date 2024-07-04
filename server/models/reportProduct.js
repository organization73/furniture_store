const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const reportProductSchema = new Schema(
  {
    productId: {
      type: Schema.Types.ObjectId,
      ref: "Product",
      required: true,
    },
    reporter: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    reason: {
      type: String,
      default: "Wrong classification",
    },
  },
  { timestamps: true }
);

const ReportProduct = mongoose.model("ReportProduct", reportProductSchema);
module.exports = ReportProduct;