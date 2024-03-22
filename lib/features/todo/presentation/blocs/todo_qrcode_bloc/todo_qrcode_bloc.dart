import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_state.dart';

class TodoQRCodeBloc extends Bloc<TodoQRCodeEvent, TodoQRCodeState> {
  late SharedPreferences prefs;
  final TodoRepository todoRepository;
  TodoQRCodeBloc({required this.todoRepository}) : super(const TodoQRCodeInitial()) {
    on<TodoAddQRCodeEvent>(_todoAddQRCodeEvent);
    on<TodoAddQRCodeSubtitleEvent>(_todoAddQRCodeSubtitleEvent);
  }

  _todoAddQRCodeEvent(TodoAddQRCodeEvent event, emit) async {
    prefs = await SharedPreferences.getInstance();

    emit(TodoQRCodeLoading());

   
      final myTodo = Todo(
          id: event.todo.id,
          title: event.todo.title,
          subTitle: event.todo.subTitle,
          status: event.todo.status);

      final todoJson = jsonEncode(myTodo.toMap());

      emit(TodoQRCodeLoaded(todoJson: todoJson));
    
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
