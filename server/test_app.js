const { check } = require("express-validator");
const yup = require("yup");
const userSchema = yup.object().shape({
  firstName: yup
    .string()
    .notOneOf([null], 'Field cannot be null')
    // .required("لازم يوزر نيم")
    .min(3, "first name from 3 to 12 characters")
    .max(12, "first name from 3 to 12 characters"),
  // lastName: yup
  //   .string()
  //   .required()
  //   .min(3, "last name from 3 to 12 characters")
  //   .max(12, "last name from 3 to 12 characters"),
  // username: yup
  //   .string()
  //   .required()
  //   .min(3, "user name from 3 to 25 characters")
  //   .max(25, "first name from 3 to 25 characters"),
  // email: yup
  //   .string()
  //   .email("Invalid email form.")
  //   .required("Email is required"),
  // password: yup
  //   .string()
  //   .required()
  //   .min(6)
  //   .max(20)
  //   .matches(/[A-Z]/, "Password must contain at least one uppercase letter")
  //   .matches(/[0-9]/, "Password must contain at least one number")
  //   .matches(
  //     /[!@#$%^&*(),.?":{}|<>]/,
  //     "Password must contain at least one special character"
  //   ),
  // confirmPassword: yup
  //   .string()
  //   .min(6)
  //   .max(20)
  //   // .test("password-match", "Passwords must match", function (value) {
  //   //   console.log(value === this.parent.password);
  //   //   return value === this.parent.password;
  //   // })
  //   .required(),
});

const user = {
  firstName:null,
  lastName: "Doe",
  username: "saqs",
  email: "abdo.make73@gmail.com",
  password: "my_password1A@",
  confirmPassword: "my_password@",
};
console.log(user);

async function checkUser(user) {
  try {
    await userSchema.validate({ ...user });
    console.log("done");
  } catch (error) {
    console.log(error.message);
  }
}
checkUser(user);
