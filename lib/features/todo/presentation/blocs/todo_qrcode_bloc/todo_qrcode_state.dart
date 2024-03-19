import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoQRCodeState extends Equatable {
  const TodoQRCodeState();
}

class TodoQRCodeInitial extends TodoQRCodeState {
  const TodoQRCodeInitial();

  @override
  List<Object?> get props => [];
}



class TodoQRCodeLoading extends TodoQRCodeState {
  const TodoQRCodeLoading();
  @override
  List<Object?> get props => [];
}

class TodoQRCodeLoaded extends TodoQRCodeState {
  final String todoJson;
  const TodoQRCodeLoaded({
    required this.todoJson,
  });
  @override
  List<Object?> get props => [todoJson];
}

class TodoQRCodeError extends TodoQRCodeState {
  final String message;
  const TodoQRCodeError(this.message);
  @override
  List<Object?> get props => [message];
}
