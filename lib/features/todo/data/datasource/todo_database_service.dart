import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/models/todo_model.dart';

class TodoDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Todo?> addTodoDatabase(Todo todo) async {
    await _db.collection("Todolist").doc(todo.id.toString()).set(todo.toMap());
  }

  Future<List<Todo>> getTodoDatabase() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Todolist").get();
    return snapshot.docs
        .map((docSnapshot) => Todo.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void>? deleteTodoDatabase(String id) async {
    DocumentReference _documentReference = _db.collection("Todolist").doc(id);
    await _documentReference.delete();
  }

  Future<Todo?> updateTodoTitleDatabase(Todo todo, String title) async {
    await _db.collection("Todolist").doc(todo.id.toString()).update({'title' : title});
    print(todo.title);
  }

  Future<Todo?> updateTodoSubtitleDatabase(Todo todo, String subTitle) async {
    await _db.collection("Todolist").doc(todo.id.toString()).update({'subTitle' : subTitle});
  }

  // Future<Todo?> deleteFromDatabase() {
    
  // }
}

