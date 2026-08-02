import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  // Mock data for restaurant reviews (Restaurant Detail Screen)
  final List<Map<String, String>> _restaurantReviews = [
    {'name': 'Andrés Velasco', 'text': '"Muy buena comida !!"', 'rating': '4.5'},
    {'name': 'María López', 'text': '"Excelente servicio y rapidez"', 'rating': '5.0'},
    {'name': 'Carlos Díaz', 'text': '"Recomendado al 100%"', 'rating': '4.8'},
    {'name': 'Ana Silva', 'text': '"El mejor lugar de la ciudad"', 'rating': '5.0'},
    {'name': 'Luis Gómez', 'text': '"Sabor increíble"', 'rating': '4.7'},
    {'name': 'Sofía Ortiz', 'text': '"Volveré pronto"', 'rating': '4.9'},
    {'name': 'Diego Cruz', 'text': '"Buena atención"', 'rating': '4.2'},
    {'name': 'Elena Paz', 'text': '"Me encantó el ambiente"', 'rating': '4.6'},
  ];

  // Mock data for favorite restaurants (Account, Favorites, Search Screen)
  final List<Map<String, dynamic>> _favoriteRestaurants = [
    {
      'name': 'BURGER KING',
      'rating': 4.5,
      'imageUrl': 'assets/media/f1a2d7_burger_kin.svg',
      'cardColor': Colors.white,
    },
    {
      'name': "McDonald's",
      'rating': 4.0,
      'imageUrl': 'assets/media/c75819_mcdonalds.svg',
      'cardColor': const Color(0xFFDA291C),
    },
    {
      'name': "Carl's Jr",
      'rating': 4.3,
      'imageUrl': 'assets/media/logo_carlsjr.png',
      'cardColor': const Color(0xFFE21A22),
    },
    {
      'name': "Little Caesars",
      'rating': 3.9,
      'imageUrl': 'assets/media/logo_littlecaesars.png',
      'cardColor': const Color(0xFFFF6600),
    },
    {
      'name': "Domino's Pizza",
      'rating': 4.2,
      'imageUrl': 'assets/media/logo_dominos.png',
      'cardColor': const Color(0xFF0055A5),
    },
    {
      'name': "KFC",
      'rating': 4.1,
      'imageUrl': 'assets/media/logo_kfc.svg',
      'cardColor': const Color(0xFFE4002B),
    },
    {
      'name': "Subway",
      'rating': 4.0,
      'imageUrl': 'assets/media/logo_subway.png',
      'cardColor': const Color(0xFF008938),
    },
    {
      'name': "Pío Pío",
      'rating': 4.6,
      'imageUrl': 'assets/media/logo_piopio.png',
      'cardColor': const Color(0xFFF0531C),
    },
    {
      'name': "Don Lee",
      'rating': 4.4,
      'imageUrl': 'assets/media/logo_donlee.png',
      'cardColor': const Color(0xFFC00A27),
    },
  ];

  // Mock data for discover restaurants (Search Screen)
  final List<Map<String, dynamic>> _discoverRestaurants = [
    {
      'name': 'LUCCA', 
      'type': 'Italiana', 
      'rating': 4.5,
      'imageUrl': 'assets/media/27281c_asset_35.png',
    },
    {
      'name': 'GIORGIO\'S', 
      'type': 'Italiana', 
      'rating': 4.0,
      'imageUrl': 'assets/media/39d88b_asset_34.png',
    },
  ];

  List<Map<String, String>> get restaurantReviews => _restaurantReviews;
  List<Map<String, dynamic>> get favoriteRestaurants => _favoriteRestaurants;
  List<Map<String, dynamic>> get discoverRestaurants => _discoverRestaurants;

  void addReview(String name, String text, double rating) {
    _restaurantReviews.insert(0, {
      'name': name,
      'text': '"$text"',
      'rating': rating.toStringAsFixed(1),
    });
    notifyListeners();
  }
}
