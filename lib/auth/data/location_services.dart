import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> cheechAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceExption();
      }
    }
  }

  Future<void> cheechAndRequestLocationPermittions() async {
    var permittionStatus = await location.hasPermission();
    if (permittionStatus == PermissionStatus.deniedForever) {
      throw LocationPermitionExption();
    }
    if (permittionStatus == PermissionStatus.denied) {
      permittionStatus = await location.requestPermission();
      if (permittionStatus != PermissionStatus.granted) {
        throw LocationPermitionExption();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await cheechAndRequestLocationService();
    await cheechAndRequestLocationPermittions();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await cheechAndRequestLocationService();
    await cheechAndRequestLocationPermittions();
    return await location.getLocation();
  }
}

class LocationServiceExption implements Exception {
  @override
  String toString() {
    return 'Location services are disabled. Please enable location services to proceed.';
  }
}

class LocationPermitionExption implements Exception {
  @override
  String toString() {
    return 'Location permission is not granted. Please allow location access to use this feature.';
  }
}
