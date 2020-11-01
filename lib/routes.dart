enum AppRoute {
  randomWords,
  favoriteStartupIdea,
}

extension AppRouteValue on AppRoute {
  static const _values = {
    AppRoute.randomWords: '/random-words',
    AppRoute.favoriteStartupIdea: '/favorite-startup-idea',
  };

  String asString() {
    return _values[this];
  }
}
