const Admin = require("../models/admin");

exports.getProfile = (req, res, next) => {
  const admin = req.admin;
  admin.password = undefined;
  res.status(200).render("admin/profile", {
    pageTitle: "Admin Profile",
    path: "/profile",
    isAuthenticated: req.admin? true : false,
    admin: admin,
  });
  // res.status(200).json({
  //   message: "Profile fetched successfully",
  //   admin: req.admin,
  // });
};
