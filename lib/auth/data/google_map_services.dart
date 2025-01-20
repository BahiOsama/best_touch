import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_project/auth/domain/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:second_project/auth/domain/models/place_details_model/place_details_model.dart';

class GoogleMapsPlacesServices {
  final String baseurl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyCCMQe7Jeb5Uf5Z0pmceRReHWl9-Op0j58';
  Future<List<PlaceAutoCompleteModel>> getPredictions(
      {required String input, required String sessionToken}) async {
    var response = await http
        .get(Uri.parse('$baseurl/autocomplete/json?input=$input&key=$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['predictions'];
      print(data);
      List<PlaceAutoCompleteModel> places = [];
      for (var item in data) {
        places.add(PlaceAutoCompleteModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
    var response = await http.get(Uri.parse(
        '$baseurl/details/json?place_id=$placeId&key=$apiKey&sesstionToken'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];

      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<String> getPlaceDetailsFromLatLng({
    required double? lat,
    required double? lng,
  }) async {
    if (lat == null || lng == null) {
      throw Exception('Latitude and longitude must not be null');
    }

    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        } else {
          throw Exception('No results found for the given coordinates.');
        }
      } else {
        throw Exception('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching place details: $e');
    }
  }
}
