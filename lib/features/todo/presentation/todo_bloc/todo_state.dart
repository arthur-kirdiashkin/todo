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

class TodosLoaded extends TodoState {
  final List<Todo> todos;
  const TodosLoaded(this.todos);
  @override
  List<Object?> get props => [todos];
}

class TodoLoaded extends TodoState {
  final Todo todo;
  const TodoLoaded(this.todo);
  @override
  List<Object?> get props => [todo];
}

class TodoUpdated extends TodoState {
  const TodoUpdated();

  @override
  List<Object?> get props => [];
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
  @override
  List<Object?> get props => [message];
}