import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:poolheatercalculator/core/models/pool.dart';
import 'package:poolheatercalculator/core/models/weather.dart';
import 'package:poolheatercalculator/core/services/api.dart';
import 'package:poolheatercalculator/core/services/firebase_utils.dart';
import 'package:poolheatercalculator/core/utils/shared_pref_util.dart';
import 'package:poolheatercalculator/locator.dart';

class HomeService {
  Api api = locator<Api>();

  Future<String> getBleDeviceAddress() {
    return SharedPrefUtil.getBleDeviceAddress();
  }

  Future<bool> setBleDeviceAddress(String address) {
    return SharedPrefUtil.setBleDeviceAddress(address);
  }

  Future<WeatherData> getWeatherData(LocationData location) {
    return api.getWeatherData(location);
  }

  getElevation(LocationData locationData) {
    return api.getElevation(locationData);
  }

  saveReading(Pool pool) {
    return FirebaseUtils.saveReading(pool.toJson());
  }

  getAllReadingsForCurrentUser(String currentUser) {
    return FirebaseUtils.getAllReadingsForCurrentUser(currentUser);
  }

  getCurrentUser() {
    return FirebaseUtils.getCurrentUser();
  }

  Future<void> deleteEntry(String uid) {
    return FirebaseUtils.deleteEntry(uid);
  }
}
