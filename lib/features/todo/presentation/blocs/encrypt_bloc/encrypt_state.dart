import 'package:equatable/equatable.dart';

abstract class EncryptState extends Equatable {}

class EncryptInitialState extends EncryptState {
  @override
  List<Object?> get props => [];
}

class EncryptStateLoading extends EncryptState {
  @override
  List<Object?> get props => [];

}

class AddEncryptStateLoaded extends EncryptState {
 

  AddEncryptStateLoaded();
  @override

  List<Object?> get props => [];

}


class EncryptStateLoaded extends EncryptState {
  @override
  List<Object?> get props => [];

}

class DecryptStateLoaded extends EncryptState {
  @override
  List<Object?> get props => [];

}


class AddDecryptStateLoaded extends EncryptState {
  @override
  List<Object?> get props => [];

}