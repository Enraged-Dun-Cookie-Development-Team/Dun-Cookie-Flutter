class FileUtil {
  static String getReadableFileSize(int bytes, {int fractionDigits = 0}) {
    final units = ['B', 'KB', 'MB', 'GB', 'TB'];
    double size = bytes.toDouble();
    int unitIndex = 0;
    for (unitIndex = 0; unitIndex < units.length; unitIndex++) {
      if (size < 1024) break;
      size = size / 1024;
    }
    if (unitIndex >= units.length) {
      size = size * 1024;
      unitIndex -= 1;
    }
    return size.toStringAsFixed(fractionDigits) + units[unitIndex];
  }
}
