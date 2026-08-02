import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    return Scaffold(
      backgroundColor: creamWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            // Cabecera Naranja
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
                              MaterialPageRoute(builder: (context) => const SettingsMenuScreen(userName: 'Andrés Velasco')),
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
                  
                  // Perfil simplificado
                  SvgPicture.asset(
                    'assets/media/8c491b_profile_icon.svg',
                    width: 76,
                    height: 76,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Andrés Velasco',
                    style: TextStyle(
                      color: primaryBrown,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    '¡¡hola!!',
                    style: TextStyle(
                      color: primaryBrown,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Contador de Favoritos
                  const Column(
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                          color: creamWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 48,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        'FAVORITOS',
                        style: TextStyle(
                          color: primaryBrown,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Icono de guardado gigante
            SvgPicture.asset(
              'assets/media/59675c_fav.svg',
              width: 35,
              colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
            ),
            const SizedBox(height: 30),

            // Lista de restaurantes (Tus Favoritos)
            const _RestaurantCardsCarousel(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _RestaurantCardsCarousel extends StatefulWidget {
  const _RestaurantCardsCarousel({Key? key}) : super(key: key);

  @override
  State<_RestaurantCardsCarousel> createState() => _RestaurantCardsCarouselState();
}

class _RestaurantCardsCarouselState extends State<_RestaurantCardsCarousel> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  bool _isUserScrolling = false;

  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'BURGER KING',
      'rating': 4.5,
      'imageUrl': 'assets/media/f1a2d7_burger_kin.svg',
      'cardColor': Colors.white,
    },
    {
      'name': "McDonald's",
      'rating': 4.0,
      'imageUrl': 'assets/media/c75819_mcdonalds.svg',
      'cardColor': const Color(0xFFDA291C),
    },
    {
      'name': "Carl's Jr",
      'rating': 4.3,
      'imageUrl': 'assets/media/logo_carlsjr.png',
      'cardColor': const Color(0xFFE21A22),
    },
    {
      'name': "Little Caesars",
      'rating': 3.9,
      'imageUrl': 'assets/media/logo_littlecaesars.png',
      'cardColor': const Color(0xFFFF6600),
    },
    {
      'name': "Domino's Pizza",
      'rating': 4.2,
      'imageUrl': 'assets/media/logo_dominos.png',
      'cardColor': const Color(0xFF0055A5),
    },
    {
      'name': "KFC",
      'rating': 4.1,
      'imageUrl': 'assets/media/logo_kfc.svg',
      'cardColor': const Color(0xFFE4002B),
    },
    {
      'name': "Subway",
      'rating': 4.0,
      'imageUrl': 'assets/media/logo_subway.png',
      'cardColor': const Color(0xFF008938),
    },
    {
      'name': "Pío Pío",
      'rating': 4.6,
      'imageUrl': 'assets/media/logo_piopio.png',
      'cardColor': const Color(0xFFF0531C), // Naranja Pío Pío
    },
    {
      'name': "Don Lee",
      'rating': 4.4,
      'imageUrl': 'assets/media/logo_donlee.png',
      'cardColor': const Color(0xFFC00A27),
    },
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_scrollController.hasClients && !_isUserScrolling) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double cardWidthWithSpacing = 170.0 + 24.0; 
        double nextScroll = currentScroll + cardWidthWithSpacing;
        
        if (nextScroll > maxScroll) {
          nextScroll = 0;
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color greenBg = Color(0xFF2E563B);

    return Column(
      children: [
        SizedBox(
          height: 260,
          child: Listener(
            onPointerDown: (_) => _isUserScrolling = true,
            onPointerUp: (_) => _isUserScrolling = false,
            onPointerCancel: (_) => _isUserScrolling = false,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  int newIndex = (_scrollController.offset / (170.0 + 24.0)).round();
                  if (newIndex < 0) newIndex = 0;
                  if (newIndex >= restaurants.length) newIndex = restaurants.length - 1;
                  
                  if (newIndex != _currentIndex) {
                    setState(() {
                      _currentIndex = newIndex;
                    });
                  }
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 45),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: index == restaurants.length - 1 ? 0 : 24.0),
                    child: RestaurantCard(
                      name: restaurants[index]['name'],
                      type: '',
                      rating: restaurants[index]['rating'],
                      isSavedStyle: true,
                      imageUrl: restaurants[index]['imageUrl'],
                      cardColor: restaurants[index]['cardColor'],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(restaurants.length, (index) {
            bool isEdge = index == 0 || index == restaurants.length - 1;
            bool isActive = index == _currentIndex;
            return Container(
              width: isActive ? 35.0 : (isEdge ? 15.0 : 30.0),
              height: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isActive ? greenBg : greenBg.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
    );
  }
}
