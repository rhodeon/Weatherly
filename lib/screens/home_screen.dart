import 'package:flutter/material.dart';
import 'package:weatherly/models/current_weather_model.dart';
import 'package:weatherly/network/weather_api_client.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  CurrentWeatherModel? _currentWeather;
  final _cityTextController = TextEditingController();
  final _countryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.blue),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    buildLocationForm(),
                    SizedBox(height: 10),
                    buildLocationDetails(),
                    buildIcon(),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              //
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLocationDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Icon(
            Icons.location_pin,
            size: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCityName(),
              buildCountryName(),
            ],
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTemperature(),
              buildDescription(),
            ],
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Text buildCityName() {
    if (_currentWeather != null) {
      return Text(
        "${_currentWeather?.city}",
        style: TextStyle(fontSize: 30),
      );
    }
    return Text(
      "--",
      style: TextStyle(fontSize: 30),
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

  Text buildTemperature() {
    if (_currentWeather != null) {
      return Text(
        "${_currentWeather?.weatherFactors.temp}°F",
        style: TextStyle(fontSize: 30),
      );
    }
    return Text(
      "--",
      style: TextStyle(fontSize: 30),
    );
  }

  Text buildDescription() {
    if (_currentWeather != null) {
      return Text(
        "${_currentWeather?.weatherState.description}",
        style: TextStyle(fontSize: 20),
      );
    }
    return Text(
      "--",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildIcon() {
    if (_currentWeather != null) {
      return Image.network(
          "https://openweathermap.org/img/w/${_currentWeather!.weatherState.icon}.png");
    }
    return Icon(Icons.cloud);
  }

  Form buildLocationForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(child: buildRoundedContainer(buildCityField())),
            Container(width: 10),
            Expanded(child: buildRoundedContainer(buildCountryField())),
            buildSearchButton()
          ],
        ),
      ),
    );
  }

  Container buildRoundedContainer(TextFormField textField) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(50),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      child: textField,
    );
  }

  TextFormField buildCityField() {
    return TextFormField(
      controller: _cityTextController,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "City",
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      validator: (input) {
        if (input == "") {
          return "Enter a city name";
        }
        return null;
      },
    );
  }

  TextFormField buildCountryField() {
    return TextFormField(
      controller: _countryTextController,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Country",
        border: InputBorder.none,
      ),
    );
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // print(_cityTextController.text);
            getWeather(_cityTextController.text, _countryTextController.text);
          }
        });
  }

  void getWeather(String city, String country) async {
    final weather = await OpenWeatherMapApiClient()
        .getCurrentWeather(city: city, countryCode: country);

    setState(() {
      _currentWeather = weather;
    });
  }

  Widget buildWeatherFactors() {
    return Column();
  }
}
