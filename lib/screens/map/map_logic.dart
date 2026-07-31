import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'delivery_model.dart';

class DeliveryMapController extends ChangeNotifier {
  late StoreModel storeData;
  
  // Punto ficticio para el local en Panamá
  final LatLng _storeLocation = const LatLng(8.9824, -79.5209); // Multiplaza area

  DeliveryMapController() {
    _initData();
  }

  void _initData() {
    storeData = StoreModel(
      coordinates: _storeLocation,
      title: 'Hamburguesería BUCO',
      address: 'Multiplaza, Av. Balboa, Planta Baja',
      phone: '+50760000000', // Ejemplo de número de WhatsApp
    );
  }
}
