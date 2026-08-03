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
      'imageUrl': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
    },
    {
      'name': 'GIORGIO\'S', 
      'type': 'Italiana', 
      'rating': 4.0,
      'imageUrl': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
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
      'name': 'LA BRASERIA', 
      'type': 'Carnes', 
      'rating': 4.6,
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-811114215b81?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'SUSHITA', 
      'type': 'Japonesa', 
      'rating': 4.3,
      'imageUrl': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'EL TRAPICHE', 
      'type': 'Criolla', 
      'rating': 4.9,
      'imageUrl': 'assets/media/trapiche/TRAPICHE.jpg',
    },
    {
      'name': 'CASA BLANCA', 
      'type': 'Internacional', 
      'rating': 4.4,
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'NACION SUSHI', 
      'type': 'Asiática', 
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1553621042-f6e147245754?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'ATHEN\'S', 
      'type': 'Griega', 
      'rating': 4.5,
      'imageUrl': 'https://images.unsplash.com/photo-1532598375624-9b2f6efba983?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'PAUL', 
      'type': 'Francesa', 
      'rating': 4.6,
      'imageUrl': 'https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'CREPES & WAFFLES', 
      'type': 'Postres', 
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1562376552-0d160a2f9fa4?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'BURGER KING',
      'type': 'Rápida',
      'rating': 4.6,
      'imageUrl': 'assets/media/f1a2d7_burger_kin.svg',
    },
    {
      'name': 'MCDONALD\'S',
      'type': 'Rápida',
      'rating': 4.4,
      'imageUrl': 'assets/media/c75819_mcdonalds.svg',
    },
    {
      'name': 'SOBAN KOREAN GOURMET',
      'type': 'Coreana',
      'rating': 4.8,
      'imageUrl': 'assets/media/soban/SOBAN.jpg',
    },
    {
      'name': 'AYA LA VIDA',
      'type': 'Panameña',
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
    },
    {
      'name': 'MAITO',
      'type': 'Contemporánea',
      'rating': 5.0,
      'imageUrl': 'assets/media/maito/MAITO.jpg',
    },
    {
      'name': 'PARRILLADA JIMMY',
      'type': 'Parrilladas',
      'rating': 4.8,
      'imageUrl': 'assets/media/jimmy/PARRILLADA_JIMMY.jpg',
    },
    {
      'name': 'CARL\'S JR',
      'type': 'Rápida',
      'rating': 4.7,
      'imageUrl': 'assets/media/logo_carlsjr.png',
    },
    {
      'name': 'LITTLE CAESARS',
      'type': 'Rápida',
      'rating': 4.3,
      'imageUrl': 'assets/media/logo_littlecaesars.png',
    },
    {
      'name': 'DOMINO\'S PIZZA',
      'type': 'Rápida',
      'rating': 4.6,
      'imageUrl': 'assets/media/logo_dominos.png',
    },
    {
      'name': 'KFC',
      'type': 'Rápida',
      'rating': 4.6,
      'imageUrl': 'assets/media/logo_kfc.svg',
    },
    {
      'name': 'SUBWAY',
      'type': 'Rápida',
      'rating': 4.6,
      'imageUrl': 'assets/media/logo_subway.png',
    },
    {
      'name': 'PÍO PÍO',
      'type': 'Rápida',
      'rating': 4.7,
      'imageUrl': 'assets/media/logo_piopio.png',
    },
    {
      'name': 'DON LEE',
      'type': 'Rápida',
      'rating': 4.7,
      'imageUrl': 'assets/media/logo_donlee.png',
    },
  ];

  int _categoryPageIndex = 0;
  int get categoryPageIndex => _categoryPageIndex;

  void setCategoryPageIndex(int index) {
    _categoryPageIndex = index;
    notifyListeners();
  }
}
