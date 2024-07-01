const yup = require("yup");

const User = require("../models/user");
const Gallary = require("../models/gallary");

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
