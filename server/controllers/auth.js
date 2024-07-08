const yup = require("yup");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const sendgridTransport = require("nodemailer-sendgrid-transport");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");

const domain = require("../utils/domain");
const User = require("../models/user");
const { error } = require("console");
//todo
let from = "beterabdo811@gmail.com";
TOKEN_VALID_MIN = 120;
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
    .notOneOf([null], "Field cannot be null")
    .min(3, "first name from 3 to 12 characters")
    .max(12, "first name from 3 to 12 characters"),
  lastName: yup
    .string()
    .notOneOf([null], "Field cannot be null")
    .min(3, "last name from 3 to 12 characters")
    .max(12, "last name from 3 to 12 characters"),
  username: yup
    .string()
    .notOneOf([null], "Field cannot be null")
    .min(3, "user name from 3 to 25 characters")
    .max(25, "first name from 3 to 25 characters"),
  email: yup
    .string()
    .email("Invalid email form.")
    .required("Email is required"),
  password: yup
    .string()
    .notOneOf([null], "Field cannot be null")
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
    .notOneOf([null], "Field cannot be null"),
  phone: yup.string(),
});

exports.creatUser = async (req, res, next) => {
  //exprtactoin of data
  console.log("Create User\n+++++++");
  const {
    firstName,
    lastName,
    username,
    email,
    password,
    confirmPassword,
    phone,
  } = req.body;
  //Data Validation
  try {
    await userSchema.validate({
      firstName,
      lastName,
      username,
      email,
      password,
      confirmPassword,
      phone,
    });
  } catch (error) {
    return throwError(422, error.message, error.path, next);
  }
  console.log("data validated:", email);
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
    //check if phone already exist
    // if (phone) {
    //   const existingPhone = await User.findOne({ phone });
    //   if (existingPhone) {
    //     return throwError(409, "Phone is already in use", "phone", next);
    //   }
    // }
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
  console.log("password hashed:", email);
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
  console.log("email was send to:", email);

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
    phone,
  });
  //saving the user into the database
  try {
    const saveUser = await user.save();
    console.log("email was saved to:", email);
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
          .notOneOf([null], "Field cannot be null")
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
  const user = await User.findOne({
    email,
    isConfirmed: true,
    $or: [{ type: "Client" }, { type: "Gallery" }],
  });
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
    process.env.JWT_SECRET
  );
  // res.status(200).json({ token: token, userId: user._id.toString() ,username: user.username, email: user.email, firstName: user.firstName, lastName: user.lastName, isConfirmed: user.isConfirmed,});
  res.status(200).json({ token: token, user: user });
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
        <a href='${domain(req)}/auth/verify/${token}'> Verify </a> </p>
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
  user.confirmToken = token;
  user.confirmTokenExpiration = Date.now() + TOKEN_VALID_MIN * 60 * 1000;
  //saving the user into the database
  try {
    await user.save();
    return res.status(200).json({
      message: `Re-send emial to ${email} have been done successfully`,
    });
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
    if (!user) {
      return throwError(404, "user not found", "email", next);
    }

    //generating JSON web token.
    let token;
    if (user.isConfirmed) {
      token = jwt.sign(
        {
          email: user.email,
          userId: user._id,
        },
        process.env.JWT_SECRET
      );
    }

    return res.status(200).json({
      message: "Fetching user status successfully",
      isConfirmed: user.isConfirmed,
      token: token || undefined,
    });
  } catch (error) {
    if (!error.statusCode) error.statusCode = 422;
    return next(error);
  }
};

