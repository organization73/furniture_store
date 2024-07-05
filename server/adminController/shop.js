const Product = require("../models/product");
const deleteFile = require("../utils/file").deleteFile;
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
    const totalItems = await Product.find({
      appellation: true,
    }).countDocuments();
    const products = await Product.find({ appellation: true })
      .skip(PRODUCTS_PER_PAGE * (page - 1))
      .limit(PRODUCTS_PER_PAGE);
    console.log("hasNextPage", PRODUCTS_PER_PAGE * page < totalItems);
    console.log("totalItems", totalItems);
    console.log("hasPreviousPage", page > 1);
    console.log("nextPage", +page + 1);
    console.log("previousPage", page - 1);
    console.log("lastPage", Math.ceil(totalItems / PRODUCTS_PER_PAGE));
    res.render("shop/products", {
      path: "/products",
      pageTitle: "Products",
      errorMessage: null, // Pass the stored flash message to the view
      isAuthenticated: req.admin ? true : false,
      products: products,
      currentPage: +page,
      hasNextPage: PRODUCTS_PER_PAGE * page < totalItems,
      hasPreviousPage: page > 1,
      nextPage: +page + 1,
      previousPage: page - 1,
      lastPage: Math.ceil(totalItems / PRODUCTS_PER_PAGE),
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
    if (!product) {
      const error = new Error("Product not found.");
      error.statusCode = 404;
      throw error;
    }
    console.log("product.images", product.images);
    product.images.forEach((image) => {
      console.log("image.imageUrl", image.imageUrl);
      deleteFile(image.imageUrl);
    });
    res
      .status(200)
      .json({ message: "Product was deleted successfullySuccess", product });
  } catch (err) {
    next(err);
  }
};

exports.approveProduct = async (req, res, next) => {
  const productId = req.params.productId;
  console.log("approving:", productId);
  try {
    const product = await Product.findOneAndUpdate(
      { _id: productId },
      { $set: { appellation: false } },
      { new: true }
    );
    res
      .status(201)
      .json({ message: "Product was approved successfully", product });
  } catch (err) {
    next(err);
  }
};

exports.getProduct = async (req, res, next) => {
  const productId = req.params.productId;
  try {
    const product = await Product.findById(productId).populate("creator");
    if (!product) {
      const error = new Error("Product not found.");
      error.statusCode = 404;
      throw error;
    }
    res.render("shop/product-details", {
      product: product,
      pageTitle: product.title,
      path: "/product-details",
      isAuthenticated: req.admin ? true : false,
    });
  } catch (err) {
    next(err);
  }
};
