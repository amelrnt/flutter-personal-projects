import 'package:equatable/equatable.dart';

import '../models/todos.dart';


sealed class EditDataState extends Equatable {
  const EditDataState();
  
  @override
  List<Object> get props => [];
}

final class EditDataInitial extends EditDataState {}

class EditDataSuccess extends EditDataState{
  final Todos data;

  const EditDataSuccess(this.data);
}

class EditDataFailure extends EditDataState {
  final String description;

  const EditDataFailure(this.description);
}

