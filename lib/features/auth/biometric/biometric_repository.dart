import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
        
        print(isAuthenticated);
      } on PlatformException catch (e) {
        print(e.toString());
      }

      print(isAuthenticated);
    }
    return isAuthenticated;
  }
}
