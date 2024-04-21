import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:vendor_pannel/providers/selectionmodal.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, LocationData?>((ref) => LocationNotifier());

class LocationNotifier extends StateNotifier<LocationData?> {
  LocationNotifier() : super(null);
  Location _location = Location();

  Future<void> getLocation(TextEditingController controller,WidgetRef ref) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    LocationData currentLocation = await _location.getLocation();
    state = currentLocation;
    ref.read(selectionModelProvider.notifier).updateLocation( "Lat: ${currentLocation.latitude}, Long: ${currentLocation.longitude}");
  }
}
