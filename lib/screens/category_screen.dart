import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/custom_app_header.dart';
import '../widgets/restaurant_card.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryTitle;

  const CategoryScreen({Key? key, required this.categoryTitle}) : super(key: key);

  List<Map<String, dynamic>> _getRestaurantsForCategory(BuildContext context, String category) {
    final allRestaurants = context.read<HomeProvider>().mostLovedRestaurants;
    List<String> validTypes = [];

    switch (category.toUpperCase()) {
      case 'PASTAS':
        validTypes = ['Italiana', 'Contemporánea'];
        break;
      case 'SUSHI':
        validTypes = ['Japonesa', 'Asiática'];
        break;
      case 'POSTRES':
        validTypes = ['Postres'];
        break;
      case 'PIZZAS':
        validTypes = ['Pizzas', 'Italiana'];
        break;
      case 'BURGER':
      case 'POLLO':
      case 'ALITAS':
        validTypes = ['Rápida'];
        break;
      case 'ENSALADA':
        validTypes = ['Griega', 'Contemporánea', 'Internacional'];
        break;
      case 'CARNES':
        validTypes = ['Carnes', 'Parrilladas'];
        break;
      case 'POKE':
        validTypes = ['Asiática', 'Japonesa'];
        break;
      case 'CAFÉ':
        validTypes = ['Francesa'];
        break;
      case 'DONAS':
        validTypes = ['Postres', 'Rápida'];
        break;
      default:
        validTypes = ['Rápida']; // Default fallback
    }

    final filtered = allRestaurants.where((rest) {
      final type = rest['type'] as String;
      return validTypes.contains(type);
    }).toList();

    // Si no hay resultados, mostramos todos (o algunos aleatorios) para que no quede vacía
    if (filtered.isEmpty) {
      return allRestaurants.take(6).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    final restaurants = _getRestaurantsForCategory(context, categoryTitle);

    return Scaffold(
      backgroundColor: creamWhite,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppHeader(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: greenBg,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: creamWhite),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    categoryTitle.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Bernoru',
                      color: creamWhite,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance the back button
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'LOCALES RECOMENDADOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bernoru',
                color: primaryBrown,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: restaurants.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.9, 
              ),
              itemBuilder: (context, index) {
                final rest = restaurants[index];
                final restaurantProvider = context.watch<RestaurantProvider>();
                final restName = rest['name'] as String;
                return RestaurantCard(
                  name: restName,
                  type: rest['type'],
                  rating: rest['rating'],
                  imageUrl: rest['imageUrl'],
                  isFavorite: restaurantProvider.isFavorite(restName),
                  onFavoriteToggle: () => restaurantProvider.toggleFavorite(restName, data: rest),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
