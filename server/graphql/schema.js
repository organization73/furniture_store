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
        class: String
        confidence: Float
      }

    type User {
    _id: ID
    email: String
    imageUrl: String
    firstName: String
    lastName: String
    username: String
    isConfirmed: Boolean
    type: String
    }
    type Rate {
        product: ID
        customer: User
        rate: Float
        description: String
        createdAt: String
        updatedAt: String
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
        rates: [Rate]
        rate: Float
        details: Details
    }

    type productData{
        products: [Product!]!
        totalPosts: Int
    }

    input ProductFilterInput {
        class: String
        newest: Int
        mostPrice: Float
        leastPrice: Float
    }

    type RootQuery {
    products(filters: ProductFilterInput,searchTitle:String, page: Int ): productData!
    product(id: ID!): Product!
    hello: String
    user(id:ID!): User!
    usersProducts(id:ID): productData!
    users(page: Int): [User!]!
    }

    schema {
        query: RootQuery
    }
`);

module.exports = schema;

// input ProductInputData {
//     page: Int
// }
