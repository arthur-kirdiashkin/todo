import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {}

class AddTodoEvent extends TodoEvent {
  final String todoTitle;

  AddTodoEvent({required this.todoTitle});
  @override
  List<Object?> get props => [todoTitle];
}

class AddTodoDatabaseEvent extends TodoEvent {
  final String todoTitle;

  AddTodoDatabaseEvent({required this.todoTitle});

  @override
  List<Object?> get props => [todoTitle];
}

class GetTodoDatabaseEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  final String todoTitle;
  DeleteTodoEvent({
    required this.id,
    required this.todoTitle,
  });

  @override
  List<Object?> get props => [id, todoTitle];
}

class DeleteTodoFirebaseEvent extends TodoEvent {
  final int id;
  final String todoTitle;

  DeleteTodoFirebaseEvent({
    required this.id,
    required this.todoTitle,
  });

  @override
  List<Object?> get props => [];
}

class GetTodoEvent extends TodoEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteAllDocumentsEvent extends TodoEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class IsSaveInFirebaseEvent extends TodoEvent {
  final bool isSaveInFirebase;

  IsSaveInFirebaseEvent({
    required this.isSaveInFirebase,
  });

  @override
  List<Object?> get props => [isSaveInFirebase];
}

class ShowIsSelectedButtonEvent extends TodoEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

}

