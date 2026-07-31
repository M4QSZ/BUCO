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
                              'assets/icons/Asset 30.svg',
                              height: 24,
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
                               child: SvgPicture.asset(
                                 'assets/icons/Asset 29.svg',
                                 width: 22,
                                 colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                               ),
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
                            SvgPicture.asset(
                              'assets/icons/profile_icon.svg',
                              width: 64,
                              height: 64,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'Andrés Velasco',
                                          style: TextStyle(
                                            color: primaryBrown,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 22,
                                            height: 1.0,
                                          ),
                                        ),
                                        Text(
                                          '¡¡hola!!',
                                          style: TextStyle(
                                            color: primaryBrown,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: -5,
                                      right: -10,
                                      child: SvgPicture.asset(
                                        'assets/icons/Asset 28.svg',
                                        width: 18,
                                        colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                        margin: const EdgeInsets.only(top: 25),
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                          color: primaryBrown,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Text(
                          '“Muy buena comida!!”',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: creamWhite, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset(
                          'assets/icons/burger_king.svg',
                          fit: BoxFit.contain,
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
                    height: 260,
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
