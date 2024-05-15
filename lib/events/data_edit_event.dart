import 'package:equatable/equatable.dart';

sealed class EditDataEvent extends Equatable {
  const EditDataEvent();

  @override
  List<Object> get props => [];
}

class PostDataEvent extends EditDataEvent {
  final int id;
  final String name;
  final String description;

  const PostDataEvent(this.id, this.name, this.description);
}

class AddDataEvent extends EditDataEvent {
  final String name;
  final String description;

  const AddDataEvent(this.name, this.description);
}
