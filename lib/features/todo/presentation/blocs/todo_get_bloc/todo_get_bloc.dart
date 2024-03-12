import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/todo_get_bloc/todo_get_event.dart';
import 'package:text_editor_test/features/todo/presentation/todo_get_bloc/todo_get_state.dart';

// class TodoGetBloc extends Bloc<TodoGetEvent, TodoGetState> {
//   final TodoRepository todoRepository;
//   TodoGetBloc({required this.todoRepository}) : super(TodoInitial()) {
//     // on<AddTodoEvent>(_addTodoEvent);
//     on<GetTodoEvent>(_getTodoEvent);
    // on<DeleteTodoEvent>(_deleteTodoEvent);
  // }
  // _addTodoEvent(AddTodoEvent event, emit) async {
  //   emit(TodoLoading());
  //   List<Todo> myTodos = [];
  //   try {
  //     final myTodo = await todoRepository
  //         .addTodo(Todo(title: event.todoTitle, id: Random().nextInt(50)));

  //     myTodos.add(myTodo!);

  //     emit(TodoLoaded(myTodos!));
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // _getTodoEvent(GetTodoEvent event, emit) async {
  //   emit(TodoLoading());
  //   final todo = await todoRepository.getTodo();
  //   emit(TodoLoaded(todo!));
  // }

  // _deleteTodoEvent(DeleteTodoEvent event, emit) async {
  //   final deleteTodo = await todoRepository.deleteTodo(Todo(
  //     id: id,
  //     title: title,
  //   ));
  // }
// }