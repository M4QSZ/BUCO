import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantHeaderImage extends StatelessWidget {
  const RestaurantHeaderImage({super.key});

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
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    'assets/media/ee45a3_back_arrow.svg',
                    height: 28,
                    colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                  ),
                ),
                SvgPicture.asset(
                  'assets/media/4e9d05_asset_52.svg',
                  height: 50,
                  colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/media/3ff13c_menu_icon.svg', 
                    width: 22, 
                    colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          
          // Logo de Burger King gigante
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset(
                'assets/media/f1a2d7_burger_kin.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
