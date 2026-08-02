import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color activeColor;

  const CarouselIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemCount <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isEdge = index == 0 || index == itemCount - 1;
        bool isActive = index == currentIndex;
        return Container(
          width: isActive ? 35.0 : (isEdge ? 15.0 : 30.0),
          height: 4.0,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? activeColor : activeColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
