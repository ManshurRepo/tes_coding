// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cuaca_app/datasources/weather_datasources.dart';
import 'package:flutter_cuaca_app/presentations/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherDatasources('51616e7b61d0c1983fb4d671e316828c');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getConditionsWeather(String? mainCondition) {
    if (mainCondition == null) return 'assets/clear_sky.json';
    switch (mainCondition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'drizzle':
      case 'rain':
        return 'assets/rain.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/clear_sky.json';
      case 'clouds':
        return 'assets/clouds.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'dust':
      case 'sand':
        return 'assets/mist.json';
      default:
        return 'assets/clear_sky.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: const AlignmentDirectional(10, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-10, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_pin, size: 30),
                        const SizedBox(width: 5),
                        Text(
                          _weather?.locationName ?? "mengambil data",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Lottie.asset(getConditionsWeather(_weather?.mainWeather)),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather?.mainWeather ?? "",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.black,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Text(
                            '${_weather?.temperature.round()}°C',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
