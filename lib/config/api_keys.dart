// api_config.dart

enum TemperatureUnit {
  metric, // Celsius
  imperial, // Fahrenheit
  standard, // Kelvin
}

class ApiConfig {
  static const String openWeatherMapBaseUrl = 'http://api.openweathermap.org/data/2.5';
  static const String currentWeatherEndpoint = '/weather';

  static TemperatureUnit defaultTemperatureUnit = TemperatureUnit.metric;
  static String defaultLanguage = 'en'; // Bahasa Inggris sebagai default

  static const int requestTimeout = 5000; // Timeout dalam milidetik (ms)
  static const int maxRetry = 3; // Jumlah maksimum percobaan ulang jika permintaan gagal
}
