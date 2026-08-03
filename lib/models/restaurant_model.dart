import 'package:isar/isar.dart';

part 'restaurant_model.g.dart'; // Requerido por Isar para generar el código

@collection
class RestaurantModel {
  Id id = Isar.autoIncrement; // ID local en la base de datos (entero)

  @Index(unique: true, replace: true)
  String? remoteId; // ID en el backend remoto (por si acaso usamos UUIDs luego)

  String name;
  String description;
  String imageUrl;
  double rating;
  bool isFavorite;
  
  // Para llevar control del modo offline-first (opcional pero muy útil)
  bool isSynced; 

  RestaurantModel({
    this.remoteId,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.rating = 0.0,
    this.isFavorite = false,
    this.isSynced = false,
  });
}
