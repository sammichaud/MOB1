import 'package:flutter/material.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/utils/weather.dart';
import 'package:intl/intl.dart';

import 'city_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.weatherData});

  final weatherData;

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  String dayName = DateFormat('EEEE').format(DateTime.now());

  late int temperature;
  late int temperatureMin;
  late int temperatureMax;
  late String weatherIcon;
  late String cityName;
  late String weatherCondition;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData != null) {
        temperature = weatherData['main']['temp'].toInt();
        temperatureMin = weatherData['main']['temp_min'].toInt();
        temperatureMax = weatherData['main']['temp_max'].toInt();
        weatherIcon = weather.getWeatherIcon(weatherData['weather'][0]['id']);
        cityName = weatherData['name'];
        weatherCondition = weatherData['weather'][0]['main'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    cityName,
                    style: kCityNameTextStyle,
                  ),
                  Text(
                    dayName,
                    style: kTimeTextStyle,
                  ),
                ],
              ),
              Image.asset(
                'assets/images/$weatherIcon.png',
                height: 160,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      '$temperature°',
                      style: kTemperatureTextStyle,
                    ),
                  ),
                  Text(
                    weatherCondition.toUpperCase(),
                    style: kConditionTextStyle,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/thermometer_low.png',
                    height: 50,
                  ),
                  Text(
                    '$temperatureMin°',
                    style: kSmallTemperatureTextStyle,
                  ),
                  Image.asset(
                    'assets/images/thermometer_high.png',
                    height: 50,
                  ),
                  Text(
                    '$temperatureMax°',
                    style: kSmallTemperatureTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashRadius: 27.5,
        icon: const Icon(
          Icons.near_me,
          color: Colors.white,
        ),
        onPressed: () async {
          var weatherData = await weather.getLocationWeather();
          updateUI(weatherData);
        },
      ),
      actions: <Widget>[
        IconButton(
          highlightColor: Colors.transparent,
          icon: const Icon(
            Icons.my_location,
            color: Colors.white,
          ),
          onPressed: () async {
            var typedName = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CityScreen();
                },
              ),
            );
            if (typedName != null) {
              var weatherData = await weather.getCityWeather(typedName);
              updateUI(weatherData);
            }
          },
        )
      ],
    );
  }
}
