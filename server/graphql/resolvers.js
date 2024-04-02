const Product = require("../models/product");
const PRODUCTS_PER_PAGE = 2;
const User = require("../models/user");

const root = {
  products: async function ({ page }, { req }, context, info) {
    // Get requested fields for the `products` field
    console.log("context:", context);
    console.log("info:", info)
    console.log("info:", info.fieldNodes[0].arguments[0].loc.source.body)
    //validating data
    if (!page) page = 1;
    let products;
    try {
      products = await Product.find()
        .populate("creator", "-password")
        .skip((page - 1) * PRODUCTS_PER_PAGE)
        .limit(PRODUCTS_PER_PAGE)
        .sort({ createdAt: -1 }).select("_id "); //can be make on client side
        console.log("products:", products);
    } catch (error) {
      throw error;
    }

    const return_values = {
      products: products.map((p) => {
        return {
          ...p._doc,
          _id: p._id.toString(),
          creator: p.creator._id.toString(),
          ImageUrl: p.imageUrl,
          creator: p.creator,
          createdAt: p.createdAt.toISOString(),
          updatedAt: p.updatedAt.toISOString(),
        };
      }),
    };
    return return_values;
  },

  product: async function ({ id }, { req }) {
    //fetching data
    let product;
    try {
      product = await Product.findById(id).populate("creator", "-password");
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      throw error;
    }
    //validating data existance
    if (!product) {
      const error = new Error("Could not find product.");
      error.statusCode = 404;
      throw error;
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
      user = await User.findById(id).select("-password");
      console.log("user:", user);
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      // throw error;
      throw error;
    }
    //validate user exist.
    if (!user) {
      const error = new Error("User not found.");
      error.statusCode = 404;
      // throw error;
      throw error;
    }
    return {
      ...user._doc,
      _id: user._id.toString(),
    };
  },
};

module.exports = root;
