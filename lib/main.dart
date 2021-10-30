import 'package:flutter/material.dart';
import 'package:flutter_course_device_features_app/providers/great_places.dart';
import 'package:flutter_course_device_features_app/screens/add_place_screen.dart';
import 'package:flutter_course_device_features_app/screens/place_detail_screen.dart';
import 'package:flutter_course_device_features_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.amber,
              ),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
