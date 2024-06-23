import 'package:flutter/material.dart';
import 'package:wheater_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;
  List<Weather> _weeklyWeather = [];
  bool _isLoading = false;

  Weather? get currentWeather => _currentWeather;
  List<Weather> get weeklyWeather => _weeklyWeather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    final apiKey = '622121162a39d75d46820c797f833f68';
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';
    final forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (response.statusCode == 200 && forecastResponse.statusCode == 200) {
        final data = json.decode(response.body);
        final forecastData = json.decode(forecastResponse.body);

        _currentWeather = Weather.fromJson(data);

        _weeklyWeather = (forecastData['list'] as List)
            .map((item) => Weather.fromJson(item))
            .toList();
      } else {
        _currentWeather = null;
        _weeklyWeather = [];
      }
    } catch (error) {
      _currentWeather = null;
      _weeklyWeather = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
