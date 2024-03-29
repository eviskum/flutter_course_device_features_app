import 'dart:convert';

import 'package:flutter_course_device_features_app/helpers/keys_helper.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${GOOGLE_API_KEY}';
  }

  static Future<String> getPlaceAddress({required double latitude, required double longitude}) async {
    // final urlStr = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final Uri addressUri = Uri.https(
        'maps.googleapis.com', 'maps/api/geocode/json', {'latlng': '$latitude,$longitude', 'key': GOOGLE_API_KEY});
    final response = await http.get(addressUri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
