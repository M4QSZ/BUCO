import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main_layout.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/carousel_indicator.dart';

import 'restaurant_detail/restaurant_header_image.dart';
import 'restaurant_detail/restaurant_info_card.dart';
import 'restaurant_detail/restaurant_leave_review_section.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantName;
  final String? logoImage;
  final String? type;
  final double? rating;
  const RestaurantDetailScreen({super.key, required this.restaurantName, this.logoImage, this.type, this.rating});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool isDetailsSelected = true;
  late PageController _pageController;
  late PageController _imageSliderController;
  Timer? _timer;
  int _currentCommentPage = 0;
  int _currentImageSliderPage = 0;

  Future<void> _launchWhatsApp(String? phone) async {
    // Si no tiene teléfono en la base de datos o el mock, inventamos uno por defecto de Panamá.
    final String targetPhone = (phone != null && phone.toString().trim().isNotEmpty) ? phone.toString() : "50760000000";
    String cleanPhone = targetPhone.replaceAll(RegExp(r'[^\d]'), '');
    final Uri whatsappUrl = Uri.parse("https://wa.me/$cleanPhone");
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp.')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _imageSliderController = PageController(initialPage: 0);
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
    _imageSliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color beigeColor = Color(0xFFDCC8B2);
    const Color greenBg = Color(0xFF2E563B);

    final restaurantProvider = context.watch<RestaurantProvider>();
    final userProvider = Provider.of<UserProvider>(context);
    
    final restaurantDetails = restaurantProvider.getDetailsFor(widget.restaurantName);
    
    // Lista de imágenes para el slider
    List<String> sliderImages = [];
    if (restaurantDetails.containsKey('sliderImages') && restaurantDetails['sliderImages'] != null) {
      sliderImages = List<String>.from(restaurantDetails['sliderImages']);
    } else {
      // Fallback
      sliderImages = [restaurantDetails['headerImage'] ?? 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&auto=format&fit=crop'];
    }
    final reviews = restaurantProvider.getReviewsFor(widget.restaurantName);

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
                RestaurantHeaderImage(
                  headerImage: restaurantDetails['headerImage'],
                  logoImage: widget.logoImage ?? restaurantDetails['logoImage'],
                ),
                const SizedBox(height: 20),
                
                // Fila de Info (Nombre, Calificación, Icono User)
                RestaurantInfoCard(
                  name: restaurantDetails['name'],
                  type: widget.type != null && widget.type!.isNotEmpty ? widget.type! : restaurantDetails['type'],
                  rating: widget.rating ?? (restaurantDetails['rating'] as num).toDouble(),
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
                      GestureDetector(
                        onTap: () async {
                          final menuLink = restaurantDetails['menuLink'];
                          if (menuLink != null && menuLink.toString().isNotEmpty) {
                            final Uri menuUrl = Uri.parse(menuLink);
                            if (await canLaunchUrl(menuUrl)) {
                              await launchUrl(menuUrl, mode: LaunchMode.externalApplication);
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('No se pudo abrir el menú.')),
                                );
                              }
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Este local no tiene menú disponible.')),
                              );
                            }
                          }
                        },
                        child: SvgPicture.asset(
                          'assets/media/a91996_asset_32.svg', 
                          width: 28,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ),
                      ), // Menú SVG
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => _launchWhatsApp(restaurantDetails['phone']),
                        child: SvgPicture.asset(
                          'assets/media/f92c0e_asset_33.svg', 
                          width: 24,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ), // Teléfono SVG
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                if (isDetailsSelected) ...[
                  // Texto descriptivo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      restaurantDetails['description'] ?? '',
                      style: const TextStyle(
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
                    height: 200,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentCommentPage = page;
                        });
                      },
                      children: reviews.map((review) => Padding(
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
                  CarouselIndicator(
                    itemCount: reviews.length,
                    currentIndex: _currentCommentPage,
                    activeColor: greenBg,
                  ),
                  const SizedBox(height: 20),
                ],

                // Imagen del local con barra naranja de navegación superpuesta y puntos
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // PageView para el slider de imágenes
                      PageView.builder(
                        controller: _imageSliderController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageSliderPage = index;
                          });
                        },
                        itemCount: sliderImages.length,
                        itemBuilder: (context, index) {
                          String imagePath = sliderImages[index];
                          bool isNetwork = imagePath.startsWith('http');
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              image: DecorationImage(
                                image: isNetwork 
                                    ? NetworkImage(imagePath) as ImageProvider 
                                    : AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
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
                            GestureDetector(
                              onTap: () {
                                if (_currentImageSliderPage > 0) {
                                  _imageSliderController.previousPage(
                                    duration: const Duration(milliseconds: 300), 
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/media/91ea5f_pagination_arrow.svg',
                                height: 14,
                                colorFilter: ColorFilter.mode(
                                  _currentImageSliderPage > 0 ? Colors.white : Colors.white54, 
                                  BlendMode.srcIn
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: List.generate(
                                sliderImages.length,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: index == _currentImageSliderPage ? Colors.white : Colors.white54,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                if (_currentImageSliderPage < sliderImages.length - 1) {
                                  _imageSliderController.nextPage(
                                    duration: const Duration(milliseconds: 300), 
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Transform.flip(
                                flipX: true,
                                child: SvgPicture.asset(
                                  'assets/media/91ea5f_pagination_arrow.svg',
                                  height: 14,
                                  colorFilter: ColorFilter.mode(
                                    _currentImageSliderPage < sliderImages.length - 1 ? Colors.white : Colors.white54, 
                                    BlendMode.srcIn
                                  ),
                                ),
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
                CarouselIndicator(
                  itemCount: reviews.length,
                  currentIndex: _currentCommentPage,
                  activeColor: greenBg.withValues(alpha: 0.8),
                ),
                const SizedBox(height: 20),

                
                // Sección DEJA TU OPINIÓN (Siempre visible)
                RestaurantLeaveReviewSection(
                  initialRating: 5.0,
                  onSubmit: (rating, comment) {
                    restaurantProvider.addReview(
                      widget.restaurantName,
                      userProvider.userName,
                      comment,
                      rating,
                    );
                    setState(() {
                      isDetailsSelected = false; // Cambiar a la pestaña de reviews
                    });
                  },
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
