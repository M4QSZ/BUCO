import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/auto_scroll_restaurant_carousel.dart';
import 'settings_menu_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/restaurant_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);

    final userProvider = context.watch<UserProvider>();

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
                              MaterialPageRoute(builder: (context) => SettingsMenuScreen(userName: userProvider.userName)),
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
                  Text(
                    userProvider.userName,
                    style: const TextStyle(
                      color: primaryBrown,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    userProvider.email,
                    style: const TextStyle(
                      color: primaryBrown,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Contador de Favoritos
                  Column(
                    children: [
                      Text(
                        context.watch<RestaurantProvider>().favoritesCount.toString(),
                        style: const TextStyle(
                          color: creamWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 48,
                          height: 1.1,
                        ),
                      ),
                      const Text(
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

            const SizedBox(height: 20),
            Consumer<RestaurantProvider>(
              builder: (context, restaurantProvider, child) {
                return AutoScrollRestaurantCarousel(
                  restaurants: restaurantProvider.favoriteRestaurants,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
