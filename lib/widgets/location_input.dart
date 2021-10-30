import 'package:flutter/material.dart';
import 'package:flutter_course_device_features_app/helpers/location_helper.dart';
import 'package:flutter_course_device_features_app/models/place.dart';
import 'package:flutter_course_device_features_app/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as gps;

class LocationInput extends StatefulWidget {
  final Function selectPlace;

  const LocationInput(this.selectPlace, {Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double latitude, double longitude) {
    print('${latitude} ${longitude}');
    final staticImagePreviewUrl = LocationHelper.generateLocationPreviewImage(latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = staticImagePreviewUrl;
    });
    widget.selectPlace(latitude, longitude);
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await gps.Location().getLocation();
      if (locData.latitude == null || locData.longitude == null) return;
      _showPreview(locData.latitude!, locData.longitude!);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng?>(
      MaterialPageRoute(
        // fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No Location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton.icon(
              onPressed: _getCurrentLocation, icon: Icon(Icons.location_on), label: Text('Current Location')),
          TextButton.icon(onPressed: _selectOnMap, icon: Icon(Icons.map), label: Text('Select on Map')),
        ]),
      ],
    );
  }
}
