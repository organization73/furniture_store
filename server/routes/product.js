const express = require("express");
const router = express.Router();
const productController = require("../controllers/product");

router.post("/create-product", productController.createProduct);

router.post("/create-ai-product", productController.createAIProduct);

//create a route for rating products
router.post("/rate-product", productController.rateProduct);

module.exports = router;