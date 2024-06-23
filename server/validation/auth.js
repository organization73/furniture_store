const { check, body } = require("express-validator");

const Admin = require("../models/user");

module.exports.signup = [
  check("email")
    .isEmail()
    .withMessage("Please enter a valid email.")
    .normalizeEmail({ gmail_remove_dots: false })
    .trim()
    .custom((value, { req }) => {
      console.log(value, "value")
      // if (value === "abdo") {
      //   console.log("value", value, value === "abdo");
      //   throw new Error("this email is forbidden");
      // }
      //if we return a promise express validator will wait for it to be fullfield.
      return Admin.findOne({ email: value }).then((adminDoc) => {
        if (adminDoc) {
          console.log("Email already exists.");
          //this reject will be stored as an error message.
          return Promise.reject("Email already exists.");
        }
      });
    }),
  body(
    "password",
    "Plese enter a pass with lenth more than or equal 5 ch."
  ).isLength({ min: 5 }),
  body("confirmPassword").custom((value, { req }) => {
    if (value !== req.body.password) {
      throw new Error("Passwords have to match!");
    }
    return true;
  }),
];

module.exports.login = [
  check("email", "Envalid  email.")
    .isEmail()
    .custom((value, { req }) => {
      return Admin.findOne({ email: value }).then((admin) => {
        if (!admin) {
          return Promise.reject("this email dosen't exists.");
        }
      });
    })
    .normalizeEmail({ gmail_remove_dots: false })
    .trim(),
  check("password", "password must be at least 5 characters.")
    .isLength({ min: 5 }),
];
