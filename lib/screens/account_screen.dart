import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    return Scaffold(
      backgroundColor: greenBg, // Fondo verde debajo
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Cabecera Naranja Completa
                Container(
                  padding: const EdgeInsets.only(top: 45, bottom: 20),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SettingsMenuScreen()),
                                );
                              },
                              child: const Icon(Icons.menu, color: creamWhite, size: 28),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Fila de Perfil
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: creamWhite,
                              child: SvgPicture.asset(
                                'assets/icons/profile_icon.svg',
                                height: 55,
                                colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Flexible(
                                        child: Text(
                                          'Andrés Velasco',
                                          style: TextStyle(
                                            color: primaryBrown,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.edit, color: creamWhite, size: 18),
                                    ],
                                  ),
                                  Text(
                                    '¡¡hola!!',
                                    style: TextStyle(
                                      color: primaryBrown.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rep',
                                  style: TextStyle(
                                    color: primaryBrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '020.000',
                                  style: TextStyle(
                                    color: creamWhite,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Contadores
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _buildStat('0', 'CALIFICACIONES')),
                          Expanded(child: _buildStat('0', 'FAVORITOS')),
                          Expanded(child: _buildStat('0', 'RESTAURANTES')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Tarjeta de reseña sobre el fondo verde
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: primaryBrown,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '"Muy buena comida!!"',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: creamWhite, fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SvgPicture.asset(
                            'assets/icons/burger_king.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _buildPaginationDots(Colors.white),
                const SizedBox(height: 15),
              ],
            ),
          ),

          // Contenedor crema inferior masivo
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: creamWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/icons/FAV.svg',
                    width: 35,
                    colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 45, right: 16),
                      children: const [
                        RestaurantCard(
                          name: 'BURGER KING',
                          type: '',
                          rating: 4.5,
                          isSavedStyle: true,
                          imageUrl: 'assets/icons/burger_king.svg',
                          cardColor: Colors.white,
                        ),
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
                  const SizedBox(height: 20),
                  _buildPaginationDots(greenBg),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
);
  }

  Widget _buildPaginationDots(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(8, (index) {
        return Container(
          width: 16,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }


  Widget _buildStat(String number, String label) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: creamWhite,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(
              color: primaryBrown,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
