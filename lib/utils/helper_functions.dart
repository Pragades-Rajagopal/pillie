T? sanitizeValue<T>(dynamic value) =>
    value is T && value != null ? value : null;

String convertDateFormat(String input) {
  final parts = input.split('/');
  if (parts.length != 3) throw const FormatException('Invalid date format');
  final day = parts[0].padLeft(2, '0');
  final month = parts[1].padLeft(2, '0');
  final year = parts[2];
  return '$month/$day/$year';
}
