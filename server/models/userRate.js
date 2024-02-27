const userRatesSchema = new Schema({
  sellerId: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  customerId: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  rate: Number,
  description: String,
});
module.exports = mongoose.model("Userrate", userRatesSchema);
