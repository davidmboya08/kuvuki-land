import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:GoogleMap(
        mapType: MapType.terrain,

        onMapCreated: (GoogleMapController controller){
        }, initialCameraPosition: _kGooglePlex,
      ),
    );
  }
}
