const { graphql, buildSchema } = require("graphql");


const schema = buildSchema(`
    type Details {
        wood: String
        abalakach: String
        cloth: String
        condition: String
        color: String
        delevary: Boolean
        negotiable: Boolean
        modefiable: Boolean
    }

    type Image {
        imageUrl: String!
      }      

    type User {
    _id: ID
    email: String
    firstName: String
    lastName: String
    username: String
    isConfirmed: Boolean
    }

    type Product {
        _id: ID!
        title: String!
        price: Float
        description: String!
        creator: User!
        createdAt: String!
        updatedAt: String
        images: [Image!]
        rate: Float
        details: Details
    }

    type productData{
        products: [Product!]!
        totalPosts: Int
    }

    type RootQuery {
    products(page: Int): productData!
    product(id: ID!): Product!
    hello: String
    user(id:ID!): User!
    }

    schema {
        query: RootQuery
    }
`);

module.exports = schema;

// input ProductInputData {
//     page: Int
// }