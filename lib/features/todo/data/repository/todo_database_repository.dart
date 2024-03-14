import 'package:text_editor_test/features/todo/data/datasource/todo_database_service.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/models/todo_model.dart';

abstract class TodoDatabaseRepository {
  Future<void> saveTodoData(Todo todo);
  Future<List<Todo>> getTodoFromFirebase();
  Future<void> deleteTodoData(String id);
  Future<void> updateTodoTitleDatabase(Todo todo, String title);
  Future<void> updateTodoSubtitleDatabase(Todo todo, String subTitle);
}



class TodoDatabaseRepositoryImpl implements TodoDatabaseRepository {
  TodoDatabaseService service = TodoDatabaseService();

  @override
  Future<void> saveTodoData(Todo todo) {
    return service.addTodoDatabase(todo);
  }

  @override
  Future<List<Todo>> getTodoFromFirebase() {
    return service.getTodoDatabase();
  }
  
  @override
  Future<void> deleteTodoData(String id) async{
    return service.deleteTodoDatabase(id);
  }
  
  @override
  Future<void> updateTodoSubtitleDatabase(Todo todo, String subTitle) {
    return service.updateTodoSubtitleDatabase(todo, subTitle);
  }
  
  @override
  Future<void> updateTodoTitleDatabase(Todo todo, String title) {
    return service.updateTodoTitleDatabase(todo, title);
  }
  
 
}

