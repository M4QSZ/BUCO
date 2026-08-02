import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

void showEditProfileModal(BuildContext context) {
  const Color primaryBrown = Color(0xFF662715);
  const Color creamWhite = Color(0xFFF8EDDB);
  const Color greenBg = Color(0xFF2E563B);
  const Color primaryOrange = Color(0xFFF0531C);

  final userProvider = context.read<UserProvider>();
  final TextEditingController nameController = TextEditingController(text: userProvider.userName);
  final TextEditingController descController = TextEditingController(text: userProvider.userDesc);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: primaryOrange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Foto de Perfil
            SvgPicture.asset(
              'assets/media/8c491b_profile_icon.svg',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            const Text(
              'Foto de Perfil',
              style: TextStyle(
                color: primaryBrown,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Nombre de Usuario
            const Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.person, color: primaryBrown, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Nombre de Usuario',
                    style: TextStyle(
                      color: primaryBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: creamWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Descripción
            const Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.person, color: primaryBrown, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Descripción',
                    style: TextStyle(
                      color: primaryBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: creamWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botón CONTINUAR
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  userProvider.updateProfile(nameController.text, descController.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'CONTINUAR',
                  style: TextStyle(
                    color: creamWhite,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
