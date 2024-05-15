abstract class DataEvent {}

class GetDataEvent extends DataEvent {}

class DeleteDataEvent extends DataEvent {
  final int id;

  DeleteDataEvent(this.id);
}

// TODO: add event of loading data, data error, data loaded

