import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? mapController;
  LocationData? _currentLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final locationService = Location();
    try {
      _currentLocation = await locationService.getLocation();
      _addMarkerToMap(
          _currentLocation!.latitude!, _currentLocation!.longitude!);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Failed to fetch location: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _addMarkerToMap(double latitude, double longitude) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("picked_location"),
          position: LatLng(latitude, longitude),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Expanded(
            child: _currentLocation != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) => mapController = controller,
                    markers: _markers,
                    onTap: (LatLng location) {
                      _addMarkerToMap(location.latitude, location.longitude);
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_markers.isNotEmpty) {
                Navigator.of(context).pop(_markers.first.position);
              }
            },
            child: const Text('Select Location'),
          ),
        ],
      ),
    );
  }
}
