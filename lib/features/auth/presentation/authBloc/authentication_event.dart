import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {

}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
  
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});
  
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}