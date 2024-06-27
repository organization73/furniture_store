// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class AppClints {
//   static ValueNotifier<GraphQLClient> productsClient =
//       ValueNotifier<GraphQLClient>(
//     GraphQLClient(
//       link: HttpLink(
//         'https://furniture-store-4qhc.onrender.com/graphql',
//         defaultHeaders: {
//           'Authorization': 'Bearer ${GetStorage().read('token')}',
//         },
//       ),
//       cache: GraphQLCache(store: InMemoryStore()),
//     ),
//   );
// }
