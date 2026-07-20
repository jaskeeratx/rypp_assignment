import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _displayFormat = DateFormat('dd MMM yyyy');

  static String formatDate(DateTime date) => _displayFormat.format(date);

  static int rentalDays(DateTime pickup, DateTime returnDate) {
    final normalizedPickup = DateTime(pickup.year, pickup.month, pickup.day);
    final normalizedReturn =
        DateTime(returnDate.year, returnDate.month, returnDate.day);
    final diff = normalizedReturn.difference(normalizedPickup).inDays;
    return diff <= 0 ? 1 : diff;
  }

  static bool isReturnBeforePickup(DateTime pickup, DateTime returnDate) {
    final normalizedPickup = DateTime(pickup.year, pickup.month, pickup.day);
    final normalizedReturn =
        DateTime(returnDate.year, returnDate.month, returnDate.day);
    return normalizedReturn.isBefore(normalizedPickup);
  }
}
