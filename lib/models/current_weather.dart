class CurrentWeatherModel {
  final String name; // city name
  final String country; // country code
  final WeatherState weather;
  final WeatherFactors main;

  CurrentWeatherModel({
    required this.name,
    required this.country,
    required this.weather,
    required this.main,
  });
}

class WeatherState {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherState({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
}

class WeatherFactors {
  final double temp;
  final double pressure;
  final double humidity;

  WeatherFactors({
    required this.temp,
    required this.pressure,
    required this.humidity,
  });
}
