import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';

import 'package:text_editor_test/features/todo/presentation/todo_add_bloc/todo_add_state.dart';
import 'package:text_editor_test/features/todo/presentation/todo_add_bloc/todo_add_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEvent);
    on<GetTodoEvent>(_getTodoEvent);
    on<DeleteTodoEvent>(_deleteTodoEvent);
  }
  _addTodoEvent(AddTodoEvent event, emit) async {
    emit(TodoLoading());

    try {
      final myTodo = await todoRepository
          .addTodo(Todo(title: event.todoTitle, id: Random().nextInt(50)));
      final myTodos = await todoRepository.getTodo();
      emit(TodoLoaded(myTodos!));
    } catch (e) {
      print(e.toString());
    }
  }

  _getTodoEvent(GetTodoEvent event, emit) async {
    emit(TodoLoading());
    final todo = await todoRepository.getTodo();
    emit(TodoLoaded(todo!));
  }

  _deleteTodoEvent(DeleteTodoEvent event, emit) async {
    final deleteTodo = await todoRepository.deleteTodo(event.id);
    final todos = await todoRepository.getTodo();
  
    emit(TodoLoaded(todos!));
  }
}
