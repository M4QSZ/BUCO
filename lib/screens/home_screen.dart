import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';
import 'map/map_screen.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 15,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/Asset 30.svg',
                  height: 28,
                  colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/Asset 53.svg', // Logo BUCO con ubicación
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsMenuScreen()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/menu_icon.svg',
                  width: 22,
                  colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Principal
            Container(
              height: 220,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Asset 31.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildPaginationDots(greenBg),
            const SizedBox(height: 16),
            
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
                      SvgPicture.asset(
                        'assets/icons/pagination_arrow.svg',
                        height: 20,
                        colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                      ),
                      // Puntitos de paginación
                      Row(
                        children: List.generate(
                          11,
                          (index) => _buildDot(index == 0),
                        ),
                      ),
                      Transform.flip(
                        flipX: true,
                        child: SvgPicture.asset(
                          'assets/icons/pagination_arrow.svg',
                          height: 20,
                          colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                        ),
                      ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: const [
                        Expanded(
                          child: RestaurantCard(
                            name: 'LUCCA', 
                            type: 'Italiana', 
                            rating: 4.5,
                            imageUrl: 'assets/images/Asset 35.png',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: RestaurantCard(
                            name: 'GIORGIO\'S', 
                            type: 'Italiana', 
                            rating: 4.0,
                            imageUrl: 'assets/images/Asset 34.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: const [
                        Expanded(
                          child: RestaurantCard(
                            name: 'NAPOLI', 
                            type: 'Pizzas', 
                            rating: 4.8,
                            imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: RestaurantCard(
                            name: 'LOS AÑOS LOCOS', 
                            type: 'Carnes', 
                            rating: 4.7,
                            imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildPaginationDots(greenBg),
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
                        fontFamily: 'Bernoru',
                        color: creamWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          imageUrl: 'assets/icons/burger_king.svg',
                          cardColor: Colors.white,
                        ),
                        SizedBox(width: 24), // Añadido para recuperar el espacio
                        RestaurantCard(
                          name: 'MAC DONALDS', 
                          type: '', 
                          rating: 4.0, 
                          isSavedStyle: true,
                          imageUrl: 'assets/icons/mcdonalds.svg',
                          cardColor: Color(0xFFDA291C),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPaginationDots(Colors.white),
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
                  fontFamily: 'Bernoru',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildColorBox(Colors.red),
                  const SizedBox(width: 16),
                  _buildColorBox(greenBg),
                  const SizedBox(width: 16),
                  _buildColorBox(primaryOrange),
                  const SizedBox(width: 16),
                  _buildColorBox(const Color(0xFFF2BF4A)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Puntitos de paginación para Descubre
            _buildPaginationDots(greenBg),
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
                      style: TextStyle(
                        fontFamily: 'Bernoru',
                        color: creamWhite, 
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/burger_kin.svg',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/pagination_arrow.svg',
                    height: 20,
                    colorFilter: const ColorFilter.mode(greenBg, BlendMode.srcIn),
                  ),
                  Row(
                    children: List.generate(
                      11,
                      (index) => _buildDot(index == 0, color: greenBg),
                    ),
                  ),
                  Transform.flip(
                    flipX: true,
                    child: SvgPicture.asset(
                      'assets/icons/pagination_arrow.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(greenBg, BlendMode.srcIn),
                    ),
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
            fontFamily: 'Bernoru',
            color: Color(0xFFF2BF4A),
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
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
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
