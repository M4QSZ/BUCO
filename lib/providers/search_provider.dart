import 'package:flutter/foundation.dart';

class SearchProvider extends ChangeNotifier {
  // Mock data for search history
  final List<String> _searchHistory = [
    'Burger',
    'Mac donal',
    'Pasta',
    'Sushi',
  ];

  // Mock data for promos images
  final List<String> _promos = [
    'assets/media/300f20_asset_36.png',
    'assets/media/8bc92b_asset_37.png',
    'assets/media/7300fc_asset_38.png',
  ];

  List<String> get searchHistory => _searchHistory;
  List<String> get promos => _promos;

  void removeHistoryItem(int index) {
    _searchHistory.removeAt(index);
    notifyListeners();
  }

  void addHistoryItem(String item) {
    if (!_searchHistory.contains(item)) {
      _searchHistory.insert(0, item);
      notifyListeners();
    }
  }
}
