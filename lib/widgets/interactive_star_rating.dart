import 'package:flutter/material.dart';

class InteractiveStarRating extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;

  const InteractiveStarRating({
    Key? key,
    this.initialRating = 5.0,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  State<InteractiveStarRating> createState() => _InteractiveStarRatingState();
}

class _InteractiveStarRatingState extends State<InteractiveStarRating> {
  late double _selectedStars;

  @override
  void initState() {
    super.initState();
    _selectedStars = widget.initialRating;
  }

  @override
  void didUpdateWidget(covariant InteractiveStarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _selectedStars = widget.initialRating;
    }
  }

  Widget _buildInteractiveStar(int index) {
    double starValue = index + 1.0;
    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset localPosition = box.globalToLocal(details.globalPosition);
        
        // Asumiendo que el ancho total de las 5 estrellas es de ~200 (40 * 5)
        // Calculamos la estrella basada en la posición X
        double newRating = (localPosition.dx / 40.0).clamp(0.0, 5.0);
        
        // Redondear a la media estrella más cercana
        newRating = (newRating * 2).round() / 2.0;
        
        if (newRating != _selectedStars) {
          setState(() {
            _selectedStars = newRating;
          });
          widget.onRatingChanged(_selectedStars);
        }
      },
      onTapDown: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        double localX = details.localPosition.dx;
        
        double newRating = index + (localX > 15 ? 1.0 : 0.5);
        if (newRating != _selectedStars) {
          setState(() {
            _selectedStars = newRating;
          });
          widget.onRatingChanged(_selectedStars);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Icon(
          _selectedStars >= starValue
              ? Icons.star
              : _selectedStars >= starValue - 0.5
                  ? Icons.star_half
                  : Icons.star_border,
          color: const Color(0xFFF2BF4A), // Amarillo
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => _buildInteractiveStar(index)),
    );
  }
}
