const express = require("express");

const shopController = require("../adminController/shop");
const isAuth = require("../middleware/admin-auth");

const router = express.Router();
router.get("/", isAuth, shopController.getIndex);

router.get("/products", isAuth, shopController.getProducts);

// router.get("/edit-product/:productId", isAuth, shopController.getEditProduct);

// router.post("/edit-product", isAuth, shopController.postEditProduct);

router.delete("/product/:productId", isAuth, shopController.deleteProduct);

//approve products
router.patch("/approve-product/:productId", isAuth, shopController.approveProduct);

//get product details
router.get("/product-details/:productId", isAuth, shopController.getProduct);

router.get("/chat", isAuth, shopController.getChat);

module.exports = router;
