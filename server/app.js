const path = require("path");

const express = require("express");
const body_parser = require("body-parser");
const mongoose = require("mongoose");
const multer = require("multer");
const { createHandler } = require("graphql-http/lib/use/express");
const playground = require("graphql-playground-middleware-express").default;
const cors = require("cors");
const ejs = require("ejs");
const cookieParser = require("cookie-parser");
const useragent = require("express-useragent");
const morgan = require("morgan");

const authRoutes = require("./routes/auth");
const productRoutes = require("./routes/product");
const userRouters = require("./routes/user");

const adminAuthRoutes = require("./adminRouter/auth");
const adminShopRoutes = require("./adminRouter/shop");
const adminRouter = require("./adminRouter/admin");
const adminChatRouter = require("./adminRouter/chat"); 

const chatRoutes = require("./routes/chat");

const schema = require("./graphql/schema");
const resolvers = require("./graphql/resolvers");
const isAuth = require("./middleware/is-auth");

const PORT = process.env.PORT || 3000;
const MONGODB_URL =
  "mongodb+srv://abdomake73:xlsgzIvu2CYeOTrg@cluster0.vclsggt.mongodb.net/furniture?retryWrites=true&w=majority";
// "mongodb://localhost:27017/furniture-shop";
const fileStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "images");
  },
  filename: (req, file, cb) => {
    cb(
      null,
      new Date().toISOString().replace(/:/g, "-") + "-" + file.originalname
    );
  },
});
const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "image/png" ||
    file.mimetype === "image/jpg" ||
    file.mimetype === "image/jpeg"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const app = express();

//seting the view engine
app.set("view engine", "ejs");
app.set("views", "views");
app.use(express.static(path.join(__dirname, "public")));

app.use(useragent.express());

app.use((req, res, next) => {
  console.log("----------------------------");
  const source = req.useragent.isDesktop ? 'website' : 'mobile';
  console.log(`Request from: ${source}`);
  // console.log("Incoming request:", req.method, req.url);
  next();
});

app.use(morgan("dev"));

app.use(
  multer({ storage: fileStorage, fileFilter: fileFilter }).array("images", 10)
);

app.use(body_parser.urlencoded({ extended: false }));

app.use(body_parser.json());

app.use(cookieParser());



 
app.use("/images", express.static(path.join(__dirname, "images")));

// app.use(cors());
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "OPTIONS, GET, POST, PUT, PATCH, DELETE"
  );
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  if (req.method === "OPTIONS") {
    return res.sendStatus(200);
  }
  next();
});

// app.use((req, res, next) => {
//   // console.log("app.js:", req.file);
//   const details = JSON.parse(req.body.details);
//   console.log("app.js:", details);
//   console.log("app.js:", details.wood);
//   res.send("Ok");
// });

app.use("/admin", adminAuthRoutes);

app.use("/admin", adminShopRoutes);

app.use("/admin", adminRouter);

app.use("/admin/chat", adminChatRouter);

app.use("/auth", authRoutes);

app.use("/user", isAuth, userRouters);

app.use("/product", isAuth, productRoutes);

app.use("/chat", chatRoutes);

app.get("/playground", playground({ endpoint: "/graphql" }));

app.use(
  "/graphql",
  isAuth,
  createHandler({
    schema: schema,
    rootValue: resolvers,
    graphiql: true,
    context: (req) => ({ req }),
    formatError(err) {
      if (!err.originalError) {
        return err;
      }
      console.log("err:", err.originalError);
      console.log("graphqlerr:", err.locations);
      console.log("errorPath:", err.path);
      const message = err.message || "An error occured.";
      const code = err.originalError.statusCode || 500;
      return {
        message: message,
        status: code,
        path: err.path,
        locations: err.locations,
      };
    },
  })
);

app.use((error, req, res, next) => {
  console.log(error);
  console.log("app.js Error:", error.message);
  console.log("end+++++++++++++++++++++++");
  const status = error.statusCode || 500;
  const message = error.message;
  res.status(status).json({ message: message, path: error.path });
});

// Connect to the database
mongoose
  .connect(MONGODB_URL)
  .then(async (result) => {
    console.log("Connected to the database");
    // Start the server
    const server = await app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
    //seting up the websocket
    const io = require("./socketio/socket").init(server, {
      pingTimeout: 60000,
      cors: {
        origin: "*",
      },
    });
    io.on("connection", (socket) => {
      console.log(socket.id.substring(0, 5), "connected");
      const socketHelper = require("./socketio/socketHelper");
      socketHelper.actionListeners(socket);
    });
  })
  .catch((err) => {
    console.log(err);
  });

//todo
/*
filter if user has gallary
bed-sofa-chair-table-seivelchair
passport
cors options
*/

//done
/*
websocket
admin panel
make the db find with select of what came from graphql query.
connect with ml model.
image processing to make it smaller
image storage with firebase
multer to upload multiple images
*/
