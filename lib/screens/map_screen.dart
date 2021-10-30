import 'package:flutter/material.dart';
import 'package:flutter_course_device_features_app/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;

  const MapScreen(
      {this.initialLocation = const Location(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false,
      Key? key})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: Icon(Icons.check)),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude), zoom: 16),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null && widget.isSelecting
            ? {}
            : {
                Marker(
                    markerId: MarkerId('m1'),
                    position:
                        _pickedLocation ?? LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude))
              },
      ),
    );
  }
}
