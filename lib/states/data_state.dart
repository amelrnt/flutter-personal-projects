import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todos.dart';

sealed class DataState extends Equatable {
  const DataState();
  
  @override
  List<Object> get props => [];
}

class TodoInitial extends DataState {}

class TodoLoading extends DataState {}

class TodoLoaded extends DataState {
  final List<Todos> data;

  const TodoLoaded(this.data);
}

class TodoSuccess extends DataState {
  final String id;
  final String description;

  const TodoSuccess(this.id, this.description);
}

class TodoFailure extends DataState {
  final String description;

  const TodoFailure(this.description);
}
