import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../widgets/auto_scroll_restaurant_carousel.dart';
import '../providers/restaurant_provider.dart';
import 'account/profile_header_card.dart';
import 'account/profile_review_carousel.dart';
import 'account/edit_profile_modal.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    return Scaffold(
      backgroundColor: greenBg, // Fondo verde debajo
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Cabecera Naranja Completa
                ProfileHeaderCard(
                  onEditProfile: () => showEditProfileModal(context),
                ),
                const SizedBox(height: 15),

                // Tarjeta de reseña sobre el fondo verde (Carousel)
                const ProfileReviewCarousel(),
                const SizedBox(height: 15),
              ],
            ),
          ),

          // Contenedor crema inferior masivo
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: creamWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/media/59675c_fav.svg',
                    width: 35,
                    colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
                  ),
                  const SizedBox(height: 15),
                  Consumer<RestaurantProvider>(
                    builder: (context, restaurantProvider, child) {
                      return AutoScrollRestaurantCarousel(
                        restaurants: restaurantProvider.favoriteRestaurants,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
