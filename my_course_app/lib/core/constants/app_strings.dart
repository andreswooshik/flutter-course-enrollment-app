/// Application string constants
class AppStrings {
  AppStrings._();

  // App Info
  static const appTitle = 'USJR Course\nEnrollment App';
  static const appMotto = 'Caritas et Scientia';
  
  // Login Screen
  static const loginTitle = 'Welcome Back!';
  static const loginSubtitle = 'Please login to continue';
  static const loginButton = 'Login';
  static const registerButton = 'Register';
  static const accountIdLabel = 'Account ID';
  static const passwordLabel = 'Password';
  static const noAccountText = "Don't have an account? ";
  static const registerLinkText = "Register";
  
  // Validation Messages
  static const accountIdRequired = 'Please enter your Account ID';
  static const accountIdTooShort = 'Account ID must be at least 3 characters';
  static const passwordRequired = 'Please enter your password';
  static const passwordTooShort = 'Password must be at least 4 characters';
  
  // Status Messages
  static const loginSuccess = 'Login successful!';
  static const loginFailed = 'Invalid Account ID or Password.';
  static const loginError = 'Error reading user data. Please try again.';
}