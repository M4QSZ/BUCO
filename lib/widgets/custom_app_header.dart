import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/map/map_screen.dart';
import '../screens/settings_menu_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class CustomAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final Color iconColor;
  final String logoAsset;
  
  const CustomAppHeader({
    Key? key,
    this.iconColor = const Color(0xFF662715), // primaryBrown
    this.logoAsset = 'assets/media/a12df1_asset_53.svg',
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    
    return Padding(
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
              'assets/media/4f8e9a_asset_30.svg',
              height: 28,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          SvgPicture.asset(
            logoAsset,
            height: 50,
          ),
          GestureDetector(
            onTap: () {
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
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
