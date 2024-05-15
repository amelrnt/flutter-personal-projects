import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:todo_list/events/data_event.dart';
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
  }

  Stream<DataState> getDataToState(DataEvent event) async* {
    if (event is GetDataEvent) {
      final QueryResult result = await graphQLClient.query(
        QueryOptions(
          document: gql(
            r'''
            query ShowAllData {
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

  
}
