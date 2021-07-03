import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weatherly/models/current_weather_model.dart';

/// Widget which displays weather forecast details
class WeatherDetailsContainer extends StatelessWidget {
  final CurrentWeatherModel? _currentWeather;
  final int? _responseCode;

  WeatherDetailsContainer(this._currentWeather, this._responseCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildMoreDetails(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      alignment: Alignment.center,
    );
  }

  Column buildMoreDetails() {
    if (_currentWeather != null) {
      return buildWeatherFactors();
    }
    return buildNoLocationDisplay();
  }

  Column buildNoLocationDisplay() {
    // Message shown when no valid location has been entered
    String errorMessage = "Enter a location";
    if (_responseCode == 404) {
      errorMessage = "City not found";
    }
    return Column(
      children: [
        Icon(
          Icons.location_off,
          size: 40,
        ),
        Text(
          errorMessage,
          style: TextStyle(fontSize: 20),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Column buildWeatherFactors() {
    // Shows temperature, pressure
    // humidity, wind speed and visibility
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildWeatherIcon(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTemperature(),
                  buildDescription(),
                ],
              ),
            ],
          ),
        ),
        //
        ListTile(
          leading: FaIcon(FontAwesomeIcons.gasPump),
          title: Text("Pressure"),
          trailing: Text("${_currentWeather?.weatherFactors.pressure} hPa"),
        ),
        //
        buildHorizontalDivider(),
        //
        ListTile(
          leading: FaIcon(FontAwesomeIcons.water),
          title: Text("Humidity"),
          trailing: Text("${_currentWeather?.weatherFactors.humidity} %"),
        ),
        //
        buildHorizontalDivider(),
        //
        ListTile(
          leading: FaIcon(FontAwesomeIcons.wind),
          title: Text("Wind Speed"),
          trailing: Text("${_currentWeather?.windSpeed} m/s"),
        ),
        //
        buildHorizontalDivider(),
        //
        ListTile(
          leading: FaIcon(FontAwesomeIcons.lowVision),
          title: Text("Visibility"),
          trailing: Text("${_currentWeather?.visibility} m"),
        ),
      ],
    );
  }

  Text buildTemperature() {
    return Text(
      "${_currentWeather!.weatherFactors.temp}°F",
      style: TextStyle(fontSize: 30),
    );
  }

  Text buildDescription() {
    return Text(
      "${_currentWeather?.weatherState.description}",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildWeatherIcon() {
    final String iconBaseUrl = "https://openweathermap.org/img/w/";
    final String iconExtension = ".png";
    return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image:
            "$iconBaseUrl${_currentWeather!.weatherState.icon}$iconExtension");
  }

  Container buildHorizontalDivider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 20,
        color: Colors.black,
      ),
    );
  }
}
