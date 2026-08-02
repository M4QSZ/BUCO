import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/account_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715); // Ajustado a la imagen
    const Color primaryOrange = Color(0xFFF0531C); // Naranja flat de la imagen

    return Scaffold(
      body: Stack(
        children: [
          // Pantallas (IndexedStack para mantener el estado)
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          
          // Barra de Navegación Flotante
          Positioned(
            left: 20,
            right: 20,
            bottom: 24, // Distancia desde el fondo
            child: Container(
              height: 70, // Grosor de la píldora
              decoration: BoxDecoration(
                color: primaryOrange, // Naranja vibrante
                borderRadius: BorderRadius.circular(50), // Redondeado perfecto (Píldora)
                // Se eliminó la sombra para un aspecto flat tal cual la imagen
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem('assets/media/80352c_home.svg', 0, primaryBrown),
                  _buildNavItem('assets/media/e13312_search.svg', 1, primaryBrown),
                  _buildNavItem('assets/media/59675c_fav.svg', 2, primaryBrown),
                  _buildNavItem('assets/media/b5e1db_perfil.svg', 3, primaryBrown),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(dynamic icon, int index, Color baseColor) {
    final bool isSelected = _currentIndex == index;
    // Si está seleccionado, usa crema/blanco. Si no, usa el café base sólido.
    final Color currentColor = isSelected ? const Color(0xFFF8EDDB) : baseColor;
    
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: icon is String
            ? SvgPicture.asset(
                icon,
                height: 24,
                colorFilter: ColorFilter.mode(currentColor, BlendMode.srcIn),
              )
            : FaIcon(
                icon,
                color: currentColor,
                size: 24,
              ),
      ),
    );
  }
}
