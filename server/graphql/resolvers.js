const Product = require("../models/product");
const PRODUCTS_PER_PAGE = 2;
const User = require("../models/user");

const root = {
  products: async function ({ page }, { req }) {
    //validating data
    if (!page) page = 1;
    let products;
    try {
      products = await Product.find()
        .populate("creator")
        .skip((page - 1) * PRODUCTS_PER_PAGE)
        .limit(PRODUCTS_PER_PAGE)
        .sort({ createdAt: -1 }); //can be make on client side
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }

    return {
      products: products.map((p) => {
        return {
          ...p._doc,
          _id: p._id.toString(),
          creator: p.creator._id.toString(),
          ImageUrl: p.imageUrl,
          // creator: {_id: p.creator._id.toString() },
          createdAt: p.createdAt.toISOString(),
          updatedAt: p.updatedAt.toISOString(),
        };
      }),
    };
  },

  product: async function ({ id }, { req }) {
    //fetching data
    let product;
    try {
      product = await Product.findById(id).populate("creator");
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
    //validating data existance
    if (!product) {
      const error = new Error("Could not find product.");
      error.statusCode = 404;
      next(error);
    }
    //returning data
    return {
      ...product._doc,
      _id: product._id.toString(),
      creator: product.creator,
      createdAt: product.createdAt.toISOString(),
      ImageUrl: product.imageUrl,
      updatedAt: product.updatedAt.toISOString(),
    };
  },
  hello: (parent, args, context, info) => {
    console.log(context);
    return "Hello world!";
  },
  user: async function ({ id }, { req }) {
    //validate Id
    console.log("id:", id);
    if (!id) {
      const error = new Error("Wrong Id.");
      error.statusCode = 404;
      throw error;
    }
    //fetching user's data
    let user;
    try {
      user = await User.findById(id);
      console.log("user:", user);
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      // next(error);
      throw error;
    }
    //validate user exist.
    if (!user) {
      const error = new Error("User not found.");
      error.statusCode = 404;
      // next(error);
      throw error;
    }
    return {
      ...user._doc,
      _id: user._id.toString(),
    };
  },
};

module.exports = root;
