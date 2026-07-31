import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color greenBg = Color(0xFF2E563B);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color orangeBg = Color(0xFFF0531C);

    return Scaffold(
      backgroundColor: orangeBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculated percentages from 1179x2556 SVG
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.08), // 94px from 1179 = ~8%
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(flex: 33), // Top padding

                        // Logo de BUCO
                        Center(
                          child: SvgPicture.asset(
                            'assets/icons/Asset 52.svg',
                            height: h * 0.093, // ~237px from 2556 SVG
                            colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                          ),
                        ),
                        
                        const Spacer(flex: 20),

                        // Correo electrónico
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/email_icon.svg', 
                              width: w * 0.045, 
                              colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn)
                            ),
                            SizedBox(width: w * 0.02),
                            Text(
                              'Correo electrónico',
                              style: GoogleFonts.montserrat(
                                color: primaryBrown,
                                fontWeight: FontWeight.w700,
                                fontSize: w * 0.035, // 42px in SVG
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.005),
                        Container(
                          height: h * 0.045, // 110px in SVG
                          decoration: BoxDecoration(
                            color: creamWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            style: GoogleFonts.montserrat(
                              color: primaryBrown,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.035,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: h * 0.012),
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 10),

                        // Contraseña
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/CONTRASEÑA.svg', 
                              width: w * 0.045, 
                              colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn)
                            ),
                            SizedBox(width: w * 0.02),
                            Text(
                              'Contraseña',
                              style: GoogleFonts.montserrat(
                                color: primaryBrown,
                                fontWeight: FontWeight.w700,
                                fontSize: w * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.005),
                        Container(
                          height: h * 0.045,
                          decoration: BoxDecoration(
                            color: creamWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            obscureText: true,
                            style: GoogleFonts.montserrat(
                              color: primaryBrown,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.035,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: h * 0.012),
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 5),
                        
                        // Olvidaste la contraseña?
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              '¿Olvidaste la contraseña?',
                              style: GoogleFonts.montserrat(
                                color: primaryBrown,
                                fontWeight: FontWeight.w600,
                                fontSize: w * 0.030, // 35px in SVG
                              ),
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 14),

                        // Botón CONTINUAR
                        Center(
                          child: SizedBox(
                            width: w * 0.376, // 443px out of 1179
                            height: h * 0.058, // 149px out of 2556
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainLayout()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: greenBg,
                                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'CONTINUAR',
                                  style: TextStyle(
                                    fontFamily: 'Bernoru',
                                    fontSize: w * 0.03, // 32px out of 1179
                                    fontWeight: FontWeight.w800,
                                    color: creamWhite,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 17),

                        // Divisor
                        Row(
                          children: [
                            const Expanded(child: Divider(color: primaryBrown, thickness: 1.5)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '¿No tienes cuenta?',
                                  style: GoogleFonts.montserrat(
                                    color: primaryBrown,
                                    fontWeight: FontWeight.w800,
                                    fontSize: w * 0.038, // 45px in SVG
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: primaryBrown, thickness: 1.5)),
                          ],
                        ),
                        
                        const Spacer(flex: 12),

                        // Botón Crear Cuenta
                        SizedBox(
                          height: h * 0.058, // 148px out of 2556
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenBg,
                              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Crear una cuenta',
                                style: GoogleFonts.montserrat(
                                  fontSize: w * 0.043, // 51px in SVG
                                  fontWeight: FontWeight.w800,
                                  color: creamWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 5),

                        // Iniciar con Instagram
                        _buildSocialButton('assets/icons/instagram_icon.svg', 'Iniciar con Instagram', primaryBrown, creamWhite, h, w),
                        
                        const Spacer(flex: 5),

                        // Iniciar con Google
                        _buildSocialButton('assets/icons/google_icon.svg', 'Iniciar con Google', primaryBrown, creamWhite, h, w),
                        
                        const Spacer(flex: 30), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconAsset, String label, Color textColor, Color bgColor, double h, double w) {
    return SizedBox(
      height: h * 0.058,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(horizontal: w * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconAsset, width: w * 0.055),
            SizedBox(width: w * 0.03),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: w * 0.038, // 45px in SVG
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
