import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

abstract class BiometricRepository {
  Future<bool> authenticateWithBiometrics();
}

class BiometricRepositoryImpl implements BiometricRepository {
  @override
  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported || canCheckBiometrics) {
      try {
        isAuthenticated = true;
      //   isAuthenticated = await localAuthentication.authenticate(
      //   localizedReason: 'Please complete the biometrics to proceed.',
        
      //   // authMessages: <AuthMessages> [
      //   //   AndroidAuthMessages(
      //   //     signInTitle: 'Biometric is required',
      //   //     cancelButton: 'No, thanks'
      //   //   )
      //   // ]
        
        
      // );
      print(isAuthenticated);
      } on PlatformException catch (e) {
        print(e.toString());
      }
      
      print(isAuthenticated);
    }
    return isAuthenticated;
  }
}
