import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/data_bloc.dart';
import 'package:todo_list/events/data_event.dart';
import 'package:todo_list/states/data_state.dart';
import 'package:todo_list/view/detail_screen.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    dataBloc.add(GetDataEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter TODO"),
      ),
      body: Column(
        children: <Widget>[
          const Center(
              child: Text(
            "My Todo List",
            style: TextStyle(fontSize: 25),
          )),
          BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TodoLoaded) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      dataBloc.add(GetDataEvent());
                    },
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                        child: ListTile(
                            title: Text(state.data[index].name),
                            subtitle: Row(
                              children: [
                                Text(
                                  state.data[index].updated_at.substring(0, 7),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Container(
                                  width: 20,
                                ),
                                Text(
                                  state.data[index].description,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            )),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(todo: state.data[index])),
                        );
                      },
                    );
                                  },
                                ),
                  ));
              }
              if (state is TodoFailure) {
                return Center(child: Text(state.description));
              }
              else{
                return Container();
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: on back after this page then get data again
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}