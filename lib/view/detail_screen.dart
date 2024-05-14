import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/todos.dart';

import '../blocs/data_blocs.dart';
import '../events/data_events.dart';
import '../states/data_state.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.todo});

  final Todos? todo;

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<DataBloc>(context);
    var title = TextEditingController();
    var desc = TextEditingController();

    if (todo != null) {
      title.text = todo!.name;
      desc.text = todo!.description;
    }

    Future<bool> onWillPop() async {
      // final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
      dataBloc.add(PostDataEvent(title.text, desc.text));
      return true;
    }

    return BlocProvider(
      create: (context) => DataBloc(),
      child: WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Flutter TODO"),
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
      ),
    );
  }
}
