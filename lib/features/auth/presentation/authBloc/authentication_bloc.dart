import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/data/user.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';

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
        if (prefs.getBool('currentUser') == true) {
          MyUser user = await authenticationRepository.getCurrentUser().first;
          // if(user.displayName == null) {
          //   return emit(AuthenticationFailure());
          // } else {
          //   return emit(AuthenticationSuccess(displayName: user.displayName));
          // }
          if (user.uid != "uid") {
            String? displayName =
                await authenticationRepository.retrieveUserName(user);
            emit(AuthenticationSuccess(displayName: displayName));
          } else {
            emit(AuthenticationFailure());
          }
        } else if(prefs.getBool('currentUser') == false) {
            emit(AuthenticationNotSuccess());
        } 
        
        else {
          emit(AuthenticationNotSuccess());
        }
        // try {
        //   emit(AuthenticationSuccess(displayName: user.displayName));
        // } catch (e) {
        //   emit(AuthenticationFailure());
        // }
      } else if (event is AuthenticationSignedOut) {
        prefs.setBool('currentUser', false);
        await authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
