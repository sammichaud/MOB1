import 'package:weather_app/utils/location.dart';
import 'package:weather_app/utils/http.dart';
import 'package:weather_app/const.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    HttpHelper networkHelper = HttpHelper(
      '$kOpenWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric',
    );
    return await networkHelper.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    HttpHelper networkHelper = HttpHelper(
      '$kOpenWeatherMapURL?q=$cityName&appid=$kApiKey&units=metric',
    );
    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'thunder';
    } else if (condition < 400) {
      return 'drizzle';
    } else if (condition == 500) {
      return 'rain';
    } else if (condition < 600) {
      return 'heavy_rain';
    } else if (condition < 700) {
      return 'snow';
    } else if (condition < 800) {
      return 'fog';
    } else if (condition == 800) {
      return 'sun';
    } else if (condition <= 804) {
      return 'cloud';
    } else {
      return 'thermometer';
    }
  }
}
