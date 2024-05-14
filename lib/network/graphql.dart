import 'package:graphql/client.dart';

import '../key.dart';

final HttpLink httpLink = HttpLink('https://fluent-lion-81.hasura.app/v1/graphql', defaultHeaders: {
  'Content-Type': 'application/json',
  'x-hasura-admin-secret': hasuraKey
});

final GraphQLClient graphQLClient = GraphQLClient(
  cache: GraphQLCache(),
  link: httpLink,
);

