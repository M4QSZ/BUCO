import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/carousel_indicator.dart';

class ProfileReviewCarousel extends StatefulWidget {
  const ProfileReviewCarousel({Key? key}) : super(key: key);

  @override
  State<ProfileReviewCarousel> createState() => _ProfileReviewCarouselState();
}

class _ProfileReviewCarouselState extends State<ProfileReviewCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (!mounted) return;
      final reviews = context.read<UserProvider>().userReviews;
      if (reviews.isEmpty) return;
      
      setState(() {
        if (_currentIndex < reviews.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
      });
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF662715);
    const Color creamWhite = Color(0xFFF8EDDB);

    final reviews = context.watch<UserProvider>().userReviews;
    if (reviews.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      decoration: BoxDecoration(
                        color: primaryBrown,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Text(
                        reviews[index]['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: creamWhite, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(
                        reviews[index]['icon']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        CarouselIndicator(
          itemCount: reviews.length,
          currentIndex: _currentIndex,
          activeColor: creamWhite,
        ),
      ],
    );
  }
}
