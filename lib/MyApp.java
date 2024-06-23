// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_project_name/providers/weather_provider.dart';
import 'package:your_project_name/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'Cuaca App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WeatherScreen(),
      ),
    );
  }
}
