import 'package:flutter/foundation.dart';
import '../../domain/usecases/login_usecase.dart';

/// ViewModel for login screen
/// Following MVVM pattern and Separation of Concerns
class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  bool _isLoading = false;
  bool _showLoginForm = false;
  bool _obscurePassword = true;

  bool get isLoading => _isLoading;
  bool get showLoginForm => _showLoginForm;
  bool get obscurePassword => _obscurePassword;

  void toggleLoginForm() {
    _showLoginForm = !_showLoginForm;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<LoginResult> login(String accountId, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _loginUseCase.execute(accountId, password);
      return result;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _showLoginForm = false;
    _obscurePassword = true;
    notifyListeners();
  }
}