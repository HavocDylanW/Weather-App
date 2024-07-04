import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic>? weatherData;
  List<dynamic>? hourlyData; // Add this line to store hourly data
  String? errorMessage;

  final WeatherService _weatherService = WeatherService();

  WeatherProvider() {
    fetchWeather('Tegal');
  }

  Future<void> fetchWeather(String city) async {
    try {
      weatherData = await _weatherService.fetchWeather(city);
      hourlyData =
          await _weatherService.fetchHourlyWeather(city); // Fetch hourly data
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
