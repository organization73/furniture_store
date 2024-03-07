//todo
//flash an error 1 in failed to signup with reasons
const jwt = require("jsonwebtoken");
const crypto = require("crypto");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const sendgridTransport = require("nodemailer-sendgrid-transport");
//get all the validation errors might have been thrown
const { validationResult } = require("express-validator");

const Admin = require("../models/admin");

const API_KEY =
  "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";
const SINGLE_SENDER = '"furnature" sara.momo7112@gmail.com';

const transporter = nodemailer.createTransport(
  sendgridTransport({
    auth: {
      api_key: API_KEY,
    },
  })
);

exports.getLogin = (req, res, next) => {
  res.render("auth/login", {
    path: "/login",
    pageTitle: "Login",
    errorMessage: null, // Pass the stored flash message to the view
    oldInput: {
      email: "",
      password: "",
      confirmPassword: "",
    },
    validationErrors: [],
    isAuthenticated: false,
  });
};

exports.getSignup = (req, res, next) => {
  res.render("auth/signup", {
    path: "/signup",
    pageTitle: "Signup",
    isAuthenticated: false,
    errorMessage: null,
    oldInput: {
      email: "",
      password: "",
      confirmPassword: "",
    },
    validationErrors: [],
  });
};

exports.postSignup = (req, res, next) => {
  const name = req.body.name;
  const email = req.body.email;
  const password = req.body.password;
  const confirmPassword = req.body.password;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(422).render("auth/signup", {
      path: "/signup",
      pageTitle: "Signup-PR",
      isAuthenticated: false,
      errorMessage: errors.array()[0].msg,
      oldInput: {
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      },
      validationErrors: errors.array(),
    });
  }
  crypto.randomBytes(32, (err, buffer) => {
    if (err) {
      console.log(err);
      //flash an error 1
      return res.redirect("/signup");
    }
    const token = buffer.toString("hex");
    bcrypt
      .hash(password, 12)
      .then((hashedPassword) => {
        const admin = new Admin({
          name: name || "temp",
          email: email,
          password: hashedPassword,
          isConfirmed: false,
          confirmToken: token,
          confirmTokenExpiration: Date.now() + 60000 * 120, //120min
          cart: { items: [] },
        });
        return admin.save();
      })
      .then((result) => {
        return res.redirect("/admin/login");
        // return transporter
        //   .sendMail({
        //     to: email,
        //     from: SINGLE_SENDER,
        //     subject: "Signup successfully!",
        //     html: `<h1>hi from us. </h1>
        //       <p> To confirm you email <a href='http://localhost:3000/reset/${token}'> Click here </a>
        //     `,
        //   })
        //   .catch((err) => console.log(err));
      })
      .catch((err) => console.log(err));
  });
};

exports.getProfile = (req, res, next) => {
  res.render("user/profile", {
    path: "/profile",
    pageTitle: "Profile",
    isAuthenticated: false,
    errorMessage: null,
  });
};

exports.postLogin = async (req, res, next) => {
  const email = req.body.email;
  const password = req.body.password;
  console.log(email, password);

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(422).render("auth/login", {
      path: "/login",
      pageTitle: "login-PR",
      isAuthenticated: false,
      errorMessage: errors.array()[0].msg,
      oldInput: {
        email: email,
        password: password,
      },
      validationErrors: errors.array(),
    });
  }

  try {
    const admin = await Admin.findOne({ email: email });
    if (!admin) {
      const error = new Error("Invalid email or password.");
      error.statusCode = 401;
      throw error;
    }

    const doMatch = await bcrypt.compare(password, admin.password);
    if (doMatch) {
      const token = jwt.sign(
        { adminId: admin._id, email: admin.email },
        process.env.JWT_SECRET,
        { expiresIn: "2d" }
      );
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      res.cookie("token", token, {
        httpOnly: true,
        maxAge: 1000 * 60 * 60 * 24* 2,
      });
      res.redirect("/admin");
    } else {
      const error = new Error("Invalid email or password.");
      error.statusCode = 401;
      throw error;
    }
  } catch (err) {
    console.log(err);
    return res.status(422).render("auth/login", {
      path: "/login",
      pageTitle: "login-PR",
      isAuthenticated: false,
      errorMessage: err.message,
      oldInput: {
        email: email,
        password: password,
      },
      validationErrors: errors.array(),
    });
  }
};

exports.postLogout = (req, res, next) => {
  res.cookie("token", "", { maxAge: 1 });
  res.redirect("/admin/login");
};

exports.getConfirmSignup = (req, res, next) => {
  const token = req.params.token;
  console.log(token);
  Admin.findOne({
    confirmToken: token,
    confirmTokenExpiration: { $gt: Date.now() },
  }).then((user) => {
    if (!user) {
      console.log("confirmfailed");
    }
    user.isConfirmed = true;
    user.confirmToken = undefined;
    user.confirmTokenExpiration = undefined;
    return user.save().then(() => {
      return res.render("auth/confirm-signup");
    });
  });
};
