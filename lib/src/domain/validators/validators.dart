class Validators {
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static bool isGreaterThanZero(num? value) {
    return value != null && value > 0;
  }

  static bool isValidDate(String date) {
    return DateTime.tryParse(date) != null;
  }
}