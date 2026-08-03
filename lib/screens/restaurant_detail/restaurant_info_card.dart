import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/restaurant_provider.dart';

class RestaurantInfoCard extends StatelessWidget {
  final String name;
  final String type;
  final double rating;

  const RestaurantInfoCard({
    super.key,
    required this.name,
    required this.type,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    final restaurantProvider = context.watch<RestaurantProvider>();
    final bool isFav = restaurantProvider.isFavorite(name);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Container(
              height: 105,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: primaryBrown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name.toUpperCase().replaceAll(' ', '\n'), // Separar palabras por línea para emular estilo previo, o simplemente name.
                            style: const TextStyle(
                              fontFamily: 'Bernoru',
                              color: creamWhite,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type,
                          style: const TextStyle(
                            color: creamWhite,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      restaurantProvider.toggleFavorite(name);
                    },
                    child: SvgPicture.asset(
                      isFav 
                          ? 'assets/media/107df8_marcar_favorito.svg' 
                          : 'assets/media/8d6e5a_fav_sin_marcar.svg', 
                      width: 28, 
                      colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn)
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Container(
              height: 105,
              decoration: BoxDecoration(
                color: const Color(0xFFF2BF4A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontFamily: 'Bernoru',
                    color: creamWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Container(
              height: 105,
              decoration: BoxDecoration(
                color: primaryBrown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/media/b5e1db_perfil.svg', 
                  width: 32, 
                  colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
