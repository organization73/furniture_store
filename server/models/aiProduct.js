const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const aiProductsSchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    required: true, 
  },
  title: String,
  price: Number,
  imageUrl: String,
  description: String,
});

module.exports = mongoose.model("aiProduct", aiProductsSchema);
