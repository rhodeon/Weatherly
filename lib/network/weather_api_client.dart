import 'dart:convert';
import 'package:http/http.dart';
import 'package:weatherly/models/current_weather_model.dart';

class OpenWeatherMapApiClient {
  final String baseUrl = "api.openweathermap.org";
  final String currentWeatherEndpoint = "data/2.5/weather/";
  final String apiKey = "011fcf65427e360e15f1a22132399386";

  Map<String, String> setQueryParameters(
    // Query parameters for current weather
    String city,
    String countryCode,
  ) =>
      {
        "q": "$city, $countryCode",
        "appid": "$apiKey",
        "units": "metric",
      };

  Future<WeatherResponse> getCurrentWeather({
    // Requests for the current weather
    required String city,
    required String countryCode,
  }) async {
    final response = await Client().get(
      Uri.https(
        baseUrl,
        currentWeatherEndpoint,
        setQueryParameters(city, countryCode),
      ),
    );

    final responseCode = response.statusCode;

    if (responseCode == 404) {
      // city not found
      return WeatherResponse.setErrorCode(responseCode);
    }

    return WeatherResponse(
      CurrentWeatherModel.fromJson(json.decode(response.body)),
      responseCode,
    );
  }
}

/// Contains current weather and response
/// status code for checking if an invalid
/// city is entered
class WeatherResponse {
  CurrentWeatherModel? currentWeather;
  int statusCode;

  WeatherResponse(this.currentWeather, this.statusCode);
  WeatherResponse.setErrorCode(this.statusCode); // city not found
}
