import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todos.dart';

// class DataState extends Equatable {
//   final List<Todos> data;

//   const DataState(this.data);

//   @override
//   List<Object?> get props => [data];
// }

// Define the Bloc state
abstract class DataState {}

class TodoInitial extends DataState {}

class TodoLoading extends DataState {}

class TodoLoaded extends DataState {
  final List<Todos> data;

  TodoLoaded(this.data);

  // @override
  // List<Object?> get props => [data];
}

class TodoSuccess extends DataState {
  final String id;
  final String description;

  TodoSuccess(this.id, this.description);
}

class TodoFailure extends DataState {
  final String description;

  TodoFailure(this.description);
}
