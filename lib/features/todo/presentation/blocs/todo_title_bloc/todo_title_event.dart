import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoTitleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateTodoTitleEvent extends TodoTitleEvent {
  final Todo todo;
  final String? title;

  UpdateTodoTitleEvent({
    required this.todo,
    required this.title,
  });
}

class UpdateTodoSubTitleEvent extends TodoTitleEvent {
  final String subTitle;
  final Todo todo;

  UpdateTodoSubTitleEvent({
    required this.subTitle,
    required this.todo,
  });
}

class AddOneTodoEvent extends TodoTitleEvent {
  final Todo todo;

  AddOneTodoEvent({
    required this.todo,
  });
}

class AddQRCodeEvent extends TodoTitleEvent {
  final String todoJson;

  AddQRCodeEvent({
    required this.todoJson,
  });
}

class GetTitleFromQRCodeEvent extends TodoTitleEvent {
  GetTitleFromQRCodeEvent();
}

class AddQRCodeSubtitleEvent extends TodoTitleEvent {
  final Todo todo;
  final String subtitile;

  AddQRCodeSubtitleEvent({
    required this.todo,
    required this.subtitile,
  });
}
