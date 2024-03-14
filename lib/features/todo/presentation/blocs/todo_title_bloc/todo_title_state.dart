import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoTitleState extends Equatable {}

class TodoTitleInitial extends TodoTitleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TodoTitleUpdated extends TodoTitleState {
  final Todo todo;

  TodoTitleUpdated({required this.todo});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TodoTitleLoading extends TodoTitleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TodoTitleLoaded extends TodoTitleState {
  // final String subtitle;
  // final String title;
  // final int id;
  final Todo todo;

  TodoTitleLoaded({required this.todo});
  // TodoTitleLoaded({
  //   required this.title,
  //   required this.id,
  //   required this.subtitle,
  // });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TodoTitleError extends TodoTitleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
