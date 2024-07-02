const axios = require("axios");
const yup = require("yup");

const fs = require("fs");
const path = require("path");

const Product = require("../models/product");
const AiProduct = require("../models/aiProduct");
const ProductRate = require("../models/productRate");

const productSchema = yup.object().shape({
  title: yup.string().required(),
  price: yup.number().required(),
  description: yup.string().required(),
  rate: yup.number(),
  details: yup
    .object()
    .shape({
      wood: yup.string().required(),
      //   abalakach: yup.string(),
      cloth: yup.string().required(),
      condition: yup.string().required(),
      color: yup.string().required(),
      delevary: yup.boolean().required(),
      negotiable: yup.boolean().required(),
      modefiable: yup.boolean().required(),
    })
    .required(),
});

const aiProductSchema = yup.object().shape({
  title: yup.string(),
  price: yup.number(),
  category: yup.string(),
  subCategory: yup.string(),
  imageUrl: yup.string(),
  description: yup.string(),
});

const rateProductSchema = yup.object().shape({
  productId: yup.string().required(),
  rate: yup.number().required(),
  description: yup.string(),
});

exports.createProduct = async (req, res, next) => {
  // Validate the product data
  const { title, price, description, details, images } = req.body;
  try {
    productSchema.validateSync({ title, price, description, details });
  } catch (error) {
    next(error);
    return throwError(422, error.message, error.path, next);
  }
  //classfiy images
  let imagesObjests = [];
  for (let i = 0; i < images.length; i++) {
    const imageUrl = images[i];
    try {
      //make the values fixed until the AI model is deployed.
      // const response = await fetch(
      //   `http://localhost:8000/predict?image_url=${imageUrl}`,
      //   {
      //     method: "POST",
      //     headers: {
      //       "Content-Type": "application/json",
      //     },
      //   }
      // );
      // const classificationResult = await response.json();
      // if (response.status !== 201 && response.status !== 200) {
      //   throw new Error("imageUrl not valid.");
      // }

      // imagesObjests.push({
      //   imageUrl: imageUrl,
      //   class: classificationResult.class,
      //   confidence: classificationResult.confidence,
      // });
      imagesObjests.push({
        imageUrl: "https://i.ibb.co/nPHVzyG/char1.jphttps://as2.ftcdn.net/v2/jpg/00/64/19/57/1000_F_64195798_bgbXhuyHTLrW1xBhQ6b7woFyEDxxzQpR.jpg",
        class: "chair",
        confidence: 98,
      });
    } catch (error) {
      console.error("Error classifying image:", error);
      res.status(500).json({ error: "Failed to classify image" });
    }
  }
  console.log("imagesObjests111:", imagesObjests);
  try {
    //Create the product
    const product = new Product({
      creator: req.user._id, //why id required?
      title: title,
      price: price,
      description: description,
      images: imagesObjests,
      details: details,
    });
    // Save the product
    await product.save();
    console.log("product saved success");

    //add the product to the user's products array
    console.log("start saving..");
    req.user.products.push(product._id);
    await req.user.save();
    console.log("product added to user");
  } catch (error) {
    error.codeStatus = 401;
    next(error);
  }

  res.status(201).json({ message: "Product created" });
};

exports.createAIProduct = async (req, res, next) => {
  console.log("create ai p");
  const { title, price, description, category, subCategory, imageUrl } =
    req.body;
  //validate user input.
  try {
    await aiProductSchema.validateSync({
      title,
      price,
      description,
      category,
      subCategory,
      imageUrl,
    });
  } catch (error) {
    return throwError(422, error.message, error.path, next);
  }

  //create the product
  const product = new AiProduct({
    creator: req.user._id,
    title: title,
    price: price,
    category: category,
    subCategory: subCategory,
    imageUrl: imageUrl,
    description: description,
  });

  //save the product
  try {
    await product.save();
    res.status(201).json({ message: "Product created successfully" });
  } catch (error) {
    return throwError(500, "Failed to save product", "server", next);
  }
};

