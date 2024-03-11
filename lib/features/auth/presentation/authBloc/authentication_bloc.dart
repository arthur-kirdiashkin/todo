import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;
  AuthBloc({required this.authenticationRepository})
      : super(UnAuthenticatedState()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authenticationRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authenticationRepository.signUp(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoadingState());
      await authenticationRepository.logOut();
      emit(UnAuthenticatedState());
    });
  }
}
