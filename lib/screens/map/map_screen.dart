import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'map_logic.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final DeliveryMapController _controller = DeliveryMapController();
  final MapController _mapController = MapController();

  Future<void> _launchWhatsApp(String phone) async {
    // Eliminar posibles espacios o signos + para asegurar la compatibilidad
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    final Uri whatsappUrl = Uri.parse("whatsapp://send?phone=$cleanPhone");
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      // Si el usuario no tiene WhatsApp instalado
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp. Verifica que esté instalado.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeData = _controller.storeData;
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color primaryOrange = Color(0xFFF0531C);

    return Scaffold(
      backgroundColor: creamWhite,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: storeData.coordinates,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.buco',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: storeData.coordinates,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.person,
                      color: primaryBrown,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Orange Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 15,
                left: 16,
                right: 16,
                bottom: 24,
              ),
              decoration: const BoxDecoration(
                color: primaryOrange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/media/ee45a3_back_arrow.svg',
                          height: 28,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/media/a12df1_asset_53.svg', // Logo BUCO con ubicación
                        height: 50,
                        colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Handle menu tap if needed
                        },
                        child: SvgPicture.asset(
                          'assets/media/3ff13c_menu_icon.svg',
                          width: 22,
                          colorFilter: const ColorFilter.mode(primaryBrown, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: creamWhite,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      children: [
                        FaIcon(FontAwesomeIcons.magnifyingGlass, color: primaryBrown, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          

          // Bottom Sheet (Info Local)
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E563B), // greenBg
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _launchWhatsApp(storeData.phone),
                            child: SvgPicture.asset('assets/media/f92c0e_asset_33.svg', width: 32, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
                          ),
                          SvgPicture.asset('assets/media/8d6e5a_fav_sin_marcar.svg', width: 32, colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Americana - Comida rápida',
                        style: TextStyle(
                          color: creamWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/media/8131cb_estrellita.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          const Text('4.5', style: TextStyle(color: creamWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 16),
                          SvgPicture.asset('assets/media/126258_reloj.svg', width: 24, colorFilter: const ColorFilter.mode(primaryOrange, BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          const Text('25-35 min', style: TextStyle(color: creamWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 16),
                          SvgPicture.asset('assets/media/b5e1db_perfil.svg', width: 20, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          const Text('25', style: TextStyle(color: creamWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: creamWhite,
                            foregroundColor: primaryBrown,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'VISITAR RESTAURANTE',
                            style: TextStyle(
                              fontFamily: 'Bernoru',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Burger King Logo
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: creamWhite,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/media/f1a2d7_burger_kin.svg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
