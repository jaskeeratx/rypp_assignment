import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/bike_card.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.logoutTitle),
        content: const Text(AppStrings.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              AppStrings.logoutTitle,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true && mounted) {
      await context.read<AuthProvider>().logout();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final productProvider = context.read<ProductProvider>();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    AppStrings.sortTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _SortTile(
                  label: AppStrings.sortNone,
                  option: SortOption.none,
                  provider: productProvider,
                ),
                _SortTile(
                  label: AppStrings.sortPriceLowHigh,
                  option: SortOption.priceLowToHigh,
                  provider: productProvider,
                ),
                _SortTile(
                  label: AppStrings.sortPriceHighLow,
                  option: SortOption.priceHighToLow,
                  provider: productProvider,
                ),
                _SortTile(
                  label: AppStrings.sortRatingHighLow,
                  option: SortOption.ratingHighToLow,
                  provider: productProvider,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        actions: [
          IconButton(
            tooltip: AppStrings.sortTitle,
            onPressed: _showSortSheet,
            icon: const Icon(Icons.tune_rounded),
          ),
          IconButton(
            tooltip: AppStrings.logoutTitle,
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            CustomSearchBar(
              onChanged: (value) => context.read<ProductProvider>().search(value),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, _) {
                  switch (productProvider.loadState) {
                    case ProductLoadState.initial:
                    case ProductLoadState.loading:
                      return const LoadingWidget();

                    case ProductLoadState.error:
                      return AppErrorWidget(
                        message: productProvider.errorMessage ??
                            AppStrings.errorSubtitleGeneric,
                        onRetry: productProvider.fetchProducts,
                      );

                    case ProductLoadState.loaded:
                      final products = productProvider.filteredProducts;
                      if (products.isEmpty) {
                        return const EmptyWidget(
                          title: AppStrings.noBikesFoundTitle,
                          subtitle: AppStrings.noBikesFoundSubtitle,
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: productProvider.refresh,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 16, top: 4),
                          itemCount: products.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return BikeCard(
                              product: product,
                              animationDelay: Duration(
                                milliseconds: 40 * (index % 10),
                              ),
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.details,
                                arguments: product,
                              ),
                            );
                          },
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  const _SortTile({
    required this.label,
    required this.option,
    required this.provider,
  });

  final String label;
  final SortOption option;
  final ProductProvider provider;

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.sortOption == option;
    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : null,
      onTap: () {
        provider.sort(option);
        Navigator.pop(context);
      },
    );
  }
}
