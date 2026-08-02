import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main_layout.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool isDetailsSelected = true;
  double _selectedStars = 5.0;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, String>> _reviews = [
    {'name': 'Andrés Velasco', 'text': '"Muy buena comida !!"', 'rating': '4.5'},
    {'name': 'María López', 'text': '"Excelente servicio y rapidez"', 'rating': '5.0'},
    {'name': 'Carlos Díaz', 'text': '"Recomendado al 100%"', 'rating': '4.8'},
    {'name': 'Ana Silva', 'text': '"El mejor lugar de la ciudad"', 'rating': '5.0'},
    {'name': 'Luis Gómez', 'text': '"Sabor increíble"', 'rating': '4.7'},
    {'name': 'Sofía Ortiz', 'text': '"Volveré pronto"', 'rating': '4.9'},
    {'name': 'Diego Cruz', 'text': '"Buena atención"', 'rating': '4.2'},
    {'name': 'Elena Paz', 'text': '"Me encantó el ambiente"', 'rating': '4.6'},
  ];

  late PageController _pageController;
  Timer? _timer;
  int _currentCommentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!isDetailsSelected && _pageController.hasClients) {
        int nextPage = _currentCommentPage + 1;
        if (nextPage >= 8) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color beigeColor = Color(0xFFDCC8B2);
    const Color greenBg = Color(0xFF2E563B);

    Widget buildInteractiveStar(int index) {
      double starValue = index + 1.0;
      return GestureDetector(
        onTapDown: (details) {
          if (details.localPosition.dx < 16) {
            setState(() {
              _selectedStars = index + 0.5;
            });
          } else {
            setState(() {
              _selectedStars = index + 1.0;
            });
          }
        },
        child: SizedBox(
          width: 32,
          height: 32,
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/media/5968f1_star_custom.svg',
                height: 32,
                width: 32,
                colorFilter: ColorFilter.mode(creamWhite.withValues(alpha: 0.3), BlendMode.srcIn),
              ),
              if (_selectedStars > index)
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: _selectedStars >= starValue ? 1.0 : 0.5,
                    child: SvgPicture.asset(
                      'assets/media/5968f1_star_custom.svg',
                      height: 32,
                      width: 32,
                      colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: creamWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // Padding to avoid navbar overlap
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cabecera Naranja con logo gigante
                SizedBox(
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
                              onTap: () {
                                // Podrías navegar a SettingsMenuScreen aquí si lo deseas
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
                ),
                const SizedBox(height: 20),
                
                // Fila de Info (Nombre, Calificación, Icono User)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: primaryBrown,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'BURGER\nKING',
                                      style: TextStyle(
                                        fontFamily: 'Bernoru',
                                        color: creamWhite,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Hamburguesas - Comida rápida',
                                      style: TextStyle(
                                        color: creamWhite,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset('assets/media/8d6e5a_fav_sin_marcar.svg', width: 28, colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2BF4A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              '4.5',
                              style: TextStyle(
                                fontFamily: 'Bernoru',
                                color: creamWhite,
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                            color: primaryBrown,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: SvgPicture.asset('assets/media/b5e1db_perfil.svg', width: 32, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Fila de Botones (Detalles, Reviews, Menu, Phone)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDetailsSelected = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDetailsSelected ? primaryBrown : beigeColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            'DETALLES',
                            style: TextStyle(
                              fontFamily: 'Bernoru',
                              color: creamWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDetailsSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: !isDetailsSelected ? primaryBrown : beigeColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            'REVIEWS',
                            style: TextStyle(
                              fontFamily: 'Bernoru',
                              color: creamWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/media/a91996_asset_32.svg', 
                        width: 28,
                        colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                      ), // Menú SVG
                      const SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/media/f92c0e_asset_33.svg', 
                        width: 24,
                        colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                      ), // Teléfono SVG
                    ],
                  ),
                ),
                const SizedBox(height: 20),



                if (isDetailsSelected) ...[
                  // Texto descriptivo
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      '¡Bienvenido a Burger King, el hogar original del Whopper! Disfruta de nuestras clásicas hamburguesas a la parrilla, preparadas con ingredientes frescos y de la mejor calidad. Contamos con un ambiente familiar, servicio rápido y promociones increíbles todos los días. Ven a saborear la experiencia que nos hace únicos y descubre por qué somos tu mejor opción para disfrutar de comida rápida con un sabor auténtico.',
                      style: TextStyle(
                        color: primaryBrown,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                ] else ...[
                  // Sección de Reseña de Usuario
                  SizedBox(
                    height: 135,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentCommentPage = page;
                        });
                      },
                      children: _reviews.map((review) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: greenBg,
                                  child: SvgPicture.asset('assets/media/b5e1db_perfil.svg', width: 30, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  review['name']!,
                                  style: const TextStyle(
                                    fontFamily: 'Bernoru',
                                    color: primaryBrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6C844), // Yellow
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    review['rating']!,
                                    style: const TextStyle(
                                      fontFamily: 'Bernoru',
                                      color: creamWhite,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              decoration: BoxDecoration(
                                color: primaryBrown,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                review['text']!,
                                style: const TextStyle(
                                  fontFamily: 'Bernoru',
                                  color: creamWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Paginación (línea verde)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(8, (index) {
                      bool isEdge = index == 0 || index == 7;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isEdge ? 15.0 : 30.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: _currentCommentPage == index ? greenBg : greenBg.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                ],

                // Imagen del local con barra naranja de navegación superpuesta y puntos
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Imagen de fondo
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&auto=format&fit=crop'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Degradado negro en la parte inferior para que se vean los puntos
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87],
                            ),
                          ),
                        ),
                      ),
                      // Paginación de imagen
                      Positioned(
                        bottom: 8,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/media/91ea5f_pagination_arrow.svg',
                              height: 14,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: List.generate(
                                11,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: index == 0 ? Colors.white : Colors.white54,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Transform.flip(
                              flipX: true,
                              child: SvgPicture.asset(
                                'assets/media/91ea5f_pagination_arrow.svg',
                                height: 14,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Título PROMOS
                const Center(
                  child: Text(
                    'PROMOS',
                    style: TextStyle(
                      fontFamily: 'Bernoru',
                      color: primaryBrown,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 3 Imágenes de Promo con fondo naranja
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
                const SizedBox(height: 20),

                // Separador Punteado Mejorado (Dashes)
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
                const SizedBox(height: 20),

                
                // Sección DEJA TU OPINIÓN (Siempre visible)
                Container(
                  color: greenBg,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                  child: Column(
                    children: [
                      const Text(
                        'DEJA TU OPINIÓN',
                        style: TextStyle(
                          fontFamily: 'Bernoru',
                          color: creamWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Row(
                            children: [
                              buildInteractiveStar(index),
                              if (index < 4) const SizedBox(width: 8),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: creamWhite,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _commentController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            hintText: 'Escribe tu comentario aquí...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Bernoru',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_selectedStars > 0 && _commentController.text.isNotEmpty) {
                            setState(() {
                              _reviews.insert(0, {
                                'name': 'Tú',
                                'text': '"${_commentController.text}"',
                                'rating': _selectedStars.toString(),
                              });
                              _selectedStars = 5.0;
                              _commentController.clear();
                              isDetailsSelected = false; // Cambiar a la pestaña de reviews
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        child: const Text(
                          'ENVIAR',
                          style: TextStyle(
                            fontFamily: 'Bernoru',
                            color: creamWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          
          // Barra de Navegación Flotante (estilo píldora como en el resto de la app)
          Positioned(
            left: 20,
            right: 20,
            bottom: 24, // Distancia desde el fondo
            child: Container(
              height: 70, // Grosor de la píldora
              decoration: BoxDecoration(
                color: primaryOrange, // Naranja vibrante
                borderRadius: BorderRadius.circular(50), // Redondeado perfecto (Píldora)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Ícono HOME seleccionado (crema)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainLayout(initialIndex: 0)),
                        (route) => false,
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SvgPicture.asset(
                        'assets/media/80352c_home.svg',
                        height: 24,
                        colorFilter: const ColorFilter.mode(Color(0xFFF8EDDB), BlendMode.srcIn),
                      ),
                    ),
                  ),
                  // Ícono SEARCH (marrón base)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainLayout(initialIndex: 1)),
                        (route) => false,
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SvgPicture.asset(
                        'assets/media/e13312_search.svg',
                        height: 24,
                        colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  // Ícono FAV (marrón base)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainLayout(initialIndex: 2)),
                        (route) => false,
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SvgPicture.asset(
                        'assets/media/59675c_fav.svg',
                        height: 24,
                        colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  // Ícono PERFIL (marrón base)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainLayout(initialIndex: 3)),
                        (route) => false,
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SvgPicture.asset(
                        'assets/media/b5e1db_perfil.svg',
                        height: 24,
                        colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
