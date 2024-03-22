import 'package:equatable/equatable.dart';

abstract class EncryptEvent extends Equatable {}

class EncryptDataEvent extends EncryptEvent {
  final String password;

  EncryptDataEvent({
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        password,
      ];
}

class AddEncryptDataEvent extends EncryptEvent {
  AddEncryptDataEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


