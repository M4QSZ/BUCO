import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    return Scaffold(
      backgroundColor: creamWhite,
      appBar: AppBar(
        backgroundColor: creamWhite,
        elevation: 0,
        leading: SvgPicture.asset(
          'assets/icons/Asset 30.svg',
          fit: BoxFit.scaleDown,
          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
        ),
        title: SvgPicture.asset(
          'assets/icons/Asset 52.svg',
          height: 40,
          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: primaryBrown),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsMenuScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Principal
            Container(
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/burger.jpg'), // Burger placeholder
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'PROMO MCMELT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Categorías
            Container(
              color: greenBg,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCategory('PASTAS'),
                      _buildCategory('SUSHI'),
                      _buildCategory('POSTRES'),
                      _buildCategory('PIZZAS'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.arrow_back_ios, color: creamWhite, size: 20),
                      // Puntitos de paginación
                      Row(
                        children: [
                          _buildDot(true),
                          _buildDot(false),
                          _buildDot(false),
                          _buildDot(false),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios, color: creamWhite, size: 20),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Los más queridos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'LOS MAS QUERIDOS',
                style: TextStyle(
                  color: primaryBrown,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  RestaurantCard(
                    name: 'LUCCA', 
                    type: 'Italiana', 
                    rating: 4.5,
                  ),
                  RestaurantCard(
                    name: 'GIORGIO\'S', 
                    type: 'Italiana', 
                    rating: 4.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tus Favoritos
            Container(
              color: greenBg,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'TUS FAVORITOS',
                      style: TextStyle(
                        color: creamWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          imageUrl: 'assets/images/bk_logo.png',
                        ),
                        RestaurantCard(
                          name: 'MAC DONALDS', 
                          type: '', 
                          rating: 4.0, 
                          backgroundColor: primaryOrange,
                          cardColor: Colors.white,
                          isLargeTitle: true,
                          imageUrl: 'assets/images/mcd_logo.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Descubre
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'DESCUBRE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryBrown,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildColorBox(Colors.red),
                  _buildColorBox(greenBg),
                  _buildColorBox(primaryOrange),
                  _buildColorBox(const Color(0xFFF2BF4A)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Puntitos de paginación para Descubre
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(true, color: primaryBrown),
                _buildDot(false, color: primaryBrown),
                _buildDot(false, color: primaryBrown),
              ],
            ),
            const SizedBox(height: 32),

            // Review final
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryBrown,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      '"Muy buena comida!!"',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: creamWhite, fontSize: 16),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/bk_logo.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title) {
    const Color creamWhite = Color(0xFFF8EDDB);
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(16), // Más redondeado
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: const Color(0xFFF2BF4A),
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive, {Color color = const Color(0xFFF8EDDB)}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildColorBox(Color color) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
