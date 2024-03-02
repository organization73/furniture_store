//todo
//flash an error 1 in failed to signup with reasons

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
        return res.redirect("/login");
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

exports.postLogin = (req, res, next) => {
  const email = req.body.email;
  const password = req.body.password;

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

  Admin.findOne({ email: email, isConfirmed: true })
    .then((user) => {
      if (!user) {
        // req.flash("error", "Invalid email or password.");
        return res.redirect("/login");
      }
      bcrypt.compare(password, user.password).then((doMatch) => {
        if (doMatch) {
          req.session.isLoggedIn = true;
          req.session.user = user;
          req.session.save((err) => {
            console.log(err);
            res.redirect("/");
          });
        } else {
          return res.redirect("/login");
        }
      });
    })
    .catch((err) => console.log(err));
};

exports.postLogout = (req, res, next) => {
  req.session.destroy((err) => {
    console.log(err);
    res.redirect("/");
  });
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
