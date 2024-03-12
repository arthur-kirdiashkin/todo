import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/models/todo_model.dart';

class TodoDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

   Future<Todo?> addTodoDatabase(TodoModel todo) async {
    await _db.collection("Todolist").doc(todo.id.toString()).set(todo.toMap());
  }

    Future<List<TodoModel>> retrieveTodoDatabase() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Todolist").get(); 
    return snapshot.docs
        .map((docSnapshot) => TodoModel.fromDocumentSnapshot(docSnapshot))
        .toList();
    }

        Future<String> retrieveTodoTitle(Todo todo) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Todolist").doc(todo.id.toString()).get();
    return snapshot.data()!['textTitle'];
    }
}