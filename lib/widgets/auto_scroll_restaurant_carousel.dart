import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import 'restaurant_card.dart';
import 'carousel_indicator.dart';

class AutoScrollRestaurantCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> restaurants;
  final Color indicatorActiveColor;

  const AutoScrollRestaurantCarousel({
    Key? key,
    required this.restaurants,
    this.indicatorActiveColor = const Color(0xFF2E563B),
  }) : super(key: key);

  @override
  State<AutoScrollRestaurantCarousel> createState() => _AutoScrollRestaurantCarouselState();
}

class _AutoScrollRestaurantCarouselState extends State<AutoScrollRestaurantCarousel> {
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
        double cardWidthWithSpacing = 170.0 + 24.0;
        double nextScroll = currentScroll + cardWidthWithSpacing;

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

  @override
  Widget build(BuildContext context) {
    const Color greenBg = Color(0xFF2E563B);
    
    if (widget.restaurants.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 260,
          child: Listener(
            onPointerDown: (_) => _isUserScrolling = true,
            onPointerUp: (_) => _isUserScrolling = false,
            onPointerCancel: (_) => _isUserScrolling = false,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  int newIndex = (_scrollController.offset / (170.0 + 24.0)).round();
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
                padding: const EdgeInsets.symmetric(horizontal: 45),
                itemCount: widget.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurantProvider = context.watch<RestaurantProvider>();
                  final restName = widget.restaurants[index]['name'] as String;
                  return Padding(
                    padding: EdgeInsets.only(right: index == widget.restaurants.length - 1 ? 0 : 24.0),
                    child: RestaurantCard(
                      name: restName,
                      type: '',
                      rating: widget.restaurants[index]['rating'],
                      isSavedStyle: true,
                      imageUrl: widget.restaurants[index]['imageUrl'],
                      cardColor: widget.restaurants[index]['cardColor'],
                      isFavorite: restaurantProvider.isFavorite(restName),
                      onFavoriteToggle: () => restaurantProvider.toggleFavorite(restName, data: widget.restaurants[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        CarouselIndicator(
          itemCount: widget.restaurants.length,
          currentIndex: _currentIndex,
          activeColor: widget.indicatorActiveColor,
        ),
      ],
    );
  }
}
