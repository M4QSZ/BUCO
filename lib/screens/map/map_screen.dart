import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  // Tienda (Store)
                  Marker(
                    point: storeData.coordinates,
                    width: 200,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
                            ],
                            border: Border.all(color: primaryBrown, width: 2),
                          ),
                          child: Text(
                            storeData.title,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: primaryBrown, fontFamily: 'Bernoru'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Triangulito del pin
                        Container(
                          width: 2,
                          height: 10,
                          color: primaryBrown,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: primaryBrown, shape: BoxShape.circle),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Botón de regresar
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: primaryBrown, size: 20),
              ),
            ),
          ),

          // Bottom Sheet (Info Local y WhatsApp)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    storeData.title,
                    style: const TextStyle(
                      fontFamily: 'Bernoru',
                      fontSize: 24,
                      color: primaryBrown,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    storeData.address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _launchWhatsApp(storeData.phone),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366), // Color oficial de WhatsApp
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 24),
                    label: const Text(
                      'Enviar Mensaje',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
