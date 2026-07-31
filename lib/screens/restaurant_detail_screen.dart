import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main_layout.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color beigeColor = Color(0xFFDCC8B2);
    const Color greenBg = Color(0xFF2E563B);

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
                              'assets/icons/back_arrow.svg',
                              height: 28,
                              colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/Asset 52.svg',
                            height: 50,
                            colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Podrías navegar a SettingsMenuScreen aquí si lo deseas
                            },
                            child: SvgPicture.asset(
                              'assets/icons/menu_icon.svg', 
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
                        'assets/icons/burger_kin.svg',
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
                                Text(
                                  'BURGER\nKING',
                                  style: TextStyle(
                                    fontFamily: 'Bernoru',
                                    color: creamWhite,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    height: 1.1,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
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
                          SvgPicture.asset('assets/icons/FAV SIN MARCAR.svg', width: 28, colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn)),
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
                        child: SvgPicture.asset('assets/icons/PERFIL.svg', width: 32, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: primaryBrown,
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
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: beigeColor,
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
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/Asset 32.svg', 
                    width: 28,
                    colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                  ), // Menú SVG
                  const SizedBox(width: 16),
                  SvgPicture.asset(
                    'assets/icons/Asset 33.svg', 
                    width: 24,
                    colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                  ), // Teléfono SVG
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Texto descriptivo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem',
                style: TextStyle(
                  color: primaryBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),

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
                          'assets/icons/pagination_arrow.svg',
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
                            'assets/icons/pagination_arrow.svg',
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

            // 3 Imágenes de Promo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('assets/images/Asset 36.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Image.asset('assets/images/Asset 37.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Image.asset('assets/images/Asset 38.png', fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Separador Punteado
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 15,
                height: 3,
                color: greenBg.withValues(alpha: 0.5),
              )),
            ),
            const SizedBox(height: 20),

            // Sección DEJA TU OPINIÓN
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: creamWhite, size: 32),
                      SizedBox(width: 8),
                      Icon(Icons.star, color: creamWhite, size: 32),
                      SizedBox(width: 8),
                      Icon(Icons.star, color: creamWhite, size: 32),
                      SizedBox(width: 8),
                      Icon(Icons.star, color: creamWhite, size: 32),
                      SizedBox(width: 8),
                      Icon(Icons.star, color: creamWhite, size: 32),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: creamWhite,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sección de Reseña de Usuario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: greenBg,
                        child: SvgPicture.asset('assets/icons/PERFIL.svg', width: 30, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Andrés Velasco',
                        style: TextStyle(
                          fontFamily: 'Bernoru',
                          color: primaryBrown,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
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
                    child: const Text(
                      '"Muy buena comida !!"',
                      style: TextStyle(
                        fontFamily: 'Bernoru',
                        color: creamWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Separador Punteado Final
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 15,
                height: 3,
                color: greenBg.withValues(alpha: 0.5),
              )),
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
                        'assets/icons/HOME.svg',
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
                        'assets/icons/SEARCH.svg',
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
                        'assets/icons/FAV.svg',
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
                        'assets/icons/PERFIL.svg',
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
