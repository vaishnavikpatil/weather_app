import 'dart:developer';

import 'package:http/http.dart' as http;

Future<http.Response?> weatherData(String city) async {
  http.Response? response;
  var queryParameter = {'q': city, 'appid': '48f01af1f34231636a3671258da84f36'};
  try {
    response = await http.get(Uri.https(
        'api.openweathermap.org', 'data/2.5/weather', queryParameter));
  }
  //FOR  EXCEPTIONS
  on Error catch (e) {
    log(e.toString());
  }
  return response;
}