exports.sendResetPassword = async (req, res, next) => {
  console.log("reser");
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
  } catch (error) {
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
    user.resetToken = token;
    //give the token 120 min to expire
    user.resetTokenExpiration = Date.now() + TOKEN_VALID_MIN * 60 * 1000;
    await user.save();
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
      html: `<h2>Dear ${user.firstName},</h2>

      <p>We received a request to reset your password.</p>
      <p>If you made this request, please click on the link below to reset your password:</p>
      <p><a href='${domain(
        req
      )}/auth/reset-password/${token}'>Reset Password</a></p>
      <p>If you did not request a password reset, please ignore this email or contact support if you have any concerns.</p>
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
  const token = req.params.token;

  //Check if the token is valid
  if (!token) {
    return throwError(404, "no token was provided.", "token", next);
  }

  try {
    //Find the user with the token
    let user = await User.findOne({ resetToken: token });
    if (!user) {
      console.log("user not found");
      const error = new Error("user not found");
      error.statusCode = 404;
      throw error;
    }

    //Check if the token is expired
    if (user.resetTokenExpiration < Date.now()) {
      return res.status(404).json({ message: "Token expired" });
    }

    return res.render("auth/reset", {
      path: "/reset-password",
      pageTitle: "reset-password",
      token: token,
      errorMessage: null, // Pass the stored flash message to the view
      oldInput: {
        email: "",
        password: "",
        confirmPassword: "",
      },
      validationErrors: [],
      isAuthenticated: false,
    });
  } catch (error) {
    next(error);
  }
};

exports.resetPassword = async (req, res, next) => {
  const { email, token, password, confirmPassword } = req.body;
  console.log(email, token, password, confirmPassword);
  try {
    //validate the data
    if (password !== confirmPassword) {
      return throwErrorInfo(422, "Passwords do not match", "password");
    }
    if (!token) {
      return throwErrorInfo(404, "no token was provided.", "token");
    }

    await userSchema.validate({
      email,
      password,
      confirmPassword,
    });
  } catch (error) {
    if (!error.statusCode) error.statuscode = 500;
    throwError(error.statuscode, error.message, error.path, next);
  }

  try {
    //Find the user with the token
    let user = await User.findOne({ resetToken: token, email: email });
    if (!user) {
      return throwErrorInfo(404, "user not found", "user");
    }
    //Check if the token is expired
    if (user.resetTokenExpiration < Date.now()) {
      return throwErrorInfo(404, "Token expired", "token");
    }
    //hashing the password
    let hashedPassword = await bcrypt.hash(password, 12);

    //reset the password
    user.password = hashedPassword;
    user.resetToken = undefined;
    user.resetTokenExpiration = undefined;
    console.log(user);
    await user.save();
    return res.status(200).json({
      message: "Password reset successfully",
    });
  } catch (error) {
    next(error);
  }
};

exports.continueWithGoogle = async (req, res, next) => {
  //exprtactoin of data
  console.log("Create User\n+++++++");
  const { firstName, lastName, username, email, googleId } = req.body;
  //Data Validation
  try {
    await userSchema.validate({
      firstName,
      lastName,
      // username,
      email,
      googleId,
    });
  } catch (error) {
    return throwError(422, error.message, error.path, next);
  }
  console.log("data validated:", email);
  //Check if user's email  already exists
  try {
    const existingUser = await User.findOne({
      $and: [{ email }],
    });
    if (existingUser) {
      //check if user has a googleid
      if (!existingUser.googleId) {
        return throwError(
          409,
          "Email is already in use with ordinary signup",
          "email",
          next
        );
      }
      //if user exist. sign in
      //generating JSON web token.
      const token = jwt.sign(
        {
          email: existingUser.email,
          userId: existingUser._id,
        },
        process.env.JWT_SECRET
      );
      return res
        .status(200)
        .json({ token: token, user: existingUser, firstTime: false });
    }
  } catch (error) {
    if (!error.statusCode) error.statusCode = 500;
    next(error);
  }
  //user is first to signup
  //check if the username is already in use
  // try {
  //   const existingUser = await User.findOne({ username });
  //   if (existingUser) {
  //     return throwError(409, "Username is already in use", "username", next);
  //   }
  // } catch (error) {
  //   next(error);
  // }
  //hashing the password
  let hashedGoogleId;
  try {
    hashedGoogleId = await bcrypt.hash(googleId, 12);
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
  }
  console.log("GoogleId :", googleId);
  console.log("GoogleId hashed:", hashedGoogleId);

  //creating the user
  const user = new User({
    firstName,
    lastName,
    // username,
    email,
    isConfirmed: true,
    googleId: hashedGoogleId,
  });
  //saving the user into the database
  try {
    const saveUser = await user.save();
    console.log("email was saved :", email);
    return res
      .status(200)
      .json({
        message: "User created successfully",
        email: saveUser.email,
        firstTime: true,
      });
  } catch (err) {
    if (!err.statusCode) err.statusCode = 500;
    next(err);
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
