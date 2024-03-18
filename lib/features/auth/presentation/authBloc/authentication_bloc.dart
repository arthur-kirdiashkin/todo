import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/data/user.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
    
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  late SharedPreferences prefs;
  late bool finishedOnBoarding;
  AuthenticationBloc({required this.authenticationRepository})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();
      if (event is AuthenticationStarted) {
        if(kIsWeb) {
          prefs.setBool('Biometric On', true);
        }
        if (prefs.getBool('currentUser') == true && prefs.getBool('Biometric On') == true) {
         
          MyUser user = await authenticationRepository.getCurrentUser().first;
          if (user.uid != "uid") {
            String? displayName =
                await authenticationRepository.retrieveUserName(user);
            emit(AuthenticationSuccess(displayName: displayName));
          } else {
            emit(AuthenticationFailure());
          }
        } else if (prefs.getBool('currentUser') == false) {
          emit(AuthenticationNotSuccess());
        } else {
          emit(AuthenticationNotSuccess());
        }
      } else if (event is AuthenticationSignedOut) {
        prefs.setBool('currentUser', false);
        await authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
