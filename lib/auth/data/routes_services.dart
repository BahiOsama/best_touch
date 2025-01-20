import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_project/auth/domain/models/routes_model/routes_model.dart';

class RoutesServices {
  final String baseUrl =
      'https://routes.googleapis.com/directions/v2:computeRoutes';
  final String apiKey = 'AIzaSyCCMQe7Jeb5Uf5Z0pmceRReHWl9-Op0j58';
  Future<RoutesModel> fetchRoutes() async {
    Uri url = Uri.parse(baseUrl);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
    };
    Map<String, dynamic> body = {
      "origin": {
        "location": {
          "latLng": {"latitude": 37.419734, "longitude": -122.0827784}
        }
      },
      "destination": {
        "location": {
          "latLng": {"latitude": 37.417670, "longitude": -122.079595}
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return RoutesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }
}
