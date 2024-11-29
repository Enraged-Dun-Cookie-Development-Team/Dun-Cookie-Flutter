class MangaTool {
  static RegExp regExp = RegExp(
    r'^https://terra-historicus.hypergryph.com/comic/(\d+)/episode/(\d+)',
  );

  String getUrl(String comic, String episode) =>
      'https://terra-historicus.hypergryph.com/comic/$comic/episode/$episode';

  static String getEpisodeId(String url) {
    RegExpMatch? match = regExp.firstMatch(url);
    if (match != null) {
      String? episode = match.group(2);
      if (episode != null) {
        return episode;
      }
    }
    return '';
  }
}
