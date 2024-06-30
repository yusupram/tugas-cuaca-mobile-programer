import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: WeatherWidget(),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String cityName = 'Jakarta, Indonesia';
  int temperature = 23;
  String weatherCondition = 'Partly Cloudy';
  DateTime currentDate = DateTime(2021, 3, 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5B9FFF), Color(0xFF1E88E5)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildDateLocationWidget(),
              ),
              Expanded(
                child: _buildMainWeatherWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildWeatherInfoWidget(),
                    SizedBox(height: 20),
                    _buildHourlyForecast(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateLocationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${currentDate.day} ${_getMonthName(currentDate.month)} ${currentDate.year}',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          cityName,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMainWeatherWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud, size: 120, color: Colors.white),
          SizedBox(height: 20),
          Text(
            '$temperature°',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            weatherCondition,
            style: TextStyle(fontSize: 24, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfoWidget() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(Icons.air, '7km/h', 'Wind'),
          _buildInfoItem(Icons.water_drop, '28%', 'Humidity'),
          _buildInfoItem(Icons.remove_red_eye, '20km', 'Visibility'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 25),
        SizedBox(height: 5),
        Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHourlyItem('13:00', Icons.wb_sunny, '26°'),
            _buildHourlyItem('14:00', Icons.thunderstorm, '26°'),
            _buildHourlyItem('15:00', Icons.cloud, '23°'),
            _buildHourlyItem('16:00', Icons.wb_cloudy, '22°'),
          ],
        ),
      ],
    );
  }

  Widget _buildHourlyItem(String time, IconData icon, String temp) {
    return Column(
      children: [
        Text(time, style: TextStyle(color: Colors.white)),
        Icon(icon, color: Colors.white),
        Text(temp, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }
}