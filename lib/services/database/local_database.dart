import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Importaremos los modelos aquí una vez los creemos
import '../../models/restaurant_model.dart';

class LocalDatabase {
  late final Isar isar;

  /// Inicializa la base de datos local y la abre.
  /// Debe llamarse antes de que la aplicación empiece a usar Isar.
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [RestaurantModelSchema], // Aquí se registran todos los esquemas (modelos)
      directory: dir.path,
    );
  }
}
