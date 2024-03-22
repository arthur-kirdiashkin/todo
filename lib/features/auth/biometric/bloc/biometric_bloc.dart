import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/auth/biometric/biometric_repository.dart';
part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  late SharedPreferences prefs;
  final BiometricRepository biometricRepository;
  BiometricBloc({required this.biometricRepository})
      : super(BiometricInitial()) {
    on<IsAuthenticatedEvent>(_onAuthenticated);
    on<IsBiometricEvent>(_isBiometric);
  }

  _onAuthenticated(IsAuthenticatedEvent event, emit) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('Biometric On', true);
    print('Вошел');
  }

  _isBiometric(IsBiometricEvent event, emit) async {
    if(Platform.isAndroid) {
    prefs = await SharedPreferences.getInstance();
    bool isAuth = await biometricRepository.authenticateWithBiometrics();
    if (prefs.getBool('currentUser') == true) {
      if (isAuth) {
        prefs.setBool('Biometric On', false);
        emit(BiometricOn());
      } 
    }
    }
  }
}
