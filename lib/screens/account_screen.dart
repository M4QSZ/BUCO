import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import 'settings_menu_screen.dart';
import '../services/auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _userName = 'Andrés Velasco';
  String _userDesc = '';

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
                                  MaterialPageRoute(builder: (context) => const SettingsMenuScreen()),
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
                                                _userName,
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
                                              onTap: () {
                                                _showEditProfileModal(context);
                                              },
                                              child: SvgPicture.asset(
                                                'assets/media/8eb9ad_asset_28.svg',
                                                width: 18,
                                                colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          AuthService().getCurrentUser()?['email'] ?? '¡¡hola!!',
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
                          Expanded(child: _buildStat('0', 'CALIFICACIONES')),
                          Expanded(child: _buildStat('0', 'FAVORITOS')),
                          Expanded(child: _buildStat('0', 'RESTAURANTES')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Tarjeta de reseña sobre el fondo verde (Carousel)
                const _ProfileReviewCarousel(),
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
                    'assets/media/59675c_fav.svg',
                    width: 35,
                    colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
                  ),
                  const SizedBox(height: 15),
                  const _RestaurantCardsCarousel(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
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

  void _showEditProfileModal(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);
    const Color primaryOrange = Color(0xFFF0531C);

    final TextEditingController nameController = TextEditingController(text: _userName);
    final TextEditingController descController = TextEditingController(text: _userDesc);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: primaryOrange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Foto de Perfil
              SvgPicture.asset(
                'assets/media/8c491b_profile_icon.svg',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 10),
              const Text(
                'Foto de Perfil',
                style: TextStyle(
                  color: primaryBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Nombre de Usuario
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.person, color: primaryBrown, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Nombre de Usuario',
                      style: TextStyle(
                        color: primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: creamWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Descripción
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.person, color: primaryBrown, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Descripción',
                      style: TextStyle(
                        color: primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: creamWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Botón CONTINUAR
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _userName = nameController.text;
                      _userDesc = descController.text;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'CONTINUAR',
                    style: TextStyle(
                      color: creamWhite,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileReviewCarousel extends StatefulWidget {
  const _ProfileReviewCarousel({Key? key}) : super(key: key);

  @override
  State<_ProfileReviewCarousel> createState() => _ProfileReviewCarouselState();
}

class _ProfileReviewCarouselState extends State<_ProfileReviewCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> reviews = [
    {
      'text': '“Muy buena comida!!”',
      'icon': 'assets/media/c75819_mcdonalds.svg', // Changed to McDonald's
    },
    {
      'text': '“Excelente servicio!!”',
      'icon': 'assets/media/f1a2d7_burger_kin.svg', 
    },
    {
      'text': '“Llegó súper rápido!”',
      'icon': 'assets/media/c75819_mcdonalds.svg',
    },
    {
      'text': '“La mejor hamburguesa”',
      'icon': 'assets/media/f1a2d7_burger_kin.svg',
    },
    {
      'text': '“Siempre calientito”',
      'icon': 'assets/media/c75819_mcdonalds.svg',
    },
    {
      'text': '“Muy amables al entregar”',
      'icon': 'assets/media/f1a2d7_burger_kin.svg',
    },
    {
      'text': '“Todo perfecto, gracias”',
      'icon': 'assets/media/c75819_mcdonalds.svg',
    },
    {
      'text': '“Súper recomendado”',
      'icon': 'assets/media/f1a2d7_burger_kin.svg',
    },
    {
      'text': '“Buenísimo el sabor”',
      'icon': 'assets/media/c75819_mcdonalds.svg',
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
      if (_currentIndex < reviews.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);

    return Column(
      children: [
        SizedBox(
          height: 120, // Suficiente altura para el texto y padding
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Container(
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
                      child: Text(
                        reviews[index]['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: creamWhite, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(
                        reviews[index]['icon']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(reviews.length, (index) {
            bool isEdge = index == 0 || index == reviews.length - 1;
            bool isActive = index == _currentIndex;
            return Container(
              width: isActive ? 35.0 : (isEdge ? 15.0 : 30.0),
              height: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
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
      'imageUrl': 'assets/media/logo_carlsjr.svg',
      'cardColor': const Color(0xFFE21A22),
    },
    {
      'name': "Little Caesars",
      'rating': 3.9,
      'imageUrl': 'assets/media/logo_littlecaesars.svg',
      'cardColor': const Color(0xFFFF6600),
    },
    {
      'name': "Domino's Pizza",
      'rating': 4.2,
      'imageUrl': 'assets/media/logo_dominos.svg',
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
      'imageUrl': 'assets/media/logo_subway.svg',
      'cardColor': const Color(0xFF008938),
    },
    {
      'name': "Pío Pío",
      'rating': 4.6,
      'imageUrl': 'assets/media/logo_piopio.svg',
      'cardColor': const Color(0xFFF0531C), // Naranja Pío Pío
    },
    {
      'name': "Don Lee",
      'rating': 4.4,
      'imageUrl': 'assets/media/logo_donlee.svg',
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
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double cardWidthWithSpacing = 170.0 + 24.0; 
        double nextScroll = currentScroll + cardWidthWithSpacing;
        
        if (nextScroll > maxScroll) {
          nextScroll = 0;
          _currentIndex = 0;
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          if (_currentIndex < restaurants.length - 1) {
            _currentIndex++;
          }
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
        setState(() {});
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

