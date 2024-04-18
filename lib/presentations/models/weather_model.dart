class Weather {
  final String mainWeather;
  final String locationName;
  final double temperature;
  Weather({
    required this.mainWeather,
    required this.locationName,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      mainWeather: json['weather'][0]['main'],
      locationName: json['name'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}
