import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_course_device_features_app/helpers/db_helper.dart';
import 'package:flutter_course_device_features_app/helpers/location_helper.dart';
import 'package:flutter_course_device_features_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String title, File image, Location location) async {
    final locationAddress =
        await LocationHelper.getPlaceAddress(latitude: location.latitude, longitude: location.longitude);
    final updatedLocation =
        Location(latitude: location.latitude, longitude: location.longitude, address: locationAddress);
    final newPlace = Place(id: DateTime.now().toString(), title: title, image: image, location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'loc_address': newPlace.location!.address ?? ''
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: Location(latitude: e['loc_lat'], longitude: e['loc_lng'], address: e['loc_address'])))
        .toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((e) => e.id == id);
  }
}
