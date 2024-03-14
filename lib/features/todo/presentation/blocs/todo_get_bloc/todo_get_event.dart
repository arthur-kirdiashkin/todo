import 'package:equatable/equatable.dart';

abstract class TodoGetEvent extends Equatable {}

class GetTodolistEvent extends TodoGetEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}