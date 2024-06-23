const axios = require("axios");
const yup = require("yup");

const fs = require("fs");
const path = require("path");

const Product = require("../models/product");

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
      const response = await fetch(
        `http://localhost:8000/predict?image_url=${imageUrl}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
        }
      );
      const classificationResult = await response.json();
      if (response.status !== 201 && response.status !== 200) {
        throw new Error("imageUrl not valid.");
      }

      imagesObjests.push({
        imageUrl: imageUrl,
        class: classificationResult.class,
        confidence: classificationResult.confidence,
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

// exports.createProduct = async (req, res, next) => {
//   // Validate the product data
//   const { title, price, description } = req.body;
//   const details = JSON.parse(req.body.details);
//   try {
//     productSchema.validateSync({ title, price, description, details });
//   } catch (error) {
//     return throwError(422, error.message, error.path, next);
//   }
//   //validationg images
//   console.log(req.files.length);
//   if (!req.files.length) {
//     // errorsList.push({ message: "No image provided", path: "images" });
//     return throwError(422, "No image provided", "images", next);
//   }

//   const images = req.files.map((file) => {
//     return { imageUrl: file.path };
//   });
//   console.log("images:", images);

//   //Create the product
//   const product = new Product({
//     creator: req.user._id, //why id required?
//     title: title,
//     price: price,
//     description: description,
//     images: images,
//     details: details,
//   });
//   console.log("product:", product);
//   // Save the product
//   try {
//     await product.save();
//   } catch (error) {
//     error.codeStatus = 401;
//     next(error);
//   }
//   //add the product to the user's products array
//   try {
//     req.user.products.push(product);
//     await req.user.save();
//   } catch (error) {
//     return throwError(500, "Adding product to user failed");
//   }

//   res.status(201).json({ message: "Product created" });
// };

function throwError(codeStatus, message, path, next) {
  const error = new Error(message);
  error.statusCode = codeStatus;
  error.path = path;
  return next(error);
}
