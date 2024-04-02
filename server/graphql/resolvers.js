const Product = require("../models/product");
const PRODUCTS_PER_PAGE = 2;
const User = require("../models/user");

const root = {
  products: async function ({ page }, { req }, info) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("products.", "")
    );
    cleanedFields.push("updatedAt");
    // Extract the paths that include the 'creator' field
    const [creatorProperties, arrayCreatorProperties] =
      extractCreatorProperties(cleanedFields);
    cleanedFields = cleanedFields.filter(
      (field) => !arrayCreatorProperties.includes(field)
    );
    //validating data
    if (!page) page = 1;
    let products;
    try {
      products = await Product.find()
        .populate("creator", creatorProperties) // Populate the 'creator' path without selecting any fields
        .select(cleanedFields)
        .skip((page - 1) * PRODUCTS_PER_PAGE)
        .limit(PRODUCTS_PER_PAGE)
        .sort({ createdAt: -1 });

      // console.log("products:", products);
    } catch (error) {
      throw error;
    }

    const return_values = {
      products: products.map((p) => {
        return {
          ...p._doc,
          _id: p._id.toString(),
          // imageUrl: p.imageUrl,
          creator: p.creator,
          createdAt: p.createdAt.toISOString(),
          updatedAt: p.updatedAt.toISOString(),
        };
      }),
    };
    return return_values;
  },

  product: async function ({ id }, { req }, info) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("products.", "")
    );
    cleanedFields.push("updatedAt");
    // Extract the paths that include the 'creator' field
    const [creatorProperties, arrayCreatorProperties] =
      extractCreatorProperties(cleanedFields);
    cleanedFields = cleanedFields.filter(
      (field) => !arrayCreatorProperties.includes(field)
    );
    //fetching data
    let product;
    try {
      product = await Product.findById(id)
        .populate("creator", creatorProperties)
        .select(cleanedFields);
      console.log("product:", product);
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      throw error;
    }
    //validating data existance
    if (!product) {
      const error = new Error("Could not find product.");
      error.statusCode = 404;
      throw error;
    }
    //returning data
    return {
      ...product._doc,
      _id: product._id.toString(),
      creator: product.creator,
      createdAt: product.createdAt.toISOString(),
      ImageUrl: product.imageUrl,
      updatedAt: product.updatedAt.toISOString(),
    };
  },
  hello: (parent, args, context, info) => {
    console.log(context);
    return "Hello world!";
  },
  user: async function ({ id }, { req }, info) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("products.", "")
    );
    cleanedFields.push("updatedAt");
    //validate Id
    console.log("id:", id);
    if (!id) {
      const error = new Error("Wrong Id.");
      error.statusCode = 404;
      throw error;
    }
    //fetching user's data
    let user;
    try {
      user = await User.findById(id).select(cleanedFields);
      console.log("user:", user);
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      // throw error;
      throw error;
    }
    //validate user exist.
    if (!user) {
      const error = new Error("User not found.");
      error.statusCode = 404;
      // throw error;
      throw error;
    }
    return {
      ...user._doc,
      _id: user._id.toString(),
    };
  },
};

module.exports = root;

function getRequestedFields(fieldNode, path = "") {
  if (!fieldNode.selectionSet) {
    return [path];
  }

  return fieldNode.selectionSet.selections.flatMap((selection) => {
    if (selection.kind === "Field") {
      return getRequestedFields(
        selection,
        path ? `${path}.${selection.name.value}` : selection.name.value
      );
    } else if (
      selection.kind === "InlineFragment" ||
      selection.kind === "FragmentSpread"
    ) {
      return getRequestedFields(selection, path);
    }
  });
}

function extractCreatorProperties(propertyPaths) {
  let creatorProperties = "";
  let arrayCreatorProperties = [];

  for (const path of propertyPaths) {
    const properties = path.split(".");

    if (properties[0] === "creator") {
      creatorProperties += properties[1] + " ";
      arrayCreatorProperties.push(path);
    }
  }

  return [creatorProperties, arrayCreatorProperties];
}
