import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_state.dart';

class TodoQRCodeBloc extends Bloc<TodoQRCodeEvent, TodoQRCodeState> {
  final TodoRepository todoRepository;
  TodoQRCodeBloc({required this.todoRepository}) : super(TodoQRCodeInitial()) {
  
    on<TodoAddQRCodeEvent>(_todoAddQRCodeEvent);
    on<TodoAddQRCodeSubtitleEvent>(_todoAddQRCodeSubtitleEvent);

  }
 
   _todoAddQRCodeEvent(TodoAddQRCodeEvent event, emit) async {
    emit(TodoQRCodeLoading());
    emit(TodoQRCodeLoaded(todoJson: event.todoJson));
  }
 
 _todoAddQRCodeSubtitleEvent(TodoAddQRCodeSubtitleEvent event, emit) async {
   final todo = Todo(
        id: event.todo.id,
        title: event.todo.title,
        subTitle: event.subtitile,
        status: event.todo.status);
    final todoJson = jsonEncode(todo.toMap());
    emit(TodoQRCodeLoading());
    emit(TodoQRCodeLoaded(todoJson: todoJson));
 }

  
}