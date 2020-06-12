import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:poolheatercalculator/core/models/elevation.dart';
import 'package:poolheatercalculator/core/models/weather.dart';

class Api {
  static BaseOptions _options = new BaseOptions(
    baseUrl: "https://api.openweathermap.org/data/2.5/weather?",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio _dio = new Dio(_options);

  Api() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      return options; //continue
    }, onResponse: (Response response) async {
      print("=============RESPONSE==============");
      print(response);
      print("=============RESPONSE==============");
      return response; // continue
    }, onError: (DioError e) async {
      print(e);
      return e; //continue
    }));
  }

  Future<WeatherData> getWeatherData(LocationData location) async {
    try {
      _dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';
      print(
          "lat=${location.latitude}&lon=${location.longitude}&appid=0e1a7c9d4643a299bc8a1a286bb8e843");
      Response response = await _dio.get(
          "lat=${location.latitude}&lon=${location.longitude}&appid=0e1a7c9d4643a299bc8a1a286bb8e843");
      print(response.data.runtimeType);
      return WeatherData.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  getElevation(LocationData location) async {
    try {
      _dio.options.baseUrl =
          'https://maps.googleapis.com/maps/api/elevation/json?locations=';
      Response response = await _dio.get(
          "${location.latitude},${location.longitude}&key=AIzaSyBYsA7qJnG77Ore0amcxOwgi85_8BmuYdo");
      return Elevation.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
