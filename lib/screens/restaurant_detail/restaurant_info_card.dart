import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantInfoCard extends StatelessWidget {
  const RestaurantInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Container(
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
                      children: [
                        const Text(
                          'BURGER\nKING',
                          style: TextStyle(
                            fontFamily: 'Bernoru',
                            color: creamWhite,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Hamburguesas - Comida rápida',
                          style: TextStyle(
                            color: creamWhite,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/media/8d6e5a_fav_sin_marcar.svg', 
                    width: 28, 
                    colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn)
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
              child: const Center(
                child: Text(
                  '4.5',
                  style: TextStyle(
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
