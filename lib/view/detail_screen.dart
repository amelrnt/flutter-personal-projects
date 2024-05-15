import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/data_edit_bloc.dart';
import 'package:todo_list/models/todos.dart';

import '../events/data_edit_event.dart';
import '../states/data_edit_state.dart';

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

    Future<bool> onWillPop(BuildContext context) async {
      if (title.text.isEmpty & desc.text.isEmpty) {
        return true;
      }
      final EditDataBloc dataBloc = BlocProvider.of<EditDataBloc>(context);
      if (todo != null) {
        print("trigger 1");
        dataBloc.add(PostDataEvent(todo!.id, title.text, desc.text));
      } else {
        print("trigger 2");
        dataBloc.add(AddDataEvent(title.text, desc.text));
      }
      return true;
    }

    return BlocProvider(
      create: (context) => EditDataBloc(),
      child: BlocBuilder<EditDataBloc, EditDataState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => onWillPop(context),
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
        },
      ),
    );
  }
}
