import 'package:climate_app/weather_class.dart';
import 'package:climate_app/weather_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClimateScreen extends StatefulWidget {
  const ClimateScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClimateScreenState();
  }
}

class ClimateScreenState extends State<ClimateScreen> {
  WeatherModel weatherData = WeatherModel();

  TextEditingController cityTextController = TextEditingController();

  String city = "Mumbai";
  String weathertype = '';
  String temperature = "", cityname = "", windspeed = "";

  final Map<String, String> weatherImage = {
    'Clouds': 'assets/clouds.png',
    'Rain': 'assets/rain.png',
    'Snow': 'assets/snow.png',
    'Sunny': 'assets/sun.png',
    'Haze': 'assets/haze.png',
    'Windy': 'assets/windy.png',
  };

  Future<void> readdata() async {
    var provider = Provider.of<WeatherClass>(context, listen: false);
    await provider.getWeatherData(city);
    setState(() {
      weatherData = provider.data;
      weathertype = weatherData.weather![0].main.toString();
      var temp = weatherData.main!.temp! - 273.15;
      temperature = temp.toString();
      cityname = weatherData.name.toString();
      windspeed = weatherData.wind!.speed.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    readdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                    ),
                    child: TextField(
                      controller: cityTextController,
                      cursorColor: Colors.white24,
                      style: const TextStyle(color: Colors.white60),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white60),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.white60),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          city = value;
                          readdata();
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white10,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        city = cityTextController.text.toString();
                        readdata();
                      });
                    },
                    icon: const Icon(Icons.check, color: Colors.white60),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                weatherImage.containsKey(weathertype)
                    ? weatherImage[weathertype]!
                    : 'assets/demo.png',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "City Name : " +
                        cityname +
                        "\n" +
                        "Weather : " +
                        weathertype +
                        "\n" +
                        "Temperature : " +
                        temperature + " C"
                        "\n" +
                        "Wind Speed : " +
                        windspeed +
                        "\n",
                    style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.normal)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
