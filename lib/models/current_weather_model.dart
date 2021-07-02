class CurrentWeatherModel {
  late final String city; // city name
  late final String country; // country code
  late final WeatherState weatherState; // weather
  late final WeatherFactors weatherFactors; // main

  CurrentWeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    this.city = parsedJson["name"];
    this.country = parsedJson["sys"]["country"];
    this.weatherState = WeatherState.fromJson(parsedJson["weather"][0]);
    this.weatherFactors = WeatherFactors.fromJson(parsedJson["main"]);
  }
}

class WeatherState {
  late final int id;
  late final String main;
  late final String description;
  late final String icon;

  WeatherState.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson["id"];
    this.main = parsedJson["main"];
    this.description = parsedJson["description"];
    this.icon = parsedJson["icon"];
  }
}

class WeatherFactors {
  late final double temp;
  late final int pressure;
  late final int humidity;

  WeatherFactors.fromJson(Map<String, dynamic> parsedJson) {
    this.temp = parsedJson["temp"]!;
    this.pressure = parsedJson["pressure"]!;
    this.humidity = parsedJson["humidity"]!;
  }
}
