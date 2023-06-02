import 'dart:convert';

import 'package:climate_app/weather_model.dart';
import 'package:climate_app/weather_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class WeatherClass with ChangeNotifier {
  WeatherModel data = WeatherModel();

  Future<void> getWeatherData(String city) async {
    http.Response? response = await weatherData(city);

    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      var responseData = json.decode(response.body);
      print(response.body);
      data = WeatherModel.fromJson(responseData);
    }

    notifyListeners();
  }
}
