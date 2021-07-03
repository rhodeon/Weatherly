class CurrentWeatherModel {
  late final String city; // city name
  late final String country; // country code
  late final WeatherState weatherState; // weather
  late final WeatherFactors weatherFactors; // main
  late final num windSpeed;
  late final num visibility;

  CurrentWeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    this.city = parsedJson["name"];
    this.country = parsedJson["sys"]["country"];
    this.weatherState = WeatherState.fromJson(parsedJson["weather"][0]);
    this.weatherFactors = WeatherFactors.fromJson(parsedJson["main"]);
    this.windSpeed = parsedJson["wind"]["speed"];
    this.visibility = parsedJson["visibility"];
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
  late final num temp;
  late final num pressure;
  late final num humidity;

  WeatherFactors.fromJson(Map<String, dynamic> parsedJson) {
    this.temp = parsedJson["temp"]!;
    this.pressure = parsedJson["pressure"]!;
    this.humidity = parsedJson["humidity"]!;
  }
}
