import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_date_utils.dart';
import '../../core/utils/extensions.dart';
import '../../models/product_model.dart';
import '../../providers/booking_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().initForBooking(widget.product.dailyRentalPrice);
    });
  }

  Future<void> _pickDate({required bool isPickup}) async {
    final bookingProvider = context.read<BookingProvider>();
    final now = DateTime.now();
    final initialDate = isPickup
        ? (bookingProvider.pickupDate ?? now)
        : (bookingProvider.returnDate ?? bookingProvider.pickupDate ?? now);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );

    if (picked == null) return;
    if (isPickup) {
      bookingProvider.setPickupDate(picked);
    } else {
      bookingProvider.setReturnDate(picked);
    }
  }

  Future<void> _onConfirmBooking() async {
    final bookingProvider = context.read<BookingProvider>();
    final success = await bookingProvider.confirmBooking();

    if (!mounted) return;
    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.success,
        (route) => route.settings.name == AppRoutes.home,
      );
    } else {
      context.showSnackBar(
        bookingProvider.errorMessage ?? AppStrings.errorSelectBothDates,
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.bookingTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Consumer<BookingProvider>(
          builder: (context, booking, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BikeSummaryCard(product: widget.product),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _DateSelector(
                        label: AppStrings.pickupDateLabel,
                        date: booking.pickupDate,
                        onTap: () => _pickDate(isPickup: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DateSelector(
                        label: AppStrings.returnDateLabel,
                        date: booking.returnDate,
                        onTap: () => _pickDate(isPickup: false),
                      ),
                    ),
                  ],
                ),
                if (booking.errorMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    booking.errorMessage!,
                    style: const TextStyle(color: AppColors.error, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 24),
                _CostSummary(
                  totalDays: booking.totalDays,
                  totalCost: booking.totalCost,
                ),
                const Spacer(),
                CustomButton(
                  label: AppStrings.confirmBookingButton,
                  isLoading: booking.isBooking,
                  onPressed: booking.canConfirmBooking ? _onConfirmBooking : null,
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BikeSummaryCard extends StatelessWidget {
  const _BikeSummaryCard({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image,
                width: 56,
                height: 56,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.pedal_bike_rounded,
                  color: AppColors.textHint,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.bikeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.dailyRentalPrice.toStringAsFixed(2)}${AppStrings.perDay}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({required this.label, required this.date, required this.onTap});

  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    size: 15, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(label, style: context.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              date != null ? AppDateUtils.formatDate(date!) : AppStrings.selectDate,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: date != null ? AppColors.textPrimary : AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CostSummary extends StatelessWidget {
  const _CostSummary({required this.totalDays, required this.totalCost});

  final int totalDays;
  final double totalCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: AppStrings.totalDaysLabel,
            value: totalDays == 0
                ? '-'
                : '$totalDays ${totalDays == 1 ? AppStrings.day : AppStrings.days}',
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: AppStrings.totalCostLabel,
            value: '\$${totalCost.toStringAsFixed(2)}',
            isEmphasized: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isEmphasized = false,
  });

  final String label;
  final String value;
  final bool isEmphasized;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.textTheme.bodyMedium),
        Text(
          value,
          style: TextStyle(
            fontSize: isEmphasized ? 20 : 15,
            fontWeight: FontWeight.w700,
            color: isEmphasized ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
