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
    numberOfProducts: Int
    phone: String
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

    type AiProduct {
        _id: ID
        title: String
        category: String
        subCategory: String
        price: Float
        description: String
        creator: User
        createdAt: String
        updatedAt: String
        imageUrl: String

    }


    type productData{
        products: [Product!]!
    }

    type AiProductData{
        aiProducts: [AiProduct!]!
    }

    input ProductFilterInput {
        class: String
        newest: Int
        mostPrice: Float
        leastPrice: Float
    }
        
    type Coordinates {
        lat: Float
        lng: Float
    }

    type Gallary {
        _id: ID
        creator: User
        name: String
        country: String
        city: String
        street: String
        images: [Image]
        certificate: String
        coordinates: Coordinates
        createdAt: String
        updatedAt: String
    }

    type GallariesData {
        gallaries: [Gallary!]!
    }

    input AiProductFilterInput {
        category: String
        subCategory: String
        newest: Int
        mostPrice: Float
        leastPrice: Float
    }
    
    input GallariesFilterInput {
    hasCertificate: Boolean
    country: String
    city: String
    street: String
    newest: Int
    }

    type RootQuery {
    products(filters: ProductFilterInput,searchTitle:String, page: Int ): productData!
    aiProducts(filters: AiProductFilterInput,searchTitle:String, page: Int, id:ID ): AiProductData!
    product(id: ID!): Product!
    hello: String
    user(id:ID!): User!
    usersProducts(id:ID): productData!
    usersAiProducts(id:ID): AiProductData!
    users(page: Int): [User!]!
    gallaries (filters: GallariesFilterInput,searchTitle:String , page:Int, id:ID): GallariesData!
    }

    schema {
        query: RootQuery
    }
`);

module.exports = schema;
