import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final bool? isDone;
  final String? textTitle;
  final String? id;

  TodoModel({
    this.isDone,
    this.textTitle,
    this.id,
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

//  Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "textTitle": textTitle,
//       "isDone": isDone
//     };
//   }

//   factory TodoModel.fromJson(Map<String, dynamic> json) {
//     return TodoModel(
//         id: json['id'],
//         textTitle: json['textTitle'],
//         isDone: json['isDone']);
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [isDone, textTitle, id];
}
