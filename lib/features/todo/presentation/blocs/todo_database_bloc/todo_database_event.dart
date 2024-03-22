import 'package:equatable/equatable.dart';

abstract class TodoDatabaseEvent extends Equatable {

}

class AddTodoDatabaseeEvent extends TodoDatabaseEvent {
  final String? textTitle;

  AddTodoDatabaseeEvent({required this.textTitle});

  @override
  List<Object?> get props => [textTitle];

}

class LoadTodoDataEvent extends TodoDatabaseEvent {
  @override
  List<Object?> get props => [];

}

class DeleteTotoDataEvent extends TodoDatabaseEvent {
  final String? id;

  DeleteTotoDataEvent({required this.id});

  @override
  List<Object?> get props => [id];

}