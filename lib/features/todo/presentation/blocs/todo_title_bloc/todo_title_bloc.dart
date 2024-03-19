import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_database_repository.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_state.dart';

class TodoTitleBloc extends Bloc<TodoTitleEvent, TodoTitleState> {
  final TodoRepository todoRepository;
  final TodoDatabaseRepository todoDatabaseRepository;
  TodoTitleBloc(
      {required this.todoRepository, required this.todoDatabaseRepository})
      : super(TodoTitleInitial()) {
    on<UpdateTodoTitleEvent>(_updateTodoTitleEvent);
    on<UpdateTodoSubTitleEvent>(_updateTodoSubTitleEvent);
    on<AddOneTodoEvent>(_addOneTodoEvent);

    on<GetTitleFromQRCodeEvent>(_getTitileFromQRCodeEvent);
  }

  _updateTodoTitleEvent(UpdateTodoTitleEvent event, emit) async {
    // emit(TodoTitleLoading());
    final todoFromBase = await todoDatabaseRepository.getTodoFromFirebase();
    final updateTodoTitleDatabase = await todoDatabaseRepository
        .updateTodoTitleDatabase(event.todo, event.title!);
    final updateTodoTitle =
        await todoRepository.updateTodoTitle(event.todo, event.title!);
    List<Todo>? todo = await todoRepository.getTodo();
    emit(TodoTitleUpdated(todo: event.todo));
  }

  _updateTodoSubTitleEvent(UpdateTodoSubTitleEvent event, emit) async {
    // emit(TodoTitleLoading());
    final todoFromBase = await todoDatabaseRepository.getTodoFromFirebase();
    final updateTodoSubTitleDatabase = await todoDatabaseRepository
        .updateTodoSubtitleDatabase(event.todo, event.subTitle);
    final updateTodoSubTitle =
        await todoRepository.updateSubtitle(event.todo, event.subTitle);
    List<Todo>? todo = await todoRepository.getTodo();
    emit(TodoTitleUpdated(todo: event.todo));
  }

  _addOneTodoEvent(AddOneTodoEvent event, emit) async {
    emit(TodoTitleLoading());
    emit(TodoTitleLoaded(todo: event.todo));
    emit(TodoTitleUpdated(todo: event.todo));
  }

  _getTitileFromQRCodeEvent(GetTitleFromQRCodeEvent event, emit) async {
    final qrCode = await todoRepository.scanQR();
    final todo = Todo.fromJson(jsonDecode(qrCode!));
    emit(TodoTitleLoading());
    emit(TodoTitleLoaded(todo: todo));
  }
}
