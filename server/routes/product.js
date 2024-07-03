const express = require("express");
const router = express.Router();
const productController = require("../controllers/product");

router.post("/create-product", productController.createProduct);

router.post("/create-ai-product", productController.createAIProduct);

//create a route for rating products
router.post("/rate-product", productController.rateProduct);

//edit a product
router.put("/edit-rate", productController.editRate);

router.post("/edit-product", productController.editProduct);

router.delete("/delete-rate", productController.deleteRate);

//delete a product
router.delete("/delete-product", productController.deleteProduct);

//delete ai product
router.delete("/delete-ai-product", productController.deleteAIProduct);

module.exports = router;