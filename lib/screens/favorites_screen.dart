import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);

    return Scaffold(
      backgroundColor: creamWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            // Cabecera Naranja
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 40), // Masiva
              decoration: const BoxDecoration(
                color: primaryOrange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  // App Bar interno
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Asset 30.svg',
                          width: 28,
                          colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                        ),
                        SvgPicture.asset(
                          'assets/icons/Asset 52.svg',
                          height: 50,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ),
                        const Icon(Icons.menu, color: creamWhite, size: 28),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Perfil simplificado
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: creamWhite,
                    child: Icon(Icons.person, size: 55, color: primaryBrown),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Andrés Velasco',
                    style: TextStyle(
                      color: primaryBrown,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    '¡¡hola!!',
                    style: TextStyle(
                      color: primaryBrown.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Contador de Favoritos
                  const Column(
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                          color: creamWhite,
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        'FAVORITOS',
                        style: TextStyle(
                          color: primaryBrown,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Icono de guardado gigante
            const Icon(
              Icons.bookmark,
              color: Color(0xFFF2BF4A),
              size: 60,
            ),
            const SizedBox(height: 30),

            // Lista de restaurantes (Tus Favoritos)
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  RestaurantCard(
                    name: 'BURGER KING', 
                    type: '', 
                    rating: 4.5, 
                    backgroundColor: primaryOrange,
                    cardColor: Colors.white,
                    isLargeTitle: true,
                    isSavedStyle: true,
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1024px-Burger_King_2020.svg.png',
                  ),
                  RestaurantCard(
                    name: 'MAC DONALDS', 
                    type: '', 
                    rating: 4.0, 
                    backgroundColor: primaryOrange,
                    cardColor: Colors.white,
                    isLargeTitle: true,
                    isSavedStyle: true,
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1024px-McDonald%27s_Golden_Arches.svg.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.more_horiz, color: primaryBrown, size: 50),
              ],
            )
          ],
        ),
      ),
    );
  }
}
