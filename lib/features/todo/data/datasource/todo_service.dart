import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? title;

  @HiveField(1)
  TodoStatus? status;

  @HiveField(2)
  final int id;

  @HiveField(3)
  String? subTitle;

  Todo({
    required this.id,
    required this.title,
    this.status,
    this.subTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'title': title,
      'id': id,
      'subTitle': subTitle,
    };
  }

  Todo.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = int.parse(doc.id),
        title = doc.data()!['title'],
        status = doc.data()!['status'],
        subTitle = doc.data()!['subTitle'];

  void setStatus(TodoStatus status) {
    this.status = status;
  }

  Todo copyWith({
    String? title,
    String? subTitle,
    int? id,
  }) {
    return Todo(
      id: id ?? this.id,
      subTitle: subTitle ?? this.subTitle,
      title: title ?? this.subTitle,
    );
  }
}
