import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/location_permission_status.dart';

class LocationPermissionNotifier extends Notifier<LocationPermissionStatus> {
  @override
  LocationPermissionStatus build() {
    return LocationPermissionStatus.unknown;
  }

  Future<void> checkPermission() async {
    final status = await Permission.location.status;
    state = _mapStatus(status);
  }

  Future<void> requestPermission() async {
    final status = await Permission.location.request();
    state = _mapStatus(status);
  }

  LocationPermissionStatus _mapStatus(PermissionStatus status) {
    if (status.isGranted) {
      return LocationPermissionStatus.granted;
    }
    if (status.isDenied) {
      return LocationPermissionStatus.denied;
    }
    if (status.isPermanentlyDenied) {
      return LocationPermissionStatus.permanentlyDenied;
    }
    if (status.isRestricted) {
      return LocationPermissionStatus.restricted;
    }
    if (status.isLimited) {
      return LocationPermissionStatus.limited;
    }

    return LocationPermissionStatus.unknown;
  }
}

final locationPermissionProvider =
    NotifierProvider<LocationPermissionNotifier, LocationPermissionStatus>(
      LocationPermissionNotifier.new,
    );
