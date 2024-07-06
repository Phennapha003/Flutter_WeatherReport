//import 'package:flutter_application_w7/data_classes/weather_data/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

import '../data_classes/weather_data/weather_data.dart';
import 'package:http/http.dart' as http;

class OpenWeather {
  static Future<Position> _determinePosition(LocationAccuracy lowest) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are disabled.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanetly denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<WeatherData> fetchByCurrentPosition() async {
    await dotenv.load(fileName: 'lib/.env');
    Position position = await _determinePosition(LocationAccuracy.lowest);
    String latitude = position.latitude.toStringAsFixed(3);
    String longitude = position.longitude.toStringAsFixed(3);
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${dotenv.env['API_KEY']}';
    return await _fetch(url);
  }

  static Future<WeatherData> _fetch(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load weather data');
    }
    return WeatherData.fromJson(response.body);
  }

  static Future<WeatherData> fetchByCityName({required cityName}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${dotenv.env['API_KEY']}';
    try {
      return await _fetch(url);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
