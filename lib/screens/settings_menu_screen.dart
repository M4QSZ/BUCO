import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../login_screen.dart';
import '../services/auth_service.dart';

class SettingsMenuScreen extends StatelessWidget {
  final String userName;
  
  const SettingsMenuScreen({super.key, required this.userName});

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
              padding: const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/media/ee45a3_back_arrow.svg',
                    height: 20,
                    colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                  ),
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
                  'assets/media/b5e1db_perfil.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Name and Email
            Text(
              userName,
              style: const TextStyle(
                color: primaryBrown,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              AuthService().getCurrentUser()?['email'] ?? 'usuario@ejemplo.com',
              style: TextStyle(
                color: primaryBrown.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
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
                  onPressed: () async {
                    await AuthService().signOut();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text(
                    'CERRAR SESIÓN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Bernoru',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: creamWhite,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Menu Items and Bottom Mascot
            Expanded(
              child: ClipRect(
                child: Stack(
                  children: [
                    // Mascot fixed at the bottom - cropped so only top part shows
                    Positioned(
                      bottom: -50,
                      left: -10,
                      right: -10,
                      child: IgnorePointer(
                        child: SvgPicture.asset(
                          'assets/media/025531_buco_pet___pattern.svg',
                          width: MediaQuery.of(context).size.width * 1.05,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    
                    // Menu List (Sin scroll)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 0),
                          _buildMenuItem('assets/media/772100_contrase_a.svg', 'Privacidad de la cuenta', greenBg, starYellow, primaryBrown),
                          _buildMenuItem('assets/media/18ecef_faq.svg', 'FAQ', greenBg, starYellow, primaryBrown),
                          _buildMenuItem('assets/media/985b73_ayuda.svg', 'Ayuda', greenBg, starYellow, primaryBrown),
                          _buildMenuItem('assets/media/a91300_contacto.svg', 'Contacto', greenBg, starYellow, primaryBrown),
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
                width: 26,
                height: 26,
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
          Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              'assets/media/ee45a3_back_arrow.svg',
              height: 15,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
