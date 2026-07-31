import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String type;
  final double rating;
  final Color backgroundColor;
  final Color? cardColor; // Usado para el fondo del logo circular
  final bool isLargeTitle;
  final String? imageUrl; 
  final bool isSavedStyle; // Nuevo parametro para estilo de Mi Cuenta / Favoritos

  const RestaurantCard({
    super.key,
    required this.name,
    required this.type,
    required this.rating,
    this.backgroundColor = const Color(0xFFF0531C), 
    this.cardColor,
    this.isLargeTitle = false,
    this.imageUrl,
    this.isSavedStyle = false, // Por defecto usa el estilo del Home (BUCO 6)
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const RestaurantDetailScreen()),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isSavedStyle ? _buildSavedStyle(primaryBrown, creamWhite) : _buildHomeStyle(primaryBrown, creamWhite),
      ),
    );
  }

  // Estilo de tarjeta para la pantalla de perfil/favoritos (Asset 30.svg)
  // Proporciones basadas en el SVG: card 525.05x738.14, aspect ratio ~0.711
  Widget _buildSavedStyle(Color primaryBrown, Color creamWhite) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Texto del nombre del restaurante
        // SVG: posicionado a ~4.3% left, ~12.3% top del card
        // Con card width=160, height~225: left≈7, top≈28
        Positioned(
          top: 14,
          left: 14,
          right: 14,
          child: Text(
            name.replaceAll(' ', '\n'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              height: 0.95,
            ),
          ),
        ),

        // Logo circular sobresaliendo a la izquierda
        // SVG: logo a ~-10.3% left, ~22.6% top, tamaño ~70% del ancho
        // Con card width=160: left≈-16, top≈50, tamaño≈110
        Positioned(
          top: 65,
          left: -18,
          child: Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              color: cardColor ?? Colors.orange,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: creamWhite, width: 4),
              image: imageUrl != null && !imageUrl!.toLowerCase().endsWith('.svg')
                ? DecorationImage(
                    image: imageUrl!.startsWith('http') 
                        ? NetworkImage(imageUrl!) as ImageProvider
                        : AssetImage(imageUrl!),
                    fit: BoxFit.cover,
                  ) 
                : null,
            ),
            child: imageUrl != null && imageUrl!.toLowerCase().endsWith('.svg')
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SvgPicture.asset(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
          ),
        ),

        // Rating badge
        // SVG: w=160.54, h=101.21, posicionado a ~8.1% left, ~6.5% desde abajo
        // Con card width=160: left≈13, bottom≈15, ancho proporcional
        Positioned(
          bottom: 14,
          left: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2BF4A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              rating.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
        ),

        // Bookmark Icon SVG
        // SVG: posicionado a ~90.3% left desde el card
        Positioned(
          bottom: 14,
          right: 14,
          child: SvgPicture.asset(
            'assets/icons/FAV SIN MARCAR.svg',
            width: 22,
            colorFilter: ColorFilter.mode(primaryBrown, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildHomeStyle(Color primaryBrown, Color creamWhite) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen superior (cuadrada redondeada)
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: cardColor ?? Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: creamWhite, width: 3),
                  image: imageUrl != null && !imageUrl!.toLowerCase().endsWith('.svg')
                    ? DecorationImage(
                        image: imageUrl!.startsWith('http') 
                            ? NetworkImage(imageUrl!) as ImageProvider
                            : AssetImage(imageUrl!),
                        fit: BoxFit.cover,
                      ) 
                    : null,
                ),
                child: imageUrl != null && imageUrl!.toLowerCase().endsWith('.svg')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SvgPicture.asset(
                          imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 12),
              // Título
              Text(
                name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  height: 1.1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Subtítulo
              if (type.isNotEmpty) Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        
        // Badge de calificación
        Positioned(
          top: 18,
          left: 18,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF2BF4A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              rating.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
        ),

        // Ícono de guardado (Bookmark) SVG
        Positioned(
          bottom: 12,
          right: 12,
          child: SvgPicture.asset(
            'assets/icons/FAV SIN MARCAR.svg',
            width: 24,
            colorFilter: ColorFilter.mode(primaryBrown, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
