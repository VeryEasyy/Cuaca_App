// weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wheater_app/models/weather_model.dart';

class WeatherService {
  static const String apiKey = '622121162a39d75d46820c797f833f68'; // Replace with your API key
  static const String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String hourlyForecastUrl = 'https://api.openweathermap.org/data/2.5/onecall';

  static Future<Weather?> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      return null;
    }
  }

  static Future<Weather?> getHourlyWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse('$hourlyForecastUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      return null;
    }
  }
}
