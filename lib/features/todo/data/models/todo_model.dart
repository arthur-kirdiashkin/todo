import 'package:equatable/equatable.dart';

class TodoModel extends Equatable{
  final bool? isDone;
  final String? text;
  final String? id;

  TodoModel({
    required this.isDone,
    required this.text,
    required this.id,
  });
  
 Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "isDone": isDone
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'],
        text: json['text'],
        isDone: json['isDone']);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [isDone, text, id];

  


}