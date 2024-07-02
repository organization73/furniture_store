const yup = require("yup");

const User = require("../models/user");
const Gallary = require("../models/gallary");
const Product = require("../models/product");
const AiProduct = require("../models/aiProduct");
const Rate = require("../models/productRate");
const Message = require("../models/message");
const Chatroom = require("../models/chatRoom");

const gallarySchema = yup.object().shape({
  name: yup.string().required(),
  address: yup.string(),
  images: yup.array().of(
    yup.object().shape({
      imageUrl: yup.string().required(),
    })
  ),
  certificate: yup.string(),
});

exports.assignImage = async (req, res, next) => {
  const { imageUrl } = req.body;
  req.user.imageUrl = imageUrl;
  await req.user.save();
  res.status(200).json({ message: "Image assigned" });
};

exports.addGallary = async (req, res, next) => {
  const { name, address, images, certificate, coordinates } = req.body;

  //validate data.
  try {
    await gallarySchema.validate({
      name,
      address,
      images,
      certificate,
    });
  } catch (err) {
    return res.status(400).json({ message: err.errors[0] });
  }

  //create a new gallary
  const gallary = new Gallary({
    name,
    address,
    images,
    certificate,
    coordinates,
    creator: req.user._id,
  });

  //save the gallary
  try {
    await gallary.save();
    if (!req.user.gallaries) {
      req.user.gallaries = [];
    }
    req.user.type = "Gallery";
    req.user.gallaries.push(gallary._id);
    await req.user.save();
    res.status(201).json({ message: "Gallary created", gallary });
  } catch (err) {
    next(err);
  }
};

exports.deleteGallary = async (req, res, next) => {
  const { gallaryId } = req.body;

  //validate data
  if (!gallaryId) {
    return res.status(400).json({ message: "gallaryId is required" });
  }

  try {
    //find the gallary
    const gallary = await Gallary.findById(gallaryId);
    if (!gallary) {
      const error = new Error("Gallary not found");
      error.statusCode = 404;
      throw error;
    }

    //check if the user is the creator of the gallary
    if (gallary.creator.toString() !== req.user._id.toString()) {
      const error = new Error("Not authorized");
      error.statusCode = 403;
      throw error;
    }

    //delete the gallary
    await Gallary.findByIdAndDelete(gallaryId);
    req.user.gallaries = req.user.gallaries.filter(
      (g) => g.toString() !== gallaryId.toString()
    );
    await req.user.save();

    res.status(200).json({ message: "Gallary deleted" });
  } catch (err) {
    next(err);
  }
};

exports.deleteUser = async (req, res, next) => {
  try {
    const user = await User.findByIdAndDelete(req.user._id);
    if (user) {
      res.status(200).json({ message: "User deleted" });

      //delete user's gallaries
      await Gallary.deleteMany({ creator: req.user._id });

      //delete user's products
      await Product.deleteMany({ creator: req.user._id });

      //delete user's ai products
      await AiProduct.deleteMany({ creator: req.user._id });

      //delete user's rates
      await Rate.deleteMany({ user: req.user._id });

      //delete user's chatrooms
      const chatRoom = await Chatroom.deleteMany({ users: req.user._id });

      //delete user's messages
      await Message.deleteMany({ chatRoom: chatRoom._id });
      
      res.status(200).json({ message: `${user.username} was deleted.` });
    } else {
      const error = new Error("User not found");
      error.statusCode = 404;
      throw error;
    }
  } catch (err) {
    next(err);
  }
};
