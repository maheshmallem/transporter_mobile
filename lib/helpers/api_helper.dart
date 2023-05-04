import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transporter/helpers/models/location_model.dart';
import 'config.dart';
import 'models/places_responce.dart';

Future<List<LocationModel>> getLocationResults(String qr) {
  List<LocationModel> options = [];

  return http.get(
      Uri.parse(
          "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$qr&language=en&region=en&key=$map_key"),
      headers: {"token": map_key}).then((value) {
    print("RESPONCE :=> ${value.toString()}");
    var model = placesResponceFromJson(value.body);
    for (var element in model.results) {
      options.add(LocationModel(element.formattedAddress,
          element.geometry.location.lat, element.geometry.location.lng));
    }

    return options;
  });
}

Future<dynamic> otpLogin(String strMobile) async {
  return await http
      .get(Uri.parse(
          'https://2factor.in/API/V1/$two_factor_key/SMS/$strMobile/AUTOGEN/OTP1'))
      .then((response) {
    return json.decode(response.body);
  });
}

Future<dynamic> verifyOtp(String sessionId, String otp) async {
  String url =
      'https://2factor.in/API/V1/$two_factor_key/SMS/VERIFY/$sessionId/$otp';
  print("Session Verify ==> $url");
  return await http.get(Uri.parse(url)).then((response) {
    return json.decode(response.body);
  });
}
