mixin RegisterValidators {
  String get confirmPasswordMatchText => '';

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Nombre requerido';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email requerido';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Contraseña requerida';
    if (value.length < 8) return 'La contraseña debe tener al menos 8 caracteres';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirmar contraseña requerida';
    if (value != confirmPasswordMatchText) return 'Las contraseñas no coinciden';
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Usuario requerido';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Telefono requerido';
    return null;
  }
}
