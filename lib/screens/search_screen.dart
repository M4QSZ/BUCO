import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/user_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/custom_app_header.dart';
import 'search/search_filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchResults(RestaurantProvider restaurantProvider) {
    final results = restaurantProvider.searchRestaurants(_searchQuery);
    if (results.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Text(
            'No se encontraron resultados.',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF662715),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 170 / 250, // Proporción de la tarjeta en estilo Favoritos
        ),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final rest = results[index];
          final restName = rest['name'] as String;
          return RestaurantCard(
            name: restName,
            type: rest['type'] ?? '',
            rating: (rest['rating'] as num).toDouble(),
            imageUrl: rest['logoImage'] ?? rest['headerImage'] ?? rest['imageUrl'],
            cardColor: rest['cardColor'] ?? Colors.white,
            isSavedStyle: true,
            isFavorite: restaurantProvider.isFavorite(restName),
            onFavoriteToggle: () => restaurantProvider.toggleFavorite(restName, data: rest),
          );
        },
      ),
    );
  }

  Widget _buildLogoItem(Map<String, dynamic> restaurant) {
    final color = restaurant['cardColor'] as Color? ?? Colors.white;
    final imageUrl = restaurant['imageUrl'] as String? ?? '';

    return GestureDetector(
      onTap: () {
        // Navigate to restaurant detail
        Navigator.pushNamed(context, '/restaurant-detail', arguments: restaurant);
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildLogo(imageUrl),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(String imageUrl) {
    if (imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imageUrl,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        imageUrl,
        fit: BoxFit.contain,
      );
    }
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
                              controller: _searchController,
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
            
            if (_searchQuery.isNotEmpty)
              _buildSearchResults(restaurantProvider)
            else ...[
              // Search History
            const Divider(height: 2, color: primaryOrange, thickness: 2),
            ...searchProvider.searchHistory.map((item) {
              return Column(
                children: [
                  _buildSearchHistoryItem(item, primaryBrown),
                  const Divider(height: 2, color: primaryOrange, thickness: 2),
                ],
              );
            }),
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
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: restaurantProvider.favoriteRestaurants.length,
                  itemBuilder: (context, index) {
                    final rest = restaurantProvider.favoriteRestaurants[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == restaurantProvider.favoriteRestaurants.length - 1 ? 0 : 16.0,
                      ),
                      child: _buildLogoItem(rest),
                    );
                  },
                ),
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
                children: context.read<HomeProvider>().mostLovedRestaurants.take(2).map((rest) {
                  final restName = rest['name'] as String;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RestaurantCard(
                      name: restName, 
                      type: rest['type'] ?? '', 
                      rating: (rest['rating'] as num).toDouble(),
                      imageUrl: rest['imageUrl'] ?? rest['logoImage'],
                      cardColor: rest['cardColor'] ?? Colors.white,
                      isSavedStyle: true,
                      isFavorite: restaurantProvider.isFavorite(restName),
                      onFavoriteToggle: () => restaurantProvider.toggleFavorite(restName, data: rest),
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
              height: 260, // Aumentar un poco la altura para que encaje bien la tarjeta con su estilo saved
              child: ListView(
                clipBehavior: Clip.none, // Permitir que la imagen que sale de la tarjeta no se corte
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 45, right: 20), // Más padding a la izq por la imagen
                children: restaurantProvider.discoverRestaurants.take(2).map((rest) {
                  final restName = rest['name'] as String;
                  return Padding(
                    padding: const EdgeInsets.only(right: 24.0), // Mismo spacing que el carousel
                    child: RestaurantCard(
                      name: restName, 
                      type: rest['type'] ?? '', 
                      rating: (rest['rating'] as num).toDouble(),
                      imageUrl: rest['imageUrl'],
                      cardColor: rest['cardColor'],
                      isSavedStyle: true,
                      isFavorite: restaurantProvider.isFavorite(restName),
                      onFavoriteToggle: () => restaurantProvider.toggleFavorite(restName, data: rest),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
            ], // Close the else ...[ array here
          ],
        ),
      ),
    );
  }
}
