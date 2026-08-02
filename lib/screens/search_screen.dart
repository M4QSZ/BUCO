import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';
import 'map/map_screen.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/custom_app_header.dart';
import 'search/search_filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget _buildEmptyBox() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFF8EDDB),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildSearchHistoryItem(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Icon(Icons.close, color: textColor, size: 22),
        ],
      ),
    );
  }



  @override

  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color beigeColor = Color(0xFFDCC8B2);
    const Color greenBg = Color(0xFF2E563B);

    final userProvider = context.watch<UserProvider>();
    final searchProvider = context.watch<SearchProvider>();
    final restaurantProvider = context.watch<RestaurantProvider>();

    return Scaffold(
      backgroundColor: creamWhite,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppHeader(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: beigeColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.magnifyingGlass, color: primaryBrown, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(
                                color: primaryBrown,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Buscar...',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => showFilterBottomSheet(context),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: greenBg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: FaIcon(FontAwesomeIcons.filter, color: creamWhite, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Search History
            const Divider(height: 2, color: primaryOrange, thickness: 2),
            ...searchProvider.searchHistory.map((item) {
              return Column(
                children: [
                  _buildSearchHistoryItem(item, primaryBrown),
                  const Divider(height: 2, color: primaryOrange, thickness: 2),
                ],
              );
            }).toList(),
            const SizedBox(height: 24),

            // TUS FAVORITOS
            const Text(
              'TUS FAVORITOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bernoru',
                color: primaryBrown,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              color: greenBg,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEmptyBox(),
                  _buildEmptyBox(),
                  _buildEmptyBox(),
                  _buildEmptyBox(),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // LOS MAS QUERIDOS
            const Text(
              'LOS MAS QUERIDOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bernoru',
                color: primaryBrown,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: restaurantProvider.favoriteRestaurants.take(2).map((rest) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RestaurantCard(
                      name: rest['name'], 
                      type: rest['type'] ?? '', 
                      rating: rest['rating'],
                      imageUrl: rest['imageUrl'],
                      cardColor: rest['cardColor'] ?? Colors.white,
                      isSavedStyle: true,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // PROMOS
            const Text(
              'PROMOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bernoru',
                color: primaryBrown,
                fontSize: 42,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: primaryOrange,
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                children: searchProvider.promos.map((promo) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Image.asset(promo, fit: BoxFit.contain),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            CarouselIndicator(
              itemCount: 8,
              currentIndex: -1,
              activeColor: greenBg.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 24),

            // DESCUBRE
            const Text(
              'DESCUBRE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bernoru',
                color: primaryBrown,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: restaurantProvider.discoverRestaurants.take(2).map((rest) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RestaurantCard(
                      name: rest['name'], 
                      type: rest['type'] ?? '', 
                      rating: rest['rating'],
                      imageUrl: rest['imageUrl'],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
