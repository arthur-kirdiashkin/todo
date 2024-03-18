import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoTitleEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateTodoTitleEvent extends TodoTitleEvent {
  // final int id;
  final Todo todo;
  final String? title;
  // final String subTitle;

  UpdateTodoTitleEvent({
    required this.todo,
    // required this.id,
    required this.title,
    // required this.subTitle,
  });
}

class UpdateTodoSubTitleEvent extends TodoTitleEvent {
  // final int id;
  final String subTitle;
  final Todo todo;
  // final String? subTitle;

  UpdateTodoSubTitleEvent({
    // required this.id,
    required this.subTitle,
    required this.todo,
    // required this.subTitle,
  });
}

class AddOneTodoEvent extends TodoTitleEvent {
  final Todo todo;
  // final String subtitle;
  // final int id;
  // final String title;

  AddOneTodoEvent({
    required this.todo,
    // required this.subtitle,
    // required this.id,
    // required this.title,
  });
}

class AddQRCodeEvent extends TodoTitleEvent {
  // final Todo todo;
  final String todoJson;

  AddQRCodeEvent({
    // required this.todo,
    required this.todoJson,
  });
}

class GetTitleFromQRCodeEvent extends TodoTitleEvent {
  // final Todo qrTodo;

  GetTitleFromQRCodeEvent(
    // required this.qrTodo,
  );
}
