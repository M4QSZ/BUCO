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
      'name': 'ATHENS PIZZA', 
      'type': 'Pizzas', 
      'rating': 4.6,
      'imageUrl': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'name': 'NACION SUSHI', 
      'type': 'Sushi', 
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400',
    },
    {
      'name': 'LA CASA REDONDA', 
      'type': 'Comida Criolla', 
      'rating': 4.3,
      'imageUrl': 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400',
    },
    {
      'name': 'BURGER KING', 
      'type': 'Hamburguesas', 
      'rating': 4.2,
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'name': 'MCDONALD\'S', 
      'type': 'Hamburguesas', 
      'rating': 4.1,
      'imageUrl': 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400',
    },
    {
      'name': 'SAKURA', 
      'type': 'Japonesa', 
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=400',
    },
    {
      'name': 'TGI FRIDAYS', 
      'type': 'Americana', 
      'rating': 4.4,
      'imageUrl': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=400',
    },
    {
      'name': 'POLLO TROPICAL', 
      'type': 'Pollo', 
      'rating': 4.5,
      'imageUrl': 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400',
    },
    {
      'name': 'DOMINO\'S PIZZA', 
      'type': 'Pizzas', 
      'rating': 4.0,
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400',
    },
    {
      'name': 'KFC', 
      'type': 'Pollo', 
      'rating': 4.2,
      'imageUrl': 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=400',
    },
    {
      'name': 'AURELIO\'S', 
      'type': 'Desayunos', 
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1533089859715-ce1bb2717a6a?w=400',
    },
    {
      'name': 'TACO BELL', 
      'type': 'Mexicana', 
      'rating': 4.1,
      'imageUrl': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=400',
    },
  ];

  int _categoryPageIndex = 0;
  int get categoryPageIndex => _categoryPageIndex;

  void setCategoryPageIndex(int index) {
    _categoryPageIndex = index;
    notifyListeners();
  }
}
