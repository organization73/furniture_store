// const nodemailer = require("nodemailer");
// const sendgridTransport = require("nodemailer-sendgrid-transport");

// const API_KEY =
//   "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";
// const SINGLE_SENDER = '"furapp" sara.momo7112@gmail.com';

// const transporter = nodemailer.createTransport(
//   sendgridTransport({
//     auth: {
//       api_key: API_KEY,
//     },
//   })
// );
// const email = 'abdo.make631@gmail.com';
// transporter
//   .sendMail({
//     to: email,
//     from: SINGLE_SENDER,
//     subject: "Reset your password!",
//     html: `
//           <h1>Ready to Reset?</h1>
//           <p> [[Test]] Click this <a href='http://localhost:3000/reset/'> link </a> to set a new password</p>
//           `,
//   })
//   .catch((err) => console.log("asdfa", err));

// const nodemailer = require('nodemailer');

// const transporter = nodemailer.createTransport({
//   service: 'gmail',
//   auth: {
//     user: 'abdobeter123@gmail.com',
//     pass: 'iubdoigehhktcqof'
//   }
// });

// const mailOptions = {
//   from: 'abdobeter123@gmail.com',
//   to: 'abdo.make73@gmail.com',
//   subject: 'Sending Email using Node.js',
//   text: 'That was easy!'
// };

// transporter.sendMail(mailOptions, function(error, info){
//   if (error) {
//     console.log(error);
//   } else {
//     console.log('Email sent: ' + info.response);
//   }
// });

"use strict";
c

// async..await is not allowed in global scope, must use a wrapper
async function main() {
  // send mail with defined transport object
  const info = await transporter.sendMail({
    from: `"Fred Foo 👻" <${from}>`, // sender address
    to: "abdo.make631@gmail.com", // list of receivers
    subject: "Hello ✔", // Subject line
    text: "Hello world?", // plain text body
    html: "<b>Hello world?</b>", // html body
  });

  console.log("Message sent: %s", info.messageId);
  // Message sent: <b658f8ca-6296-ccf4-8306-87d57a0b4321@example.com>

  //
  // NOTE: You can go to https://forwardemail.net/my-account/emails to see your email delivery status and preview
  //       Or you can use the "preview-email" npm package to preview emails locally in browsers and iOS Simulator
  //       <https://github.com/forwardemail/preview-email>
  //
}

main().catch(console.error);