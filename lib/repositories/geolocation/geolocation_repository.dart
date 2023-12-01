import 'package:geolocator/geolocator.dart';
import 'package:turisteando_ando/repositories/geolocation/base_geolocation_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocationRepository extends BaseGeolocationRepository {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
      return getCurrentLocation();
    }
    else {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
  }
}