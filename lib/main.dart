import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_vac/services/location_service.dart';
import 'package:provider/provider.dart';
import 'data_models/user_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      // ignore: deprecated_member_use
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: HomeView(),
          )),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('E-Vac')
      ),
      body: Center(
          child: Container(
              height: 400.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(14.5764,121.0851),
                    zoom: 12.0
                ),
              )
          )
      ),
    );
  }
}