import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/user_provider.dart';
import '../restaurant_detail_screen.dart';
import '../settings_menu_screen.dart';
import 'map_logic.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final DeliveryMapController _controller = DeliveryMapController();
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  Map<String, dynamic>? _selectedRestaurant;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
  Widget _buildResultLogo(String imageUrl) {
    if (imageUrl.isEmpty) {
      return const Icon(Icons.restaurant, color: Color(0xFF662715), size: 20);
    }
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(imageUrl, fit: BoxFit.contain);
    } else if (imageUrl.startsWith('http')) {
      return Image.network(imageUrl, fit: BoxFit.contain);
    } else {
      return Image.asset(imageUrl, fit: BoxFit.contain);
    }
  }

  // Coordenadas mock de restaurantes en Panamá
  LatLng _getRestaurantCoordinates(String name) {
    final coords = {
      'BURGER KING': const LatLng(8.9824, -79.5209),
      'MCDONALD\'S': const LatLng(8.9836, -79.5185),
      'SOBAN KOREAN GOURMET': const LatLng(8.9850, -79.5150),
      'AYA LA VIDA': const LatLng(8.9516, -79.5340),
      'MAITO': const LatLng(8.9780, -79.5120),
      'PARRILLADA JIMMY': const LatLng(8.9900, -79.5060),
      'EL TRAPICHE': const LatLng(8.9830, -79.5280),
    };
    return coords[name.toUpperCase()] ?? const LatLng(8.9824, -79.5209);
  }

  Future<void> _launchWhatsApp(String phone) async {
    // Eliminar posibles espacios o signos + para asegurar la compatibilidad
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    final Uri whatsappUrl = Uri.parse("https://wa.me/$cleanPhone");
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Si el usuario no tiene WhatsApp instalado o no hay navegador
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp.')),
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
                  if (_selectedRestaurant != null)
                    Marker(
                      point: _getRestaurantCoordinates(_selectedRestaurant!['name'] ?? ''),
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: primaryOrange,
                        size: 40,
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
                          final userProvider = Provider.of<UserProvider>(context, listen: false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsMenuScreen(userName: userProvider.userName),
                            ),
                          );
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
                    child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.magnifyingGlass, color: primaryBrown, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            style: const TextStyle(
                              color: primaryBrown,
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Buscar restaurantes...',
                              hintStyle: TextStyle(
                                color: primaryBrown.withValues(alpha: 0.5),
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _searchFocusNode.unfocus();
                            },
                            child: Icon(Icons.close, color: primaryBrown.withValues(alpha: 0.6), size: 20),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Search Results Dropdown
          if (_searchQuery.isNotEmpty)
            Positioned(
              top: MediaQuery.of(context).padding.top + 135,
              left: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: Builder(
                  builder: (context) {
                    final restaurantProvider = context.read<RestaurantProvider>();
                    final results = restaurantProvider.searchRestaurants(_searchQuery);
                    if (results.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: creamWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'No se encontraron resultados.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primaryBrown.withValues(alpha: 0.6),
                          ),
                        ),
                      );
                    }
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      decoration: BoxDecoration(
                        color: creamWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shrinkWrap: true,
                          itemCount: results.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: primaryBrown.withValues(alpha: 0.1),
                            indent: 60,
                          ),
                          itemBuilder: (context, index) {
                            final rest = results[index];
                            final logoImage = rest['logoImage'] as String? ?? '';
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: _buildResultLogo(logoImage),
                                  ),
                                ),
                              ),
                              title: Text(
                                rest['name'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Bernoru',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: primaryBrown,
                                ),
                              ),
                              subtitle: Text(
                                rest['type'] ?? '',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryBrown.withValues(alpha: 0.6),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star, color: Color(0xFFF2BF4A), size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${rest['rating']}',
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: primaryBrown,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                _searchController.clear();
                                _searchFocusNode.unfocus();
                                setState(() {
                                  _selectedRestaurant = rest;
                                });
                                final coords = _getRestaurantCoordinates(rest['name'] ?? '');
                                _mapController.move(coords, 16.0);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          // Bottom Sheet (Info Local) - solo visible cuando hay restaurante seleccionado
          if (_selectedRestaurant != null)
            Positioned(
              bottom: 32,
              left: 24,
              right: 24,
              child: Builder(
                builder: (context) {
                  final restaurantProvider = context.watch<RestaurantProvider>();
                  final rest = _selectedRestaurant!;
                  final String displayType = rest['type'] ?? 'Restaurante';
                  final double displayRating = (rest['rating'] as num).toDouble();
                  final String displayLogo = rest['logoImage'] ?? 'assets/media/27281c_asset_35.png';
                  final String displayName = rest['name'] ?? '';
                  final bool isFav = restaurantProvider.isFavorite(displayName);

                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E563B),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Botón WhatsApp
                                GestureDetector(
                                  onTap: () {
                                    final phone = rest['phone'] ?? storeData.phone;
                                    _launchWhatsApp(phone);
                                  },
                                  child: SvgPicture.asset('assets/media/f92c0e_asset_33.svg', width: 32, colorFilter: const ColorFilter.mode(creamWhite, BlendMode.srcIn)),
                                ),
                                // Botón favorito
                                GestureDetector(
                                  onTap: () {
                                    restaurantProvider.toggleFavorite(displayName, data: rest);
                                  },
                                  child: SvgPicture.asset(
                                    isFav
                                        ? 'assets/media/8d6e5a_fav_sin_marcar.svg'
                                        : 'assets/media/8d6e5a_fav_sin_marcar.svg',
                                    width: 32,
                                    colorFilter: ColorFilter.mode(
                                      isFav ? const Color(0xFFF2BF4A) : creamWhite.withValues(alpha: 0.5),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              displayType,
                              style: const TextStyle(
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
                                Text(displayRating.toStringAsFixed(1), style: const TextStyle(color: creamWhite, fontSize: 18, fontWeight: FontWeight.bold)),
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
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RestaurantDetailScreen(
                                        restaurantName: displayName,
                                        logoImage: displayLogo,
                                        type: displayType,
                                        rating: displayRating,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: creamWhite,
                                  foregroundColor: primaryBrown,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 0,
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'VISITAR RESTAURANTE',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Bernoru',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Logo del restaurante
                      Positioned(
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: creamWhite,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: _buildResultLogo(displayLogo),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
