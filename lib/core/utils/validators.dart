import '../constants/app_constants.dart';
import '../constants/app_strings.dart';

class Validators {
  Validators._();

  static final RegExp _digitsOnly = RegExp(r'^[0-9]+$');

  static String? validateMobile(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return AppStrings.errorMobileEmpty;
    if (!_digitsOnly.hasMatch(trimmed)) return AppStrings.errorMobileDigitsOnly;
    if (trimmed.length != AppConstants.mobileNumberLength) {
      return AppStrings.errorMobileLength;
    }
    return null;
  }

  static String? validateOtpFormat(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return AppStrings.errorOtpEmpty;
    if (!_digitsOnly.hasMatch(trimmed) ||
        trimmed.length != AppConstants.otpLength) {
      return AppStrings.errorOtpLength;
    }
    return null;
  }
}
