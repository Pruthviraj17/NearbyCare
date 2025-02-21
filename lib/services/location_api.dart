import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:nearby_hospitals/animations/show_snackbar.dart';
import 'package:nearby_hospitals/model/nearbyhospitals.dart';

class LocationApi {
  Future<List<double>?> getCurrentLocation({
    required BuildContext context,
  }) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAwesomeSnackBarAnimation(
          context: context,
          title: "Location Permission",
          message: "Location permission denied",
          contentType: ContentType.failure,
        );

        return null;
      }

      Position currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      return [currentPosition.latitude, currentPosition.longitude];
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      return [currentPosition.latitude, currentPosition.longitude];
    }
    if (permission == LocationPermission.deniedForever) {
      showAwesomeSnackBarAnimation(
        context: context,
        title: "Location Permission",
        message: "Turn on location permission to get nearby hospitals data",
        contentType: ContentType.failure,
      );

      return null;
    }
    return null;
  }

  Future<List<Nearbyhospitals>?> getNearbyhospitals({
    lat = 17.161446,
    lng = 74.385010,
  }) async {
    String api = dotenv.get("GOOGLE_API_KEY");
    var response = await http.get(
      Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=10000&type=hospital&keyword=hospital&name=hospital&key=$api",
      ),
      headers: {"Content-Type": "application/json"},
    );

    List<Nearbyhospitals> data = [];

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;

      for (var jsonData in results) {
        data.add(Nearbyhospitals.fromJson(jsonData));
      }
    } else {
      return null;
    }

    return data;
  }
}
