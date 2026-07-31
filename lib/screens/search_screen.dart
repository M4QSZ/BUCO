import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    
    return Scaffold(
      backgroundColor: creamWhite,
      body: Center(
        child: Text(
          'Pantalla de Búsqueda',
          style: TextStyle(fontSize: 24, color: primaryBrown),
        ),
      ),
    );
  }
}
