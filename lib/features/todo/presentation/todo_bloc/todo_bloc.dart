import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/todo_bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEvent);
  }
  _addTodoEvent(AddTodoEvent event, emit) async{
    emit(TodoLoading());
    try {
      final myTodo = await todoRepository.addTodo(Todo(title: event.todoTitle));
      print(myTodo);
    emit(TodoLoaded(myTodo!));
    } catch (e) {
      throw Exception();
    }
    
  }
}