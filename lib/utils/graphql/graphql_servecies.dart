// import 'package:flutter/material.dart';
// import 'package:furniture_store/features/product/model/product.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class GraphqlServercies {
//   static final GraphQLConfig graphQLConfiguration = GraphQLConfig();
//   GraphQLClient clinet = GraphQLClient(
//     link: GraphQLConfig.httpLink,
//     cache: GraphQLCache(store: InMemoryStore()),
//   );

//   Future<List<NewProduct>> getProducts({required int page}) async {
//     try {
//       QueryResult result = await clinet.query(QueryOptions(
//         fetchPolicy: FetchPolicy.noCache,

//         document: gql('''
//                 query GetProducts {
//                   products(\$page: Int) {
//                     products {
//                       title
//                       price
//                       description
//                       details {
//                         wood
//                         abalakach
//                         cloth
//                         color
//                         condition
//                         delevary
//                         negotiable
//                         modefiable
//                       }
//                       creator {
//                         username
//                         firstName
//                         lastName
//                       }
//                       createdAt
//                       images {
//                         imageUrl
//                       }
//                     }
//                   }
//                 }
//               '''),
//               variables: {
//                 'page': page
//               }
//       ));
//           if(result.hasException){
//             throw Exception(result.exception.toString());
//           }

//           List? products = result.data?['products']['products'];
//           if(products == null|| products.isEmpty){
//             return [];
//           }
//           List<NewProduct> productsList = products.map((e) => NewProduct.fromJson(e)).toList();
//     return productsList;
//     } catch (e) {
//      throw Exception(e); 
//     }


//   }
// }

// class GraphQLConfig {
//   static HttpLink httpLink = HttpLink(
//     'https://furniture-store-4qhc.onrender.com/graphql',
//     defaultHeaders: {
//       'Authorization': 'Bearer ${GetStorage().read('token')}',
//     },
//   );

//   static ValueNotifier<GraphQLClient> productsClient =
//       ValueNotifier<GraphQLClient>(
//     GraphQLClient(
//       link: httpLink,
//       cache: GraphQLCache(store: InMemoryStore()),
//     ),
//   );
// }
