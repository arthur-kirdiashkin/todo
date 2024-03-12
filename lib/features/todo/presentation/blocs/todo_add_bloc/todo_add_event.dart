import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {}

class AddTodoEvent extends TodoEvent {
  final String todoTitle;

  AddTodoEvent({required this.todoTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [todoTitle];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  final String todoTitle;
  DeleteTodoEvent({
    required this.id,
    required this.todoTitle,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetTodoEvent extends TodoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
