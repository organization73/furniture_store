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
                  }
                  createdAt
                  images {
                    imageUrl
                  }
                }
              }
            }
          ''';
}
