const Product = require("../models/product");
const User = require("../models/user");
const AiProduct = require("../models/aiProduct");
const PRODUCTS_PER_PAGE = 6;
const USERS_PER_PAGE = 6;

const root = {
  products: async function ({ page, filters, searchTitle }, { req }, info) {
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

    // Check for any subfields of 'rates' and ensure 'rates' is included for population
    if (cleanedFields.some((field) => field.startsWith("rates."))) {
      cleanedFields = cleanedFields.filter(
        (field) => !field.startsWith("rates.")
      );
      cleanedFields.push("rates");
    }
    let sortCondition = {};
    let searchQuery = {};

    // Complete the sort condition logic
    if (filters.mostPrice) {
      sortCondition.price = -1;
    } else if (filters.leastPrice) {
      sortCondition.price = 1;
    }
    if (filters.newest) {
      sortCondition.createdAt = -1;
    }
    //searching query
    if (filters.class) {
      const imageObject = { "images.class": filters.class };
      searchQuery = { ...searchQuery, ...imageObject };
    }

    if (searchTitle) {
      searchQuery.title = { $regex: searchTitle, $options: "i" };
    }
    //validating data

    console.log("iam here:");
    console.log("searchQuery:", searchQuery);
    console.log("sortCondition:", sortCondition);
    console.log("cleanedFields:", cleanedFields);
    console.log("creatorProperties:", creatorProperties);

    if (!page) page = 1;
    let products;
    try {
      products = await Product.find(searchQuery)
        .populate("creator", creatorProperties) // Populate the 'creator' path without selecting any fields
        .select(cleanedFields)
        .skip((page - 1) * PRODUCTS_PER_PAGE)
        .limit(PRODUCTS_PER_PAGE)
        .sort(sortCondition)
        .populate({
          path: "rates",
          populate: {
            path: "customer", // Example of a nested field to populate
            select: " firstName lastName email username imageUrl",
          },
        });
      // console.log("products:", products);
    } catch (error) {
      throw error;
    }

    const return_values = {
      products: products.map((p) => {
        return {
          ...p._doc,
          _id: p._id ? p._id.toString() : undefined,
          rates: p.rates.map((r) => {
            return {
              ...r._doc,
              _id: r._id ? r._id.toString() : undefined,
              product: r.product.toString(),
              customer: r.customer,
              rate: r.rate,
              description: r.description,
              createdAt: r.createdAt ? r.createdAt.toISOString() : undefined,
              ImageUrl: r.imageUrl,

              updatedAt: r.updatedAt ? r.updatedAt.toISOString() : undefined,
            };
          }),
          creator: p.creator,
          createdAt: p.createdAt ? p.createdAt.toISOString() : undefined,
          updatedAt: p.updatedAt ? p.updatedAt.toISOString() : undefined,
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

    // Check for any subfields of 'rates' and ensure 'rates' is included for population
    if (cleanedFields.some((field) => field.startsWith("rates."))) {
      cleanedFields = cleanedFields.filter(
        (field) => !field.startsWith("rates.")
      );
      cleanedFields.push("rates");
    }

    //fetching data
    let product;
    try {
      product = await Product.findById(id)
        .populate("creator", creatorProperties)
        .select(cleanedFields)
        .populate({
          path: "rates",
          populate: {
            path: "customer", // Example of a nested field to populate
            select: " firstName lastName email username imageUrl",
          },
        });
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
      _id: product._id ? product._id.toString() : undefined,
      rates: product.rates.map((r) => {
        console.log(r);
        return {
          ...r._doc,
          _id: r._id ? r._id.toString() : undefined,
          product: r.product.toString(),
          customer: r.customer,
          rate: r.rate,
          description: r.description,
          createdAt: r.createdAt ? r.createdAt.toISOString() : undefined,
          updatedAt: r.updatedAt ? r.updatedAt.toISOString() : undefined,
        };
      }),

      creator: product.creator,
      createdAt: product.createdAt
        ? product.createdAt.toISOString()
        : undefined,
      ImageUrl: product.imageUrl,
      updatedAt: product.updatedAt
        ? product.updatedAt.toISOString()
        : undefined,
    };
  },

  //fetching ai products
  aiProducts: async function (
    { page, filters, searchTitle, id },
    { req },
    info
  ) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("aiProducts.", "")
    );
    cleanedFields.push("updatedAt");

    // Extract the paths that include the 'creator' field
    const [creatorProperties, arrayCreatorProperties] =
      extractCreatorProperties(cleanedFields);
    cleanedFields = cleanedFields.filter(
      (field) => !arrayCreatorProperties.includes(field)
    );

    // Check for any subfields of 'rates' and ensure 'rates' is included for population
    if (cleanedFields.some((field) => field.startsWith("rates."))) {
      cleanedFields = cleanedFields.filter(
        (field) => !field.startsWith("rates.")
      );
      // cleanedFields.push("rates");
    }

    let sortCondition = {};
    let searchQuery = {};
    page = page || 1;
    // Complete the sort condition logic
    if (id) {
      searchQuery = { creator: id };
    } else if (id === "") {
      searchQuery = { creator: req.raw.user._id };
    }

    if (filters) {
      if (filters.mostPrice) {
        sortCondition.price = -1;
      } else if (filters.leastPrice) {
        sortCondition.price = 1;
      }
      if (filters.newest) {
        sortCondition.createdAt = -1;
      }
      //searching query
      if (filters.category) {
        searchQuery.category = filters.category;
      }
      if (filters.subCategory) {
        searchQuery.subCategory = filters.subCategory;
      }
    } else {
      console.log("no filters");
    }

    if (searchTitle) {
      searchQuery.title = { $regex: searchTitle, $options: "i" };
    }

    //validating data
    if (!page) page = 1;
    let products;
    try {
      products = await AiProduct.find(searchQuery)
        .populate("creator", creatorProperties) // Populate the 'creator' path without selecting any fields
        .select(cleanedFields)
        .skip((page - 1) * PRODUCTS_PER_PAGE)
        .limit(PRODUCTS_PER_PAGE)
        .sort(sortCondition);
      // console.log("products:", products);
    } catch (error) {
      throw error;
    }

    const return_values = {
      aiProducts: products.map((p) => {
        return {
          ...p._doc,
          _id: p._id ? p._id.toString() : undefined,
          creator: p.creator,
          createdAt: p.createdAt ? p.createdAt.toISOString() : undefined,
          updatedAt: p.updatedAt ? p.updatedAt.toISOString() : undefined,
        };
      }),
    };
    return return_values;
  },

  hello: (parent, args, context, info) => {
    console.log(context);
    return "Hello world!";
  },
  // user: async function ({ id }, { req }, info) {
  //   //fetching request data.
  //   const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
  //     getRequestedFields(fieldNode)
  //   );
  //   let cleanedFields = requestedFields.map((field) =>
  //     field.replace("products.", "")
  //   );
  //   cleanedFields.push("updatedAt");

  //   //fetching the number of products per user
  //   if (cleanedFields.includes("numberOfProducts")) {
  //     cleanedFields = cleanedFields.filter(
  //       (field) => field !== "numberOfProducts"
  //     );
  //     cleanedFields.push("products");
  //   }
  //   //validate Id
  //   console.log("id:", id);
  //   console.log("hellow")
  //   console.log("cleanedFields:", cleanedFields)
  //   if (!id) {
  //     const error = new Error("Wrong Id.");
  //     error.statusCode = 404;
  //     throw error;
  //   }
  //   //fetching user's data
  //   let user;
  //   try {
  //     user = await User.findById(id).select(cleanedFields);
  //     console.log("user:", user);
  //   } catch (error) {
  //     if (error.statusCode) {
  //       error.statusCode = 500;
  //     }
  //     // throw error;
  //     throw error;
  //   }
  //   //validate user exist.
  //   if (!user) {
  //     const error = new Error("User not found.");
  //     error.statusCode = 404;
  //     // throw error;
  //     throw error;
  //   }
  //   return {
  //     ...user._doc,
  //     _id: user._id ? user._id.toString() : undefined,
  //     numberOfProducts: user.products ? user.products.length : undefined,
  //   };
  // },
  usersProducts: async function ({ id }, { req }, info) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("products.", "")
    );
    // cleanedFields.push("updatedAt");
    // Extract the paths that include the 'creator' field
    const [creatorProperties, arrayCreatorProperties] =
      extractCreatorProperties(cleanedFields);
    cleanedFields = cleanedFields.filter(
      (field) => !arrayCreatorProperties.includes(field)
    );
    //fetching user's products

    id = id || req.raw.user._id;
    console.log("id:", id);
    let products;
    try {
      products = await Product.find({ creator: id })
        .populate("creator", creatorProperties)
        .select(cleanedFields)
        .sort({ createdAt: -1 });
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      throw error;
    }
    //validating data existance
    if (!products) {
      const error = new Error("Could not find products.");
      error.statusCode = 404;
      throw error;
    }
    //returning data
    return {
      products: products.map((p) => {
        return {
          ...p._doc,
          _id: p._id ? p._id.toString() : undefined,
          creator: p.creator,
          createdAt: p.createdAt ? p.createdAt.toISOString() : undefined,
          updatedAt: p.updatedAt ? p.updatedAt.toISOString() : undefined,
        };
      }),
    };
  },
  //getuser by id
  user: async function ({ id }, { req }, info) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("products.", "")
    );
    //validate Id
    console.log("id:", id);
    //fetching the number of products per user
    if (cleanedFields.includes("numberOfProducts")) {
      cleanedFields = cleanedFields.filter(
        (field) => field !== "numberOfProducts"
      );
      cleanedFields.push("products");
    }
    //validate Id
    console.log("id:", id);
    console.log("hellow");
    console.log("cleanedFields:", cleanedFields);

    if (!id) {
      id = req.raw.user._id;
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
      _id: user._id ? user._id.toString() : undefined,
      createdAt: user.createdAt ? user.createdAt.toISOString() : undefined,
      updatedAt: user.updatedAt ? user.updatedAt.toISOString() : undefined,
      numberOfProducts: user.products ? user.products.length : undefined,
    };
  },
  //get all users
  users: async function ({ page }, { req }, info) {
    console.log("graphql Users");
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("products.", "")
    );

    //fetching the number of products per user
    if (cleanedFields.includes("numberOfProducts")) {
      cleanedFields = cleanedFields.filter(
        (field) => field !== "numberOfProducts"
      );
      cleanedFields.push("products");
    }
    console.log("cleanedFields:", cleanedFields);

    //fetching users
    let users;
    try {
      users = await User.find()
        .select(cleanedFields)
        .skip((page - 1) * USERS_PER_PAGE)
        .limit(USERS_PER_PAGE)
        .sort({ createdAt: -1 });
    } catch (error) {
      if (error.statusCode) {
        error.statusCode = 500;
      }
      throw error;
    }
    //validating data existance
    if (!users) {
      const error = new Error("Could not find users.");
      error.statusCode = 404;
      throw error;
    }
    //returning data
    const result = users.map((u) => {
      return {
        ...u._doc,
        _id: u._id ? u._id.toString() : undefined,
        createdAt: u.createdAt ? u.createdAt.toISOString() : undefined,
        updatedAt: u.updatedAt ? u.updatedAt.toISOString() : undefined,
        numberOfProducts: u.products ? u.products.length : undefined,
      };
    });
    // console.log("users:", result);
    return result;
  },
  gallaries: async function (
    { filters, searchTitle, page, id },
    { req },
    info
  ) {
    //fetching request data.
    const requestedFields = info.fieldNodes.flatMap((fieldNode) =>
      getRequestedFields(fieldNode)
    );
    let cleanedFields = requestedFields.map((field) =>
      field.replace("gallaries.", "")
    );
    cleanedFields.push("updatedAt");

    // Extract the paths that include the 'creator' field
    const [creatorProperties, arrayCreatorProperties] =
      extractCreatorProperties(cleanedFields);
    cleanedFields = cleanedFields.filter(
      (field) => !arrayCreatorProperties.includes(field)
    );

    let sortCondition = {};
    let searchQuery = {};
    page = page || 1;

    // Complete the sort condition logic
    if (id) {
      searchQuery.creator = id;
    } else if (id === "") {
      searchQuery.creator = req.raw.user._id;
    }

    if (filters) {
      if (filters.newest) {
        sortCondition = { createdAt: -1 };
      }
      //searching query
      if (filters.country) {
        searchQuery.country = filters.country;
      }
      if (filters.city) {
        searchQuery.city = filters.city;
      }
      if (filters.street) {
        searchQuery.street = filters.street;
      }
    } else {
      console.log("no filters");
    }

    if (searchTitle) {
      searchQuery.title = { $regex: searchTitle, $options: "i" };
    }
    console.log("searchQuery:", searchQuery);
    console.log("sortCondition:", sortCondition);
    console.log("cleanedFields:", cleanedFields);
    console.log("creatorProperties:", creatorProperties);
    console.log(page);
    return;
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
