// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  final LatLng _initialPosition =
      LatLng(25.397656, 68.3616974); // San Francisco

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setResturant();
  }

  setResturant() {
    _handleMapTap(LatLng(25.397656, 68.3616974), "Smit Hyderabad");
    _handleMapTap(LatLng(25.3840949, 68.2675801), "Restarant 1 ");
    _handleMapTap(LatLng(25.3669986, 68.2726173), "Restarant 2 ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Tap-to-Add Marker'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 16,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        // onTap: _handleMapTap,
      ),
    );
  }

  void _handleMapTap(LatLng position, name) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(DateTime.now().toString()), // Unique ID
          position: position,
          infoWindow: InfoWindow(
            title: 'New Marker',
            snippet: name,
          ),
          onTap: () {
            // _onMarkerTapped(position);
          },
        ),
      );
    });
  }

  void _onMarkerTapped(LatLng position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Marker Tapped'),
          content: Text(
              'Marker at ${position.latitude}, ${position.longitude} was tapped.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
