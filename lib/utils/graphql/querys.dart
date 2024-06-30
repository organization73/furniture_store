class Querys {
  // static String getProducts(int pages) => '''
  //               query GetProducts {
  //                 products(page: ${pages > 50 ? 50 : pages}) {
  //                   products {
  //                     title
  //                     price
  //                     description
  //                     details {
  //                       wood
  //                       abalakach
  //                       cloth
  //                       color
  //                       condition
  //                       delevary
  //                       negotiable
  //                       modefiable
  //                     }
  //                     creator {
  //                       username
  //                       firstName
  //                       lastName
  //                     }
  //                     createdAt
  //                     images {
  //                       imageUrl
  //                     }
  //                   }
  //                 }
  //               }
  //             ''';
  static productsQuery(page) => '''
            query GetProducts {
              products(page: $page) {
                products {
                  _id
                  title
                  price
                  description
                  details {
                    wood
                    abalakach
                    cloth
                    color
                    condition
                    delevary
                    negotiable
                    modefiable
                  }
                  creator {
                    username
                    firstName
                    lastName
                    imageUrl
                    email
                    type
                    _id
                    
                  }
                  images {
                    imageUrl
                    class
                    confidence
                  }
                  rate
                }
              }
            }
          ''';
  static UsersQuery(page) => '''
            query {
  users(page: 1) {
    _id
    email
    imageUrl
    firstName
    lastName
    username
    isConfirmed
  }
}
          ''';
}
