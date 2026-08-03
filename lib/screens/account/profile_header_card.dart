import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../settings_menu_screen.dart';

class ProfileHeaderCard extends StatelessWidget {
  final VoidCallback onEditProfile;

  const ProfileHeaderCard({Key? key, required this.onEditProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    final userProvider = context.watch<UserProvider>();

    return Container(
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
                      MaterialPageRoute(
                          builder: (context) => SettingsMenuScreen(userName: userProvider.userName)),
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

          // Fila de Perfil
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/media/8c491b_profile_icon.svg',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                userProvider.userName,
                                style: const TextStyle(
                                  color: primaryBrown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  height: 1.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: onEditProfile,
                              child: SvgPicture.asset(
                                'assets/media/8eb9ad_asset_28.svg',
                                width: 18,
                                colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          userProvider.email,
                          style: const TextStyle(
                            color: primaryBrown,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                        fontWeight: FontWeight.w600,
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
              Expanded(child: _buildStat(userProvider.reviewsCount.toString(), 'CALIFICACIONES')),
              Expanded(child: _buildStat(context.watch<RestaurantProvider>().favoritesCount.toString(), 'FAVORITOS')),
              Expanded(child: _buildStat(userProvider.restaurantsCount.toString(), 'RESTAURANTES')),
            ],
          ),
        ],
      ),
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
            fontWeight: FontWeight.w600,
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
