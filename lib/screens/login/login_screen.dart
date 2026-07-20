import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.sendOtp(_mobileController.text.trim());

    if (!mounted) return;
    if (success) {
      Navigator.pushNamed(
        context,
        AppRoutes.otp,
        arguments: _mobileController.text.trim(),
      );
    } else {
      context.showSnackBar(
        authProvider.errorMessage ?? AppStrings.unknownErrorMessage,
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.pedal_bike_rounded,
                    size: 38,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 28),
                Text(AppStrings.loginTitle, style: context.textTheme.headlineLarge),
                const SizedBox(height: 10),
                Text(
                  AppStrings.loginSubtitle,
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                Text(
                  AppStrings.mobileNumberLabel,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: AppConstants.mobileNumberLength,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: AppStrings.mobileNumberHint,
                    counterText: '',
                    prefixIcon: Icon(Icons.phone_iphone_rounded),
                  ),
                  validator: Validators.validateMobile,
                ),
                const Spacer(),
                Consumer<AuthProvider>(
                  builder: (context, auth, _) => CustomButton(
                    label: AppStrings.continueButton,
                    isLoading: auth.isLoading,
                    onPressed: _onContinue,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
