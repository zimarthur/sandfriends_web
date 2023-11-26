extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension DoubleExtension on double {
  String formatPrice() {
    return "R\$${this.toStringAsFixed(2).replaceAll(".", ",")}";
  }
}
