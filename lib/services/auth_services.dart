import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthServices {
  static final _localAuth = LocalAuthentication();
  final _box = GetStorage();
  final _key = "isOnID";

  void checkLocalAuth() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    print(canCheckBiometrics);
    print(_box.read(
      _key,
    ));
  }

  Future<bool> get isUserHasFingerprint async {
    return await _localAuth.isDeviceSupported();
  }

  void saveToLocalAuthToBox({required bool isAuthOn}) {
    _box.write(_key, isAuthOn);
  }

  bool get getIsUserNeedAuthenticate {
    if (_box.read(_key) == true) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _localAuth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
}
