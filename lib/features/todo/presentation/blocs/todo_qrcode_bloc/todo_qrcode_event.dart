import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoQRCodeEvent extends Equatable {}

class TodoAddQRCodeEvent extends TodoQRCodeEvent {
  final String todoJson;

  TodoAddQRCodeEvent({required this.todoJson});

  @override
  // TODO: implement props
  List<Object?> get props => [todoJson];
}

class TodoAddQRCodeSubtitleEvent extends TodoQRCodeEvent {
  final Todo todo;
  final String subtitile;

  TodoAddQRCodeSubtitleEvent({
    required this.todo,
    required this.subtitile,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        todo,
        subtitile,
      ];
}
