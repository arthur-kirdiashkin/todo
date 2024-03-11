
// import 'package:hive/hive.dart';
// import 'package:text_editor_test/features/data/datasource/todo_service.dart';
// import 'package:text_editor_test/features/data/models/todo_model.dart';

// abstract class TodoRepository {
//   Future<void> addTodo(Todo todo);

//   Future<void> deleteTodo(Todo todo);

//   Future<void> addTodoList(String title);

//   Future<void> deleteTodoList();
// }

// class TodoRepositoryImpl implements TodoRepository {

//   final Box<Todo> _todoBox;

//   TodoRepositoryImpl(this._todoBox);




//   @override
//   Future<void> addTodo(Todo todo) async{
//    await _todoBox.add(todo);
//   }

//   @override
//   Future<void> addTodoList(String title) {
//    final todoToEdit = _todoBox.values.firstWhere((todo) => todo.title == title);
//     List<LocalList> lists = todoToEdit.lists;
//     lists.add(list);
//     todoToEdit.save();
//   }

//   @override
//   Future<void> deleteTodo(Todo todo) {
   
//   }

//   @override
//   Future<void> deleteTodoList() {
   
//   }

// }