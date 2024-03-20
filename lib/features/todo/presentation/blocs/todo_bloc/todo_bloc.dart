import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_database_repository.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';

import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  final TodoDatabaseRepository todoDatabaseRepository;
  bool isSaveInFirebase = true;
  TodoBloc({required this.todoRepository, required this.todoDatabaseRepository})
      : super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEvent);
    on<GetTodoEvent>(_getTodoEvent);
    on<DeleteTodoEvent>(_deleteTodoEvent);
    on<GetTodoDatabaseEvent>(_getTodoDatabaseEvent);
    on<DeleteTodoFirebaseEvent>(_deleteTodoFirebaseEvent);
    on<DeleteAllDocumentsEvent>(_deleteAllDocumentsEvent);
    on<IsSaveInFirebaseEvent>(_isSaveInFirebaseEvent);
  }
  _addTodoEvent(AddTodoEvent event, emit) async {
    emit(TodoLoading());
    final randomValue = Random().nextInt(50);
    if (isSaveInFirebase == true) {
      final todos = await todoDatabaseRepository
          .saveTodoData(Todo(title: event.todoTitle, id: randomValue));

      try {
        final myTodo = await todoRepository
            .addTodo(Todo(title: event.todoTitle, id: randomValue));
        final myTodos = await todoRepository.getTodo();
        emit(TodoLoaded(myTodos!));
      } catch (e) {
        print(e.toString());
      }
    } else if (isSaveInFirebase == false) {
      try {
        final myTodo = await todoRepository
            .addTodo(Todo(title: event.todoTitle, id: randomValue));
        final myTodos = await todoRepository.getTodo();
        emit(TodoLoaded(myTodos!));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _getTodoDatabaseEvent(GetTodoDatabaseEvent event, emit) async {
    emit(TodoLoading());
    List<Todo>? todo = await todoRepository.getTodo();
    List<Todo> listofTodoData =
        await todoDatabaseRepository.getTodoFromFirebase();

    var set = Set<String>();

    if (todo != null) {
      for (Todo i in listofTodoData) {
        if (!todo!.contains(i)) {
          await todoRepository.addTodo(i);
        }
      }
    }

    emit(TodoLoaded(listofTodoData));
  }

  _getTodoEvent(GetTodoEvent event, emit) async {
    emit(TodoLoading());

    final todo = await todoRepository.getTodo();

    emit(TodoLoaded(todo!));
  }

  _deleteTodoEvent(DeleteTodoEvent event, emit) async {
    final deleteTodoFirebase =
        await todoDatabaseRepository.deleteTodoData(event.id.toString());
    final deleteTodo = await todoRepository.deleteTodo(event.id);

    final todosFromFireBase =
        await todoDatabaseRepository.getTodoFromFirebase();
    emit(TodoLoaded(todosFromFireBase));

    var set = Set<String>();
  }

  _deleteTodoFirebaseEvent(DeleteTodoFirebaseEvent event, emit) async {
    final todo = await todoRepository.getTodo();

    final deleteTodoFirebase =
        await todoDatabaseRepository.deleteTodoData(event.id.toString());

    List<Todo> todosFromFireBase =
        await todoDatabaseRepository.getTodoFromFirebase();
    todo!.addAll(todosFromFireBase);
    var set = Set<String>();
    List<Todo> uniqList =
        todo!.where((element) => set.add(element.title!)).toList();

    emit(TodoLoaded(uniqList));
  }

  _deleteAllDocumentsEvent(DeleteAllDocumentsEvent event, emit) async {
    emit(TodoLoading());
    final deleteAllFromHive = await todoRepository.deleteBox();
    final deleteAllFromFirebase =
        await todoDatabaseRepository.deleteAllFromFirebase();
    List<Todo>? todo = await todoRepository.getTodo();
    List<Todo> listofTodoData =
        await todoDatabaseRepository.getTodoFromFirebase();

    if (todo == null || todo == []) {
      todo = [];
    }

    var set = Set<String>();

    if (todo != null) {
      for (Todo i in listofTodoData) {
        if (!todo.contains(i)) {
          await todoRepository.addTodo(i);
        }
      }
    }

    emit(TodoLoaded(todo));
  }

  _isSaveInFirebaseEvent(IsSaveInFirebaseEvent event, emit) async {
    isSaveInFirebase = event.isSaveInFirebase;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSelected', isSaveInFirebase);
    print(isSaveInFirebase);
  }
}
