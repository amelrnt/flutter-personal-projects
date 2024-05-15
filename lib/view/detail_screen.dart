import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:todo_list/models/todos.dart';

import '../network/graphql.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.todo});

  final Todos? todo;

  @override
  Widget build(BuildContext context) {
    var title = TextEditingController();
    var desc = TextEditingController();

    if (todo != null) {
      title.text = todo!.name;
      desc.text = todo!.description;
    }

    Future<bool> onWillPop() async {
      if (title.text.isEmpty & desc.text.isEmpty) {
        return true;
      }
      const String edit_mutation = '''
        mutation UpdateTodoByPk(\$id: Int!,\$name: String!, \$description: String!) {
          update_todos_by_pk(pk_columns: {id: \$id}, _set: {name: \$name, description: \$description}) {
            id
            name
            description
            updated_at
          }
        }
      ''';

      const String insert_mutation = '''
        mutation InsertTodo(\$name: String!, \$description: String!) {
          insert_todos_one(object: {name: \$name, description: \$description}) {
            id
            name
            description
            updated_at
          }
        }
      ''';

      final options = todo != null
          ? MutationOptions(
              document: gql(edit_mutation),
              variables: {
                'id': todo!.id,
                'name': title.text,
                'description': desc.text,
              },
              onCompleted: (dynamic resultData) {
                print("edit");
                print(resultData);
              },
            )
          : MutationOptions(
              document: gql(insert_mutation),
              variables: {
                'name': title.text,
                'description': desc.text,
              },
              onCompleted: (dynamic resultData) {
                print("add");
                print(resultData);
              },
            );

      final result = await graphQLClient.mutate(options);
      if (result.hasException) {
        // Handle mutation errors here
        print(result.exception.toString());
      } else {
        print(result.data);
      }

      return true;
    }

    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: todo != null ? Text("Edit Todo") : Text("Add Todo"),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: title,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    hintText: "Title"),
              ),
              TextFormField(
                controller: desc,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    hintText: "Description"),
              ),
            ]),
      ),
    );
  }
}
