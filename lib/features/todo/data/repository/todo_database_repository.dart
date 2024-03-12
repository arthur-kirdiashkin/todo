import 'package:text_editor_test/features/todo/data/datasource/todo_database_service.dart';
import 'package:text_editor_test/features/todo/data/models/todo_model.dart';

abstract class TodoDatabaseRepository {
  Future<void> saveTodoData(TodoModel todomodel);
  Future<List<TodoModel>> retrieveTodoData();
}



class TodoDatabaseRepositoryImpl implements TodoDatabaseRepository {
  TodoDatabaseService service = TodoDatabaseService();

  @override
  Future<void> saveTodoData(TodoModel todomodel) {
    return service.addTodoDatabase(todomodel);
  }

  @override
  Future<List<TodoModel>> retrieveTodoData() {
    return service.retrieveTodoDatabase();
  }
}

