import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/models/current_weather_model.dart';
import 'package:weatherly/network/weather_api_client.dart';

import 'weather_details_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CurrentWeatherModel? _currentWeather;
  int? _responseCode; // 200 or 404
  final _cityTextController = TextEditingController();
  final _countryTextController = TextEditingController();

  void getWeather(String city, String country) async {
    final weather = await OpenWeatherMapApiClient()
        .getCurrentWeather(city: city, countryCode: country);

    setState(() {
      _currentWeather = weather.currentWeather;
      _responseCode = weather.statusCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              buildMetaDetails(),
              Expanded(
                child: WeatherDetailsContainer(_currentWeather, _responseCode),
              ),
            ],
          ),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }

  Container buildMetaDetails() {
    // Shows location (with form) and date
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          buildLocationForm(),
          SizedBox(height: 10),
          buildLocationDetails(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Form buildLocationForm() {
    // Entries for city and country names
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(child: buildLocationField(_cityTextController, "City")),
            Container(width: 10),
            Expanded(
                child: buildLocationField(_countryTextController, "Country")),
            buildSearchButton()
          ],
        ),
      ),
    );
  }

  Widget buildLocationField(TextEditingController controller, String hint) {
    return buildRoundedContainer(
      TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container buildRoundedContainer(TextFormField textField) {
    // Container to wrap location textfields
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(50),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      child: textField,
    );
  }

  Material buildSearchButton() {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          if (_cityTextController.text.trim().isEmpty) {
            // if no city is typed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Enter a city name"),
              ),
            );
          } else {
            getWeather(_cityTextController.text, _countryTextController.text);
          }
        },
      ),
    );
  }

  Widget buildLocationDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        leading: Icon(
          Icons.location_pin,
          size: 50,
        ),
        title: buildCityName(),
        subtitle: buildCountryName(),
        horizontalTitleGap: 0,
        trailing: buildDate(),
      ),
    );
  }

  Text buildCityName() {
    if (_currentWeather != null) {
      return Text(
        "${_currentWeather?.city}",
        style: TextStyle(fontSize: 20),
      );
    }
    return Text(
      "--",
      style: TextStyle(fontSize: 20),
    );
  }

  Text buildCountryName() {
    if (_currentWeather != null) {
      return Text(
        "${_currentWeather?.country}",
        style: TextStyle(fontSize: 20),
      );
    }
    return Text(
      "--",
      style: TextStyle(fontSize: 20),
    );
  }

  Text buildDate() {
    final date = DateFormat.yMMMMEEEEd().format(DateTime.now());
    return Text(
      date.toString(),
      style: TextStyle(fontSize: 15),
    );
  }
}
