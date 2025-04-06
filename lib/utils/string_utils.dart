abstract class StringUtils {
  static String toPersonalName(String name) {
    return '${name[0].toUpperCase()}${name.substring(1).toLowerCase()}';
  }
}
