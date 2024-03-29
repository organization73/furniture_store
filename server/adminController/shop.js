const Product = require("../models/product");

const PRODUCTS_PER_PAGE = 4;

module.exports.getIndex = (req, res, next) => {
  res.render("shop/index", {
    path: "/",
    pageTitle: "Home",
    errorMessage: null, // Pass the stored flash message to the view
    isAuthenticated: req.admin ? true : false,
  });
};

module.exports.getChat = (req, res, next) => {
  res.render("shop/chat", {
    path: "/chat",
    pageTitle: "chat",
    errorMessage: null, // Pass the stored flash message to the view
    isAuthenticated: req.admin ? true : false,
    currentUser: req.admin,
  });
};

module.exports.getProducts = async (req, res, next) => {
  const page = req.query.page || 1;
  try {
    const products = await Product.find()
      .skip(PRODUCTS_PER_PAGE * (page - 1))
      .limit(PRODUCTS_PER_PAGE);
    res.render("admin/products", {
      path: "/products",
      pageTitle: "Products",
      errorMessage: null, // Pass the stored flash message to the view
      isAuthenticated: req.admin ? true : false,
      products: products,
    });
  } catch (err) {
    next(err);
  }
};

module.exports.deleteProduct = async (req, res, next) => {
  const productId = req.params.productId;
  console.log("productId", productId);
  try {
    const product = await Product.findByIdAndDelete(productId);
    res
      .status(200)
      .json({ message: "Product was deleted successfullySuccess", product });
  } catch (err) {
    next(err);
  }
};
