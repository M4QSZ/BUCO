import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    // Aquí puedes agregar la lógica para el registro más adelante
  }

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
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(flex: 15),

                        // Logo de BUCO
                        Center(
                          child: SvgPicture.asset(
                            'assets/media/4e9d05_asset_52.svg',
                            height: h * 0.093,
                            colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                          ),
                        ),
                        
                        const Spacer(flex: 15),

                        // Nombre de Usuario
                        _buildLabel('Nombre de Usuario', 'assets/media/b5e1db_perfil.svg', primaryBrown, w),
                        SizedBox(height: h * 0.005),
                        _buildTextField(_usernameController, false, creamWhite, primaryBrown, w, h),
                        
                        const Spacer(flex: 5),

                        // Correo electrónico
                        _buildLabel('Correo electrónico', 'assets/media/a3d808_email_icon.svg', primaryBrown, w),
                        SizedBox(height: h * 0.005),
                        _buildTextField(_emailController, false, creamWhite, primaryBrown, w, h),

                        const Spacer(flex: 5),

                        // Contraseña
                        _buildLabel('Contraseña', 'assets/media/772100_contrase_a.svg', primaryBrown, w),
                        SizedBox(height: h * 0.005),
                        _buildTextField(_passwordController, true, creamWhite, primaryBrown, w, h),

                        const Spacer(flex: 5),

                        // Confirmar Contraseña
                        _buildLabel('Confirmar Contraseña', 'assets/media/772100_contrase_a.svg', primaryBrown, w),
                        SizedBox(height: h * 0.005),
                        _buildTextField(_confirmPasswordController, true, creamWhite, primaryBrown, w, h),

                        const Spacer(flex: 15),

                        // Botón REGISTRAR
                        Center(
                          child: SizedBox(
                            width: w * 0.45,
                            height: h * 0.058,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: greenBg,
                                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'REGISTRAR',
                                  style: TextStyle(
                                    fontFamily: 'Bernoru',
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.w800,
                                    color: creamWhite,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(flex: 15),

                        // Divisor ¿Ya tienes una Cuenta?
                        Row(
                          children: [
                            const Expanded(child: Divider(color: primaryBrown, thickness: 1.5)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                              child: Text(
                                '¿Ya tienes una Cuenta?',
                                style: GoogleFonts.montserrat(
                                  color: primaryBrown,
                                  fontWeight: FontWeight.w800,
                                  fontSize: w * 0.038,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: primaryBrown, thickness: 1.5)),
                          ],
                        ),

                        const Spacer(flex: 10),

                        // Botón Iniciar Sesión
                        SizedBox(
                          height: h * 0.058,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenBg,
                              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Iniciar Sesión',
                                style: GoogleFonts.montserrat(
                                  fontSize: w * 0.043,
                                  fontWeight: FontWeight.w800,
                                  color: creamWhite,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(flex: 20),
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

  Widget _buildLabel(String text, String iconAsset, Color color, double w) {
    return Row(
      children: [
        SvgPicture.asset(
          iconAsset, 
          width: w * 0.045, 
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
        ),
        SizedBox(width: w * 0.02),
        Text(
          text,
          style: GoogleFonts.montserrat(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: w * 0.035,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, bool obscureText, Color bgColor, Color textColor, double w, double h) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.montserrat(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: w * 0.035,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: h * 0.015),
          isDense: true,
        ),
      ),
    );
  }
}
