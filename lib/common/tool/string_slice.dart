
class StringSliceUtil {
  static String stringSliceAndMore(String content, int retain) {
    return content.substring(0, retain) + "...";
  }
}