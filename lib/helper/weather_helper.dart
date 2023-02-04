import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_api/model/Weather.dart';

class WeatherHelper {
  WeatherHelper._();

  static final WeatherHelper weatherHelper = WeatherHelper._();

  Future<Weather?> fetchWeatherData({String city = 'surat'}) async {
    String apiKey = "ae230e32f825e392da3b83daa209ccad";
    String api =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";

    http.Response response = await http.get(
      Uri.parse(api),
    );

    if (response.statusCode == 200) {
      Map decodeData = jsonDecode(response.body);

      Weather weather = Weather.fromMap(data: decodeData);

      return weather;
    }
  }
}
