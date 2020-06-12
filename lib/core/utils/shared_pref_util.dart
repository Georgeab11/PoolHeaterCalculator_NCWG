import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  static String _bleAddress = "bleAddress";
  static String _dontShowMessageAgain = "showMessageAgain";

  static Future<String> getBleDeviceAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(_bleAddress);
  }

  static Future<bool> setBleDeviceAddress(String address) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(_bleAddress, address);
  }

  static Future<bool> shouldShowMessageAgain() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_dontShowMessageAgain) == null
        ? true
        : !sharedPreferences.getBool(_dontShowMessageAgain);
  }

  static Future<bool> setDontShowMessageAgain(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(_dontShowMessageAgain, value);
  }
}
