import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

abstract class TodoRepository {
  Future<Todo?> addTodo(Todo todo);

  Future<bool> deleteTodo(int id);

  Future<List<Todo>?> getTodo();

  Future<Todo>? updateTodoTitle(Todo todo, String titile);

  Future<Todo>? updateSubtitle(Todo todo, String subTitle);

  void openBox();

  Future<String?> scanQR();

  Future<Box?> deleteBox();
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
  Future<Box> openBox() async {
    // Hive.deleteBoxFromDisk('HiveTodos');
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

  @override
  Future<Todo>? updateTodoTitle(Todo todo, String title) async {
    todo.title = title;
    todo.save();
    final todoBox = await openBox();
    todoBox.put(todo.id, todo);
    print(todoBox.values);
    return todo;
  }

  @override
  Future<Todo>? updateSubtitle(Todo todo, String subtitle) async {
    todo.subTitle = subtitle;
    todo.save();
    final todoBox = await openBox();
    todoBox.put(todo.id, todo);
    print(todoBox.values);

    return todo;
  }

  @override
  Future<String?> scanQR() async {
    String? qrResult;
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      qrResult = qrCode.toString();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return qrResult;
  }

  @override
  Future<Box?> deleteBox() async {
    final todoBox = await openBox();
    todoBox.clear();
  }
}
