import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InteractiveStarRating extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;
  final Color creamWhite = const Color(0xFFF8EDDB);

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
      onTapDown: (details) {
        if (details.localPosition.dx < 16) {
          setState(() {
            _selectedStars = index + 0.5;
          });
        } else {
          setState(() {
            _selectedStars = index + 1.0;
          });
        }
        widget.onRatingChanged(_selectedStars);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/media/5968f1_star_custom.svg',
                height: 32,
                width: 32,
                colorFilter: ColorFilter.mode(widget.creamWhite.withValues(alpha: 0.3), BlendMode.srcIn),
              ),
              if (_selectedStars > index)
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: _selectedStars >= starValue ? 1.0 : 0.5,
                    child: SvgPicture.asset(
                      'assets/media/5968f1_star_custom.svg',
                      height: 32,
                      width: 32,
                      colorFilter: const ColorFilter.mode(Color(0xFFF2BF4A), BlendMode.srcIn),
                    ),
                  ),
                ),
            ],
          ),
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
