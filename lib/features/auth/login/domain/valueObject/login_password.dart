class LoginPassword {
  final String value;

  static final RegExp _uppercase = RegExp(r'[A-Z]');
  static final RegExp _lowercase = RegExp(r'[a-z]');
  static final RegExp _number = RegExp(r'[0-9]');

  LoginPassword._(this.value);

  factory LoginPassword(String input) {
    final trimmed = input.trim();

    if (trimmed.length < 8 || trimmed.length > 32) {
      throw ArgumentError('Password must be between 8 and 32 characters');
    }

    if (!_uppercase.hasMatch(trimmed)) {
      throw ArgumentError(
        'Password must contain at least one uppercase letter',
      );
    }

    if (!_lowercase.hasMatch(trimmed)) {
      throw ArgumentError(
        'Password must contain at least one lowercase letter',
      );
    }

    if (!_number.hasMatch(trimmed)) {
      throw ArgumentError('Password must contain at least one number');
    }

    return LoginPassword._(trimmed);
  }
}
