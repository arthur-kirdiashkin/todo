import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  const TodoInitial();

  @override
  List<Object?> get props => [];
}

class TodoAdded extends TodoState {
  const TodoAdded();

  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {
  const TodoLoading();
  @override
  List<Object?> get props => [];
}

class TodoLoaded extends TodoState {
  final List<Todo> todo;
  const TodoLoaded(this.todo);
  @override
  List<Object?> get props => [todo];
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
  @override
  List<Object?> get props => [message];
}
