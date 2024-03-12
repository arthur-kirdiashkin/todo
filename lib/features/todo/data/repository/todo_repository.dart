import 'package:hive/hive.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';

abstract class TodoRepository {
  Future<Todo?> addTodo(Todo todo);

  Future<bool> deleteTodo(int id);

  Future<void> addTodoList(String title);

  Future<void> deleteTodoList();

  Future<List<Todo>?> getTodo();

  void openBox();
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl();

  @override
  Future<Todo?> addTodo(Todo todo) async {
    final todoBox = await openBox();
    todoBox.put(todo.id, todo);

    return todo;
  }

  @override
  Future<bool> deleteTodo(int id) async {
    final todoBox = await openBox();
    todoBox.delete(id);
    return true;
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

  @override
  Future<Box> openBox() async {
    return await Hive.openBox('HiveTodos');
  }

  @override
  Future<List<Todo>?> getTodo() async {
    List<Todo> todo = [];
    final todoBox = await openBox();

    for (var i in todoBox.values) {
      if (i.runtimeType == Todo) {
        todo.add(i);
      }
    }
    print(todoBox.values);
    return todo;
  }

  // @override
  // Future<void> addTodoList(String title) {
  //  final todoToEdit = _todoBox.values.firstWhere((todo) => todo.title == title);
  //   List<LocalList> lists = todoToEdit.lists;
  //   lists.add(list);
  //   todoToEdit.save();
  // }
}
