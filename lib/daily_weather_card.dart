import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hava_durumu/constants.dart';

class DailyWeatherCard extends StatelessWidget {
  const DailyWeatherCard({
    Key? key,
    required this.icon,
    required this.temperature,
    required this.date,
  }) : super(key: key);

  final String icon;
  final double temperature;
  final String date;

  @override
  Widget build(BuildContext context) {


    //text olarak gelen verisini DateTime objesini parse
    final parsedTime = DateTime.parse(date);
    List<String> weekdays = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];


    return Card(
      color: Colors.transparent,
      child: SizedBox(
        height: 120,
        width: 100,
        child: Column(
          children: [
            Image.network('https://openweathermap.org/img/wn/$icon.png'),
            Text(
              '$temperature° C',

              /// temperature(sıcaklık) , sıcaklığı yukarıda 20º C diye tanımladık ama 'double' eklediğimiz için 20.0° C olarak yansıttık.
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            Text(weekdays[parsedTime.weekday -1]),
          ],
        ),
      ),
    );
  }
}
