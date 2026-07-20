import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

enum ProductLoadState { initial, loading, loaded, error }

enum SortOption { none, priceLowToHigh, priceHighToLow, ratingHighToLow }

class ProductProvider extends ChangeNotifier {
  ProductProvider(this._apiService);

  final ApiService _apiService;

  List<ProductModel> _allProducts = [];
  ProductLoadState _loadState = ProductLoadState.initial;
  String? _errorMessage;
  String _searchQuery = '';
  SortOption _sortOption = SortOption.none;

  ProductLoadState get loadState => _loadState;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  SortOption get sortOption => _sortOption;

  List<ProductModel> get filteredProducts {
    var result = _allProducts.where((product) {
      if (_searchQuery.trim().isEmpty) return true;
      return product.bikeName.toLowerCase().contains(
            _searchQuery.trim().toLowerCase(),
          );
    }).toList();

    switch (_sortOption) {
      case SortOption.priceLowToHigh:
        result.sort((a, b) => a.dailyRentalPrice.compareTo(b.dailyRentalPrice));
        break;
      case SortOption.priceHighToLow:
        result.sort((a, b) => b.dailyRentalPrice.compareTo(a.dailyRentalPrice));
        break;
      case SortOption.ratingHighToLow:
        result.sort((a, b) => b.ratingValue.compareTo(a.ratingValue));
        break;
      case SortOption.none:
        break;
    }
    return result;
  }

  bool get isEmpty =>
      _loadState == ProductLoadState.loaded && filteredProducts.isEmpty;

  Future<void> fetchProducts() async {
    _loadState = ProductLoadState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _allProducts = await _apiService.fetchProducts();
      _loadState = ProductLoadState.loaded;
    } on ApiException catch (e) {
      _loadState = ProductLoadState.error;
      _errorMessage = e.message;
    } catch (_) {
      _loadState = ProductLoadState.error;
      _errorMessage = 'Something went wrong. Please try again.';
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh() => fetchProducts();

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void sort(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }
}
