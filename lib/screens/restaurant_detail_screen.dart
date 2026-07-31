import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);

    return Scaffold(
      backgroundColor: creamWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabecera Naranja con logo gigante
            SizedBox(
              height: 400, // Más alta
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      color: primaryOrange,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(150), // Curva perfecta
                        bottomRight: Radius.circular(150),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: creamWhite, size: 28),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Text(
                            'BUCO',
                            style: TextStyle(
                              color: primaryBrown,
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              letterSpacing: 1,
                            ),
                          ),
                          const Icon(Icons.menu, color: creamWhite, size: 28),
                        ],
                      ),
                    ),
                  ),
                  
                  // Logo de Burger King gigante
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: creamWhite, width: 6),
                        image: const DecorationImage(
                          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1024px-Burger_King_2020.svg.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Fila de Info (Nombre, Calificación, Icono User)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BURGER\nKING',
                                  style: TextStyle(
                                    color: creamWhite,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    height: 1.1,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Hamburguesas - Comida rápida',
                                  style: TextStyle(
                                    color: creamWhite,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.bookmark, color: Color(0xFFF2BF4A), size: 36),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
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
                            color: creamWhite,
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 105,
                      decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(Icons.person, color: creamWhite, size: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Botones de acción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: primaryBrown,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'DETALLES',
                      style: TextStyle(color: creamWhite, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: creamWhite,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: primaryBrown.withOpacity(0.3), width: 2),
                    ),
                    child: Text(
                      'REVIEWS',
                      style: TextStyle(color: primaryBrown.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const Icon(Icons.menu_book, color: primaryBrown, size: 36),
                  const Icon(Icons.phone, color: primaryBrown, size: 36),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Texto descriptivo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem',
                style: TextStyle(
                  color: primaryBrown,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 30),

            // Imagen inferior del local
            Container(
              height: 250,
              decoration: const BoxDecoration(
                color: Colors.black54,
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
