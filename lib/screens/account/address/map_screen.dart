import 'package:app/models/percation.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? selectedLocation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request to enable location services
      await Geolocator.openLocationSettings();
      return;
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permissions are denied, exit the function
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        timeLimit: const Duration(seconds: 30),
      ),
    );

    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
      isLoading = false;
    });

    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(selectedLocation!, 15),
    );
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      selectedLocation = latLng;
    });
  }

  void _submitLocation() async {
    if (selectedLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedLocation!.latitude,
        selectedLocation!.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        Percation selectedPercation = Percation(
          latitude: selectedLocation!.latitude,
          longitude: selectedLocation!.longitude,
          address: place.street ?? '',
          city: place.locality ?? '',
          street: place.thoroughfare ?? '',
        );

        if (mounted) {
          Navigator.pop(context, selectedPercation);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("الرجاء اختيار موقع")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: Text('حدد الموقع'),
        centerTitle: true,
        closable: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.81,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: selectedLocation ?? LatLng(32.0, 13.0),
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    onTap: _onMapTapped,
                    markers: {
                      if (selectedLocation != null)
                        Marker(
                          markerId: MarkerId("selected-location"),
                          position: selectedLocation!,
                        ),
                    },
                  ),
                ),
                Button(
                  text: 'حفظ الموقع',
                  onClick: _submitLocation,
                  borderRadius: 10,
                  height: 40,
                  color: Colors.blueAccent.shade700,
                ),
              ],
            ),
    );
  }
}
