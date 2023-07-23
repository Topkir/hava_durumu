import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hava_durumu/constants.dart';
import 'package:hava_durumu/daily_weather_card.dart';
import 'package:hava_durumu/search_page.dart';
import 'package:http/http.dart' as http;
import 'loading_widget.dart';

/// as http ile https isminde çağırıyoruz.

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = 'İstanbul';
  double? temperature;
  final String key = '37c3e3b5014d79d8206d116ccaef11b0';
  var locationData;
  String code = 'home';

  /// https://home.openweathermap.org/api_keys sitesindeki anahtarımızı buraya yazdık.
  Position? devicePosition;
  String? icon;

  List<String> icons = [];
  List<double> temperatures = [];
  List<String> dates = [];

  /// locationData değişkenini bir alttaki fonksiyondan çıkardık çünkü çıkarmasaydık
  /// location fonksiyonunu tek o getLocationData fonksiyonun içinde kullanabilirdik bu da bizim işimize yaramaz
  /// alt kısımda locationData fonksiyonun özelliklerini tanımladık ve artık her yerde getLocationData fonksiyonunu kullanabilecez.

  Future<void> getLocationDataFromAPI() async {
    locationData = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric'));
    final locationDataParsed = jsonDecode(locationData.body);

    setState(() {
      temperature = locationDataParsed['main']['temp'];
      location = locationDataParsed['name'];
      code = locationDataParsed['weather'].first['main'];
      //code = locationDataParsed['weather'][0]['main'];
      icon = locationDataParsed['weather'].first['icon'];

      List<String> icons = [
        '01d',
        '02d',
        '03d',
        '04d',
        '09d',
        '10d',
        '11d',
        '13d',
        '50d',
      ];
      List<double> temperatures = [
        20.0,
        20.0,
        20.0,
        20.0,
        20.0,
      ];
      List<String> dates = [
        'Pazartesi',
        'Salı',
        'Çarşamba',
        'Perşembe',
        'Cuma',
      ];
    });
  }

  Future<void> getLocationDataFromAPIByLatLon() async {
    if (devicePosition != null) {
      locationData = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${devicePosition!.latitude}&lon=${devicePosition!.longitude}&appid=$key&units=metric'));
      final locationDataParsed = jsonDecode(locationData.body);

      setState(() {
        temperature != locationDataParsed['main']['temp'];
        location = locationDataParsed['name'];
        code = locationDataParsed['weather'].first['main'];
        //code = locationDataParsed['weather'][0]['main'];
        icon = locationDataParsed['weather'].first['icon'];
      });
    }
  }

  Future<void> getDevicePosition() async {
    try {
      devicePosition = await _determinePosition();
      print(devicePosition);
    }

    // catch(error){
    //   print('Şu Hata Oluştu $error');
    // }

    finally {
      //her ne olursa olsun buradaki kod çalışsın.
    }
  }

  Future<void> getDailyForecastByLatLon() async {
    var forecastData = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${devicePosition!.latitude}&lon=${devicePosition!.longitude}&appid=$key&units=metric'));
    var forecastDataParse = jsonDecode(forecastData.body);

    temperatures.clear();
    icons.clear();
    dates.clear();

    setState(() {
      for (int i = 7; i < 40; i = i + 8) {
        temperatures.add(forecastDataParse['list'][i]['main']['temp']);
        icons.add(forecastDataParse['list'][i]['weather'][0]['icon']);
        dates.add(forecastDataParse['list'][i]['dt_txt']);
      }

      // temperatures.add(forecastDataParse['list'][15]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][23]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][31]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][39]['main']['temp']);
      //
      // icons.add(forecastDataParse['list'][7]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][15]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][23]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][31]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][39]['weather'][0]['icon']);
      //
      // dates.add(forecastDataParse['list'][7]['dt_txt']);
      // dates.add(forecastDataParse['list'][15]['dt_txt']);
      // dates.add(forecastDataParse['list'][23]['dt_txt']);
      // dates.add(forecastDataParse['list'][31]['dt_txt']);
      // dates.add(forecastDataParse['list'][39]['dt_txt']);
    });
  }

  Future<void> getDailyForecastByLocation() async {
    var forecastData = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$key&units=metric'));
    var forecastDataParse = jsonDecode(forecastData.body);

    temperatures.clear();
    icons.clear();
    dates.clear();

    setState(() {
      for (int i = 7; i < 40; i = i + 8) {
        temperatures.add(forecastDataParse['list'][i]['main']['temp']);
        icons.add(forecastDataParse['list'][i]['weather'][0]['icon']);
        dates.add(forecastDataParse['list'][i]['dt_txt']);
      }

      // temperatures.add(forecastDataParse['list'][7]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][15]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][23]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][31]['main']['temp']);
      // temperatures.add(forecastDataParse['list'][39]['main']['temp']);
      //
      // icons.add(forecastDataParse['list'][7]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][15]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][23]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][31]['weather'][0]['icon']);
      // icons.add(forecastDataParse['list'][39]['weather'][0]['icon']);
      //
      // dates.add(forecastDataParse['list'][7]['dt_txt']);
      // dates.add(forecastDataParse['list'][15]['dt_txt']);
      // dates.add(forecastDataParse['list'][23]['dt_txt']);
      // dates.add(forecastDataParse['list'][31]['dt_txt']);
      // dates.add(forecastDataParse['list'][39]['dt_txt']);
    });
  }

  void getInitialData() async {
    await getDevicePosition();
    await getLocationDataFromAPIByLatLon(); // Current weather Data
    await getDailyForecastByLatLon(); // Forecast for 5 days
  }

  @override
  void initState() {
    getInitialData();
    getLocationDataFromAPI();
    // getLocationDataFromAPI();
    super.initState();
  }

  Widget build(BuildContext context) {
    BoxDecoration containerDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/$code.jpg'), fit: BoxFit.cover

          /// fit: BoxFit.cover ---> telefonun eni ve boyuna göre ekranın tamamını kapatır.
          ),
    );
    return Container(
      decoration: containerDecoration,
      //eğer temperature == null ise, CirclularProgressIndicator göster, aksi halde veri gelince setState yap ve Scaffold u göster.
      child: (temperature == null ||
              devicePosition == null ||
              icons.isEmpty ||
              dates.isEmpty ||
              temperatures.isEmpty)
          ? const LoadingWidget()
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Image.network(
                            'https://openweathermap.org/img/wn/$icon@4x.png'),
                      ),
                      Text(
                        '$temperature° C',

                        /// temperature(sıcaklık) , sıcaklığı yukarıda 20º C diye tanımladık ama 'double' eklediğimiz için 20.0° C olarak yansıttık.
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          shadows: [kGolge],
                          // color : renk, blurRadius: bulanıklık,
                          // Offset:(sağ,aşağı) sağ a - verirsek sol olur / aşağı - verirsek yukarı olur
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        /// Ana Eksen Hizalaması
                        children: [
                          Text(
                            location,
                            style: const TextStyle(
                                fontSize: 30, shadows: [kGolge]),
                          ),
                          IconButton(
                              onPressed: () async {
                                final selectedCity = await Navigator.push(

                                    /// ekranın üstüne yapıştır.
                                    context,

                                    /// içerik
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchPage()));
                                location = selectedCity;
                                getLocationDataFromAPI();
                                getDailyForecastByLocation();
                              },
                              icon: const Icon(
                                Icons.search,
                                shadows: [kGolge],
                              )),

                          /// search ikonuna bastığımızda SearchPage sayfasınd yönlendirecek.
                        ],
                      ),
                      kHeight10,
                      buildWeatherCard(context),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildWeatherCard(BuildContext context) {
    List<DailyWeatherCard> cards = [];

    // [
    //   DailyWeatherCard(
    //       icon: icons[0],
    //       temperature: temperatures[0],
    //       date: dates[0]),
    //   DailyWeatherCard(
    //       icon: icons[1],
    //       temperature: temperatures[1],
    //       date: dates[1]),
    //   DailyWeatherCard(
    //       icon: icons[2],
    //       temperature: temperatures[2],
    //       date: dates[2]),
    //   DailyWeatherCard(
    //       icon: icons[3],
    //       temperature: temperatures[3],
    //       date: dates[3]),
    //   DailyWeatherCard(
    //       icon: icons[4],
    //       temperature: temperatures[4],
    //       date: dates[4]),
    // ];

    for (int i = 0; i < 5; i++) {
      cards.add(DailyWeatherCard(
          icon: icons[i], temperature: temperatures[i], date: dates[i]));
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cards,
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
