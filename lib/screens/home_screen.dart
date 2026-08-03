import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/review_carousel.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/custom_app_header.dart';
import 'map/map_screen.dart';
import '../widgets/auto_scroll_restaurant_carousel.dart';
import '../widgets/auto_scroll_discover_carousel.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/carousel_indicator.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

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
            // Banner Principal
            const _BannerCarousel(
              banners: [
                'assets/media/392bec_asset_31.png',
                'assets/media/2.png',
                'assets/media/2323.png',
                'assets/media/3.png',
                'assets/media/4.png',
                'assets/media/5e48b5818af0117f322d7c4ae77977a8.png',
                'assets/media/experimenta-lo-mejor333.png',
              ],
            ),
            const SizedBox(height: 16),
            
            _CategoryCarousel(),
            const SizedBox(height: 24),

            // Los más queridos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'LOS MAS QUERIDOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Bernoru',
                  color: primaryBrown,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const _MostLovedCarousel(),
            const SizedBox(height: 24),

            // Tus Favoritos
            Container(
              color: greenBg,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'TUS FAVORITOS',
                      style: TextStyle(
                        fontFamily: 'Bernoru',
                        color: creamWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<RestaurantProvider>(
                    builder: (context, restaurantProvider, child) {
                      return AutoScrollRestaurantCarousel(
                        restaurants: restaurantProvider.favoriteRestaurants,
                        indicatorActiveColor: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Descubre
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'DESCUBRE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Bernoru',
                  color: primaryBrown,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<RestaurantProvider>(
              builder: (context, restaurantProvider, child) {
                return AutoScrollDiscoverCarousel(
                  restaurants: restaurantProvider.discoverRestaurants,
                  indicatorActiveColor: greenBg,
                );
              },
            ),
            const SizedBox(height: 32),

            // Review final
            const ReviewCarousel(
              reviews: [
                {'text': '"Muy buena comida!!"', 'icon': 'assets/media/c75819_mcdonalds.svg'},
                {'text': '"Excelente servicio!!"', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
                {'text': '"Llegó súper rápido!"', 'icon': 'assets/media/c75819_mcdonalds.svg'},
                {'text': '"La mejor hamburguesa"', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
                {'text': '"Siempre calientito"', 'icon': 'assets/media/c75819_mcdonalds.svg'},
                {'text': '"Muy amables al entregar"', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
                {'text': '"Todo perfecto, gracias"', 'icon': 'assets/media/c75819_mcdonalds.svg'},
                {'text': '"Súper recomendado"', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
                {'text': '"Buenísimo el sabor"', 'icon': 'assets/media/c75819_mcdonalds.svg'},
                {'text': '"Volveré a pedir seguro"', 'icon': 'assets/media/f1a2d7_burger_kin.svg'},
                {'text': '"El mejor restaurante"', 'icon': 'assets/media/c75819_mcdonalds.svg'},
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

// _buildCategory removed

  Widget _buildDot(bool isActive, {Color color = const Color(0xFFF8EDDB)}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }




}

class _CategoryCarousel extends StatefulWidget {
  const _CategoryCarousel({Key? key}) : super(key: key);

  @override
  State<_CategoryCarousel> createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<_CategoryCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);
    
    final categories = context.watch<HomeProvider>().categories;
    // Calcula cuántas páginas hay (4 ítems por página)
    int pageCount = (categories.length / 4).ceil();

    return Container(
      color: greenBg,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 130, // Aumentado para que no se corte la imagen sobresaliente
            child: PageView.builder(
              clipBehavior: Clip.none, // Evita que PageView corte lo que sobresale
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: pageCount,
              itemBuilder: (context, pageIndex) {
                int startIndex = pageIndex * 4;
                int endIndex = (startIndex + 4 > categories.length)
                    ? categories.length
                    : startIndex + 4;
                
                List<Map<String, String>> pageItems =
                    categories.sublist(startIndex, endIndex);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: pageItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(categoryTitle: item['title']!),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: creamWhite,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                Positioned(
                                  top: -20, // Sobresale más
                                  bottom: -10,
                                  left: -20,
                                  right: -20,
                                  child: Image.asset(
                                    item['image']!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 70,
                            child: FittedBox(
                              fit: BoxFit.scaleDown, // Achica la letra si no cabe
                              child: Text(
                                item['title']!,
                                textAlign: TextAlign.center,
                                maxLines: 2, // Permite 2 líneas si aun así necesita bajar
                                style: const TextStyle(
                                  fontFamily: 'Bernoru',
                                  color: Color(0xFFF2BF4A),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11, // Tamaño base
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (_currentIndex > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: SvgPicture.asset(
                  'assets/media/91ea5f_pagination_arrow.svg',
                  height: 20,
                  colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                ),
              ),
              Row(
                children: List.generate(
                  pageCount,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 10 : 8,
                    height: _currentIndex == index ? 10 : 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? creamWhite : creamWhite.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_currentIndex < pageCount - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Transform.flip(
                  flipX: true,
                  child: SvgPicture.asset(
                    'assets/media/91ea5f_pagination_arrow.svg',
                    height: 20,
                    colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class _MostLovedCarousel extends StatefulWidget {
  const _MostLovedCarousel({Key? key}) : super(key: key);

  @override
  State<_MostLovedCarousel> createState() => _MostLovedCarouselState();
}

class _MostLovedCarouselState extends State<_MostLovedCarousel> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startTimer();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      double cardWidthWithSpacing = (MediaQuery.of(context).size.width / 2) - 8.0;
      if (cardWidthWithSpacing > 0) {
        int newIndex = (_scrollController.position.pixels / cardWidthWithSpacing).round();
        if (newIndex != _currentIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        }
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double cardWidthWithSpacing = (MediaQuery.of(context).size.width / 2) - 8.0; 
        double nextScroll = currentScroll + cardWidthWithSpacing;
        
        if (nextScroll > maxScroll || (maxScroll - currentScroll) < 10) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 500),
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
    final restaurants = context.watch<HomeProvider>().mostLovedRestaurants;
    int columnsCount = (restaurants.length / 2).ceil();
    // Usually only columnsCount - 1 steps are needed to reach the end if 2 columns are visible, 
    // but to keep it simple, we show dots for each scrollable column step.
    int indicatorCount = columnsCount > 1 ? columnsCount - 1 : 1; 
    
    // Safety bound for currentIndex to avoid out-of-range errors in the indicator
    int displayIndex = _currentIndex;
    if (displayIndex >= indicatorCount) {
      displayIndex = indicatorCount - 1;
    }
    if (displayIndex < 0) {
      displayIndex = 0;
    }

    return Column(
      children: [
        SizedBox(
          height: 440, // 2 filas de tarjetas + espaciado
          child: GridView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: restaurants.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 tarjetas de alto
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.1, // Ajuste para que las tarjetas se vean bien
            ),
            itemBuilder: (context, index) {
              final rest = restaurants[index];
              final restaurantProvider = context.watch<RestaurantProvider>();
              final restName = rest['name'] as String;
              return RestaurantCard(
                name: restName,
                type: rest['type'],
                rating: rest['rating'],
                imageUrl: rest['imageUrl'],
                isFavorite: restaurantProvider.isFavorite(restName),
                onFavoriteToggle: () => restaurantProvider.toggleFavorite(restName, data: rest),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        CarouselIndicator(
          itemCount: indicatorCount, 
          currentIndex: displayIndex, 
          activeColor: const Color(0xFF2E563B),
        ),
      ],
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  final List<String> banners;
  const _BannerCarousel({Key? key, required this.banners}) : super(key: key);

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentIndex + 1;
        if (nextPage >= widget.banners.length) {
          nextPage = 0;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
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
    return Column(
      children: [
        Container(
          height: 220,
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(widget.banners[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        CarouselIndicator(
          itemCount: widget.banners.length, 
          currentIndex: _currentIndex, 
          activeColor: const Color(0xFF2E563B),
        ),
      ],
    );
  }
}

