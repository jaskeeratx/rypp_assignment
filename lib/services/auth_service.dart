import '../core/constants/app_constants.dart';
import 'storage_service.dart';

class AuthService {
  AuthService(this._storageService);

  final StorageService _storageService;

  Future<void> sendOtp(String mobile) async {
    await Future.delayed(AppConstants.simulatedAuthDelay);
  }

  Future<bool> verifyOtp({required String mobile, required String otp}) async {
    await Future.delayed(AppConstants.simulatedAuthDelay);
    final isValid = otp == AppConstants.dummyOtp;
    if (isValid) {
      await _storageService.setMobileNumber(mobile);
      await _storageService.setLoggedIn(true);
    }
    return isValid;
  }

  Future<bool> isLoggedIn() => _storageService.isLoggedIn();

  Future<String?> currentMobileNumber() => _storageService.getMobileNumber();

  Future<void> logout() => _storageService.clearSession();
}
