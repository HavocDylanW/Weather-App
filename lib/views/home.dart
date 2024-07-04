import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/weather_provider.dart';
import '/providers/theme.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .fetchWeather(_controller.text);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.weatherData == null) {
                    return Center(
                      child: Text(
                        'Loading weather data...',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.network(
                                    'https://openweathermap.org/img/wn/${provider.weatherData!['weather'][0]['icon']}@2x.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${provider.weatherData!['name']}',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Image.network(
                                        'https://flagcdn.com/24x18/${provider.weatherData!['sys']['country'].toLowerCase()}.png',
                                        width: 24,
                                        height: 18,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    '${provider.weatherData!['main']['temp']}°C',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Kondisi',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            '${provider.weatherData!['weather'][0]['description']}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Humidity',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            '${provider.weatherData!['main']['humidity']}%',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Kecepatan Angin',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            '${provider.weatherData!['wind']['speed']} m/s',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        provider.hourlyData == null
                            ? Center(
                                child: Text(
                                  'Loading hourly data...',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.hourlyData!.length,
                                  itemBuilder: (context, index) {
                                    final hourly = provider.hourlyData![index];
                                    return Card(
                                      child: Container(
                                        width:
                                            100, // Adjust the width of the cards here
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              'https://openweathermap.org/img/wn/${hourly['weather'][0]['icon']}@2x.png',
                                              width: 50,
                                              height: 50,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${hourly['main']['temp']}°C',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${hourly['dt_txt'].substring(11, 16)}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
