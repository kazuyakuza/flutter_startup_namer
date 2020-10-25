enum AppRoute {
  randomWords,
  favoriteWords,
}

extension AppRouteValue on AppRoute {
  static const _values = {
    AppRoute.randomWords: '/random-words',
    AppRoute.favoriteWords: '/favorite-words',
  };

  String asString() {
    return _values[this];
  }
}
