import 'package:hive/hive.dart';
part 'todo_service.g.dart';

@HiveType(typeId: 0)
enum TodoStatus {
  @HiveField(0)
  pending,

  @HiveField(1)
  archived
}

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  TodoStatus? status;

  @HiveField(2)
  final int id;

  Todo({
    required this.id,
    required this.title,
    this.status,
  });
  

  void setStatus(TodoStatus status) {
    this.status = status;
  }
}