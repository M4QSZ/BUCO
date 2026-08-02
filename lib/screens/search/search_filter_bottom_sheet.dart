import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showFilterBottomSheet(BuildContext context) {
  const Color primaryBrown = Color(0xFF662715);
  const Color creamWhite = Color(0xFFF8EDDB);
  const Color primaryOrange = Color(0xFFF0531C);
  const Color beigeBgColor = Color(0xFFDBC19C);
  const Color greenBg = Color(0xFF2E563B);

  int currentPanel = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          if (currentPanel == 0) {
            // Green Panel (Main Filter Categories)
            return Container(
              decoration: const BoxDecoration(
                color: greenBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top header bar
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: creamWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(FontAwesomeIcons.filter, color: primaryBrown, size: 24),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        _buildGreenPanelButton('Ordenar por', () {
                          setState(() {
                            currentPanel = 1;
                          });
                        }),
                        const SizedBox(height: 16),
                        _buildGreenPanelButton('Gastronomía', () {}),
                        const SizedBox(height: 16),
                        _buildGreenPanelButton('Horario', () {}),
                        const SizedBox(height: 16),
                        _buildGreenPanelButton('Calificaciones', () {}),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            );
          } else {
            // Beige Panel (Ordenar por)
            return Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cream Header
                  Container(
                    decoration: const BoxDecoration(
                      color: creamWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPanel = 0;
                            });
                          },
                          child: const FaIcon(FontAwesomeIcons.filter, color: primaryBrown, size: 36),
                        ),
                        const SizedBox(width: 24),
                        const Text(
                          'Ordenar por',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: primaryBrown,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Beige Body
                  Container(
                    color: beigeBgColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.start,
                          children: [
                            _buildFilterChip('Relevancia', true),
                            _buildFilterChip('Mas comentados', false),
                            _buildFilterChip('Más recientes', false),
                            _buildFilterChip('Recomendados', false),
                            _buildFilterChip('Recomendados', false),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Pagination Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.arrow_back_ios_new, color: greenBg, size: 24),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(10, (index) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(Icons.circle, color: greenBg, size: 10),
                                );
                              }),
                            ),
                            const Icon(Icons.arrow_forward_ios, color: greenBg, size: 24),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFilterSquareBox(),
                            _buildFilterSquareBox(),
                            _buildFilterSquareBox(),
                            _buildFilterSquareBox(),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                    color: creamWhite,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'RESTABLECER',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: primaryBrown,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                    color: primaryOrange,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'CONTINUAR',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: creamWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      );
    },
  );
}

Widget _buildGreenPanelButton(String title, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8EDDB),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xFF662715),
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}

Widget _buildFilterChip(String label, bool isSelected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF8EDDB),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xFF662715),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildFilterSquareBox() {
  return Container(
    width: 65,
    height: 65,
    decoration: BoxDecoration(
      color: const Color(0xFFF8EDDB),
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
