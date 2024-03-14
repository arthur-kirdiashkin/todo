import 'package:equatable/equatable.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoGetState extends Equatable {
  const TodoGetState();
}

class TodoGetInitial extends TodoGetState {
  const TodoGetInitial();
  
  @override
  List<Object?> get props => [];
}

// class TodoAdded extends TodoGetState {
//   const TodoAdded();

//   @override
//   List<Object?> get props => [];
// }

class TodoGetLoading extends TodoGetState {
  const TodoGetLoading();
  @override
  List<Object?> get props => [];
}



class TodoGetLoaded extends TodoGetState {
  final List<Todo> todo;
  const TodoGetLoaded(this.todo);
  @override
  List<Object?> get props => [todo];
}



class TodoGetError extends TodoGetState {
  final String message;
  const TodoGetError(this.message);
  @override
  List<Object?> get props => [message];
}