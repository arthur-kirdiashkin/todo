
import 'package:hive/hive.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';


abstract class TodoRepository {
  Future<Todo?> addTodo(Todo todo);

  Future<Todo?> deleteTodo(Todo todo);

  Future<void> addTodoList(String title);

  Future<void> deleteTodoList();
}

class TodoRepositoryImpl implements TodoRepository {

  final Box<Todo> _todoBox;

  TodoRepositoryImpl(this._todoBox);




  @override
  Future<Todo?> addTodo(Todo todo) async{
   await _todoBox.add(todo);
  }

 

   @override
  Future<Todo?> deleteTodo(Todo todo) async{
    await _todoBox.delete(todo);
  }

  
  
  @override
  Future<void> addTodoList(String title) {
    // TODO: implement addTodoList
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteTodoList() {
    // TODO: implement deleteTodoList
    throw UnimplementedError();
  }
  
 

 // @override
  // Future<void> addTodoList(String title) {
  //  final todoToEdit = _todoBox.values.firstWhere((todo) => todo.title == title);
  //   List<LocalList> lists = todoToEdit.lists;
  //   lists.add(list);
  //   todoToEdit.save();
  // }

}