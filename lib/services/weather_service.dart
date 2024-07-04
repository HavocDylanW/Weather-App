import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '1fe5f03e8b679377cbc41601289edfdd';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<dynamic>> fetchHourlyWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['list']; // 'list' contains the hourly forecast data
    } else {
      throw Exception('Failed to load hourly weather data');
    }
  }
}
