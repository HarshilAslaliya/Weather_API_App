class Weather {
  final String main;
  final String des;
  final double temp;
  final int humidity;
  final double speed;
  final String country;
  final String name;
  final int pressure;
  final double temp_min;
  final double temp_max;
  final double feel_like;

  Weather({
    required this.main,
    required this.des,
    required this.temp,
    required this.humidity,
    required this.speed,
    required this.country,
    required this.name,
    required this.pressure,
    required this.temp_min,
    required this.temp_max,
    required this.feel_like,
  });

  factory Weather.fromMap({required Map data}) {
    return Weather(
      main: data['weather'][0]['main'],
      des: data['weather'][0]['description'],
      temp: data['main']['temp'],
      humidity: data['main']['humidity'],
      speed: data['wind']['speed'],
      country: data['sys']['country'],
      name: data['name'],
      pressure: data['main']['pressure'],
      temp_min: data['main']['temp_min'],
      temp_max: data['main']['temp_max'],
      feel_like: data['main']['feels_like'],
    );
  }
}
