import 'package:equatable/equatable.dart';

class ToDo extends Equatable{
  final bool? isDone;
  final String? text;
  final String? id;

  ToDo({
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

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
        id: json['id'],
        text: json['text'],
        isDone: json['isDone']);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [isDone, text, id];

  


}