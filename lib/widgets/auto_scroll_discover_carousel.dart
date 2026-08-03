import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'carousel_indicator.dart';
import '../screens/restaurant_detail_screen.dart';

class AutoScrollDiscoverCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> restaurants;
  final Color indicatorActiveColor;

  const AutoScrollDiscoverCarousel({
    super.key,
    required this.restaurants,
    this.indicatorActiveColor = const Color(0xFF2E563B),
  });

  @override
  State<AutoScrollDiscoverCarousel> createState() => _AutoScrollDiscoverCarouselState();
}

class _AutoScrollDiscoverCarouselState extends State<AutoScrollDiscoverCarousel> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  bool _isUserScrolling = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_scrollController.hasClients && !_isUserScrolling) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double itemWidthWithSpacing = 80.0 + 16.0;
        double nextScroll = currentScroll + itemWidthWithSpacing;

        if (nextScroll > maxScroll) {
          nextScroll = 0;
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildLogo(String imageUrl) {
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imageUrl,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        imageUrl,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.restaurants.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Listener(
            onPointerDown: (_) => _isUserScrolling = true,
            onPointerUp: (_) => _isUserScrolling = false,
            onPointerCancel: (_) => _isUserScrolling = false,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  int newIndex = (_scrollController.offset / (80.0 + 16.0)).round();
                  if (newIndex < 0) newIndex = 0;
                  if (newIndex >= widget.restaurants.length) newIndex = widget.restaurants.length - 1;

                  if (newIndex != _currentIndex) {
                    setState(() {
                      _currentIndex = newIndex;
                    });
                  }
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.restaurants.length,
                itemBuilder: (context, index) {
                  final color = widget.restaurants[index]['cardColor'] as Color? ?? Colors.grey;
                  final imageUrl = widget.restaurants[index]['imageUrl'] as String? ?? '';
                  
                  return Padding(
                    padding: EdgeInsets.only(right: index == widget.restaurants.length - 1 ? 0 : 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(
                              restaurantName: widget.restaurants[index]['name'] ?? 'Restaurante',
                              logoImage: imageUrl,
                              type: widget.restaurants[index]['type'] ?? 'Restaurante',
                              rating: widget.restaurants[index]['rating']?.toDouble() ?? 5.0,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildLogo(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CarouselIndicator(
          itemCount: widget.restaurants.length,
          currentIndex: _currentIndex,
          activeColor: widget.indicatorActiveColor,
        ),
      ],
    );
  }
}
