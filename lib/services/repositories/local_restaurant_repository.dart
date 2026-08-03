import 'package:isar/isar.dart';
import '../../models/restaurant_model.dart';
import '../database/local_database.dart';

class LocalRestaurantRepository {
  final LocalDatabase _localDb;

  LocalRestaurantRepository(this._localDb);

  /// Obtener todos los restaurantes
  Future<List<RestaurantModel>> getRestaurants() async {
    return await _localDb.isar.restaurantModels.where().findAll();
  }

  /// Obtener restaurantes favoritos
  Future<List<RestaurantModel>> getFavorites() async {
    return await _localDb.isar.restaurantModels
        .filter()
        .isFavoriteEqualTo(true)
        .findAll();
  }

  /// Guardar un nuevo restaurante (o actualizar si ya existe con el mismo remoteId/id)
  Future<void> saveRestaurant(RestaurantModel restaurant) async {
    await _localDb.isar.writeTxn(() async {
      await _localDb.isar.restaurantModels.put(restaurant);
    });
  }

  /// Eliminar restaurante
  Future<bool> deleteRestaurant(int id) async {
    return await _localDb.isar.writeTxn(() async {
      return await _localDb.isar.restaurantModels.delete(id);
    });
  }
}
