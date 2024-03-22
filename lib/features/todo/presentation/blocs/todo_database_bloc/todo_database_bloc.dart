import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_database_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_state.dart';

class TodoDatabaseBloc extends Bloc<TodoDatabaseEvent, TodoDatabaseState> {
  final TodoDatabaseRepository todoDatabaseRepository;
  TodoDatabaseBloc({required this.todoDatabaseRepository}) : super(TodoDatabaseInitial()) {
    on<AddTodoDatabaseeEvent>(_addTodoDatabaseEvent);
    on<LoadTodoDataEvent>(_loadTodoDataEvent);
    on<DeleteTotoDataEvent>(_deleteTotoDataEvent);
  }

  _addTodoDatabaseEvent(AddTodoDatabaseeEvent event, emit) async {
    final todos = await todoDatabaseRepository
        .saveTodoData(Todo(title: event.textTitle!, id: Random().nextInt(50)));
  }

    _loadTodoDataEvent(LoadTodoDataEvent event,  emit) async {
      emit(TodoDatabaseLoading());
      List<Todo> listofTodoData = await todoDatabaseRepository.getTodoFromFirebase();
      emit(TodoDatabaseSuccess(listofTodoData));
      
  }
  _deleteTotoDataEvent(DeleteTotoDataEvent event, emit) async {
    final deleteTodoFirebase = await todoDatabaseRepository.deleteTodoData(event.id!);
    List<Todo> listofTodoData = await todoDatabaseRepository.getTodoFromFirebase();
     emit(TodoDatabaseSuccess(listofTodoData));
  }
}
