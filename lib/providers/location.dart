import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart'as loc;
import 'package:vendor_pannel/providers/selectionmodal.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart'as http;
final locationProvider = StateNotifierProvider<LocationNotifier, loc.LocationData?>((ref) => LocationNotifier());
final mapControllerProvider = Provider<MapController>((ref) => MapController());

class LocationNotifier extends StateNotifier<loc.LocationData?> {
  LocationNotifier() : super(null);
  loc.Location _location = loc.Location();

  Future<void> getLocation(TextEditingController controller,WidgetRef ref) async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) return;
    }

    loc.LocationData currentLocation = await _location.getLocation();
    state = currentLocation;
    // ref.read(selectionModelProvider.notifier).updateLocation( "Lat: ${currentLocation.latitude}, Long: ${currentLocation.longitude}");
ref.read(mapControllerProvider).move(LatLng(currentLocation.latitude!, currentLocation.longitude!), 15.0);
 String apiUrl = 'https://nominatim.openstreetmap.org/reverse?format=json&lat=${currentLocation.latitude}&lon=${currentLocation.longitude}';
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String address = data['display_name'];
      print("Address: $address");

      // Update the location with the reverse geocoded address
      ref.read(selectionModelProvider.notifier).updateLocation(address);
    } else {
      print("Failed to fetch address: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching address: $e");
  }
  }
}
