import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';
import 'map/map_screen.dart';

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

  void _showFilterBottomSheet(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color beigeBgColor = Color(0xFFDBC19C);
    const Color greenBg = Color(0xFF2E563B);

    int currentPanel = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            if (currentPanel == 0) {
              // Green Panel (Main Filter Categories)
              return Container(
                decoration: const BoxDecoration(
                  color: greenBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top header bar
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: creamWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(FontAwesomeIcons.filter, color: primaryBrown, size: 24),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          _buildGreenPanelButton('Ordenar por', () {
                            setState(() {
                              currentPanel = 1;
                            });
                          }),
                          const SizedBox(height: 16),
                          _buildGreenPanelButton('Gastronomía', () {}),
                          const SizedBox(height: 16),
                          _buildGreenPanelButton('Horario', () {}),
                          const SizedBox(height: 16),
                          _buildGreenPanelButton('Calificaciones', () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              );
            } else {
              // Beige Panel (Ordenar por)
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cream Header
                    Container(
                      decoration: const BoxDecoration(
                        color: creamWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPanel = 0;
                              });
                            },
                            child: const FaIcon(FontAwesomeIcons.filter, color: primaryBrown, size: 36),
                          ),
                          const SizedBox(width: 24),
                          const Text(
                            'Ordenar por',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: primaryBrown,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Beige Body
                    Container(
                      color: beigeBgColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.start,
                            children: [
                              _buildFilterChip('Relevancia', true),
                              _buildFilterChip('Mas comentados', false),
                              _buildFilterChip('Más recientes', false),
                              _buildFilterChip('Recomendados', false),
                              _buildFilterChip('Recomendados', false),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Pagination Dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.arrow_back_ios_new, color: greenBg, size: 24),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(10, (index) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: Icon(Icons.circle, color: greenBg, size: 10),
                                  );
                                }),
                              ),
                              const Icon(Icons.arrow_forward_ios, color: greenBg, size: 24),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildFilterSquareBox(),
                              _buildFilterSquareBox(),
                              _buildFilterSquareBox(),
                              _buildFilterSquareBox(),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    decoration: BoxDecoration(
                                      color: creamWhite,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'RESTABLECER',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: primaryBrown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 5,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    decoration: BoxDecoration(
                                      color: primaryOrange,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'CONTINUAR',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: creamWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildGreenPanelButton(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF8EDDB),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xFF662715),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8EDDB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xFF662715),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFilterSquareBox() {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFFF8EDDB),
        borderRadius: BorderRadius.circular(16),
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
                  'assets/media/4f8e9a_asset_30.svg',
                  height: 28,
                  colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                ),
              ),
              SvgPicture.asset(
                'assets/media/a12df1_asset_53.svg',
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
                  'assets/media/3ff13c_menu_icon.svg',
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
                    onTap: () => _showFilterBottomSheet(context),
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
            _buildSearchHistoryItem('Burger', primaryBrown),
            const Divider(height: 2, color: primaryOrange, thickness: 2),
            _buildSearchHistoryItem('Mac donal', primaryBrown),
            const Divider(height: 2, color: primaryOrange, thickness: 2),
            _buildSearchHistoryItem('Pasta', primaryBrown),
            const Divider(height: 2, color: primaryOrange, thickness: 2),
            _buildSearchHistoryItem('Sushi', primaryBrown),
            const Divider(height: 2, color: primaryOrange, thickness: 2),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 200,
                child: Row(
                  children: const [
                    Expanded(
                      child: RestaurantCard(
                        name: 'LUCCA', 
                        type: 'Italiana', 
                        rating: 4.5,
                        imageUrl: 'assets/media/27281c_asset_35.png',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: RestaurantCard(
                        name: 'GIORGIO\'S', 
                        type: 'Italiana', 
                        rating: 4.0,
                        imageUrl: 'assets/media/39d88b_asset_34.png',
                      ),
                    ),
                  ],
                ),
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
                children: [
                  Expanded(
                    child: Image.asset('assets/media/300f20_asset_36.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Image.asset('assets/media/8bc92b_asset_37.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Image.asset('assets/media/7300fc_asset_38.png', fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (index) {
                bool isEdge = index == 0 || index == 7;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isEdge ? 15.0 : 30.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: greenBg.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 200,
                child: Row(
                  children: const [
                    Expanded(
                      child: RestaurantCard(
                        name: 'LUCCA', 
                        type: 'Italiana', 
                        rating: 4.5,
                        imageUrl: 'assets/media/27281c_asset_35.png',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: RestaurantCard(
                        name: 'GIORGIO\'S', 
                        type: 'Italiana', 
                        rating: 4.0,
                        imageUrl: 'assets/media/39d88b_asset_34.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
