import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:todo_list/events/data_events.dart';
import 'package:todo_list/models/todos.dart';
import 'package:todo_list/network/graphql.dart';
import 'package:todo_list/states/data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(TodoInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is GetDataEvent) {
      yield* getDataToState(event);
    }
    if (event is PostDataEvent) {
      yield* mapAddTodoToState(event);
    }
  }

  Stream<DataState> getDataToState(DataEvent event) async* {
    if (event is GetDataEvent) {
      final QueryResult result = await graphQLClient.query(
        QueryOptions(
          document: gql(
            r'''
            query MyQuery {
              todos {
                id
                name
                description
                updated_at
              }
              }
            ''',
          ),
        ),
      );

      if (result.hasException) {
        yield TodoFailure(result.exception.toString());
      } else {
        final List data = result.data?['todos'];
        final datas = data.map((e) => Todos.fromJson(e)).toList();
        yield TodoLoaded(datas);
      }
    }
  }

  Stream<DataState> mapAddTodoToState(PostDataEvent event) async* {
    String mutation = r'''mutation MyMutation {
          insert_todos_one(object: {name: "test insert", description: "ppp"}) {
            id
            description
          }
        } ''';
    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(mutation),
          variables: {
            'name': event.name,
            'description': event.description,
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      final data = result.data!['insert_todos_one'];
      yield TodoSuccess(data['id'], data['description']);
    } catch (e) {
      yield TodoFailure(e.toString());
    }
  }
}
