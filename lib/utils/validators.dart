class Validators {
  static String? validateRequired(String? value) {
    return (value == null || value.isEmpty) ? 'This field is required' : null;
  }

  static String? validateEmail(String? value) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return (value == null || !regex.hasMatch(value))
        ? 'Enter a valid email'
        : null;
  }

  static String? validatePhone(String? value) {
    final regex = RegExp(r'^\d{8,15}$');
    return (value == null || !regex.hasMatch(value))
        ? 'Enter a valid phone number'
        : null;
  }
}
