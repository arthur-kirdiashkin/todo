// import 'package:equatable/equatable.dart';
// import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

// abstract class TodoGetState extends Equatable {
//   const TodoGetState();
// }

// class TodoInitial extends TodoGetState {
//   const TodoInitial();
  
//   @override
//   List<Object?> get props => [];
// }

// class TodoAdded extends TodoGetState {
//   const TodoAdded();

//   @override
//   List<Object?> get props => [];
// }

// class TodoLoading extends TodoGetState {
//   const TodoLoading();
//   @override
//   List<Object?> get props => [];
// }



// class TodoLoaded extends TodoGetState {
//   final List<Todo> todo;
//   const TodoLoaded(this.todo);
//   @override
//   List<Object?> get props => [todo];
// }



// class TodoError extends TodoGetState {
//   final String message;
//   const TodoError(this.message);
//   @override
//   List<Object?> get props => [message];
// }