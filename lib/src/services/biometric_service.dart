import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _biometric = LocalAuthentication();

  Future<bool> checkSupported() async {
    bool value = false;

    await _biometric.isDeviceSupported().then(
      (bool isSupported) {
        value = isSupported;
      },
    );

    bool authenticated = false;
    try {
      authenticated = await _biometric.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }

    print(authenticated);
    return value;
  }

  bool authenticated() {
    return false;
  }
}
