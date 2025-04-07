abstract class NumberUtils {
  static bool isInteger(String value) {
    return int.tryParse(value) != null;
  }
}
