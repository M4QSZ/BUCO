import 'package:latlong2/latlong.dart';

class StoreModel {
  final LatLng coordinates;
  final String title;
  final String address;
  final String phone;

  StoreModel({
    required this.coordinates,
    required this.title,
    required this.address,
    required this.phone,
  });
}
