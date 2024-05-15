import 'package:bloc/bloc.dart';
import 'package:graphql/client.dart';

import '../events/data_edit_event.dart';
import '../models/todos.dart';
import '../network/graphql.dart';
import '../states/data_edit_state.dart';

class EditDataBloc extends Bloc<EditDataEvent, EditDataState> {
  EditDataBloc() : super(EditDataInitial()) {
    on<EditDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Stream<EditDataState> mapAddTodoToState(AddDataEvent event) async* {
    const String mutation = '''
        mutation InsertTodo(\$name: String!, \$description: String!) {
          insert_todos_one(object: {name: \$name, description: \$description}) {
            id
            name
            description
            updated_at
          }
        }
      ''';
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

      // final data = result.data!['insert_todos_one'];
      final Todos data = result.data?['insert_todos_one'];
      print("add");
      print(data);
      yield EditDataSuccess(data);
    } catch (e) {
      yield EditDataFailure(e.toString());
    }
  }

  Stream<EditDataState> mapEditTodoToState(PostDataEvent event) async* {
    const String mutation = '''
        mutation InsertTodo(\$name: String!, \$description: String!) {
          insert_todos_one(object: {name: \$name, description: \$description}) {
            id
            name
            description
            updated_at
          }
        }
      ''';
    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(mutation),
          variables: {
            'id': event.id,
            'name': event.name,
            'description': event.description,
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      // final data = result.data!['insert_todos_one'];
      final Todos data = result.data?['update_todos_by_pk'];
      print("edit");
      print(data);
      yield EditDataSuccess(data);
    } catch (e) {
      yield EditDataFailure(e.toString());
    }
  }
}
