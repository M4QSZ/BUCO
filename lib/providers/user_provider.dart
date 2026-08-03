import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'Andrés Velasco';
  String _userDesc = '';
  
  // Dummy stats
  int _reviewsCount = 0;
  int _restaurantsCount = 0;
  
  // Dummy reviews left by user
  final List<Map<String, String>> _userReviews = [
    {'text': '“Muy buena comida!!”', 'icon': 'assets/media/c75819_mcdonalds.svg'},
    {'text': '“Excelente servicio!!”', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
    {'text': '“Llegó súper rápido!”', 'icon': 'assets/media/c75819_mcdonalds.svg'},
    {'text': '“La mejor hamburguesa”', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
    {'text': '“Siempre calientito”', 'icon': 'assets/media/c75819_mcdonalds.svg'},
    {'text': '“Muy amables al entregar”', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
    {'text': '“Todo perfecto, gracias”', 'icon': 'assets/media/c75819_mcdonalds.svg'},
    {'text': '“Súper recomendado”', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
    {'text': '“Buenísimo el sabor”', 'icon': 'assets/media/c75819_mcdonalds.svg'},
  ];

  String get userName => _userName;
  String get userDesc => _userDesc;
  
  String get email => AuthService().getCurrentUser()?['email'] ?? '¡¡hola!!';
  
  int get reviewsCount => _reviewsCount;
  int get restaurantsCount => _restaurantsCount;
  
  List<Map<String, String>> get userReviews => _userReviews;

  void updateProfile(String name, String desc) {
    _userName = name;
    _userDesc = desc;
    notifyListeners();
  }
}
