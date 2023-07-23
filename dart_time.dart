
main() {

  List<String> weekdays = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];


  DateTime simdi = DateTime.now();
  print(simdi); //şuanki tarih-saat

  DateTime cumhuriyet = DateTime.utc(1923, 10, 29, 9, 30);
  print('cumhuriyet: $cumhuriyet'); //Verdiğimiz tarih



  DateTime localTime = DateTime.now();
  print('localTime : $localTime'); //Verdiğimiz tarih
  print(localTime.weekday);
  print(weekdays[localTime.weekday -1]);



  DateTime simdiArtiDoksan = simdi.add(Duration(days:90)); //şuan a 90 gün ekleriz

  DateTime simdiEksiDoksan = simdi.subtract(Duration(days:111)); //şuandan 90 çıkarırız

  print(simdiArtiDoksan);
  print(simdiEksiDoksan);

  print(simdi.difference(cumhuriyet));

  // şimdi - cumhuriyet (saat - dakika - saniye olarak yazar)

}


