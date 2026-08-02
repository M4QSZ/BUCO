import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/review_carousel.dart';
import 'settings_menu_screen.dart';
import 'map/map_screen.dart';

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
                'assets/media/a12df1_asset_53.svg', // Logo BUCO con ubicación
                height: 50,
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
            // Banner Principal
            Container(
              height: 220,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/media/392bec_asset_31.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildPaginationDots(greenBg),
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
            const SizedBox(height: 16),
            _buildPaginationDots(greenBg),
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
                  SizedBox(
                    height: 260,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      children: const [
                        RestaurantCard(
                          name: 'BURGER KING', 
                          type: '', 
                          rating: 4.5, 
                          isSavedStyle: true,
                          imageUrl: 'assets/media/f1a2d7_burger_kin.svg',
                          cardColor: Colors.white,
                        ),
                        SizedBox(width: 24), // Añadido para recuperar el espacio
                        RestaurantCard(
                          name: "McDonald's", 
                          type: '', 
                          rating: 4.0, 
                          isSavedStyle: true,
                          imageUrl: 'assets/media/c75819_mcdonalds.svg',
                          cardColor: Color(0xFFDA291C),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPaginationDots(Colors.white),
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
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildColorBox(Colors.red),
                  const SizedBox(width: 16),
                  _buildColorBox(greenBg),
                  const SizedBox(width: 16),
                  _buildColorBox(primaryOrange),
                  const SizedBox(width: 16),
                  _buildColorBox(const Color(0xFFF2BF4A)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Puntitos de paginación para Descubre
            _buildPaginationDots(greenBg),
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

  Widget _buildColorBox(Color color) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildPaginationDots(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(9, (index) {
        bool isEdge = index == 0 || index == 8;
        return Container(
          width: isEdge ? 15.0 : 30.0,
          height: 4.0,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
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

  final List<Map<String, String>> categories = [
    {'title': 'PASTAS', 'image': 'assets/media/pasta-pomodoro.png'},
    {'title': 'SUSHI', 'image': 'assets/media/sushi-california.png'},
    {'title': 'POSTRES', 'image': 'assets/media/cupcake.png'},
    {'title': 'PIZZAS', 'image': 'assets/media/dinamica-rebanada-pizza-pepperoni-salpicaduras-salsa.png'},
    {'title': 'BURGER', 'image': 'assets/media/hamburguesa.png'},
    {'title': 'ENSALADA', 'image': 'assets/media/ensalada.png'},
    {'title': 'CARNES', 'image': 'assets/media/carne-ribeye.png'},
    {'title': 'POLLO', 'image': 'assets/media/pollo-frito.png'},
    {'title': 'POKE', 'image': 'assets/media/poke-bowl.png'},
    {'title': 'CAFÉ', 'image': 'assets/media/cafe-frio.png'},
    {'title': 'ALITAS', 'image': 'assets/media/alitas-buffalo.png'},
    {'title': 'DONAS', 'image': 'assets/media/dona.png'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);
    
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
                    return Column(
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

  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'LUCCA', 
      'type': 'Italiana', 
      'rating': 4.5,
      'imageUrl': 'assets/media/27281c_asset_35.png',
    },
    {
      'name': 'GIORGIO\'S', 
      'type': 'Italiana', 
      'rating': 4.0,
      'imageUrl': 'assets/media/39d88b_asset_34.png',
    },
    {
      'name': 'NAPOLI', 
      'type': 'Pizzas', 
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'LOS AÑOS LOCOS', 
      'type': 'Carnes', 
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
    },
    // Duplicados
    {
      'name': 'LUCCA', 
      'type': 'Italiana', 
      'rating': 4.5,
      'imageUrl': 'assets/media/27281c_asset_35.png',
    },
    {
      'name': 'GIORGIO\'S', 
      'type': 'Italiana', 
      'rating': 4.0,
      'imageUrl': 'assets/media/39d88b_asset_34.png',
    },
    {
      'name': 'NAPOLI', 
      'type': 'Pizzas', 
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
    },
    {
      'name': 'LOS AÑOS LOCOS', 
      'type': 'Carnes', 
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
    },
  ];

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
        // MediaQuery para obtener el ancho
        // itemWidth = MediaQuery.of(context).size.width / 2 - 24; (aproximadamente)
        // separator = 16
        // nextScroll = currentScroll + cardWidthWithSpacing;
        // Pero sin context seguro en el timer (aunque se puede usar), mejor calculamos genéricamente
        // o animamos de a poco
        double cardWidthWithSpacing = (MediaQuery.of(context).size.width / 2) - 8.0; 
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
            _scrollController.animateTo(
              nextScroll,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            _currentIndex = 0;
          }
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
    return SizedBox(
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
          return RestaurantCard(
            name: rest['name'],
            type: rest['type'],
            rating: rest['rating'],
            imageUrl: rest['imageUrl'],
          );
        },
      ),
    );
  }
}
