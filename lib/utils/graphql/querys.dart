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
              products(page: $page,filters:{leastPrice:0,mostPrice:1, newest:0} ) {
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

          static productsQuerybyFilter(page,String clas) => '''
            query GetProducts {
              products(page: $page,filters:{class:\"$clas\",leastPrice:0,mostPrice:1, newest:0} ) {
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
                    numberOfProducts
                    
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
  users(page: $page ) {
    _id
    email
    imageUrl
    firstName
    lastName
    username
    isConfirmed
    type
    numberOfProducts
  }
}
          ''';
  static String getProductOfUser(String id) {
    return '''
 query {
  usersProducts(id: \"$id\" ) {
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
                    numberOfProducts
                    
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
  }
}


// {
//   "query": "{ usersProducts(id:\"66772a07622d0e72a274ff1f\") { products { _id title details { wood color } creator { _id username firstName } createdAt images { imageUrl } } } }"
// }
