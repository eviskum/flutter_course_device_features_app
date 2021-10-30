import 'package:flutter/material.dart';
import 'package:flutter_course_device_features_app/providers/great_places.dart';
import 'package:flutter_course_device_features_app/screens/add_place_screen.dart';
import 'package:flutter_course_device_features_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      // body: Center(child: CircularProgressIndicator()),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    builder: (context, greatPlaces, child) => greatPlaces.items.isEmpty
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (_, idx) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(greatPlaces.items[idx].image),
                              ),
                              title: Text(greatPlaces.items[idx].title),
                              subtitle: Text(greatPlaces.items[idx].location.address ?? ''),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[idx].id);
                              },
                            ),
                          ),
                    child: Center(child: Text('Got no places yet, start added some!')),
                  ),
      ),
    );
  }
}
