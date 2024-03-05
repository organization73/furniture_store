const yup = require("yup");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const sendgridTransport = require("nodemailer-sendgrid-transport");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");

const domain = require("../utils/domain");
const User = require("../models/user");
//todo
let from = "beterabdo811@gmail.com";
TOKEN_VALID_MIN = 60;
const transporter = nodemailer.createTransport({
  service: "gmail",
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    // TODO: replace `user` and `pass` values from <https://forwardemail.net>
    user: from,
    pass: "ghimkhikkyaywxle",
  },
});

const userSchema = yup.object().shape({
  firstName: yup
    .string()
    .notOneOf([null], 'Field cannot be null')
    .min(3, "first name from 3 to 12 characters")
    .max(12, "first name from 3 to 12 characters"),
  lastName: yup
    .string()
    .notOneOf([null], 'Field cannot be null')
    .min(3, "last name from 3 to 12 characters")
    .max(12, "last name from 3 to 12 characters"),
  username: yup
    .string()
    .notOneOf([null], 'Field cannot be null')
    .min(3, "user name from 3 to 25 characters")
    .max(25, "first name from 3 to 25 characters"),
  email: yup
    .string()
    .email("Invalid email form.")
    .required("Email is required"),
  password: yup
    .string()
    .notOneOf([null], 'Field cannot be null')
    .min(6)
    .max(20)
    .matches(/[A-Z]/, "Password must contain at least one uppercase letter")
    .matches(/[0-9]/, "Password must contain at least one number")
    .matches(
      /[!@#$%^&*(),.?":{}|<>]/,
      "Password must contain at least one special character"
    ),
  confirmPassword: yup
    .string()
    .min(6)
    .max(20)
    // .test("password-match", "Passwords must match", function (value) {
    //   console.log(value === this.parent.password);
    //   return value === this.parent.password;
    // })
    .notOneOf([null], 'Field cannot be null'),
});

exports.creatUser = async (req, res, next) => {
  //exprtactoin of data
  console.log("Create User\n+++++++");
  const { firstName, lastName, username, email, password, confirmPassword } =
    req.body;
  //Data Validation
  try {
    await userSchema.validate({
      firstName,
      lastName,
      username,
      email,
      password,
      confirmPassword,
    });
  } catch (error) {
    return throwError(422, error.message, error.path, next);
  }
  console.log("data validated:", email)
  //Check if user's email and username already exists
  try {
    const existingUser = await User.findOne({
      $or: [{ email }, { username: username }],
    });
    if (existingUser) {
      if (existingUser.email === email) {
        return throwError(409, "Email is already in use", "email", next);
        // return throwError(409, "Email is already in use", "email", next);
      } else {
        return throwError(
          409,
          "Username is already in sfduse1",
          "username",
          next
        );
      }
    }
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    next(error);
  }
  //hashing the password
  let hashedPassword;
  try {
    hashedPassword = await bcrypt.hash(password, 12);
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
  }
  console.log("password hashed:", email)
  //creating the token
  let token;
  try {
    token = await crypto.randomBytes(32).toString("hex");
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    return next(error);
  }
  //sending the confirmation email
  try {
    const info = await transporter.sendMail({
      from: `"furnature-app🛋️" <${from}>`,
      to: email,
      subject: "Signup Confirmation ✔",
      text: "Hello world?",
      html: `<h2>Dear ${firstName}</h2>

        <p>Thank you for signing up for our platform! </p>
        <p>To ensure that you have provided a valid email address</p>
        <p> please click on the link below to verify your account: <a href='${domain(
          req
        )}/auth/verify/${token}'> Verify </a> </p>
        <p>If you did not sign up for our platform, please ignore this email.</p>
        <p>Thank you for your cooperation.</p>
        <p>Best regards,</p>
        <p>College Team</p>
        `,
    });
    console.log("Message sent: %s", info.messageId);
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    return next(err);
  }
  console.log("email was send to:", email)

  //creating the user
  const user = new User({
    firstName,
    lastName,
    username,
    email,
    isConfirmed: false,
    confirmToken: token,
    confirmTokenExpiration: Date.now() + TOKEN_VALID_MIN * 60 * 1000,
    password: hashedPassword,
  });
  //saving the user into the database
  try {
    const saveUser = await user.save();
    console.log("email was saved to:", email)

    return res
      .status(200)
      .json({ message: "User created successfully", email: saveUser.email });
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
  }
};

exports.verifyUser = async (req, res, next) => {
  const token = req.params.token;
  //Check if the token belongs to a user
  try {
    const user = await User.findOne({
      confirmToken: token,
      confirmTokenExpiration: { $gt: Date.now() },
    });

    if (!user) {
      return throwError(404, "User not found", "user", next);
    }
    //confirm the user
    user.confirmToken = undefined;
    user.confirmTokenExpiration = undefined;
    user.isConfirmed = true;
    await user.save();
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    return next(error);
  }

  return res.status(200).send("User confirmed successfully");
};

exports.login = async (req, res, next) => {
  const { email, password } = req.body;
  //Data Validation
  try {
    await yup
      .object()
      .shape({
        email: yup
          .string()
          .email("Invalid email form.")
          .required("Email is required"),
        password: yup
          .string()
          .notOneOf([null], 'Field cannot be null')
          .min(6)
          .max(20)
          .matches(
            /[A-Z]/,
            "Password must contain at least one uppercase letter"
          )
          .matches(/[0-9]/, "Password must contain at least one number")
          .matches(
            /[!@#$%^&*(),.?":{}|<>]/,
            "Password must contain at least one special character"
          ),
      })
      .validate({ email, password });
  } catch (error) {
    if (!error.statusCode) error.statusCode = 422;
    return next(error);
  }

  //Check if the user exists and confirmed
  const user = await User.findOne({ email, isConfirmed: true });
  if (!user) {
    return throwError(404, "Email not found", "email", next);
  }
  //password validation
  const isEquals = await bcrypt.compare(password, user.password);
  if (!isEquals) {
    return throwError(401, "Invalid password", "password", next);
  }
  //generating JSON web token.
  const token = jwt.sign(
    {
      email: user.email,
      userId: user._id,
    },
    "thisisaverylong"
  );
  res.status(200).json({ token: token, userId: user._id.toString() });
};

exports.reVerifyEmail = async (req, res, next) => {
  const email = req.body.email;
  if (!email) {
    throwError(500, "no email was provided", "email", next);
  }
  //Check if the user exists
  let user;
  try {
    user = await User.findOne({ email, isConfirmed: false });
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
  }
  if (!user) {
    return throwError(404, "Email not found", "email", next);
  }
  //creating the token
  let token;
  try {
    token = await crypto.randomBytes(32).toString("hex");
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    return next(error);
  }
  //sending the confirmation email
  try {
    const info = await transporter.sendMail({
      from: `"furnature-app🛋️" <${from}>`,
      to: email,
      subject: "Re-Signup Confirmation ✔",
      text: "Hello world?",
      html: `<h2>Dear ${user.firstName}</h2>

        <p>Thank you for using our platform! </p>
        <p>To ensure that you have provided a valid email address</p>
        <p> please click on the link below to reset your password:
        <a href='${domain(req)}/auth/verify/${token}'> Reset </a> </p>
        <p>Thank you for your cooperation.</p>
        <p>Best regards,</p>
        <p>College Team</p>
        `,
    });
    console.log("Message sent: %s", info.messageId);
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
  }
  //Editser's token the user
  user.resetToken = token;
  user.resetTokenExpiration = Date.now() + TOKEN_VALID_MIN * 60 * 1000;
  //saving the user into the database
  try {
    const saveUser = await user.save();
    return res
      .status(200)
      .json({ message: "Re-send emial have been done successfully" });
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
  }
  return res
    .status(200)
    .json({ message: "We send you an eamil to reset your password." });
};

exports.isConfirmed = async (req, res, next) => {
  const email = req.body.email;
  //Data Validation
  try {
    await yup
      .object()
      .shape({
        email: yup
          .string()
          .email("Invalid email form.")
          .required("Email is required"),
      })
      .validate({ email });
  } catch (error) {
    if (!error.statusCode) error.statusCode = 422;
    return next(error);
  }
  //get user status
  let user;
  try {
    user = await User.findOne({ email });
  } catch (err) {
    if (!error.statusCode) error.statusCode = 422;
    return next(error);
  }
  if (!user) {
    return throwError(404, "user not found", "email", next);
  }
  return res.status(200).json({
    message: "Fetching user status successfully",
    isConfirmed: user.isConfirmed,
  });
};

exports.sendResetPassword = async (req, res, next) => {
  const email = req.body.email;
  //Data Validation
  try {
    await yup
      .object()
      .shape({
        email: yup
          .string()
          .email("Invalid email form.")
          .required("Email is required"),
      })
      .validate({ email });
  } catch (error) {
    if (!error.statusCode) error.statusCode = 422;
    return next(error);
  }
  let user;
  try {
    user = await User.findOne({ email });
  } catch (err) {
    if (!error.statusCode) error.statusCode = 422;
    return next(error);
  }
  if (!user) {
    return throwError(404, "user not found", "email", next);
  }
  //creating the token
  let token;
  try {
    token = await crypto.randomBytes(32).toString("hex");
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    return next(error);
  }
  //sending the confirmation email
  try {
    const info = await transporter.sendMail({
      from: `"furnature-app🛋️" <${from}>`,
      to: email,
      subject: "Re-Signup Confirmation ✔",
      text: "Hello world?",
      html: `<h2>Dear ${user.firstName}</h2>

        <p>Thank you for signing up for our platform! </p>
        <p>To ensure that you have provided a valid email address</p>
        <p> please click on the link below to verify your account: <a href='${domain(
          req
        )}/auth/verify/${token}'> Verify </a> </p>
        <p>If you did not sign up for our platform, please ignore this email.</p>
        <p>Thank you for your cooperation.</p>
        <p>Best regards,</p>
        <p>College Team</p>
        `,
    });
    console.log("Message sent: %s", info.messageId);
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    return next(err);
  }
  return res.status(200).json({
    message: "sending email was done successgully.",
  });
};

exports.getResetPassword = async (req, res, next) => {
  const token = req.query.token;

  let user;
  try {
    user = await User.findOne({ resetToken: token });
  } catch (error) {
    return throwError(500, "user dosen't exists.", "email", next);
  }
  res.render("/user/resetPassword", {
    id: user._id,
  });
};

exports.resetPassword = async (req, res, next) => {
  const id = req.body;
  if (!id) {
    return res.status(404).json({ message: "no id was provided." });
  }
  try {
    const user = await User.findById(id);
    if (!user) {
      throwErrorInfo(404, "user not found!", "id");
    }
    user

  } catch (error) {
    if (!error.statusCode) error.statuscode = 500;
    throwError(error.statuscode, error.message, error.path, next);
  }
};
function throwError(codeStatus, message, path, next) {
  const error = new Error(message);
  error.statusCode = codeStatus;
  error.path = path;
  return next(error);
}

function throwErrorInfo(codeStatus, message, path) {
  const error = new Error(message);
  error.statusCode = codeStatus;
  error.path = path;
  throw error;
}
