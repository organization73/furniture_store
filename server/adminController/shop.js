module.exports.getIndex = (req, res, next) => {
  res.render("shop/index", {
    path: "/",
    pageTitle: "Home",
    errorMessage: null, // Pass the stored flash message to the view
    isAuthenticated: req.admin ? true : false,
  });
};
 
module.exports.getChat = (req, res, next) => {
  res.render("shop/chat", {
    path: "/chat",
    pageTitle: "chat",
    errorMessage: null, // Pass the stored flash message to the view
    isAuthenticated: req.admin ? true : false,
  });
};