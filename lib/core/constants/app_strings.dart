class AppStrings {
  AppStrings._();

  static const String appName = 'RideOn';
  static const String appTagline = 'Bike & Scooter Rental Marketplace';

  static const String splashLoading = 'Getting things ready...';

  static const String loginTitle = 'Welcome to RideOn';
  static const String loginSubtitle =
      'Enter your mobile number to continue renting bikes & scooters near you.';
  static const String mobileNumberLabel = 'Mobile Number';
  static const String mobileNumberHint = 'Enter 10-digit mobile number';
  static const String continueButton = 'Continue';
  static const String errorMobileEmpty = 'Mobile number is required';
  static const String errorMobileLength = 'Mobile number must be 10 digits';
  static const String errorMobileDigitsOnly = 'Mobile number must contain digits only';

  static const String otpTitle = 'Verify OTP';
  static const String otpSubtitleFirst = 'Enter the 6-digit code sent to';
  static const String otpVerifyButton = 'Verify & Continue';
  static const String otpResendPrompt = "Didn't receive the code? ";
  static const String otpResendAction = 'Resend';
  static const String otpHintDummy = 'Hint: use 123456 for this demo';
  static const String errorOtpEmpty = 'Please enter the OTP';
  static const String errorOtpLength = 'OTP must be 6 digits';
  static const String errorOtpInvalid = 'Invalid OTP. Please try again';

  static const String homeTitle = 'Find your ride';
  static const String searchHint = 'Search bikes & scooters';
  static const String sortTitle = 'Sort by';
  static const String sortPriceLowHigh = 'Price: Low to High';
  static const String sortPriceHighLow = 'Price: High to Low';
  static const String sortRatingHighLow = 'Rating: High to Low';
  static const String sortNone = 'Default';
  static const String perDay = '/day';
  static const String logoutTitle = 'Logout';
  static const String logoutConfirmMessage = 'Are you sure you want to logout?';
  static const String cancel = 'Cancel';

  static const String noBikesFoundTitle = 'No Bikes Found';
  static const String noBikesFoundSubtitle =
      'Try adjusting your search to find what you\'re looking for.';
  static const String errorTitle = 'Something went wrong';
  static const String errorSubtitleGeneric =
      'We couldn\'t load the bikes right now. Please try again.';
  static const String retryButton = 'Retry';
  static const String noInternetMessage =
      'No internet connection. Please check your network and try again.';
  static const String timeoutMessage = 'Request timed out. Please try again.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unknownErrorMessage = 'Something unexpected happened.';

  static const String available = 'Available';
  static const String booked = 'Booked';

  static const String detailsTitle = 'Bike Details';
  static const String descriptionLabel = 'Description';
  static const String bookNowButton = 'Book Now';
  static const String notAvailableMessage = 'This vehicle is currently booked';

  static const String bookingTitle = 'Book Your Ride';
  static const String pickupDateLabel = 'Pickup Date';
  static const String returnDateLabel = 'Return Date';
  static const String selectDate = 'Select date';
  static const String totalDaysLabel = 'Total Days';
  static const String totalCostLabel = 'Total Cost';
  static const String confirmBookingButton = 'Confirm Booking';
  static const String errorReturnBeforePickup =
      'Return date cannot be before pickup date';
  static const String errorSelectBothDates = 'Please select both pickup and return dates';
  static const String day = 'day';
  static const String days = 'days';

  static const String bookingSuccessTitle = 'Booking Successful!';
  static const String bookingSuccessSubtitle =
      'Your ride has been booked successfully. Enjoy your journey!';
  static const String backToHomeButton = 'Back to Home';

  static const String prefIsLoggedIn = 'is_logged_in';
  static const String prefMobileNumber = 'mobile_number';
}
