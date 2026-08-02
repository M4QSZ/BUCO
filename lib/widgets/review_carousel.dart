import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewCarousel extends StatefulWidget {
  final List<Map<String, String>> reviews;

  const ReviewCarousel({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  State<ReviewCarousel> createState() => _ReviewCarouselState();
}

class _ReviewCarouselState extends State<ReviewCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentIndex < widget.reviews.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);
    const Color greenBg = Color(0xFF2E563B);

    return Column(
      children: [
        SizedBox(
          height: 100, // Altura fija para el PageView
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.reviews.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.reviews[index]['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Bernoru',
                          color: creamWhite, 
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      widget.reviews[index]['icon']!,
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _goToPreviousPage,
                child: SvgPicture.asset(
                  'assets/media/91ea5f_pagination_arrow.svg',
                  height: 20,
                  colorFilter: const ColorFilter.mode(greenBg, BlendMode.srcIn),
                ),
              ),
              Row(
                children: List.generate(
                  widget.reviews.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 10 : 8,
                    height: _currentIndex == index ? 10 : 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? greenBg : greenBg.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _goToNextPage,
                child: Transform.flip(
                  flipX: true,
                  child: SvgPicture.asset(
                    'assets/media/91ea5f_pagination_arrow.svg',
                    height: 20,
                    colorFilter: const ColorFilter.mode(greenBg, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
