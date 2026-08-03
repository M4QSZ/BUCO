import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  // Reseñas por restaurante
  final Map<String, List<Map<String, String>>> _restaurantReviews = {
    'BURGER KING': [
      {'name': 'Andrés Velasco', 'text': '"¡Muy buena comida !!"', 'rating': '4.5'},
      {'name': 'María López', 'text': '"Excelente servicio y rapidez"', 'rating': '4.1'},
      {'name': 'Juan Pérez', 'text': '"Las mejores hamburguesas"', 'rating': '4.8'},
      {'name': 'Ana Silva', 'text': '"Siempre vengo con mi familia"', 'rating': '4.7'},
      {'name': 'Carlos Díaz', 'text': '"Rápido y sabroso"', 'rating': '4.9'},
      {'name': 'Laura Ríos', 'text': '"Me encanta el Whopper"', 'rating': '5.0'},
    ],
    'MCDONALD\'S': [
      {'name': 'Carlos Díaz', 'text': '"Recomendado al 100%"', 'rating': '4.2'},
      {'name': 'Ana Silva', 'text': '"Las papas son increíbles"', 'rating': '5.0'},
      {'name': 'Luis Gómez', 'text': '"Atención muy rápida"', 'rating': '4.0'},
      {'name': 'Sofía Ortiz', 'text': '"Me encanta el Big Mac"', 'rating': '4.9'},
      {'name': 'Diego Cruz', 'text': '"Excelente lugar para ir con niños"', 'rating': '4.4'},
      {'name': 'Pedro Ruiz', 'text': '"Siempre un clásico"', 'rating': '4.6'},
    ],
    'SOBAN KOREAN GOURMET': [
      {'name': 'Ana Silva', 'text': '"El mejor lugar de la ciudad"', 'rating': '5.0'},
      {'name': 'Luis Gómez', 'text': '"Sabor increíble, el mejor pollo frito"', 'rating': '4.7'},
      {'name': 'Elena Paz', 'text': '"Me encanta la comida coreana aquí"', 'rating': '4.9'},
      {'name': 'Juan Pérez', 'text': '"El bibimbap es delicioso"', 'rating': '4.8'},
      {'name': 'Carlos Méndez', 'text': '"Excelente atención"', 'rating': '5.0'},
      {'name': 'Laura Ríos', 'text': '"Un ambiente muy agradable"', 'rating': '4.6'},
    ],
    'AYA LA VIDA': [
      {'name': 'Sofía Ortiz', 'text': '"Volveré pronto, me encantó el ceviche"', 'rating': '4.9'},
      {'name': 'Diego Cruz', 'text': '"Buena atención y excelente música en vivo"', 'rating': '4.8'},
      {'name': 'Pedro Ruiz', 'text': '"Un lugar muy especial"', 'rating': '5.0'},
      {'name': 'Elena Paz', 'text': '"La comida es exquisita"', 'rating': '4.7'},
      {'name': 'Juan Pérez', 'text': '"Los cócteles son geniales"', 'rating': '4.9'},
      {'name': 'Carlos Méndez', 'text': '"Mejor ambiente en el Casco"', 'rating': '5.0'},
    ],
    'MAITO': [
      {'name': 'Elena Paz', 'text': '"Me encantó el ambiente y la fusión Chombasia"', 'rating': '4.9'},
      {'name': 'Juan Pérez', 'text': '"Una experiencia gastronómica de otro nivel"', 'rating': '5.0'},
      {'name': 'Sofía Ortiz', 'text': '"Increíble degustación"', 'rating': '5.0'},
      {'name': 'Diego Cruz', 'text': '"Servicio impecable"', 'rating': '4.8'},
      {'name': 'Ana Silva', 'text': '"Sabores únicos"', 'rating': '4.9'},
      {'name': 'Luis Gómez', 'text': '"Definitivamente el mejor"', 'rating': '5.0'},
    ],
    'PARRILLADA JIMMY': [
      {'name': 'Pedro Ruiz', 'text': '"Las mejores parrilladas de Panamá, tradición total"', 'rating': '4.6'},
      {'name': 'Carlos Méndez', 'text': '"Excelente lugar para la familia"', 'rating': '4.8'},
      {'name': 'Laura Ríos', 'text': '"El pulpo al carbón es espectacular"', 'rating': '5.0'},
      {'name': 'Ana Silva', 'text': '"Porciones muy grandes"', 'rating': '4.7'},
      {'name': 'Luis Gómez', 'text': '"Atención muy rápida a pesar de estar lleno"', 'rating': '4.9'},
      {'name': 'Juan Pérez', 'text': '"Un clásico que nunca falla"', 'rating': '4.8'},
    ],
    'EL TRAPICHE': [
      {'name': 'Carlos Méndez', 'text': '"La mejor comida típica, un emparedado en hojaldre espectacular."', 'rating': '4.8'},
      {'name': 'Laura Ríos', 'text': '"Excelente sancocho y ambiente muy tradicional."', 'rating': '4.7'},
      {'name': 'Pedro Ruiz', 'text': '"Los tamales son lo máximo"', 'rating': '4.9'},
      {'name': 'Elena Paz', 'text': '"Siempre pido la fiesta panameña"', 'rating': '5.0'},
      {'name': 'Sofía Ortiz', 'text': '"Precios muy accesibles"', 'rating': '4.6'},
      {'name': 'Diego Cruz', 'text': '"El mejor desayuno típico"', 'rating': '4.8'},
    ],
    'CARL\'S JR': [
      {'name': 'Mateo', 'text': '"Excelentes hamburguesas"', 'rating': '4.8'},
      {'name': 'Sofia', 'text': '"Muy buen sabor y tamaño"', 'rating': '4.7'},
      {'name': 'Luis', 'text': '"Un poco caro pero vale la pena"', 'rating': '4.5'},
      {'name': 'Ana', 'text': '"Las papas crisscut son mis favoritas"', 'rating': '5.0'},
      {'name': 'Diego', 'text': '"Atención excelente"', 'rating': '4.6'},
      {'name': 'Carla', 'text': '"El pan siempre está fresco"', 'rating': '4.8'},
    ],
    'LITTLE CAESARS': [
      {'name': 'Pedro', 'text': '"Pizza rápida y económica"', 'rating': '4.2'},
      {'name': 'Juan', 'text': '"La Hot-N-Ready siempre salva"', 'rating': '4.5'},
      {'name': 'Maria', 'text': '"A veces hay mucha fila"', 'rating': '3.8'},
      {'name': 'Luis', 'text': '"Buena relación calidad-precio"', 'rating': '4.0'},
      {'name': 'Ana', 'text': '"Los Crazy Bread son riquísimos"', 'rating': '4.7'},
      {'name': 'Carlos', 'text': '"Saca de apuros"', 'rating': '4.1'},
    ],
    'DOMINO\'S PIZZA': [
      {'name': 'Laura', 'text': '"Muy buenas pizzas a domicilio"', 'rating': '4.6'},
      {'name': 'Sofia', 'text': '"Llegan súper rápido"', 'rating': '4.8'},
      {'name': 'Mateo', 'text': '"Me encantan las orillas rellenas de queso"', 'rating': '5.0'},
      {'name': 'Diego', 'text': '"Excelentes promociones"', 'rating': '4.5'},
      {'name': 'Carla', 'text': '"Siempre calientes y frescas"', 'rating': '4.7'},
      {'name': 'Juan', 'text': '"Las alitas picantes son buenísimas"', 'rating': '4.4'},
    ],
    'KFC': [
      {'name': 'Ana', 'text': '"El pollo más crujiente"', 'rating': '4.7'},
      {'name': 'Luis', 'text': '"Me encanta el puré y el gravy"', 'rating': '4.9'},
      {'name': 'Carlos', 'text': '"Siempre pido la cubeta para la familia"', 'rating': '4.6'},
      {'name': 'Maria', 'text': '"Atención muy rápida"', 'rating': '4.5'},
      {'name': 'Pedro', 'text': '"Los biscuits son lo mejor"', 'rating': '4.8'},
      {'name': 'Sofia', 'text': '"Un clásico de siempre"', 'rating': '4.4'},
    ],
    'SUBWAY': [
      {'name': 'Diego', 'text': '"Saludable y rápido"', 'rating': '4.5'},
      {'name': 'Carla', 'text': '"Me encanta armar mi propio emparedado"', 'rating': '4.8'},
      {'name': 'Laura', 'text': '"Las galletas son deliciosas"', 'rating': '5.0'},
      {'name': 'Juan', 'text': '"Siempre tienen ingredientes frescos"', 'rating': '4.7'},
      {'name': 'Ana', 'text': '"Excelente opción para un almuerzo ligero"', 'rating': '4.6'},
      {'name': 'Luis', 'text': '"Muy buen servicio al cliente"', 'rating': '4.4'},
    ],
    'PÍO PÍO': [
      {'name': 'Carlos', 'text': '"Las mollejas son la vida"', 'rating': '5.0'},
      {'name': 'Maria', 'text': '"Sabor bien panameño"', 'rating': '4.8'},
      {'name': 'Pedro', 'text': '"Las carimañolas están brutales"', 'rating': '4.7'},
      {'name': 'Sofia', 'text': '"Para esos antojos de la madrugada"', 'rating': '4.9'},
      {'name': 'Diego', 'text': '"Sancocho muy bueno"', 'rating': '4.6'},
      {'name': 'Laura', 'text': '"Siempre te saca de un apuro"', 'rating': '4.5'},
    ],
    'DON LEE': [
      {'name': 'Ana', 'text': '"El mejor arroz frito"', 'rating': '4.8'},
      {'name': 'Luis', 'text': '"Los clanes son una excelente opción"', 'rating': '4.6'},
      {'name': 'Juan', 'text': '"Chow mein muy sabroso"', 'rating': '4.7'},
      {'name': 'Carla', 'text': '"Me encantan las costillas agridulces"', 'rating': '4.9'},
      {'name': 'Mateo', 'text': '"Comida china muy consistente"', 'rating': '4.5'},
      {'name': 'Maria', 'text': '"Excelente relación cantidad-precio"', 'rating': '4.8'},
    ],
  };

  // Detalles completos de restaurantes (mock)
  final Map<String, Map<String, dynamic>> _restaurantDetails = {
    'BURGER KING': {
      'name': 'BURGER KING',
      'type': 'Hamburguesas - Comida rápida',
      'rating': 5.0,
      'description': '¡Bienvenido a Burger King, el hogar original del Whopper! Disfruta de nuestras clásicas hamburguesas a la parrilla, preparadas con ingredientes frescos y de la mejor calidad. Contamos con un ambiente familiar, servicio rápido y promociones increíbles todos los días. Ven a saborear la experiencia que nos hace únicos y descubre por qué somos tu mejor opción para disfrutar de comida rápida con un sabor auténtico.',
      'headerImage': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&auto=format&fit=crop',
      'logoImage': 'assets/media/f1a2d7_burger_kin.svg',
      'address': 'Múltiples sucursales',
      'menuLink': 'https://www.bk.com/menu',
    },
    'MCDONALD\'S': {
      'name': 'MCDONALD\'S',
      'type': 'Hamburguesas - Comida rápida',
      'rating': 5.0,
      'description': 'McDonald\'s es la cadena de restaurantes de comida rápida más grande del mundo. Conocida por sus icónicas papas fritas, el Big Mac y la Cajita Feliz.',
      'headerImage': 'https://images.unsplash.com/photo-1627900139150-f823a31cde72?w=800&auto=format&fit=crop',
      'logoImage': 'assets/media/c75819_mcdonalds.svg',
      'address': 'Múltiples sucursales',
      'menuLink': 'https://www.mcdonalds.com/us/en-us/full-menu.html',
    },
    'SOBAN KOREAN GOURMET': {
      'name': 'SOBAN KOREAN GOURMET',
      'type': 'Comida Gourmet Coreana',
      'rating': 5.0,
      'description': 'Soban Korean Gourmet es un restaurante especializado en gastronomía coreana ubicado en Plaza New York, Marbella. Su propuesta combina la tradición culinaria de Corea con una presentación moderna y una experiencia gastronómica de alta calidad. Platos estrella: Pollo frito coreano, galbi, bibimbap, japchae y sopa kalguksu.',
      'headerImage': 'assets/media/soban/SOBAN_2.jpg',
      'logoImage': 'assets/media/soban/SOBAN.jpg',
      'address': 'Plaza New York (Marbella)',
      'menuLink': 'https://www.instagram.com/sobankoreangourmet/',
      'sliderImages': [
        'assets/media/soban/SOBAN_3.jpg',
        'assets/media/soban/SOBAN_2.jpg',
        'assets/media/soban/SOBAN.jpg',
      ],
    },
    'AYA LA VIDA': {
      'name': 'AYA LA VIDA',
      'type': 'Alta cocina panameña',
      'rating': 5.0,
      'description': 'Aya la Vida es un restaurante de alta cocina y comida típica panameña contemporánea ubicado en el Casco Antiguo. El lugar destaca por ofrecer sabores locales renovados, cócteles de autor y música en vivo en un ambiente elegante. Utiliza un 100% de productos nacionales y locales.',
      'headerImage': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop', // Restaurante fino
      'logoImage': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop', // Fallback
      'address': 'Planta baja del Edificio La Cuadra, Casco Antiguo',
      'menuLink': 'https://www.instagram.com/ayalavida/',
    },
    'MAITO': {
      'name': 'MAITO',
      'type': 'Nueva Cocina Contemporánea',
      'rating': 5.0,
      'description': 'En el corazón vibrante de Panamá City se encuentra Maito. Su carta es una fusión de tradición panameña y técnicas modernas, y una oda absoluta a los ingredientes locales. Es pionero de la "Gastronomía de Identidad Panameña" y ha figurado en las listas de los mejores restaurantes de Latinoamérica (Latin America’s 50 Best Restaurants).',
      'headerImage': 'assets/media/maito/MAITO_2.jpg', 
      'logoImage': 'assets/media/maito/MAITO.jpg', 
      'address': 'Calle 50, Este, sector Coco del Mar',
      'menuLink': 'https://www.maitorestaurante.com',
      'sliderImages': [
        'assets/media/maito/MAITO_3.jpg',
        'assets/media/maito/MAITO_2.jpg',
        'assets/media/maito/MAITO.jpg',
      ],
    },
    'PARRILLADA JIMMY': {
      'name': 'PARRILLADA JIMMY',
      'type': 'Parrilladas y Mariscos',
      'rating': 5.0,
      'description': 'Restaurante tradicional abierto desde 1958. Podrás contar con una atención placentera como si estuvieras en casa, en sus cartas podrás encontrar una gran variedad de platos (Parrilladas, Pastas, Mariscos, Pizzas y comida Griega) dignos de paladares exigentes. Atienden hasta 400 personas.',
      'headerImage': 'assets/media/jimmy/PARRILLADA_JIMMY_2.jpg',
      'logoImage': 'assets/media/jimmy/PARRILLADA_JIMMY.jpg',
      'address': 'Vía Cincuentenario, diagonal a Atlapa',
      'menuLink': 'https://www.instagram.com/parrilladajimmy/',
      'sliderImages': [
        'assets/media/jimmy/PARRILLADA_JIMMY_3.jpg',
        'assets/media/jimmy/PARRILLADA_JIMMY_2.jpg',
        'assets/media/jimmy/PARRILLADA_JIMMY.jpg',
      ],
    },
    'EL TRAPICHE': {
      'name': 'EL TRAPICHE',
      'type': 'Comida Típica Panameña',
      'rating': 5.0,
      'description': 'El Trapiche es un restaurante emblemático que te invita a disfrutar de los sabores más auténticos de Panamá. Desde 1983, sirve la mejor comida típica panameña, con platillos como el famoso emparedado en hojaldre, sancocho, tamales y fiesta panameña, manteniendo vivas las tradiciones en cada bocado.',
      'headerImage': 'assets/media/trapiche/TRAPICHE_2.jpg',
      'logoImage': 'assets/media/trapiche/TRAPICHE.jpg',
      'address': 'Vía Argentina, El Cangrejo',
      'menuLink': 'https://www.eltrapicherestaurante.com',
      'sliderImages': [
        'assets/media/trapiche/TRAPICHE_3.jpg',
        'assets/media/trapiche/TRAPICHE_2.jpg',
        'assets/media/trapiche/TRAPICHE.jpg',
        'assets/media/trapiche/TRAPICHE.avif',
      ],
    },
  };

  // Set dinámico de nombres de restaurantes favoritos (en mayúsculas para comparación)
  final Set<String> _favoriteNames = {};

  // Datos mock de restaurantes que no están en _restaurantDetails
  final Map<String, Map<String, dynamic>> _extraRestaurants = {
    'BURGER KING': {
      'name': 'BURGER KING',
      'rating': 5.0,
      'imageUrl': 'assets/media/f1a2d7_burger_kin.svg',
      'cardColor': Colors.white,
    },
    "MCDONALD'S": {
      'name': "McDonald's",
      'rating': 5.0,
      'imageUrl': 'assets/media/c75819_mcdonalds.svg',
      'cardColor': const Color(0xFFDA291C),
    },
    "CARL'S JR": {
      'name': "Carl's Jr",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_carlsjr.png',
      'cardColor': const Color(0xFFE21A22),
    },
    "LITTLE CAESARS": {
      'name': "Little Caesars",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_littlecaesars.png',
      'cardColor': const Color(0xFFFF6600),
    },
    "DOMINO'S PIZZA": {
      'name': "Domino's Pizza",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_dominos.png',
      'cardColor': const Color(0xFF0055A5),
    },
    "KFC": {
      'name': "KFC",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_kfc.svg',
      'cardColor': const Color(0xFFE4002B),
    },
    "SUBWAY": {
      'name': "Subway",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_subway.png',
      'cardColor': const Color(0xFF008938),
    },
    "PÍO PÍO": {
      'name': "Pío Pío",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_piopio.png',
      'cardColor': const Color(0xFFF0531C),
    },
    "DON LEE": {
      'name': "Don Lee",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_donlee.png',
      'cardColor': const Color(0xFFC00A27),
    },
  };

  // Mock data for discover restaurants (Search Screen)
  final List<Map<String, dynamic>> _discoverRestaurants = [
    {
      'name': 'BURGER KING',
      'rating': 5.0,
      'imageUrl': 'assets/media/f1a2d7_burger_kin.svg',
      'cardColor': Colors.white,
    },
    {
      'name': "McDonald's",
      'rating': 5.0,
      'imageUrl': 'assets/media/c75819_mcdonalds.svg',
      'cardColor': const Color(0xFFDA291C),
    },
    {
      'name': "Carl's Jr",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_carlsjr.png',
      'cardColor': const Color(0xFFE21A22),
    },
    {
      'name': "Little Caesars",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_littlecaesars.png',
      'cardColor': const Color(0xFFFF6600),
    },
    {
      'name': "Domino's Pizza",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_dominos.png',
      'cardColor': const Color(0xFF0055A5),
    },
    {
      'name': "KFC",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_kfc.svg',
      'cardColor': const Color(0xFFE4002B),
    },
    {
      'name': "Subway",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_subway.png',
      'cardColor': const Color(0xFF008938),
    },
    {
      'name': "Pío Pío",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_piopio.png',
      'cardColor': const Color(0xFFF0531C),
    },
    {
      'name': "Don Lee",
      'rating': 5.0,
      'imageUrl': 'assets/media/logo_donlee.png',
      'cardColor': const Color(0xFFC00A27),
    },
  ];

  // Calculamos el rating promedio dinámicamente basado en las reseñas
  double getRatingFor(String restaurantName) {
    final reviews = getReviewsFor(restaurantName);
    if (reviews.isEmpty) return 0.0;
    
    double sum = 0.0;
    for (var review in reviews) {
      sum += double.tryParse(review['rating'] ?? '0.0') ?? 0.0;
    }
    double avg = sum / reviews.length;
    // Retornamos truncado a 1 decimal
    return double.parse(avg.toStringAsFixed(1));
  }

  // Modificado: Devuelve las reseñas específicas de un restaurante o una lista genérica
  List<Map<String, String>> getReviewsFor(String restaurantName) {
    String upperName = restaurantName.toUpperCase();
    if (_restaurantReviews.containsKey(upperName) && _restaurantReviews[upperName]!.isNotEmpty) {
      return _restaurantReviews[upperName]!;
    }
    // Fallback con 6 reseñas aleatorias para ver el slider
    return [
      {'name': 'Invitado 1', 'text': '"Un lugar genial para comer"', 'rating': '4.5'},
      {'name': 'Invitado 2', 'text': '"Buen servicio, volveré"', 'rating': '4.0'},
      {'name': 'Invitado 3', 'text': '"Muy rápido y sabroso"', 'rating': '4.8'},
      {'name': 'Invitado 4', 'text': '"Perfecto para ir con amigos"', 'rating': '4.7'},
      {'name': 'Invitado 5', 'text': '"Precios bastante accesibles"', 'rating': '4.2'},
      {'name': 'Invitado 6', 'text': '"Me encantó el menú"', 'rating': '4.9'},
    ];
  }

  // Modificado: Devuelve los detalles específicos o genéricos
  Map<String, dynamic> getDetailsFor(String restaurantName) {
    String upperName = restaurantName.toUpperCase();
    if (_restaurantDetails.containsKey(upperName)) {
      final details = Map<String, dynamic>.from(_restaurantDetails[upperName]!);
      details['rating'] = getRatingFor(upperName);
      return details;
    }
    // Fallback genérico
    return {
      'name': upperName,
      'type': 'Restaurante',
      'rating': getRatingFor(upperName),
      'description': 'Información no disponible para este restaurante.',
      'headerImage': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop',
      'logoImage': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop', // Un genérico
      'address': 'Dirección no disponible',
      'sliderImages': [
        'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop',
      ],
    };
  }

  // Devuelve la lista de restaurantes favoritos dinámicamente
  List<Map<String, dynamic>> get favoriteRestaurants {
    if (_favoriteNames.isEmpty) return [];
    final List<Map<String, dynamic>> result = [];
    for (final name in _favoriteNames) {
      if (_restaurantDetails.containsKey(name)) {
        final details = Map<String, dynamic>.from(_restaurantDetails[name]!);
        details['imageUrl'] ??= details['logoImage'];
        details['rating'] = getRatingFor(name);
        result.add(details);
      } else if (_extraRestaurants.containsKey(name)) {
        final details = Map<String, dynamic>.from(_extraRestaurants[name]!);
        details['rating'] = getRatingFor(name);
        result.add(details);
      }
    }
    return result;
  }

  int get favoritesCount => _favoriteNames.length;

  bool isFavorite(String restaurantName) {
    return _favoriteNames.contains(restaurantName.toUpperCase());
  }

  void toggleFavorite(String restaurantName, {Map<String, dynamic>? data}) {
    final upperName = restaurantName.toUpperCase();
    if (_favoriteNames.contains(upperName)) {
      _favoriteNames.remove(upperName);
    } else {
      _favoriteNames.add(upperName);
      // Si el restaurante no está en ningún mapa, guardarlo con los datos proporcionados
      if (!_restaurantDetails.containsKey(upperName) && !_extraRestaurants.containsKey(upperName) && data != null) {
        _extraRestaurants[upperName] = data;
      }
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> get discoverRestaurants {
    return _discoverRestaurants.map((rest) {
      final updated = Map<String, dynamic>.from(rest);
      updated['rating'] = getRatingFor(rest['name'] as String);
      return updated;
    }).toList();
  }
  
  List<Map<String, dynamic>> get allRestaurants {
    return _restaurantDetails.values.map((rest) {
      final updated = Map<String, dynamic>.from(rest);
      updated['rating'] = getRatingFor(rest['name'] as String);
      return updated;
    }).toList();
  }

  List<Map<String, dynamic>> searchRestaurants(String query) {
    if (query.isEmpty) return [];
    final lowerQuery = query.toLowerCase();
    return _restaurantDetails.values.where((rest) {
      final nameMatch = (rest['name'] as String).toLowerCase().contains(lowerQuery);
      final typeMatch = (rest['type'] as String).toLowerCase().contains(lowerQuery);
      return nameMatch || typeMatch;
    }).map((rest) {
      final updated = Map<String, dynamic>.from(rest);
      updated['rating'] = getRatingFor(rest['name'] as String);
      return updated;
    }).toList();
  }

  void addReview(String restaurantName, String userName, String text, double rating) {
    String upperName = restaurantName.toUpperCase();
    if (!_restaurantReviews.containsKey(upperName)) {
      _restaurantReviews[upperName] = [];
    }
    _restaurantReviews[upperName]!.insert(0, {
      'name': userName,
      'text': '"$text"',
      'rating': rating.toStringAsFixed(1),
    });
    notifyListeners();
  }
}
