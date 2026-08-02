import 'package:flutter/material.dart';
import '../../widgets/interactive_star_rating.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class RestaurantLeaveReviewSection extends StatefulWidget {
  final double initialRating;
  final Function(double, String) onSubmit;

  const RestaurantLeaveReviewSection({
    super.key,
    required this.initialRating,
    required this.onSubmit,
  });

  @override
  State<RestaurantLeaveReviewSection> createState() => _RestaurantLeaveReviewSectionState();
}

class _RestaurantLeaveReviewSectionState extends State<RestaurantLeaveReviewSection> {
  late double _selectedStars;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStars = widget.initialRating;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);
    const Color primaryOrange = Color(0xFFF0531C);

    return Container(
      color: greenBg,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'DEJA TU OPINIÓN',
            style: TextStyle(
              fontFamily: 'Bernoru',
              color: creamWhite,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          InteractiveStarRating(
            initialRating: _selectedStars,
            onRatingChanged: (rating) {
              setState(() {
                _selectedStars = rating;
              });
            },
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: creamWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                hintText: 'Escribe tu comentario aquí...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Bernoru',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_selectedStars > 0 && _commentController.text.isNotEmpty) {
                widget.onSubmit(_selectedStars, _commentController.text);
                setState(() {
                  _selectedStars = 5.0;
                  _commentController.clear();
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text(
              'ENVIAR',
              style: TextStyle(
                fontFamily: 'Bernoru',
                color: creamWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
