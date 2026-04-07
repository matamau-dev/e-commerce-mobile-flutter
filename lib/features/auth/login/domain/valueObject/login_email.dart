class LoginEmail {
  final String value;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  LoginEmail._(this.value);

  factory LoginEmail(String input) {
    final trimmed = input.trim();

    if (!_emailRegExp.hasMatch(trimmed)) {
      throw ArgumentError('Invalid email format');
    }

    return LoginEmail._(trimmed);
  }
}
