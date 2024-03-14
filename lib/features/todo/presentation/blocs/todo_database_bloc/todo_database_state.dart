import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/models/todo_model.dart';

abstract class TodoDatabaseState extends Equatable {
  const TodoDatabaseState();
  
  @override
  List<Object?> get props => [];
}

class TodoDatabaseInitial extends TodoDatabaseState {}

class TodoDatabaseLoading extends TodoDatabaseState{}

class TodoDatabaseSuccess extends TodoDatabaseState {
  final List<Todo> listOfTodo;
  // final String? textTitle;
  const TodoDatabaseSuccess(this.listOfTodo,);

    @override
  List<Object?> get props => [listOfTodo,];
}

class TodoDatabaseError extends TodoDatabaseState {
      @override
  List<Object?> get props => [];
}