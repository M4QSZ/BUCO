import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../login_screen.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color primaryOrange = Color(0xFFF0531C);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);
    const Color starYellow = Color(0xFFF2BF4A);

    return Scaffold(
      backgroundColor: creamWhite,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar - back arrow
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: primaryBrown, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            
            // Avatar - Profile icon inside yellow circle
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                color: starYellow,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.only(top: 28, left: 10, right: 10),
                child: SvgPicture.asset(
                  'assets/icons/PERFIL.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 14),
            
            // Name and Email
            const Text(
              'Andrés Velasco',
              style: TextStyle(
                color: primaryBrown,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'sebastián.fve@gmail.com',
              style: TextStyle(
                color: primaryBrown.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'CERRAR SESIÓN',
                      style: TextStyle(
                        fontFamily: 'Bernoru',
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: creamWhite,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            
            // Menu Items and Bottom Mascot
            Expanded(
              child: ClipRect(
                child: Stack(
                  children: [
                    // Mascot fixed at the bottom - cropped so only top part shows
                    Positioned(
                      bottom: -60,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: SvgPicture.asset(
                          'assets/icons/Asset 27.svg',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    
                    // Menu List (Sin scroll)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildMenuItem('assets/icons/CONTRASEÑA.svg', 'Privacidad de la cuenta', greenBg, starYellow, primaryBrown),
                          _buildMenuItem('assets/icons/FAQ.svg', 'FAQ', greenBg, starYellow, primaryBrown),
                          _buildMenuItem('assets/icons/AYUDA.svg', 'Ayuda', greenBg, starYellow, primaryBrown),
                          _buildMenuItem('assets/icons/CONTACTO.svg', 'Contacto', greenBg, starYellow, primaryBrown),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String assetPath, String title, Color bg, Color iconColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: textColor, size: 18),
        ],
      ),
    );
  }
}
