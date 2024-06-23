import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheater_app/providers/weather_provider.dart';
import 'package:wheater_app/models/weather_model.dart';
import 'package:wheater_app/widget/weather_item.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    weatherProvider.fetchWeather(_cityController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            weatherProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : weatherProvider.currentWeather != null
                ? Expanded(child: _buildWeatherContent(weatherProvider, context))
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContent(WeatherProvider weatherProvider, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var currentDate = DateFormat('EEEE, d MMMM').format(DateTime.now());
    Weather currentWeather = weatherProvider.currentWeather!;
    String imageUrl = 'http://openweathermap.org/img/wn/${currentWeather.icon}@2x.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentWeather.cityName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        Text(
          currentDate,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: size.width,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(.5),
                offset: Offset(0, 25),
                blurRadius: 10,
                spreadRadius: -12,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -40,
                left: 20,
                child: Image.network(
                  imageUrl,
                  width: 150,
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Text(
                  currentWeather.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        currentWeather.temperature.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '°C',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            weatherItem(
              text: 'Wind Speed',
              value: currentWeather.windSpeed.toInt(),
              unit: 'km/h',
              imageUrl: 'assets/windspeed.png',
            ),
            weatherItem(
              text: 'Humidity',
              value: currentWeather.humidity.toInt(),
              unit: '%',
              imageUrl: 'assets/humidity.png',
            ),
            weatherItem(
              text: 'Max Temp',
              value: currentWeather.maxTemp.toInt(),
              unit: '°C',
              imageUrl: 'assets/max-temp.png',
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              'Next 7 Days',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherProvider.weeklyWeather.length,
            itemBuilder: (context, index) {
              final weather = weatherProvider.weeklyWeather[index];
              final formattedDate = DateFormat('EEEE').format(weather.date).substring(0, 3);
              final iconUrl = 'http://openweathermap.org/img/wn/${weather.icon}.png';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                width: 80,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.blueAccent : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 5,
                      color: index == 0 ? Colors.blueAccent : Colors.black54.withOpacity(.2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: index == 0 ? Colors.white : Colors.black54,
                        fontWeight: index == 0 ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    Image.network(
                      iconUrl,
                      width: 30,
                    ),
                    Text(
                      '${weather.temperature.toInt()}°C',
                      style: TextStyle(
                        color: index == 0 ? Colors.white : Colors.black54,
                        fontWeight: index == 0 ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget weatherItem({
  required String text,
  required int value,
  required String unit,
  required String imageUrl,
}) {
  return Column(
    children: [
      Image.asset(imageUrl, width: 50),
      Text(
        '$value$unit',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
