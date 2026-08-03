import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../map/map_screen.dart';
import '../settings_menu_screen.dart';
import '../../providers/user_provider.dart';
class RestaurantHeaderImage extends StatelessWidget {
  final String headerImage;
  final String logoImage;
  
  const RestaurantHeaderImage({
    super.key,
    required this.headerImage,
    required this.logoImage,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);

    return SizedBox(
      height: 400,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: primaryOrange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(150),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MapScreen(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/media/4f8e9a_asset_30.svg', // Map pin to match screenshot
                    height: 28,
                    colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                  ),
                ),
                SvgPicture.asset(
                  'assets/media/4e9d05_asset_52.svg',
                  height: 50,
                  colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                ),
                GestureDetector(
                  onTap: () {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsMenuScreen(userName: userProvider.userName),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/media/3ff13c_menu_icon.svg', 
                    width: 22, 
                    colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          
          // Logo circular o contenedor
          Positioned(
            bottom: 0,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: creamWhite, width: 6),
                image: logoImage.isNotEmpty && !logoImage.toLowerCase().endsWith('.svg')
                    ? DecorationImage(
                        image: logoImage.startsWith('http')
                            ? NetworkImage(logoImage) as ImageProvider
                            : AssetImage(logoImage),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: logoImage.toLowerCase().endsWith('.svg')
                  ? ClipOval(
                      child: SvgPicture.asset(
                        logoImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
