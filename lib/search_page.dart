import 'package:flutter/material.dart';
import 'package:hava_durumu/constants.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);



  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCity = '';


  // void birFonksiyon() {
  //   print('birFonksiyon calisti');
  // }
  //
  //
  // @override
  // void initState() {
  //   //gps verisi çekme, authentication, request istek...
  //   print('initState metodu çalıştı ve gps verisi isteniyor');
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   // sayfa kaldırılırken run edilecek metotlar
  //   print('dispoese metodu çalıltı ve logout istendi.');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/search.jpg'), fit: BoxFit.cover

          /// en ya da boy olarak ekranın tamamını kapatır.
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  onChanged: (value) {
                    selectedCity = value;
                    print('Text fieldeki değer: $value');
                  },
                  decoration: InputDecoration(
                      hintText: 'Şehir Seçiniz',
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  style: TextStyle(fontSize: 30),
                  textAlign: kOrtala,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    ///Bu şehir için API yanit veiyor mu?
                    var response = await http.get(Uri.parse(
                        'https://api.openweathermap.org/data/2.5/weather?q=$selectedCity&appid=0d6e98a8c7c320f72baef522f3c31a1b'));

                    if (response.statusCode == 200) {
                      Navigator.pop(context, selectedCity);

                      /// Sayfayı kaldır ve aynı zamanda bu sayfayı çağıran/açan yere komuta/satıra bir ver dön.
                    } else {
                      /// Kullanıcıya uyarı ver  ve sayfada kal
                      /// Alert Dialog göster


                      _showMyDialog();
                    }
                  },
                  style: kElevatedButtonBackground,
                  child: const Text('Select City'))
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kArkaPlanBeyaz,
          title: const Text('Location Not Found',
              textAlign: kOrtala,
              style: TextStyle(color: kBlack)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Text('Please select a valid location',
                    textAlign: kOrtala,
                    style: TextStyle(color: kBlack)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(
                  color: kBlack,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


