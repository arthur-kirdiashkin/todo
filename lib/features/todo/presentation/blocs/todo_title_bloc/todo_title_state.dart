import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoTitleState extends Equatable {}

class TodoTitleInitial extends TodoTitleState {
  @override
  List<Object?> get props => [];
}

class TodoTitleUpdated extends TodoTitleState {
  final Todo todo;

  TodoTitleUpdated({required this.todo});
  @override

  List<Object?> get props => [];
}

class TodoTitleLoading extends TodoTitleState {
  @override
  List<Object?> get props => [];
}

class TodoTitleLoaded extends TodoTitleState {
  final Todo todo;

  TodoTitleLoaded({required this.todo});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class TodoTitleError extends TodoTitleState {
  @override
  List<Object?> get props => [];
}

class QRCodeTodoTitleLoaded extends TodoTitleState {
  final String todoJson;

  QRCodeTodoTitleLoaded({
    required this.todoJson,
  });

  @override
  List<Object?> get props => [todoJson];
}
