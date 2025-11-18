import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/usecases/login_usecase.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/snackbar_helper.dart';
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accountFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }
  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }
  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _accountFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }
  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final result = await viewModel.login(
      _accountController.text.trim(),
      _passwordController.text,
    );
    if (!mounted) return;
    switch (result.type) {
      case LoginResultType.success:
        SnackBarHelper.showSuccess(context, AppStrings.loginSuccess);
        await Future.delayed(const Duration(milliseconds: 800));
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case LoginResultType.failure:
        SnackBarHelper.showError(
          context,
          result.message ?? AppStrings.loginFailed,
        );
        break;
      case LoginResultType.error:
        SnackBarHelper.showError(
          context,
          result.message ?? AppStrings.loginError,
        );
        break;
    }
  }
  void _toggleLoginForm() {
    ref.read(loginViewModelProvider.notifier).toggleLoginForm();
    final showLoginForm = ref.read(loginViewModelProvider).showLoginForm;
    if (showLoginForm) {
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) _accountFocusNode.requestFocus();
      });
    } else {
      _animationController.reverse();
      _formKey.currentState?.reset();
      _accountController.clear();
      _passwordController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGray,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth > 600
                  ? AppDimensions.tabletPadding
                  : AppDimensions.mobilePadding;
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: AppDimensions.maxContentWidth,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: AppDimensions.spacing20,
                      ),
                      child: loginState.showLoginForm
                          ? _buildLoginForm(loginState)
                          : _buildWelcomeScreen(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Widget _buildWelcomeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimensions.spacing40),
        _buildLogo(),
        const SizedBox(height: AppDimensions.spacing48),
        _buildTitle(),
        const SizedBox(height: AppDimensions.spacing16),
        _buildMotto(),
        const SizedBox(height: AppDimensions.spacing64),
        CustomButton(
          label: AppStrings.loginButton,
          onPressed: _toggleLoginForm,
          isPrimary: true,
          icon: Icons.login_rounded,
        ),
        const SizedBox(height: AppDimensions.spacing16),
        CustomButton(
          label: AppStrings.registerButton,
          onPressed: () => Navigator.pushNamed(context, '/register'),
          isPrimary: false,
          icon: Icons.person_add_rounded,
        ),
        const SizedBox(height: AppDimensions.spacing40),
      ],
    );
  }
  Widget _buildLogo() {
    return Hero(
      tag: 'logo',
      child: Container(
        width: AppDimensions.logoSize,
        height: AppDimensions.logoSize,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: AppColors.accentGold.withValues(alpha: 0.3),
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          child: Image.asset(
            'assets/usjrlogo.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.school,
                  size: 120,
                  color: AppColors.primaryBlue,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Widget _buildTitle() {
    return const Text(
      AppStrings.appTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
        height: 1.2,
      ),
    );
  }
  Widget _buildMotto() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing20,
        vertical: AppDimensions.spacing8,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      ),
      child: const Text(
        AppStrings.appMotto,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
  Widget _buildLoginForm(LoginState loginState) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.spacing20),
            IconButton(
              onPressed: loginState.isLoading ? null : _toggleLoginForm,
              icon: const Icon(Icons.arrow_back),
              color: AppColors.primaryBlue,
              iconSize: 28,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            const Text(
              AppStrings.loginTitle,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              AppStrings.loginSubtitle,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkBlue.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: AppDimensions.spacing40),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _accountController,
                    focusNode: _accountFocusNode,
                    labelText: AppStrings.accountIdLabel,
                    prefixIcon: Icons.person_outline,
                    enabled: !loginState.isLoading,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.accountIdRequired;
                      }
                      if (value.trim().length < 3) {
                        return AppStrings.accountIdTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  CustomTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    labelText: AppStrings.passwordLabel,
                    prefixIcon: Icons.lock_outline,
                    obscureText: loginState.obscurePassword,
                    enabled: !loginState.isLoading,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      if (!loginState.isLoading) _handleLogin();
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginState.obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.primaryBlue,
                      ),
                      onPressed: () {
                        ref.read(loginViewModelProvider.notifier)
                            .togglePasswordVisibility();
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.passwordRequired;
                      }
                      if (value.length < 4) {
                        return AppStrings.passwordTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimensions.spacing32),
                  CustomButton(
                    label: AppStrings.loginButton,
                    onPressed: _handleLogin,
                    isPrimary: true,
                    icon: Icons.arrow_forward_rounded,
                    isLoading: loginState.isLoading,
                  ),
                  const SizedBox(height: AppDimensions.spacing24),
                  Center(
                    child: TextButton(
                      onPressed: loginState.isLoading
                          ? null
                          : () => Navigator.pushNamed(context, '/register'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppStrings.noAccountText,
                            style: TextStyle(
                              color: AppColors.darkBlue.withValues(alpha: 0.6),
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            AppStrings.registerLinkText,
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
