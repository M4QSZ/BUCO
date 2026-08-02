import 'package:flutter/foundation.dart';
import 'dart:async';

class HomeProvider extends ChangeNotifier {
  // Categorías hardcoded extraídas de la UI
  final List<Map<String, String>> categories = [
    {'title': 'PASTAS', 'image': 'assets/media/pasta-pomodoro.png'},
    {'title': 'SUSHI', 'image': 'assets/media/sushi-california.png'},
    {'title': 'POSTRES', 'image': 'assets/media/cupcake.png'},
    {'title': 'PIZZAS', 'image': 'assets/media/dinamica-rebanada-pizza-pepperoni-salpicaduras-salsa.png'},
    {'title': 'BURGER', 'image': 'assets/media/hamburguesa.png'},
    {'title': 'ENSALADA', 'image': 'assets/media/ensalada.png'},
    {'title': 'CARNES', 'image': 'assets/media/carne-ribeye.png'},
    {'title': 'POLLO', 'image': 'assets/media/pollo-frito.png'},
    {'title': 'POKE', 'image': 'assets/media/poke-bowl.png'},
    {'title': 'CAFÉ', 'image': 'assets/media/cafe-frio.png'},
    {'title': 'ALITAS', 'image': 'assets/media/alitas-buffalo.png'},
    {'title': 'DONAS', 'image': 'assets/media/dona.png'},
  ];

  // Restaurantes hardcoded extraídos de la UI
  final List<Map<String, dynamic>> mostLovedRestaurants = [
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
    {
      'name': 'NAPOLI', 
      'type': 'Pizzas', 
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'LOS AÑOS LOCOS', 
      'type': 'Carnes', 
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
    },
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
    {
      'name': 'NAPOLI', 
      'type': 'Pizzas', 
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'LOS AÑOS LOCOS', 
      'type': 'Carnes', 
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
    },
  ];

  int _categoryPageIndex = 0;
  int get categoryPageIndex => _categoryPageIndex;

  void setCategoryPageIndex(int index) {
    _categoryPageIndex = index;
    notifyListeners();
  }
}
