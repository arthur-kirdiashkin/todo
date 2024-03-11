import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {

}


class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}


class AuthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}


class UnAuthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}


class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object?> get props => [error];
}