import 'package:flutter/foundation.dart';
import '../core/constants/app_strings.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService);

  final AuthService _authService;

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;
  String _mobileNumber = '';

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get mobileNumber => _mobileNumber;

  Future<void> checkLoginStatus() async {
    _isLoggedIn = await _authService.isLoggedIn();
    if (_isLoggedIn) {
      _mobileNumber = await _authService.currentMobileNumber() ?? '';
    }
    notifyListeners();
  }

  Future<bool> sendOtp(String mobile) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _mobileNumber = mobile;
      await _authService.sendOtp(mobile);
      return true;
    } catch (_) {
      _errorMessage = AppStrings.unknownErrorMessage;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> verifyOtp(String otp) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final success = await _authService.verifyOtp(
        mobile: _mobileNumber,
        otp: otp,
      );
      if (success) {
        _isLoggedIn = true;
      } else {
        _errorMessage = AppStrings.errorOtpInvalid;
      }
      return success;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _mobileNumber = '';
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
