const yup = require("yup");

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
  const imagesObjests = images.map((image) => {
    return { imageUrl: image };
  });
  console.log("here");
  console.log("images3:", imagesObjests);
  // //validationg images
  // console.log(req.files.length);
  // if (!req.files.length) {
  //   // errorsList.push({ message: "No image provided", path: "images" });
  //   return throwError(422, "No image provided", "images", next);
  // }

  // const images = req.files.map((file) => {
  //   return { imageUrl: file.path };
  // });
  // console.log("images:", images);

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
    console.log("product:", product);
    // Save the product
    await product.save();
  } catch (error) {
    error.codeStatus = 401;
    next(error);
  }
  //add the product to the user's products array
  try {
    req.user.products.push(product);
    await req.user.save();
  } catch (error) {
    return throwError(500, "Adding product to user failed");
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
