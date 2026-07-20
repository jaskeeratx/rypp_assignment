import 'package:flutter/foundation.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/app_date_utils.dart';

class BookingProvider extends ChangeNotifier {
  DateTime? _pickupDate;
  DateTime? _returnDate;
  double _dailyPrice = 0;
  bool _isBooking = false;
  String? _errorMessage;
  bool _bookingConfirmed = false;

  DateTime? get pickupDate => _pickupDate;
  DateTime? get returnDate => _returnDate;
  bool get isBooking => _isBooking;
  String? get errorMessage => _errorMessage;
  bool get bookingConfirmed => _bookingConfirmed;

  int get totalDays {
    if (_pickupDate == null || _returnDate == null) return 0;
    return AppDateUtils.rentalDays(_pickupDate!, _returnDate!);
  }

  double get totalCost => totalDays * _dailyPrice;

  void initForBooking(double dailyPrice) {
    _dailyPrice = dailyPrice;
    _pickupDate = null;
    _returnDate = null;
    _errorMessage = null;
    _bookingConfirmed = false;
    _isBooking = false;
  }

  void setPickupDate(DateTime date) {
    _pickupDate = date;
    _validateDates();
    notifyListeners();
  }

  void setReturnDate(DateTime date) {
    _returnDate = date;
    _validateDates();
    notifyListeners();
  }

  void _validateDates() {
    if (_pickupDate != null && _returnDate != null) {
      _errorMessage =
          AppDateUtils.isReturnBeforePickup(_pickupDate!, _returnDate!)
              ? AppStrings.errorReturnBeforePickup
              : null;
    } else {
      _errorMessage = null;
    }
  }

  bool get canConfirmBooking =>
      _pickupDate != null && _returnDate != null && _errorMessage == null;

  Future<bool> confirmBooking() async {
    if (!canConfirmBooking) {
      _errorMessage ??= AppStrings.errorSelectBothDates;
      notifyListeners();
      return false;
    }

    _isBooking = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 900));

    _isBooking = false;
    _bookingConfirmed = true;
    notifyListeners();
    return true;
  }

  void reset() {
    _pickupDate = null;
    _returnDate = null;
    _dailyPrice = 0;
    _isBooking = false;
    _errorMessage = null;
    _bookingConfirmed = false;
    notifyListeners();
  }
}