exports.rateProduct = async (req, res, next) => {
  const { productId, rate, description } = req.body;
  //validate the user input
  try {
    await rateProductSchema.validateSync({ productId, rate, description });
  } catch (error) {
    return throwError(422, error.message, error.path, next);
  }

  //find the product
  let product = await Product.findById(productId).populate("rates");
  if (!product) {
    return throwError(404, "Product not found", "server", next);
  }
  //check if the user has already rated the product
  const rated = product.rates.find(
    (rateObject) => rateObject.customer.toString() === req.user._id.toString()
  );

  if (rated) {
    return res
      .status(403)
      .json({ message: "You have already rated this product", rate: rated });
  }

  //create the product rate
  const productRate = new ProductRate({
    product: productId,
    customer: req.user._id,
    rate: rate,
    description: description,
  });

  //save the rate
  try {
    await productRate.save();
  } catch (error) {
    return throwError(500, "Failed to save rate", "server", next);
  }

  //add the rate to the prouct rates array
  try {
    let totalRates =
      product.rates.reduce((acc, rateObject) => acc + rateObject.rate, 0) +
      rate;
    product.rates.push(productRate._id);
    //update the average rate.
    console.log("product.rates:", product.rates);
    console.log("total rates:", totalRates);
    console.log("product.rates.length:", product.rates.length);
    const newRate = totalRates / product.rates.length;
    product.rate = newRate;
    await product.save();
    res.status(201).json({ message: "Rate saved successfully" });
  } catch (error) {
    return throwError(
      500,
      error.message || "Failed to save rate to product",
      "server",
      next
    );
  }
};

exports.deleteProduct = async (req, res, next) => {
  const { productId } = req.body;

  //validate the date
  if (!productId) {
    return throwError(422, "productId is required", "server", next);
  }

  //find the product
  try {
    let product = await Product.findById(productId);

    //check if the user is authorized to delete the product
    if (product.creator.toString() === req.user._id.toString()) {
      //delete the product
      await Product.findByIdAndDelete(productId);
    } else {
      //user is not authorized to delete the product
      return throwError(
        403,
        "You are not authorized to delete this product",
        "server",
        next
      );
    }

    //check if the product was deleted
    if (product) {
      //delete the product from the user's products array
      req.user.products = req.user.products.filter((product) => {
        if (product._id.toString() === productId.toString()) {
          return false;
        }
        return product._id.toString() !== productId.toString();
      });
      await req.user.save();
      return res.status(200).json({ message: "Product deleted successfully" });
    } else {
      //product not found
      return throwError(404, "Product not found", "server", next);
    }
  } catch (error) {
    next(error);
  }
};

exports.deleteAIProduct = async (req, res, next) => {
  const { productId } = req.body;

  //validate the date
  if (!productId) {
    return throwError(422, "productId is required", "server", next);
  }

  //find the product
  try {
    let product = await AiProduct.findById(productId);

    //check if the user is authorized to delete the product
    if (product.creator.toString() === req.user._id.toString()) {
      //delete the product
      await AiProduct.findByIdAndDelete(productId);
    } else {
      //user is not authorized to delete the product
      return throwError(
        403,
        "You are not authorized to delete this product",
        "server",
        next
      );
    }

    //check if the product was deleted
    if (product) {
      return res.status(200).json({ message: "Product deleted successfully" });
    } else {
      //product not found
      return throwError(404, "Product not found", "server", next);
    }
  } catch (error) {
    next(error);
  }
};

exports.editProduct = async (req, res, next) => {
  const { productId, title, price, description, details, images } = req.body;

  //validate the data
  try {
    productSchema.validateSync({ title, price, description, details });
  } catch (error) {
    return throwError(422, error.message, error.path, next);
  }

  //find the product
  try {
    let product = await Product.findById(productId);
    if (!product) {
      return throwError(404, "Product not found", "server", next);
    }

    //check if the user is authorized to edit the product
    if (product.creator.toString() !== req.user._id.toString()) {
      return throwError(
        403,
        "You are not authorized to edit this product",
        "server",
        next
      );
    }

    //edit the product
    product.title = title;
    product.price = price;
    product.description = description;
    product.details = details;
    product.images = images;
    await product.save();
    return res.status(200).json({ message: "Product edited successfully" });
  } catch (error) {
    next(error);
  }
}

function throwError(codeStatus, message, path, next) {
  const error = new Error(message);
  error.statusCode = codeStatus;
  error.path = path;
  return next(error);
}
