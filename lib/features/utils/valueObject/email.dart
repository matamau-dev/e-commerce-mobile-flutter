class Email {
  final String value;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  Email._(this.value);

  factory Email(String input) {
    final trimmed = input.trim();

    if (!_emailRegExp.hasMatch(trimmed)) {
      throw ArgumentError('Invalid email format');
    }

    return Email._(trimmed);
  }
}
