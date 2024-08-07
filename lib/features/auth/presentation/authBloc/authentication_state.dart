import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
      @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String? displayName;
  const AuthenticationSuccess({this.displayName});

    @override
  List<Object?> get props => [displayName];
}

class AuthenticationNotSuccess extends AuthenticationState{
  
}

class AuthenticationFailure extends AuthenticationState {
      @override
  List<Object?> get props => [];
}