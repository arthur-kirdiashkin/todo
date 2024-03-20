import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final bool? isDone;
  final String? textTitle;
  final String? id;

  TodoModel({
    this.isDone,
    required this.textTitle,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'isDone': isDone,
      'textTitle': textTitle,
      'id': id,
    };
  }

  TodoModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        textTitle = doc.data()!['textTitle'],
        isDone = doc.data()!["isDone"];

  @override
  // TODO: implement props
  List<Object?> get props => [
        textTitle,
        id,
        isDone,
      ];


}
