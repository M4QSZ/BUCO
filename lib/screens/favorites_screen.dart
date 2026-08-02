import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    return Scaffold(
      backgroundColor: creamWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            // Cabecera Naranja
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 15,
                bottom: 20,
              ),
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
                          'assets/media/4f8e9a_asset_30.svg',
                          height: 28,
                          colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                        ),
                        SvgPicture.asset(
                          'assets/media/4e9d05_asset_52.svg',
                          height: 50,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsMenuScreen()),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/media/3ff13c_menu_icon.svg',
                            width: 22,
                            colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Perfil simplificado
                  SvgPicture.asset(
                    'assets/media/8c491b_profile_icon.svg',
                    width: 76,
                    height: 76,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Andrés Velasco',
                    style: TextStyle(
                      color: primaryBrown,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    '¡¡hola!!',
                    style: TextStyle(
                      color: primaryBrown,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Contador de Favoritos
                  const Column(
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                          color: creamWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 48,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        'FAVORITOS',
                        style: TextStyle(
                          color: primaryBrown,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Icono de guardado gigante
            SvgPicture.asset(
              'assets/media/59675c_fav.svg',
              width: 35,
              colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
            ),
            const SizedBox(height: 30),

            // Lista de restaurantes (Tus Favoritos)
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 45),
                children: const [
                  RestaurantCard(
                    name: 'BURGER KING', 
                    type: '', 
                    rating: 4.5, 
                    isSavedStyle: true,
                    imageUrl: 'assets/media/f1a2d7_burger_kin.svg',
                    cardColor: Colors.white,
                  ),
                  SizedBox(width: 24),
                  RestaurantCard(
                    name: "McDonald's", 
                    type: '', 
                    rating: 4.0, 
                    isSavedStyle: true,
                    imageUrl: 'assets/media/c75819_mcdonalds.svg',
                    cardColor: Color(0xFFDA291C),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Paginación verde
            _buildPaginationDots(greenBg),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationDots(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(9, (index) {
        bool isEdge = index == 0 || index == 8;
        return Container(
          width: isEdge ? 15.0 : 30.0,
          height: 4.0,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
