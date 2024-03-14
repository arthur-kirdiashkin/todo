import 'package:equatable/equatable.dart';

abstract class TodoDatabaseEvent extends Equatable {

}

class AddTodoDatabaseeEvent extends TodoDatabaseEvent {
  final String? textTitle;

  AddTodoDatabaseeEvent({required this.textTitle});

  @override
  // TODO: implement props
  List<Object?> get props => [textTitle];

}

class LoadTodoDataEvent extends TodoDatabaseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DeleteTotoDataEvent extends TodoDatabaseEvent {
  final String? id;

  DeleteTotoDataEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}